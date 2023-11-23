import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';

class ViewProfileScreenOffline extends StatefulWidget {
  const ViewProfileScreenOffline({super.key});

  @override
  State<ViewProfileScreenOffline> createState() =>
      _ViewProfileScreenOfflineState();
}

class _ViewProfileScreenOfflineState extends State<ViewProfileScreenOffline> {
  bool isExpandedValue10 = false;
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
          "Employee Profile Offline", context),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profilebg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CommonAppTheme.screenPadding),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    provider.isOfflineData
                        ? provider.profileInfo[0]['firstName']
                        : provider.profileInfo[0]['name'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("(Emp. No. ",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        "${provider.profileInfo[0]['empNo']})",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NTPC Hiring:",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        provider.profileInfo[0]['doJ_NTPC'].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.profileInfo[0]['entryMode'].toString(),
                        style: TextStyle(
                          color: Color(
                            CommonAppTheme.appthemeColorForText,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Area Of Rectt.:",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        provider.profileInfo[0]['recruitmentArea'].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("DOB: ",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        provider.profileInfo[0]['dob'].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("DOE in Grade: ",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        provider.profileInfo[0]['doE_Grade'].toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("DOE in Project: ",
                          style: TextStyle(
                            color: Color(
                              CommonAppTheme.appthemeColorForText,
                            ),
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        provider.profileInfo[0]['doE_Project'].toString(),
                      ),
                    ],
                  ),
                  provider.profileInfo[0]['keyPosition'] != "" &&
                          provider.profileInfo[0]['keyPosition'] != null
                      ? SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Image.asset(
                                        "assets/images/key.png",
                                        width: 30,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${provider.profileInfo[0]['keyPosition']}",
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              CommonAppTheme.borderRadious),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: ExpansionTile(
                          onExpansionChanged: ((value) {
                            print(value);
                            setState(() {
                              isExpandedValue10 = value;
                            });
                          }),
                          trailing: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(CommonAppTheme.whiteColor),
                            ),
                            child: Icon(
                              isExpandedValue10
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Color(CommonAppTheme.appthemeColorForText),
                            ),
                          ),
                          backgroundColor:
                              Color(CommonAppTheme.buttonCommonColor),
                          collapsedBackgroundColor:
                              Color(CommonAppTheme.buttonCommonColor),
                          title: Text(
                            "Personal Information",
                            style: TextStyle(
                              color: Color(
                                CommonAppTheme.whiteColor,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                          "${provider.profileInfo[0]['mobile']}, ${provider.profileInfo[0]['email']},\n${provider.profileInfo[0]['age']} Years , ${provider.profileInfo[0]['gender']}, ${provider.profileInfo[0]['grade']}, ${provider.profileInfo[0]['designation']} \n${provider.profileInfo[0]['region']}, ${provider.profileInfo[0]['project']}-${provider.profileInfo[0]['location']}\n"),
                                      Text(
                                          "PH: ${provider.profileInfo[0]['ph']}"),
                                      Text(
                                          "Spouse in NTPC :${provider.profileInfo[0]['supose']} E.No.-${provider.profileInfo[0]['supose_EmpNo']}"),
                                      Text(
                                          "Category: ${provider.profileInfo[0]['caste']}"),
                                      Text(
                                          "Domicile: ${provider.profileInfo[0]['domicile_State']}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Location Experience:-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.profileInfo[0]['location_Exp']
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Functional Experience:-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.profileInfo[0]['fun_Exp']
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Department Experience:-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.profileInfo[0]
                                                ['department_Exp']
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Work Area Experience:-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        provider.profileInfo[0]['workArea_Exp']
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      provider.profileInfo[0]['keyPositionPast'] != "" &&
                              provider.profileInfo[0]['keyPositionPast'] != null
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        CommonAppTheme.borderRadious),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: EdgeInsets.zero,
                                  child: ExpansionTile(
                                    onExpansionChanged: ((value) {
                                      print(value);
                                      setState(() {
                                        isExpandedValue10 = value;
                                      });
                                    }),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(CommonAppTheme.whiteColor),
                                      ),
                                      child: Icon(
                                        isExpandedValue10
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        size: 30,
                                        color: Color(CommonAppTheme
                                            .appthemeColorForText),
                                      ),
                                    ),
                                    backgroundColor:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    collapsedBackgroundColor:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    title: Text(
                                      "Key Positions Held",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.whiteColor,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(7),
                                                bottomRight: Radius.circular(7),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                    "${provider.profileInfo[0]['keyPositionPast']}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              CommonAppTheme.borderRadious),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: ExpansionTile(
                          onExpansionChanged: ((value) {
                            print(value);
                            setState(() {
                              isExpandedValue10 = value;
                            });
                          }),
                          trailing: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(CommonAppTheme.whiteColor),
                            ),
                            child: Icon(
                              isExpandedValue10
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Color(CommonAppTheme.appthemeColorForText),
                            ),
                          ),
                          backgroundColor: provider.profileInfo[0]
                                          ['lastYearLeaveStatus']
                                      .toString()
                                      .toLowerCase() ==
                                  "yes"
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          collapsedBackgroundColor: provider.profileInfo[0]
                                          ['lastYearLeaveStatus']
                                      .toString()
                                      .toLowerCase() ==
                                  "yes"
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          title: Text(
                            "Leave Details",
                            style: TextStyle(
                              color: Color(
                                CommonAppTheme.whiteColor,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                          "90 days above leave in last 1 year: ${provider.profileInfo[0]['lastYearLeaveStatus']}"),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              CommonAppTheme.borderRadious),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: ExpansionTile(
                          onExpansionChanged: ((value) {
                            print(value);
                            setState(() {
                              isExpandedValue10 = value;
                            });
                          }),
                          trailing: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(CommonAppTheme.whiteColor),
                            ),
                            child: Icon(
                              isExpandedValue10
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Color(CommonAppTheme.appthemeColorForText),
                            ),
                          ),
                          backgroundColor: provider.profileInfo[0]
                                          ['healthCheckUp']
                                      .toString()
                                      .toLowerCase() ==
                                  ""
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          collapsedBackgroundColor: provider.profileInfo[0]
                                          ['healthCheckUp']
                                      .toString()
                                      .toLowerCase() ==
                                  ""
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          title: Text(
                            "Medical Status",
                            style: TextStyle(
                              color: Color(
                                CommonAppTheme.whiteColor,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                          "Annual Medical Health Check up: ${provider.profileInfo[0]['healthCheckUp']}"),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              CommonAppTheme.borderRadious),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: ExpansionTile(
                          onExpansionChanged: ((value) {
                            print(value);
                            setState(() {
                              isExpandedValue10 = value;
                            });
                          }),
                          trailing: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(CommonAppTheme.whiteColor),
                            ),
                            child: Icon(
                              isExpandedValue10
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                              color: Color(CommonAppTheme.appthemeColorForText),
                            ),
                          ),
                          backgroundColor: provider.profileInfo[0]
                                          ['isVigilance']
                                      .toString()
                                      .toLowerCase() ==
                                  "yes"
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          collapsedBackgroundColor: provider.profileInfo[0]
                                          ['isVigilance']
                                      .toString()
                                      .toLowerCase() ==
                                  "yes"
                              ? Colors.red
                              : Color(CommonAppTheme.buttonCommonColor),
                          title: Text(
                            "Vigilance / Disciplinary",
                            style: TextStyle(
                              color: Color(
                                CommonAppTheme.whiteColor,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                          "${provider.profileInfo[0]['isVigilance']}"),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
