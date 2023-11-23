import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("BUILDDD");
    AllInProvider provider = Provider.of(context, listen: false);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const ProfileScreen(),
      appBar: AppBar(
        title: Text(
          "Manpower Planning System",
          style: CommonAppTheme.textstyleWithColorBlackF18,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
          child: Column(
            children: [
              Image.asset(
                "assets/images/ntpclogo2.png",
                width: AllInProvider.iPadSize ? 200 : 120,
              ),
              Expanded(
                child: Consumer<AllInProvider>(
                  builder: (context, value, child) => GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    children: <Widget>[
                      ...provider.homeModuleList
                          .map((e) => (provider.isOfflineData &&
                                  provider.homeModuleList.indexOf(e) < 3)
                              ? InkWell(
                                  onTap: () {
                                    if (e['menuID'] == 8) {
                                      provider.deptGroupFilterValues.clear();
                                      provider.deptsubGroupFilterValues.clear();
                                      provider.deptFilterValues.clear();
                                      provider.projectCategoryFilterValues
                                          .clear();
                                      provider.locationFilterValues.clear();
                                      provider.gradeFilterValues.clear();
                                      provider.levelFilterValues.clear();
                                      if (provider.isOfflineData) {
                                        provider.getKeyPositionDataOffine(
                                          context,
                                          provider
                                              .keyPositionSearch_Post_filter_value,
                                          true,
                                          true,
                                        );
                                      } else {
                                        provider.getKeyPositionMonitoringData(
                                          context,
                                          provider
                                              .keyPositionSearch_Post_filter_value,
                                          false,
                                          true,
                                          "Main/KeyPostions_Search_Post",
                                          true,
                                        );
                                      }
                                    } else if (e['menuID'] == 9) {
                                      if (provider.isOfflineData) {
                                        provider.setOfflineFilterForSPVAnalysis(
                                            context, 1, "");
                                      } else {
                                        Map<String, String>
                                            spvAnalysisRegionFilterData = {
                                          'Department': '',
                                          'Region': '',
                                          'ProjectCategory': '',
                                          'Project': '',
                                          'Grade': '',
                                          'Spv_Dept_Type': '0',
                                          'Spv_Dept_Group': '0',
                                          'SortBy': '',
                                          'UserID': '${provider.empCode}',
                                          'UserRole': provider.userRole,
                                          'ProjectType':
                                              '${provider.empProjectType}',
                                          'RegionID': '${provider.empRegionID}',
                                          "SearchBy": ""
                                        };
                                        provider.setSpvAnalysisRequiredFilters(
                                            context,
                                            1,
                                            spvAnalysisRegionFilterData,
                                            true,
                                            false);
                                      }
                                    } else if (e['menuID'] == 10) {
                                      provider.isBack = true;
                                      provider
                                          .getHomeScreenSubModuleMenuBasedOnUserRole(
                                        context,
                                      );
                                      // Navigator.pushNamed(context, '/comparing_profile');
                                    } else if (e['menuID'] == 11) {
                                      provider.searchUserByNameId = "";
                                      provider.totalRecord = 0;
                                      provider.clearOpenSearchListData();
                                      provider.setRequiredFilterForOpenSearch(
                                        context,
                                        true,
                                      );
                                      // provider.getOpenSearchEmpData(context,
                                      //     provider.openSearchRequiedFieldsToGetData);
                                    } else if (e['menuID'] == 31) {
                                      provider.deptGroupFilterValues.clear();
                                      provider.deptsubGroupFilterValues.clear();
                                      provider.deptFilterValues.clear();
                                      provider.projectCategoryFilterValues
                                          .clear();
                                      provider.locationFilterValues.clear();
                                      provider.gradeFilterValues.clear();
                                      provider.levelFilterValues.clear();
                                      provider.getKeyPositionMonitoringData(
                                          context,
                                          provider
                                              .keyPositionSearch_Post_filter_value,
                                          false,
                                          true,
                                          "Main/Succession_Search_Post",
                                          false);
                                    } else if (e['menuID'] == 32) {
                                      provider.getJobRotationDataList(
                                          context,
                                          provider.jobRotation_value,
                                          false,
                                          true);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFF0C6DAE),
                                            const Color(0xFF239DEE),
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(0.0, 1.0),
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
                                        Image.asset(
                                          "${e['apiIcon']}",
                                          width:
                                              AllInProvider.iPadSize ? 55 : 40,
                                        ),
                                        SizedBox(
                                          height:
                                              CommonAppTheme.lineheightSpace20,
                                        ),
                                        Text(
                                          e['menuName'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: AllInProvider.iPadSize
                                                  ? 18
                                                  : 14),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : !provider.isOfflineData
                                  ? InkWell(
                                      onTap: () {
                                        if (e['menuID'] == 8) {
                                          provider.deptGroupFilterValues
                                              .clear();
                                          provider.deptsubGroupFilterValues
                                              .clear();
                                          provider.deptFilterValues.clear();
                                          provider.projectCategoryFilterValues
                                              .clear();
                                          provider.locationFilterValues.clear();
                                          provider.gradeFilterValues.clear();
                                          provider.levelFilterValues.clear();
                                          if (provider.isOfflineData) {
                                            provider.getKeyPositionDataOffine(
                                              context,
                                              provider
                                                  .keyPositionSearch_Post_filter_value,
                                              true,
                                              true,
                                            );
                                          } else {
                                            provider.getKeyPositionMonitoringData(
                                                context,
                                                provider
                                                    .keyPositionSearch_Post_filter_value,
                                                false,
                                                true,
                                                "Main/KeyPostions_Search_Post",
                                                true);
                                          }
                                        } else if (e['menuID'] == 9) {
                                          if (provider.isOfflineData) {
                                            provider
                                                .setOfflineFilterForSPVAnalysis(
                                              context,
                                              1,
                                              "",
                                            );
                                          } else {
                                            Map<String, String>
                                                spvAnalysisRegionFilterData = {
                                              'Department': '',
                                              'Region': '',
                                              'ProjectCategory': '',
                                              'Project': '',
                                              'Grade': '',
                                              'Spv_Dept_Type': '0',
                                              'Spv_Dept_Group': '0',
                                              'SortBy': '',
                                              'UserID': '${provider.empCode}',
                                              'UserRole': provider.userRole,
                                              'ProjectType':
                                                  '${provider.empProjectType}',
                                              'RegionID':
                                                  '${provider.empRegionID}',
                                              "SearchBy": ""
                                            };
                                            provider
                                                .setSpvAnalysisRequiredFilters(
                                              context,
                                              1,
                                              spvAnalysisRegionFilterData,
                                              true,
                                              false,
                                            );
                                          }
                                        } else if (e['menuID'] == 10) {
                                          provider.isBack = true;
                                          provider
                                              .getHomeScreenSubModuleMenuBasedOnUserRole(
                                            context,
                                          );
                                          // Navigator.pushNamed(context, '/comparing_profile');
                                        } else if (e['menuID'] == 11) {
                                          provider.searchUserByNameId = "";
                                          provider.totalRecord = 0;
                                          provider.clearOpenSearchListData();
                                          provider
                                              .setRequiredFilterForOpenSearch(
                                            context,
                                            true,
                                          );
                                          // provider.getOpenSearchEmpData(context,
                                          //     provider.openSearchRequiedFieldsToGetData);
                                        } else if (e['menuID'] == 31) {
                                          provider.deptGroupFilterValues
                                              .clear();
                                          provider.deptsubGroupFilterValues
                                              .clear();
                                          provider.deptFilterValues.clear();
                                          provider.projectCategoryFilterValues
                                              .clear();
                                          provider.locationFilterValues.clear();
                                          provider.gradeFilterValues.clear();
                                          provider.levelFilterValues.clear();
                                          provider.getKeyPositionMonitoringData(
                                              context,
                                              provider
                                                  .keyPositionSearch_Post_filter_value,
                                              false,
                                              true,
                                              "Main/Succession_Search_Post",
                                              false);
                                        } else if (e['menuID'] == 32) {
                                          provider.getJobRotationDataList(
                                              context,
                                              provider.jobRotation_value,
                                              false,
                                              true);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF0C6DAE),
                                                const Color(0xFF239DEE),
                                              ],
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  0.0, 1.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                  : 40,
                                            ),
                                            SizedBox(
                                              height: CommonAppTheme
                                                  .lineheightSpace20,
                                            ),
                                            Text(
                                              e['menuName'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      AllInProvider.iPadSize
                                                          ? 18
                                                          : 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox())
                          .toList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
