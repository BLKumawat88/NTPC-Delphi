import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';

enum ExcelDownloadType {
  M,
  P,
  SP,
}

class KeyPositionMonitoringScreen extends StatefulWidget {
  const KeyPositionMonitoringScreen({super.key});

  @override
  State<KeyPositionMonitoringScreen> createState() =>
      _KeyPositionMonitoringScreenState();
}

class _KeyPositionMonitoringScreenState
    extends State<KeyPositionMonitoringScreen> {
  TextEditingController namePosition = TextEditingController();
  bool isExpandedValue = false;
  List subjectData = [];
  final items = ['Head Wise'];
  String selectedValue = '';

  final items1 = ["All", 'Yes', 'No'];
  String selectedValue1 = '';

  final items2 = ["All", 'Vacant', 'Surplus'];
  String selectedValue2 = '';

  final items3 = ["All", 'Vacant', 'Surplus'];
  String selectedValue3 = '';

  final rid = ["All", '1 month', '3 months', '6 months'];
  String ridValue = '';

  updateState() {
    setState(() {});
  }

  List holdFilteredDataFromDepGroup = [];
  applyMonitoringFilter(statusForLoading) {
    AllInProvider provider = Provider.of(context, listen: false);
    provider.departGroupFilterIds.clear();
    provider.departFilterIds.clear();
    provider.departSubGroupFilterIds.clear();
    provider.projectCategoryFiltersIds.clear();
    provider.locationFiltersIds.clear();
    provider.gradeFiltersIds.clear();
    provider.levelFiltersIds.clear();

    for (int i = 0; i < provider.deptGroupFilterValues.length; i++) {
      provider.departGroupFilterIds
          .add(provider.deptGroupFilterValues[i]['groupDeptCode']);
    }

    for (int i = 0; i < provider.deptsubGroupFilterValues.length; i++) {
      provider.departSubGroupFilterIds
          .add(provider.deptsubGroupFilterValues[i]['subDeptCode']);
    }

    for (int i = 0; i < provider.deptFilterValues.length; i++) {
      provider.departFilterIds.add(provider.deptFilterValues[i]['deptCode']);
    }

    for (int i = 0; i < provider.projectCategoryFilterValues.length; i++) {
      provider.projectCategoryFiltersIds
          .add(provider.projectCategoryFilterValues[i]['projectTypeID']);
    }

    for (int i = 0; i < provider.locationFilterValues.length; i++) {
      provider.locationFiltersIds.add(provider.locationFilterValues[i]['pid']);
    }

    for (int i = 0; i < provider.gradeFilterValues.length; i++) {
      provider.gradeFiltersIds.add(provider.gradeFilterValues[i]['levelCode']);
    }
    for (int i = 0; i < provider.levelFilterValues.length; i++) {
      provider.levelFiltersIds.add(provider.levelFilterValues[i]['id']);
    }

    if (provider.isOfflineData) {
      Map<String, dynamic> requiredData = {
        'SearchID': '',
        'SearchTitle': namePosition.text,
        'Department': provider.isOfflineData
            ? provider.departFilterIds
            : provider.departFilterIds.join(','),
        'DepartmentGroup': provider.isOfflineData
            ? provider.departGroupFilterIds
            : provider.departGroupFilterIds.join(','),
        'DepartmentSubGroup': provider.isOfflineData
            ? provider.departSubGroupFilterIds
            : provider.departSubGroupFilterIds.join(','),
        'ProjectCategory': provider.isOfflineData
            ? provider.projectCategoryFiltersIds
            : provider.projectCategoryFiltersIds.join(','),
        'Project': provider.isOfflineData
            ? provider.locationFiltersIds
            : provider.locationFiltersIds.join(','),
        'Grade': provider.isOfflineData
            ? provider.gradeFiltersIds
            : provider.gradeFiltersIds.join(','),
        'Level': provider.isOfflineData
            ? provider.levelFiltersIds
            : provider.levelFiltersIds.join(','),
        'PositionType': 'Head Wise',
        'isPublished': selectedValue1 == "All"
            ? '-1'
            : selectedValue1 == "Yes"
                ? "1"
                : selectedValue1 == "No"
                    ? '0'
                    : '0',
        "VacentStatus": selectedValue2 == "All"
            ? '-1'
            : selectedValue2 == "Vacant"
                ? "1"
                : selectedValue2 == "Surplus"
                    ? '2'
                    : '0'
      };
      print(json.encode(requiredData));

      provider.getKeyPositionDataOffine(
        context,
        requiredData,
        false,
        true,
      );
    } else {
      Map<String, String> requiredData = {
        'SearchID': '',
        'SearchTitle': namePosition.text,
        'Department': provider.departFilterIds.join(','),
        'DepartmentGroup': provider.departGroupFilterIds.join(','),
        'DepartmentSubGroup': provider.departSubGroupFilterIds.join(','),
        'ProjectCategory': provider.projectCategoryFiltersIds.join(','),
        'Project': provider.locationFiltersIds.join(','),
        'Grade': provider.gradeFiltersIds.join(','),
        'Level': provider.levelFiltersIds.join(','),
        'PositionType': 'Head Wise',
        'isPublished': selectedValue1 == "All"
            ? '-1'
            : selectedValue1 == "Yes"
                ? "1"
                : selectedValue1 == "No"
                    ? '0'
                    : '0',
        "VacentStatus": selectedValue2 == "All"
            ? '-1'
            : selectedValue2 == "Vacant"
                ? "1"
                : selectedValue2 == "Surplus"
                    ? '2'
                    : '0'
      };
      provider.getKeyPositionMonitoringData1(
        context,
        requiredData,
        statusForLoading,
        provider.showProjectionStatusForSucessionPlanning
            ? "Main/KeyPostions_Search_Post"
            : "Main/Succession_Search_Post",
      );
    }
  }

  applyProjectionFilter(statusForLoading) {
    AllInProvider provider = Provider.of(context, listen: false);
    provider.departFilterIds.clear();
    provider.locationFiltersIds.clear();

    for (int i = 0; i < provider.pDep.length; i++) {
      provider.departFilterIds.add(provider.pDep[i]['deptCode']);
    }
    for (int i = 0; i < provider.pProject.length; i++) {
      provider.locationFiltersIds.add(provider.pProject[i]['pid']);
    }

    updateState();
    Map<String, String> data1234 = {
      'SearchID': '',
      'SearchTitle': '',
      'Department': provider.departFilterIds.join(','),
      'DepartmentGroup': '',
      'DepartmentSubGroup': '',
      'ProjectCategory': '',
      'Project': provider.locationFiltersIds.join(','),
      'Grade': '',
      'Level': '',
      'PositionType': '',
      "vacentStatus": selectedValue3 == "All"
          ? '-1'
          : selectedValue3 == "Vacant"
              ? "1"
              : selectedValue3 == "Surplus"
                  ? '2'
                  : '0',
      "RetireDays": ridValue == "All"
          ? '-1'
          : ridValue == "1 month"
              ? "1"
              : ridValue == "3 months"
                  ? '3'
                  : ridValue == "6 months"
                      ? '6'
                      : '0'
    };

    print("data1234 $data1234");

    // Navigator.pop(context);
    CommanDialog.showLoading(context);
    provider.getKeyProjectionMonitoringData(
        context, data1234, statusForLoading);
  }

  void showAvailableFilter() {
    AllInProvider provider = Provider.of(context, listen: false);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                // height: MediaQuery.of(context).size.height / 1,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xFFD9D9D9),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            "Select Filters",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextField(
                                  autofocus: false,
                                  controller: namePosition,
                                  style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF0F6FA),
                                    hintText: 'Name of Position',
                                    hintStyle: TextStyle(
                                      color: Color(
                                        CommonAppTheme.buttonCommonColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedValue = value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "",
                                        child: Text(
                                          "Position Type",
                                          style: TextStyle(
                                            color: Color(
                                              CommonAppTheme.buttonCommonColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ...items
                                          .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .buttonCommonColor),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                    isExpanded: true,
                                    // add extra sugar..
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                    ),

                                    underline: SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: selectedValue1,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedValue1 = value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Published",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...items1
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                      ),
                                                    ),
                                                  ))
                                          .toList(),
                                    ],
                                    isExpanded: true,
                                    // add extra sugar..
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                    ),

                                    underline: const SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      searchable: true,
                                      dialogHeight: 250,
                                      initialValue:
                                          provider.deptGroupFilterValues,
                                      items: provider.deptGroup,
                                      title: const Text(
                                        "Group",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Group",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        // To show selected Filter
                                        setState(
                                          () {
                                            provider.deptGroupFilterValues
                                                .clear();

                                            provider.deptGroupFilterValues
                                                .addAll(results);
                                          },
                                        );

                                        if (provider.deptsubGroupFilterValues
                                                .isNotEmpty ||
                                            provider
                                                .deptFilterValues.isNotEmpty) {
                                          provider.deptsubGroupFilterValues
                                              .clear();
                                          provider.deptFilterValues.clear();
                                          Navigator.pop(context);

                                          showAvailableFilter();
                                        }

                                        if (results.isEmpty) {
                                          //to show all filter values again
                                          setState(
                                            () {
                                              provider.deptSubGroupDummy
                                                  .clear();
                                              provider.deptSubGroupDummy.addAll(
                                                  provider.deptSubGroup);
                                            },
                                          );
                                        } else {
                                          //To show Dept Sub Group filter according to Dept. Group
                                          setState(() {
                                            provider.deptSubGroupDummy.clear();
                                          });

                                          List dataAfterFilter = [];
                                          List depCasData = [];

                                          for (var i = 0;
                                              i < results.length;
                                              i++) {
                                            print(i);
                                            dataAfterFilter.addAll(provider
                                                .deptSubGroup
                                                .where((element) =>
                                                    element.value[
                                                        'groupDeptCode'] ==
                                                    results[i]['groupDeptCode'])
                                                .toList());
                                          }
                                          print(
                                              "dataAfterFilter length ${dataAfterFilter.length}");

                                          for (int i = 0;
                                              i < dataAfterFilter.length;
                                              i++) {
                                            setState(() {
                                              provider.deptSubGroupDummy
                                                  .add(dataAfterFilter[i]);
                                            });
                                          }

                                          //Dep Cas data
                                          for (var i = 0;
                                              i < results.length;
                                              i++) {
                                            depCasData.addAll(provider.dept
                                                .where((element) =>
                                                    element.value[
                                                        'groupDeptCode'] ==
                                                    results[i]['groupDeptCode'])
                                                .toList());

                                            provider.deptDummy.clear();
                                            holdFilteredDataFromDepGroup
                                                .clear();
                                            holdFilteredDataFromDepGroup
                                                .addAll(depCasData);
                                          }
                                          for (int i = 0;
                                              i < depCasData.length;
                                              i++) {
                                            setState(() {
                                              provider.deptDummy
                                                  .add(depCasData[i]);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      searchable: true,
                                      initialValue:
                                          provider.deptsubGroupFilterValues,
                                      items: provider.deptSubGroupDummy,
                                      title: const Text(
                                        "Sub Group",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Sub Group",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        // To show selected Filter
                                        setState(
                                          () {
                                            provider.deptsubGroupFilterValues
                                                .clear();

                                            provider.deptsubGroupFilterValues
                                                .addAll(results);
                                          },
                                        );

                                        if (provider
                                            .deptFilterValues.isNotEmpty) {
                                          provider.deptFilterValues.clear();
                                          Navigator.pop(context);

                                          showAvailableFilter();
                                        }

                                        if (results.isEmpty) {
                                          //to show all filter values again
                                          setState(() {
                                            provider.deptDummy.clear();
                                            // provider.deptDummy
                                            //     .addAll(provider.dept);
                                            if (holdFilteredDataFromDepGroup
                                                .isNotEmpty) {
                                              print(
                                                  "holdFilteredDataFromDepGroup after ${holdFilteredDataFromDepGroup.length}");

                                              provider.deptDummy.clear();
                                              for (int i = 0;
                                                  i <
                                                      holdFilteredDataFromDepGroup
                                                          .length;
                                                  i++) {
                                                setState(() {
                                                  provider.deptDummy.add(
                                                      holdFilteredDataFromDepGroup[
                                                          i]);
                                                });
                                              }
                                            }
                                          });
                                        } else {
                                          setState(() {
                                            provider.deptDummy.clear();
                                          });

                                          for (var i = 0;
                                              i < results.length;
                                              i++) {
                                            List dataAfterFilter = provider.dept
                                                .where((element) =>
                                                    element
                                                        .value['subDeptCode'] ==
                                                    results[i]['subDeptCode'])
                                                .toList();

                                            for (int i = 0;
                                                i < dataAfterFilter.length;
                                                i++) {
                                              setState(() {
                                                provider.deptDummy
                                                    .add(dataAfterFilter[i]);
                                              });
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      searchable: true,
                                      initialValue: provider.deptFilterValues,
                                      items: provider.deptDummy,
                                      title: const Text(
                                        "Department",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Department",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        setState(() {
                                          provider.deptFilterValues.clear();

                                          provider.deptFilterValues
                                              .addAll(results);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Consumer<AllInProvider>(
                                      builder: (context, value, child) =>
                                          MultiSelectDialogField(
                                        dialogHeight: 250,
                                        searchable: true,
                                        initialValue: provider
                                            .projectCategoryFilterValues,
                                        items: provider.projectCategoryDummy,
                                        title: const Text(
                                          "Proj. Category",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        selectedColor: Colors.black,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF0F6FA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          // border: Border.all(
                                          //   color: Colors.black,
                                          //   width: 1,
                                          // ),
                                        ),
                                        buttonIcon: Icon(Icons.arrow_drop_down,
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor)),
                                        buttonText: Text(
                                          "Proj. Category",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                            fontSize: 16,
                                          ),
                                        ),
                                        onConfirm: (results) {
                                          // To show selected Filter
                                          setState(
                                            () {
                                              provider
                                                  .projectCategoryFilterValues
                                                  .clear();
                                              provider
                                                  .projectCategoryFilterValues
                                                  .addAll(results);
                                            },
                                          );

                                          if (provider.locationFilterValues
                                              .isNotEmpty) {
                                            print("Dept");
                                            provider.locationFilterValues
                                                .clear();
                                            Navigator.pop(context);

                                            showAvailableFilter();
                                          }

                                          if (results.isEmpty) {
                                            //to show all filter values again
                                            setState(() {
                                              provider.locationDummy.clear();
                                              // provider.clearLocationData();
                                              provider.locationDummy
                                                  .addAll(provider.location);
                                            });
                                          } else {
                                            setState(() {
                                              provider.locationDummy.clear();
                                            });

                                            for (var i = 0;
                                                i < results.length;
                                                i++) {
                                              List dataAfterFilter = provider
                                                  .location
                                                  .where((element) =>
                                                      int.parse(element.value[
                                                          'projectCategory']) ==
                                                      results[i]
                                                              ['projectTypeID']
                                                          .round())
                                                  .toList();

                                              for (int i = 0;
                                                  i < dataAfterFilter.length;
                                                  i++) {
                                                setState(() {
                                                  provider.locationDummy
                                                      .add(dataAfterFilter[i]);
                                                });
                                              }
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      initialValue:
                                          provider.locationFilterValues,
                                      searchable: true,
                                      items: provider.locationDummy,
                                      title: const Text(
                                        "Location",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Location",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        print(results);
                                        //to show all filter values again
                                        setState(() {
                                          provider.locationFilterValues.clear();
                                          provider.locationFilterValues
                                              .addAll(results);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      searchable: true,
                                      initialValue: provider.gradeFilterValues,
                                      items: provider.grade,
                                      title: const Text(
                                        "Grade",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Grade",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        //to show all filter values again

                                        print(" grade result  $results");
                                        setState(() {
                                          provider.gradeFilterValues.clear();
                                          provider.gradeFilterValues
                                              .addAll(results);
                                        });
                                        if (provider
                                            .levelFilterValues.isNotEmpty) {
                                          print("Dept");
                                          provider.levelFilterValues.clear();
                                          Navigator.pop(context);
                                          showAvailableFilter();
                                        }

                                        if (results.isEmpty) {
                                          //to show all filter values again
                                          setState(() {
                                            provider.levelDummy.clear();
                                            // provider.clearLocationData();
                                            provider.levelDummy
                                                .addAll(provider.level);
                                          });
                                        } else {
                                          setState(() {
                                            provider.levelDummy.clear();
                                          });

                                          for (var i = 0;
                                              i < results.length;
                                              i++) {
                                            List dataAfterFilter = provider
                                                .level
                                                .where((element) =>
                                                    element
                                                        .value['levelCode'] ==
                                                    results[i]['levelCode'])
                                                .toList();

                                            for (int i = 0;
                                                i < dataAfterFilter.length;
                                                i++) {
                                              setState(() {
                                                provider.levelDummy
                                                    .add(dataAfterFilter[i]);
                                              });
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      searchable: true,
                                      initialValue: provider.levelFilterValues,
                                      items: provider.levelDummy,
                                      title: const Text(
                                        "Level",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Level",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        setState(() {
                                          provider.levelFilterValues.clear();
                                          provider.levelFilterValues
                                              .addAll(results);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: selectedValue2,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedValue2 = value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Vacancy status",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...items2
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                      ),
                                                    ),
                                                  ))
                                          .toList(),
                                    ],
                                    isExpanded: true,
                                    // add extra sugar..
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                    ),

                                    underline: const SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Clear All")),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(
                                    CommonAppTheme.buttonCommonColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (provider.isOfflineData) {
                                    Navigator.pop(context);
                                  }
                                  updateState();
                                  applyMonitoringFilter(true);
                                },
                                child: const Text("Search"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void projectionFilter() {
    AllInProvider provider = Provider.of(context, listen: false);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                // height: MediaQuery.of(context).size.height / 1,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xFFD9D9D9),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            "Select Filters",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      initialValue: provider.pDep,
                                      searchable: true,
                                      items: provider.deptDummy,
                                      title: const Text(
                                        "Department",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Department",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        setState(() {
                                          provider.pDep.clear();
                                          provider.pDep.addAll(results);
                                        });

                                        //_selectedAnimals = results;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    MultiSelectDialogField(
                                      dialogHeight: 250,
                                      initialValue: provider.pProject,
                                      searchable: true,
                                      items: provider.locationDummy,
                                      title: const Text(
                                        "Project",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      selectedColor: Colors.black,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF0F6FA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // border: Border.all(
                                        //   color: Colors.black,
                                        //   width: 1,
                                        // ),
                                      ),
                                      buttonIcon: Icon(Icons.arrow_drop_down,
                                          color: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      buttonText: Text(
                                        "Project",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        print(results);
                                        setState(
                                          () {
                                            provider.pProject.clear();
                                            provider.pProject.addAll(results);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: selectedValue3,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedValue3 = value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Vacancy status",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...items3
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                      ),
                                                    ),
                                                  ))
                                          .toList(),
                                    ],
                                    isExpanded: true,
                                    // add extra sugar..
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                    ),

                                    underline: SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: ridValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          ridValue = value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Retirement in months",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...rid
                                          .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                      ),
                                                    ),
                                                  ))
                                          .toList(),
                                    ],
                                    isExpanded: true,
                                    // add extra sugar..
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                    ),

                                    underline: SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Clear All")),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    applyProjectionFilter(true);
                                  },
                                  child: const Text("Search")),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget returnTableColumnLable(title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget returnRowData(title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
  }

  Future<bool> _requestPermission(Permission pr) async {
    var status = await pr.request();
    print(status.isGranted);
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // generateRandomName() {
  //   String name = "abcdefgjijklmnopqrstuvwxyz";

  //   String randomName = "";

  //   return randomName;
  // }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  downloadExcelFile(type, AllInProvider provider) async {
    if (type == ExcelDownloadType.M) {
      final excel = new Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      List excelData = [
        {
          "positionID": 1890,
          "title": "Name",
          "positionType": "Type",
          "totalSanctioned": "Sanctioned",
          "totalPositioned": "Positioned",
          "region": "HYDRO-HQ",
          "project": "Hydro",
          "location": "Project",
          "departmentName": "Department",
          "subDepartmentName": "Department",
          "departmentGroupName": "PROJECT CONSTRUCTION",
          "gradeName": "E8",
          "levelName": "Vacant",
          "jobID": 0
        },
        ...provider.keyPositionMonitoringData
      ];
      for (int i = 0; i < excelData.length; i++) {
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 0,
              rowIndex: i,
            ))
            .value = '${excelData[i]['title']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 1,
              rowIndex: i,
            ))
            .value = '${excelData[i]['positionType']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 2,
              rowIndex: i,
            ))
            .value = '${excelData[i]['location']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 3,
              rowIndex: i,
            ))
            .value = '${excelData[i]['departmentName']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 4,
              rowIndex: i,
            ))
            .value = '${excelData[i]['totalSanctioned']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 5,
              rowIndex: i,
            ))
            .value = '${excelData[i]['totalPositioned']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 6,
              rowIndex: i,
            ))
            .value = i ==
                0
            ? '${excelData[i]['levelName']}'
            : "${excelData[i]['totalSanctioned'] - excelData[i]['totalPositioned']}";
      }

      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          Directory directory;
          // code to create folder and save file start
          final baseStorage = await getExternalStorageDirectory();
          String newPath = "";
          List<String> paths = baseStorage!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);
          // code to create folder and save file END

          //Create Directory
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          print("Directory Path  ${directory.path}");
          //Create file in directory
          // File("${directory.path}/output_file_name1.xlsx")
          //     .createSync(recursive: true);

          // excel.save(fileName: "MyData.xlsx");

          // ignore: use_build_context_synchronously
          CommanDialog.showLoading(context);
          var fileBytes = excel.save();
          String randomNameToDownloadSameFileMultiTime = "";
          randomNameToDownloadSameFileMultiTime = getRandomString(6);
          try {
            File(provider.showProjectionStatusForSucessionPlanning
                ? "${directory.path}/  Key Positions Details - Delphi - NTPC Manpower $randomNameToDownloadSameFileMultiTime.xlsx"
                : "${directory.path}/ Succession Planning - Delphi - NTPC Manpower $randomNameToDownloadSameFileMultiTime.xlsx")
              ..createSync(recursive: true, exclusive: true)
              ..writeAsBytesSync(fileBytes!);
          } catch (error) {
            // ignore: use_build_context_synchronously
            CommanDialog.hideLoading(context);

            return;
          }

          // ignore: use_build_context_synchronously
          CommanDialog.hideLoading(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Downloading Complete"),
            ),
          );
        } else {
          print("Else");
        }
      }
    }
    if (type == ExcelDownloadType.P) {
      print("Downlaod data of Projection1234");
      final excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      List excelData = [
        {
          "positionID": 1062,
          "title": "Position",
          "positionType": "Type",
          "totalSanctioned": "Sanctioned",
          "totalPositioned": "Positioned",
          "vacantOneM": "Vacant in 1 Month",
          "vacantThreeM": "Vacant in 3 Months",
          "vacantSixM": "Vacant in 6 Months",
          "region": "CC",
          "project": "Services",
          "location": "Location",
          "departmentName": "Department",
          "subDepartmentName": "ENGG",
          "departmentGroupName": "ENGINEERING",
          "gradeName": "E8",
          "levelName": "",
        },
        ...provider.keyProjectionMonitoringData
      ];
      for (int i = 0; i < excelData.length; i++) {
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 0,
              rowIndex: i,
            ))
            .value = '${excelData[i]['title']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 1,
              rowIndex: i,
            ))
            .value = '${excelData[i]['positionType']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 2,
              rowIndex: i,
            ))
            .value = '${excelData[i]['departmentName']}';

        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 3,
              rowIndex: i,
            ))
            .value = '${excelData[i]['location']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 4,
              rowIndex: i,
            ))
            .value = '${excelData[i]['totalSanctioned']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 5,
              rowIndex: i,
            ))
            .value = '${excelData[i]['totalPositioned']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 6,
              rowIndex: i,
            ))
            .value = '${excelData[i]['vacantOneM']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 7,
              rowIndex: i,
            ))
            .value = '${excelData[i]['vacantThreeM']}';
        sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: 8,
              rowIndex: i,
            ))
            .value = '${excelData[i]['vacantSixM']}';
      }

      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          Directory directory;
          // code to create folder and save file start
          final baseStorage = await getExternalStorageDirectory();
          String newPath = "";
          List<String> paths = baseStorage!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);
          // code to create folder and save file END

          //Create Directory
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          print("Directory Path  ${directory.path}");
          //Create file in directory
          // File("${directory.path}/output_file_name1.xlsx")
          //     .createSync(recursive: true);

          // excel.save(fileName: "MyData.xlsx");

          // ignore: use_build_context_synchronously
          CommanDialog.showLoading(context);
          var fileBytes = excel.save();
          String randomNameToDownloadSameFileMultiTime = "";
          randomNameToDownloadSameFileMultiTime = getRandomString(6);
          try {
            File(
                "${directory.path}/SVP Analysis - Delphi - NTPC Manpower $randomNameToDownloadSameFileMultiTime.xlsx")
              ..createSync(recursive: true, exclusive: true)
              ..writeAsBytesSync(fileBytes!);
          } catch (error) {
            // ignore: use_build_context_synchronously
            CommanDialog.hideLoading(context);

            return;
          }

          // ignore: use_build_context_synchronously
          CommanDialog.hideLoading(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Downloading Complete"),
            ),
          );
        } else {
          print("Else");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Consumer<AllInProvider>(
          builder: (context, value, child) => Text(
            provider.showProjectionStatusForSucessionPlanning
                ? provider
                        .statusForshowKeyPositionMonitoringDataOrProjectionData
                    ? "Key Position Projection"
                    : "Key Position Monitoring"
                : "Succession Planning",
            style: CommonAppTheme.textstyleWithColorBlackF18,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CommonAppTheme.screenPadding),
          child: SafeArea(
            child: ListView(
              children: [
                Consumer<AllInProvider>(
                  builder: (context, value, child) => Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CommonAppTheme.borderRadious),
                    ),
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    child: ExpansionTile(
                      onExpansionChanged: ((value) {
                        // setState(() {
                        //   isExpandedValue = value;
                        // });
                      }),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(CommonAppTheme.whiteColor),
                        ),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Color(CommonAppTheme.appthemeColorForText),
                        ),
                      ),
                      backgroundColor: Color(CommonAppTheme.headerCommonColor),
                      collapsedBackgroundColor:
                          Color(CommonAppTheme.headerCommonColor),
                      title: Text(
                        "Summary",
                        style: TextStyle(
                          color: Color(
                            CommonAppTheme.whiteColor,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "S- ",
                                            style: TextStyle(
                                              color: Color(
                                                CommonAppTheme
                                                    .appthemeColorForText,
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            provider.keyPositionMonitoringSummaryData[
                                                's'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("P- ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            provider.keyPositionMonitoringSummaryData[
                                                'p'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("V- ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            "${int.parse(provider.keyPositionMonitoringSummaryData['s']) - int.parse(provider.keyPositionMonitoringSummaryData['p'])}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "To Be Vacant Key Positions",
                                    style: TextStyle(
                                      color: Color(
                                        CommonAppTheme.appthemeColorForText,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          provider
                                              .getSummySectonOneMTwoMSixMData(
                                                  context,
                                                  {"VacantDays": "30"});
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "1 Mon. -",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(CommonAppTheme
                                                    .headerCommonColor),
                                                decoration:
                                                    TextDecoration.underline,
                                                // decorationColor: Color(
                                                //   CommonAppTheme.buttonCommonColor,
                                                // ),
                                              ),
                                            ),
                                            Text(
                                              "${provider.keyPositionMonitoringSummaryData['1mon']} ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider
                                              .getSummySectonOneMTwoMSixMData(
                                                  context,
                                                  {"VacantDays": "90"});
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "3 Mon. - ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(CommonAppTheme
                                                    .headerCommonColor),
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            Text(
                                              "${provider.keyPositionMonitoringSummaryData['3mon']} ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider
                                              .getSummySectonOneMTwoMSixMData(
                                                  context,
                                                  {"VacantDays": "180"});
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "6 Mon. - ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(CommonAppTheme
                                                    .headerCommonColor),
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            Text(
                                              "${provider.keyPositionMonitoringSummaryData['6mon']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                Consumer<AllInProvider>(builder: (context, controller, _) {
                  return provider
                          .statusForshowKeyPositionMonitoringDataOrProjectionData
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    provider.deptGroupFilterValues.clear();
                                    provider.deptsubGroupFilterValues.clear();
                                    provider.deptFilterValues.clear();
                                    provider.projectCategoryFilterValues
                                        .clear();
                                    provider.locationFilterValues.clear();
                                    provider.gradeFilterValues.clear();
                                    provider.levelFilterValues.clear();
                                    selectedValue = '';
                                    selectedValue1 = '';
                                    selectedValue2 = '';

                                    provider.getKeyPositionMonitoringData(
                                        context,
                                        provider
                                            .keyPositionSearch_Post_filter_value,
                                        true,
                                        false,
                                        "Main/KeyPostions_Search_Post",
                                        true);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        CommonAppTheme.appCommonGreenColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          CommonAppTheme.borderRadious),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            color: Color(
                                              CommonAppTheme.whiteColor,
                                            ),
                                          ),
                                          Text(
                                            "Monitoring",
                                            style: TextStyle(
                                              color: Color(
                                                CommonAppTheme.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    downloadExcelFile(
                                      ExcelDownloadType.P,
                                      provider,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        CommonAppTheme.buttonCommonColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          CommonAppTheme.borderRadious),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_download_outlined,
                                            color: Color(
                                              CommonAppTheme.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // provider.selectedFilterValues1.clear();
                                    // provider.selectedFilterValues2.clear();
                                    // provider.selectedFilterValues3.clear();
                                    // provider.selectedFilterValues4.clear();
                                    // provider.selectedFilterValues5.clear();
                                    // provider.selectedFilterValues6.clear();
                                    // provider.selectedFilterValues7.clear();

                                    // customMenuBottomSheet();
                                    projectionFilter();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        CommonAppTheme.buttonCommonColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        CommonAppTheme.borderRadious,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.filter_list_outlined,
                                            color: Color(
                                              CommonAppTheme.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        CommonAppTheme.borderRadious),

                                    // color: Color(
                                    //   CommonAppTheme.buttonCommonColor,
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: Color(
                                                CommonAppTheme.whiteColor),
                                          ),
                                          width: 120,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: TextFormField(
                                              onChanged: (value) => provider
                                                  .monitoringProjectiionSearch(
                                                      value),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Search",
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  borderSide: BorderSide(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  borderSide: BorderSide(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(
                                                          CommonAppTheme
                                                              .buttonCommonColor,
                                                        )),
                                                    child: Icon(
                                                      Icons.search,
                                                      color: Color(
                                                          CommonAppTheme
                                                              .whiteColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // readOnly: true,ddhd
                                              onTap: () {
                                                //Go to the next screen
                                              },
                                              cursorColor: Colors.grey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            provider.pDep.isNotEmpty ||
                                    provider.pProject.isNotEmpty ||
                                    selectedValue3 != '' ||
                                    ridValue != ''
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedValue3 = '';
                                                      ridValue = '';
                                                      provider.pDep.clear();
                                                      provider.pProject.clear();
                                                    });
                                                    CommanDialog.showLoading(
                                                        context);
                                                    provider.getKeyProjectionMonitoringData(
                                                        context,
                                                        provider
                                                            .keyProjectionSearchPostfiltervalue,
                                                        false);
                                                  },
                                                  child: const Text(
                                                    "Clear All  ",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                ...provider.pDep.map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "${e['deptName']} ",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            provider.pDep.removeWhere(
                                                                (item) =>
                                                                    item[
                                                                        'deptName'] ==
                                                                    e['deptName']);

                                                            applyProjectionFilter(
                                                                false);
                                                          },
                                                          child: const Text(
                                                            "X ",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                ...provider.pProject.map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${e['pCategory']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              provider.pProject
                                                                  .removeWhere((item) =>
                                                                      item[
                                                                          'projectType'] ==
                                                                      e['projectType']);

                                                              applyProjectionFilter(
                                                                  false);
                                                            },
                                                            child: const Text(
                                                              "X ",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                selectedValue3 != ''
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    CommonAppTheme
                                                                        .borderRadious)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                selectedValue3,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    CommonAppTheme
                                                                        .whiteColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  selectedValue3 =
                                                                      '';
                                                                  applyProjectionFilter(
                                                                      false);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  " X ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                ridValue != ''
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    CommonAppTheme
                                                                        .borderRadious)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                ridValue,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    CommonAppTheme
                                                                        .whiteColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  ridValue = '';
                                                                  applyProjectionFilter(
                                                                      false);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  " X ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            CommonAppTheme.lineheightSpace20,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Consumer<AllInProvider>(
                                builder: (context, person, _) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0)),
                                child: DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: 1,
                                  border: TableBorder.all(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(0)),
                                  dataRowHeight: 40,
                                  headingRowColor: MaterialStateProperty.all(
                                    Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: returnTableColumnLable('Head of.'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('Project'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('S'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('P'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('V'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('1'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('3'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('6'),
                                    ),
                                    DataColumn(
                                      label: returnTableColumnLable('View'),
                                    ),
                                  ],
                                  rows: <DataRow>[
                                    ...provider.keyProjectionMonitoringData.map(
                                      (e) {
                                        return DataRow(
                                          color: MaterialStateProperty
                                              .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.08);
                                            }
                                            return Colors
                                                .white; // Use the default value.
                                          }),
                                          cells: <DataCell>[
                                            DataCell(
                                              InkWell(
                                                onTap: () {
                                                  provider.getKeyPositionDetail(
                                                      context, {
                                                    "PositionID":
                                                        "${e['positionID']}"
                                                  });
                                                },
                                                child: returnRowData(
                                                    " ${e['title'].replaceAll('Head Of', '')}"),
                                              ),
                                            ),
                                            DataCell(
                                              returnRowData(
                                                  ' ${e['location']}'),
                                            ),
                                            DataCell(
                                              Center(
                                                child: returnRowData(
                                                    ' ${e['totalSanctioned']}'),
                                              ),
                                            ),
                                            DataCell(
                                              InkWell(
                                                onTap: () {
                                                  if (e['totalPositioned'] >
                                                      0) {
                                                    provider
                                                        .getKeyPostionPositionedEmpData(
                                                            context, {
                                                      "PositionID":
                                                          "${e['positionID']}"
                                                    });
                                                    print(e['positionID']);
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    '${e['totalPositioned']}',
                                                    style: TextStyle(
                                                      color: Color(CommonAppTheme
                                                          .buttonCommonColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: returnRowData(
                                                    '${e['totalSanctioned'] - e['totalPositioned']}'),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: returnRowData(
                                                    '${e['vacantOneM']}'),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: returnRowData(
                                                    '${e['vacantThreeM']}'),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: returnRowData(
                                                    '${e['vacantSixM']}'),
                                              ),
                                            ),
                                            DataCell(
                                              InkWell(
                                                onTap: () {
                                                  provider.eligibalEmpListHeadingTitle =
                                                      e['title'];
                                                  provider.getEligibalEmpList(
                                                      context,
                                                      e['positionID'],
                                                      "Main/KeyPosition_Eligible_Candidate_Search_Post",
                                                      false);
                                                },
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/viewemp.png",
                                                    width: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList()
                                  ],
                                ),
                              );
                            }),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                provider.showProjectionStatusForSucessionPlanning
                                    ? InkWell(
                                        onTap: () {
                                          CommanDialog.showLoading(context);
                                          selectedValue3 = '';
                                          ridValue = '';
                                          provider.pDep.clear();
                                          provider.pProject.clear();
                                          provider.getKeyProjectionMonitoringData(
                                              context,
                                              provider
                                                  .keyProjectionSearchPostfiltervalue,
                                              false);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(
                                              CommonAppTheme
                                                  .appCommonGreenColor,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                CommonAppTheme.borderRadious),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.list,
                                                  color: Color(
                                                    CommonAppTheme.whiteColor,
                                                  ),
                                                ),
                                                Text(
                                                  "Projection",
                                                  style: TextStyle(
                                                    color: Color(
                                                      CommonAppTheme.whiteColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                !provider
                                        .showProjectionStatusForSucessionPlanning
                                    ? const SizedBox()
                                    : const SizedBox(
                                        width: 10,
                                      ),
                                InkWell(
                                  onTap: () {
                                    downloadExcelFile(
                                      ExcelDownloadType.M,
                                      provider,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        CommonAppTheme.buttonCommonColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          CommonAppTheme.borderRadious),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_download_outlined,
                                            color: Color(
                                              CommonAppTheme.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    showAvailableFilter();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                        CommonAppTheme.buttonCommonColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        CommonAppTheme.borderRadious,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.filter_list_outlined,
                                            color: Color(
                                              CommonAppTheme.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            CommonAppTheme.borderRadious),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20,
                                                ),
                                                color: Color(
                                                    CommonAppTheme.whiteColor),
                                              ),
                                              width: 120,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    provider.monitoringSearch(
                                                        value);
                                                  },

                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Search",
                                                    hintStyle: const TextStyle(
                                                        color: Colors.grey),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            10, 0, 0, 0),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            CommonAppTheme
                                                                .whiteColor),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            CommonAppTheme
                                                                .whiteColor),
                                                      ),
                                                    ),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(
                                                            CommonAppTheme
                                                                .buttonCommonColor,
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            // provider
                                                            //     .monitoringSearch(
                                                            //         minitoringSearch
                                                            //             .text);
                                                            // print(minitoringSearch
                                                            //     .text);
                                                          },
                                                          child: Icon(
                                                            Icons.search,
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // readOnly: true,ddhd
                                                  onTap: () {
                                                    //Go to the next screen
                                                  },
                                                  cursorColor: Colors.grey,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            provider.deptGroupFilterValues.isNotEmpty ||
                                    provider
                                        .deptsubGroupFilterValues.isNotEmpty ||
                                    provider.deptFilterValues.isNotEmpty ||
                                    provider.projectCategoryFilterValues
                                        .isNotEmpty ||
                                    provider.locationFilterValues.isNotEmpty ||
                                    provider.gradeFilterValues.isNotEmpty ||
                                    provider.levelFilterValues.isNotEmpty ||
                                    selectedValue != '' ||
                                    selectedValue1 != '' ||
                                    selectedValue2 != '' ||
                                    selectedValue3 != ''
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedValue = '';
                                                      selectedValue1 = '';
                                                      selectedValue2 = '';
                                                      provider
                                                          .deptGroupFilterValues
                                                          .clear();
                                                      provider
                                                          .deptsubGroupFilterValues
                                                          .clear();
                                                      provider.deptFilterValues
                                                          .clear();
                                                      provider
                                                          .projectCategoryFilterValues
                                                          .clear();
                                                      provider
                                                          .locationFilterValues
                                                          .clear();
                                                      provider.gradeFilterValues
                                                          .clear();
                                                      provider.levelFilterValues
                                                          .clear();
                                                    });
                                                    if (provider
                                                        .isOfflineData) {
                                                      provider
                                                          .getKeyPositionDataOffine(
                                                        context,
                                                        provider
                                                            .keyPositionSearch_Post_filter_value,
                                                        false,
                                                        true,
                                                      );
                                                    } else {
                                                      provider
                                                          .getKeyPositionMonitoringData1(
                                                        context,
                                                        provider
                                                            .keyPositionSearch_Post_filter_value,
                                                        false,
                                                        provider.showProjectionStatusForSucessionPlanning
                                                            ? "Main/KeyPostions_Search_Post"
                                                            : "Main/Succession_Search_Post",
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "Clear All  ",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                selectedValue != ""
                                                    ? const Text("P.T. ")
                                                    : const SizedBox(),
                                                selectedValue != ""
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    CommonAppTheme
                                                                        .borderRadious)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  selectedValue,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        Color(
                                                                      CommonAppTheme
                                                                          .whiteColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedValue =
                                                                          '';
                                                                    });

                                                                    applyMonitoringFilter(
                                                                        false);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    " X ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      )
                                                    : const SizedBox(),
                                                selectedValue1 != ""
                                                    ? const Text("Published. ")
                                                    : const SizedBox(),
                                                selectedValue1 != ""
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    CommonAppTheme
                                                                        .borderRadious)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  selectedValue1,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        Color(
                                                                      CommonAppTheme
                                                                          .whiteColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedValue1 =
                                                                          '';
                                                                    });

                                                                    applyMonitoringFilter(
                                                                        false);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    " X ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      )
                                                    : const SizedBox(),
                                                // Text("Dept. Group: "),

                                                provider.deptGroupFilterValues
                                                        .isNotEmpty
                                                    ? const Text(
                                                        "Dept. Group: ")
                                                    : const SizedBox(),
                                                ...provider
                                                    .deptGroupFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${e['groupDeptName']} ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .deptGroupFilterValues
                                                                    .removeWhere(
                                                                        (item) =>
                                                                            item['groupDeptName'] ==
                                                                            e['groupDeptName']);
                                                                applyMonitoringFilter(
                                                                    false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                // Text("Sub. Group: "),
                                                provider.deptsubGroupFilterValues
                                                        .isNotEmpty
                                                    ? const Text(
                                                        "Sub. Group:  ")
                                                    : const SizedBox(),
                                                ...provider
                                                    .deptsubGroupFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${e['subDeptName']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              provider
                                                                  .deptsubGroupFilterValues
                                                                  .removeWhere(
                                                                      (item) =>
                                                                          item[
                                                                              'subDeptName'] ==
                                                                          e['subDeptName']);
                                                              applyMonitoringFilter(
                                                                  false);
                                                            },
                                                            child: const Text(
                                                              " X ",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                provider.deptFilterValues
                                                        .isNotEmpty
                                                    ? const Text("Dept: ")
                                                    : const SizedBox(),
                                                ...provider.deptFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${e['deptName']}",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .deptFilterValues
                                                                    .removeWhere(
                                                                        (item) =>
                                                                            item['deptName'] ==
                                                                            e['deptName']);
                                                                applyMonitoringFilter(
                                                                    false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),

                                                provider.projectCategoryFilterValues
                                                        .isNotEmpty
                                                    ? const Text("P.C.: ")
                                                    : const SizedBox(),
                                                ...provider
                                                    .projectCategoryFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${e['projectType']}",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .projectCategoryFilterValues
                                                                    .removeWhere(
                                                                        (item) =>
                                                                            item['projectType'] ==
                                                                            e['projectType']);
                                                                applyMonitoringFilter(
                                                                    false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                provider.locationFilterValues
                                                        .isNotEmpty
                                                    ? const Text("Loc: ")
                                                    : const SizedBox(),
                                                ...provider.locationFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${e['pCategory']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              provider
                                                                  .locationFilterValues
                                                                  .removeWhere(
                                                                      (item) =>
                                                                          item[
                                                                              'project'] ==
                                                                          e['project']);
                                                              applyMonitoringFilter(
                                                                  false);
                                                            },
                                                            child: const Text(
                                                              " X ",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                provider.gradeFilterValues
                                                        .isNotEmpty
                                                    ? const Text("Grade: ")
                                                    : const SizedBox(),
                                                ...provider.gradeFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${e['levelName']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              provider
                                                                  .gradeFilterValues
                                                                  .removeWhere(
                                                                      (item) =>
                                                                          item[
                                                                              'levelName'] ==
                                                                          e['levelName']);
                                                              applyMonitoringFilter(
                                                                  false);
                                                            },
                                                            child: const Text(
                                                              " X ",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                provider.levelFilterValues
                                                        .isNotEmpty
                                                    ? const Text("Level: ")
                                                    : const SizedBox(),
                                                ...provider.levelFilterValues
                                                    .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: Color(CommonAppTheme
                                                            .buttonCommonColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                CommonAppTheme
                                                                    .borderRadious)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${e['levelName']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              provider
                                                                  .levelFilterValues
                                                                  .removeWhere(
                                                                      (item) =>
                                                                          item[
                                                                              'levelName'] ==
                                                                          e['levelName']);
                                                              applyMonitoringFilter(
                                                                  false);
                                                            },
                                                            child: const Text(
                                                              " X ",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                selectedValue2 != ""
                                                    ? const Text("V.S.: ")
                                                    : const SizedBox(),
                                                selectedValue2 != ""
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    CommonAppTheme
                                                                        .borderRadious)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  selectedValue2,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        Color(
                                                                      CommonAppTheme
                                                                          .whiteColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedValue2 =
                                                                          '';
                                                                    });

                                                                    applyMonitoringFilter(
                                                                        false);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    " X ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            CommonAppTheme.lineheightSpace20,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Consumer<AllInProvider>(
                                builder: (context, person, _) {
                              return provider.isOfflineData
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: DataTable(
                                        horizontalMargin: 0,
                                        columnSpacing: 2,
                                        border: TableBorder.all(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        dataRowHeight: 40,
                                        headingRowColor:
                                            MaterialStateProperty.all(
                                          Color(
                                              CommonAppTheme.buttonCommonColor),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: returnTableColumnLable(
                                                'Head of.'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable(
                                                'Project'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('S'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('P'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('V'),
                                          ),
                                        ],
                                        rows: <DataRow>[
                                          ...provider.keyPositionMonitoringData
                                              .map(
                                            (e) {
                                              return DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.08);
                                                  }
                                                  return Colors
                                                      .white; // Use the default value.
                                                }),
                                                cells: <DataCell>[
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        if (provider
                                                            .isOfflineData) {
                                                          provider
                                                              .getKeyPositionDetailOfflineData(
                                                                  context,
                                                                  e['positionID'],
                                                                  e);
                                                        } else
                                                          provider
                                                              .getKeyPositionDetail(
                                                            context,
                                                            {
                                                              "PositionID":
                                                                  "${e['positionID']}"
                                                            },
                                                          );
                                                      },
                                                      child: returnRowData(
                                                        " ${e['title'].replaceAll('Head Of', '')}",
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    returnRowData(
                                                      provider.isOfflineData
                                                          ? ' ${e['projectName']}'
                                                          : ' ${e['location']}',
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: returnRowData(
                                                        ' ${e['totalSanctioned']}',
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        if (e['totalPositioned'] >
                                                            0) {
                                                          provider
                                                              .getKeyPostionPositionedEmpData(
                                                                  context, {
                                                            "PositionID":
                                                                "${e['positionID']}"
                                                          });
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${e['totalPositioned']}',
                                                          style: TextStyle(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: returnRowData(
                                                        '${e['totalSanctioned'] - e['totalPositioned']}',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ).toList()
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: DataTable(
                                        horizontalMargin: 0,
                                        columnSpacing: 2,
                                        border: TableBorder.all(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        dataRowHeight: 40,
                                        headingRowColor:
                                            MaterialStateProperty.all(
                                          Color(
                                              CommonAppTheme.buttonCommonColor),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: returnTableColumnLable(
                                                'Head of.'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable(
                                                'Project'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('S'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('P'),
                                          ),
                                          DataColumn(
                                            label: returnTableColumnLable('V'),
                                          ),
                                          DataColumn(
                                            label:
                                                returnTableColumnLable('View'),
                                          ),
                                        ],
                                        rows: <DataRow>[
                                          ...provider.keyPositionMonitoringData
                                              .map(
                                            (e) {
                                              return DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.08);
                                                  }
                                                  return Colors
                                                      .white; // Use the default value.
                                                }),
                                                cells: <DataCell>[
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        if (provider
                                                            .isOfflineData) {
                                                          provider
                                                              .getKeyPositionDetailOfflineData(
                                                                  context,
                                                                  e['positionID'],
                                                                  e);
                                                        } else
                                                          provider
                                                              .getKeyPositionDetail(
                                                            context,
                                                            {
                                                              "PositionID":
                                                                  "${e['positionID']}"
                                                            },
                                                          );
                                                      },
                                                      child: returnRowData(
                                                        " ${e['title'].replaceAll('Head Of', '')}",
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    returnRowData(
                                                      provider.isOfflineData
                                                          ? ' ${e['projectName']}'
                                                          : ' ${e['location']}',
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: returnRowData(
                                                        ' ${e['totalSanctioned']}',
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        if (e['totalPositioned'] >
                                                            0) {
                                                          provider
                                                              .getKeyPostionPositionedEmpData(
                                                                  context, {
                                                            "PositionID":
                                                                "${e['positionID']}"
                                                          });
                                                        }
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${e['totalPositioned']}',
                                                          style: TextStyle(
                                                            color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: returnRowData(
                                                        '${e['totalSanctioned'] - e['totalPositioned']}',
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        provider.eligibalEmpListHeadingTitle =
                                                            e['title'];
                                                        provider.getEligibalEmpList(
                                                            context,
                                                            e['positionID'],
                                                            "Main/KeyPosition_Eligible_Candidate_Search_Post",
                                                            false);
                                                      },
                                                      child: Center(
                                                        child: Image.asset(
                                                          "assets/images/viewemp.png",
                                                          width: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ).toList()
                                        ],
                                      ),
                                    );
                            }),
                          ],
                        );
                }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
