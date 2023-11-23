import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';

class EMarketPlaceScreen extends StatelessWidget {
  EMarketPlaceScreen({
    super.key,
  });

  final List gridData = [
    {"title": "Search Job", "image": "assets/images/jobsearch.png"},
    {"title": "Manage Job", "image": "assets/images/manage_job.png"},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    AllInProvider provider = Provider.of(context, listen: false);

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const ProfileScreen(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "E Market Place",
          style: TextStyle(color: Colors.black),
        ),
        leading: provider.isBack
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              )
            : const SizedBox(),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              children: <Widget>[
                ...provider.homeModuleSubMenuList
                    .map(
                      (e) => (provider.isOfflineData &&
                              provider.homeModuleSubMenuList.indexOf(e) < 1)
                          ? InkWell(
                              onTap: () {
                                if (e['apiUrl'] == "SearchJob") {
                                  // provider.getEMarketPalceSearchJobData(context);
                                  provider.getEMarketPlaceSearchJobDataNew(
                                      context,
                                      provider.eMarketPalceSearch_job_value,
                                      provider.empCode.toString(),
                                      false,
                                      true);
                                } else if (e['apiUrl'] == "ManageJob") {
                                  provider.getEMarketPalceManageJobDataNew(
                                      context,
                                      provider
                                          .eMarketPalceManageJob_Post_filter_value,
                                      false,
                                      true);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF0C6DAE),
                                        Color(0xFF239DEE),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "${e['apiIcon']}",
                                      width: AllInProvider.iPadSize ? 55 : 40,
                                    ),
                                    SizedBox(
                                        height:
                                            CommonAppTheme.lineheightSpace20),
                                    Text(
                                      e['menuName'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              AllInProvider.iPadSize ? 18 : 14),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : !provider.isOfflineData
                              ? InkWell(
                                  onTap: () {
                                    if (e['apiUrl'] == "SearchJob") {
                                      // provider.getEMarketPalceSearchJobData(context);
                                      provider.getEMarketPlaceSearchJobDataNew(
                                          context,
                                          provider.eMarketPalceSearch_job_value,
                                          provider.empCode.toString(),
                                          false,
                                          true);
                                    } else if (e['apiUrl'] == "ManageJob") {
                                      provider.getEMarketPalceManageJobDataNew(
                                          context,
                                          provider
                                              .eMarketPalceManageJob_Post_filter_value,
                                          false,
                                          true);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF0C6DAE),
                                            Color(0xFF239DEE),
                                          ],
                                          begin: FractionalOffset(0.0, 0.0),
                                          end: FractionalOffset(0.0, 1.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                            "${provider.imageUrl}/${e['apiIcon']}",
                                            width: AllInProvider.iPadSize
                                                ? 55
                                                : 40),
                                        SizedBox(
                                            height: CommonAppTheme
                                                .lineheightSpace20),
                                        Text(
                                          e['menuName'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: AllInProvider.iPadSize
                                                  ? 18
                                                  : 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
                    )
                    .toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
