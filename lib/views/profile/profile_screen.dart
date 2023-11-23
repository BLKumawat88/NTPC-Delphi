import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/theme/common_dialog.dart';
import 'package:provider/provider.dart';

import '../../theme/common_them.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AllInProvider provider = Provider.of(context, listen: false);
      print("Build Completed");
      provider.getUserProfile(context);
      provider.isUserDownloadedData();
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          width: 25,
                          height: 25,
                          child: Center(
                            child: Text(
                              "X",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer<AllInProvider>(builder: ((context, value, child) {
                    return provider.profileForProfileScreen.isNotEmpty
                        ? ListTile(
                            onTap: () {
                              provider.viewProfile(context, provider.empCode);
                            },
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "https://delphi.ntpc.co.in${provider.profileForProfileScreen[0]['imgPath']}"),
                            ),
                            title: Text(
                              provider.isOfflineData
                                  ? provider.profileForProfileScreen[0]
                                      ['firstName']
                                  : provider.profileForProfileScreen[0]['name'],
                              style: CommonAppTheme.textstyleWithColorBlack,
                            ),
                            subtitle: Text(
                              "(Emp. No. ${provider.empCode})",
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: provider.userRole != "5"
                                ? Consumer<AllInProvider>(
                                    builder: (context, value, child) => Switch(
                                      value: provider.isOfflineData,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (value) async {
                                        final _storage =
                                            const FlutterSecureStorage();
                                        final readDta = await _storage.read(
                                            key:
                                                'dateOfLastDownloadedDataOffline');
                                        if (readDta == null) {
                                          CommanDialog.showErrorDialog(context,
                                              description:
                                                  "No Offline Data Available Please download");
                                          return;
                                        }
                                        provider.switchBitweenOfflineAndOnline(
                                            value, context);
                                      },
                                    ),
                                  )
                                : SizedBox(),
                          )
                        : SizedBox();
                  })),
                  const SizedBox(
                    height: 50,
                  ),
                  Consumer<AllInProvider>(
                    builder: (context, value, child) => provider.isOfflineData
                        ? SizedBox()
                        : provider.isManasReportShow == 1
                            ? ListTile(
                                onTap: () {
                                  print("HEloo");
                                  provider.pageSizeManasReport = 20;
                                  provider.currentPageManasReport = 1;
                                  provider.totalRecordOfManasReport = "0";
                                  provider.requiredDataForFilter[
                                      'SearchApplicationID'] = '';
                                  provider.requiredDataForFilter[
                                      'SearchEmpNo'] = '';
                                  provider.requiredDataForFilter[
                                      'SearchRequestType'] = '0';
                                  provider.requiredDataForFilter[
                                      'SearchGroundType'] = '0';
                                  provider.requiredDataForFilter[
                                      'SearchRequestStatus'] = '';
                                  provider.requiredDataForFilter[
                                      'SearchRequestDateF'] = '';
                                  provider.requiredDataForFilter[
                                      'SearchRequestDateT'] = '';
                                  provider.requiredDataForFilter[
                                      'ProjectChoices'] = '';
                                  provider.requiredDataForFilter[
                                      'SearchProjectC'] = '0';
                                  provider.requiredDataForFilter[
                                      'SearchProjectP'] = '0';
                                  provider.requiredDataForFilter[
                                      'SearchSpouseData'] = '';
                                  provider.requiredDataForFilter[
                                      'CurrentPage'] = '1';
                                  provider.requiredDataForFilter['PagingSize'] =
                                      '20';
                                  provider.requiredDataForFilter[
                                      'TotalRecord'] = '0';
                                  provider.getManasReportData(context,
                                      provider.requiredDataForFilter, true);
                                },
                                leading: const Icon(
                                  Icons.report,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Manas Report",
                                  style: CommonAppTheme.textstyleWithColorBlack,
                                ),
                              )
                            : SizedBox(),
                  ),
                  Consumer<AllInProvider>(
                    builder: (context, value, child) => provider.isOfflineData
                        ? SizedBox()
                        : ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/reset_pass');
                            },
                            leading: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Change Password ",
                              style: CommonAppTheme.textstyleWithColorBlack,
                            ),
                          ),
                  ),
                  Consumer<AllInProvider>(
                      builder: (context, value, child) => provider.userRole !=
                              "5"
                          ? !provider.isOfflineData
                              ? ListTile(
                                  onTap: () async {
                                    // provider.insetFilterDataInTabls();
                                    provider.getRequiredTableDataToStoreOffline(
                                        context);
                                    final _storage =
                                        const FlutterSecureStorage();
                                    print(DateFormat.yMMMMd()
                                        .format(DateTime.now()));
                                    String currentDate = DateFormat.yMMMMd()
                                        .format(DateTime.now());
                                    provider
                                        .updateOfflineDateWhileDownloadDataOffline(
                                            currentDate);
                                    await _storage.write(
                                        key: 'dateOfLastDownloadedDataOffline',
                                        value: currentDate);
                                  },
                                  leading: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  title: Consumer<AllInProvider>(
                                    builder: (context, value, child) => Text(
                                      "Download data offline ${provider.dateOfLastDownloadedDataOffline != "" ? ({
                                          provider
                                              .dateOfLastDownloadedDataOffline
                                        }) : ""} ",
                                      style: CommonAppTheme
                                          .textstyleWithColorBlack,
                                    ),
                                  ),
                                )
                              : SizedBox()
                          : SizedBox()),
                ],
              ),
              ListTile(
                onTap: () async {
                  final _storage = const FlutterSecureStorage();
                  Navigator.pop(context);
                  await _storage.delete(key: 'ntpctwo_isuser_login');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/is_user_login_screen', (Route<dynamic> route) => false);
                },
                leading: const Icon(
                  Icons.login,
                  color: Colors.black,
                ),
                title: Text(
                  "Log Out",
                  style: CommonAppTheme.textstyleWithColorBlack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
