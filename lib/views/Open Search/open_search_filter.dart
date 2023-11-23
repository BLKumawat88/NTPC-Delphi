import 'dart:developer';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/theme/common_dialog.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';
import 'package:flutter/material.dart';

class OpenSearchFilter extends StatefulWidget {
  const OpenSearchFilter({super.key});

  @override
  State<OpenSearchFilter> createState() => _OpenSearchFilterState();
}

class _OpenSearchFilterState extends State<OpenSearchFilter> {
  List holdFilteredDataFromDepGroup = [];
  List holdFilteredDataFromGeneralDepartment = [];

  Color colorOfSelectedFilter = Colors.green;

  int tranningSDate = 00;
  int tranningEDate = 11;

  int dobMin = 1;
  int dobMax = 2;

  int sMin = 3;
  int sMax = 4;

  int pMin = 5;
  int pMax = 6;

  int dMin = 7;
  int dMax = 8;

  int gMin = 9;
  int gMax = 10;

  Widget dotForSelectedFilter() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorOfSelectedFilter,
      ),
      height: 10,
      width: 10,
    );
  }

  selectDate(context, type, DateTime currentDate, firstDate, lastDate) async {
    // DateTime currentDate = DateTime.now();
    // DateTime firstDate = DateTime(2023, 03, 03);
    // DateTime lastDate = DateTime.now();
    AllInProvider provider = Provider.of(context, listen: false);

    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (userSelectedDate == null) {
      return;
    } else {
      setState(
        () {
          currentDate = userSelectedDate;
          if (type == dobMin) {
            provider.dobmin =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == dobMax) {
            provider.dobMax =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == sMin) {
            provider.superannuationMin =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == sMax) {
            provider.superannuationMax =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == pMin) {
            provider.dojProjectMin =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == pMax) {
            provider.dojProjectMax =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == dMin) {
            provider.dOJDepartmentMin =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == dMax) {
            provider.dOJDepartmentMax =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == gMin) {
            provider.dOEGradeMin =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == gMax) {
            provider.dOEGradeMax =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == tranningSDate) {
            provider.tranningStartDate =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else if (type == tranningEDate) {
            provider.tranningEndDate =
                '${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}/${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}/${currentDate.year}';
          } else {
            print("Route did not match");
          }
        },
      );
    }
  }

  tranningDateFrom() {
    selectDate(
      context,
      tranningSDate,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  tranningDateTo() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.tranningStartDate == "Start Date") {
      CommanDialog.showErrorDialog(context,
          description: "Please select Start Date");
    } else {
      List dummy = provider.tranningStartDate.split("-");
      selectDate(
        context,
        tranningEDate,
        DateTime.now(),
        DateTime(int.parse(dummy[2]), int.parse(dummy[1]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  dobFrom() {
    selectDate(
      context,
      dobMin,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  dobTo() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.dobmin == "Date of Birth") {
      CommanDialog.showErrorDialog(context,
          description: "Please select DOB From");
    } else {
      List dummy = provider.dobmin.split("/");
      selectDate(
        context,
        dobMax,
        DateTime.now(),
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  dOSFrom() {
    selectDate(
      context,
      sMin,
      DateTime.now(),
      DateTime.now(),
      DateTime(3000),
    );
  }

  dOSTO() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.superannuationMin == "DOS") {
      CommanDialog.showErrorDialog(context,
          description: "Please select DOS From");
    } else {
      List dummy = provider.superannuationMin.split("/");
      selectDate(
        context,
        sMax,
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime(3000),
      );
    }
  }

  doJPFrom() {
    selectDate(
      context,
      pMin,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  doJPTo() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.dojProjectMin == "DOJ Project") {
      CommanDialog.showErrorDialog(context,
          description: "Please select DOJ From");
    } else {
      List dummy = provider.dojProjectMin.split("/");
      selectDate(
        context,
        pMax,
        DateTime.now(),
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  doJDFrom() {
    selectDate(
      context,
      dMin,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  doJDTo() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.dOJDepartmentMin == "DOJ Department") {
      CommanDialog.showErrorDialog(context,
          description: "Please select DOJ Department From");
    } else {
      List dummy = provider.dOJDepartmentMin.split("/");
      selectDate(
        context,
        dMax,
        DateTime.now(),
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  doEGFrom() {
    selectDate(
      context,
      gMin,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  doEGTO() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.dOEGradeMin == "DOE Grade") {
      CommanDialog.showErrorDialog(context,
          description: "Please select DOE Grade From");
    } else {
      List dummy = provider.dOEGradeMin.split("/");
      selectDate(
        context,
        gMax,
        DateTime.now(),
        DateTime(int.parse(dummy[1]), int.parse(dummy[2]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  Widget returnDateUi(
    AllInProvider provider,
    text,
    Function datePickerMethodName,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            GestureDetector(
              onTap: () {
                datePickerMethodName();
              },
              child: const Icon(
                Icons.calendar_month,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    AllInProvider provider = Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
    provider.diagnosis.text = "";
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
        "Filter Page",
        context,
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
            padding: EdgeInsets.all(CommonAppTheme.screenPadding),
            child: ListView(
              children: [
                ExpansionTile(
                  initiallyExpanded: provider.isFunctionalExp,
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.masterDepartmentGroupFilterValues.isNotEmpty ||
                              provider.masterDepartmentSubGroupFilterValues
                                  .isNotEmpty ||
                              provider
                                  .masterDepartmentFilterValues.isNotEmpty ||
                              provider.masterWorkProfileValues.isNotEmpty ||
                              provider.masterDepartmentExpEmpGroupValue != "" ||
                              provider.masterRegionValues.isNotEmpty ||
                              provider.masterProjectValues.isNotEmpty ||
                              provider.keyPositionHoldingAsOnDate ||
                              provider.keyPositionHoldedInPast
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Overall Experience "),
                    ],
                  ),
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 0),
                        initiallyExpanded: provider.isFunctionalExp,
                        title: Row(
                          children: [
                            provider.masterDepartmentGroupFilterValues.isNotEmpty ||
                                    provider
                                        .masterDepartmentSubGroupFilterValues
                                        .isNotEmpty ||
                                    provider.masterDepartmentFilterValues
                                        .isNotEmpty ||
                                    provider
                                        .masterWorkProfileValues.isNotEmpty ||
                                    provider.masterDepartmentExpEmpGroupValue !=
                                        ""
                                ? dotForSelectedFilter()
                                : const SizedBox(),
                            const Text(" Functional Exp."),
                          ],
                        ),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MultiSelectDialogField(
                                  searchable: true,
                                  dialogHeight: 250,
                                  initialValue: provider
                                      .masterDepartmentGroupFilterValues,
                                  items: provider.mastDepartmentGroupFilter,
                                  title: const Text(
                                    "Depart. Group",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Depart. Group",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    // To show all pervious selected filter when user open the filter screen again after applying filter
                                    setState(
                                      () {
                                        provider
                                            .masterDepartmentGroupFilterValues
                                            .clear();
                                        provider
                                            .masterDepartmentGroupFilterValues
                                            .addAll(results);
                                      },
                                    );
                                    //Clear Data of both deptSubGroup and Department while Select New Department Group
                                    if (provider
                                            .masterDepartmentSubGroupFilterValues
                                            .isNotEmpty ||
                                        provider.masterDepartmentFilterValues
                                            .isNotEmpty) {
                                      provider
                                          .masterDepartmentSubGroupFilterValues
                                          .clear();
                                      provider.masterDepartmentFilterValues
                                          .clear();
                                      provider
                                          .reOpenMasterFilterScreen(context);

                                      // customMenuBottomSheet();
                                    }
                                    if (results.isEmpty) {
                                      setState(
                                        () {
                                          provider
                                              .masterDepartmentSubGroupFilterDummyData
                                              .clear();
                                          provider.masterDepartmentSubGroupFilterDummyData =
                                              provider.subDepartmentsF
                                                  .map((subjectdataa) {
                                            return MultiSelectItem(subjectdataa,
                                                subjectdataa['subDeptName']);
                                          }).toList();
                                          provider
                                              .masterDepartmentFilterDummyData
                                              .clear();
                                          provider.masterDepartmentFilterDummyData =
                                              provider.departmentsF
                                                  .map((subjectdataa) {
                                            return MultiSelectItem(subjectdataa,
                                                subjectdataa['deptName']);
                                          }).toList();
                                        },
                                      );
                                    } else {
                                      // Show the avaialble filter of Department group and Department according to Department Group
                                      setState(() {
                                        provider
                                            .masterDepartmentSubGroupFilterDummyData
                                            .clear();
                                      });
                                      List dummySubDeptGroupData = [];
                                      List depCasData = [];
                                      for (var i = 0; i < results.length; i++) {
                                        dummySubDeptGroupData.addAll(provider
                                            .subDepartmentsF
                                            .where((element) =>
                                                element['groupDeptCode'] ==
                                                results[i]['groupDeptCode'])
                                            .toList());
                                      }
                                      provider.masterDepartmentSubGroupFilterDummyData =
                                          dummySubDeptGroupData
                                              .map((subjectdataa) {
                                        return MultiSelectItem(subjectdataa,
                                            subjectdataa['subDeptName']);
                                      }).toList();

                                      //Dep Cas data
                                      for (var i = 0; i < results.length; i++) {
                                        depCasData.addAll(provider.departmentsF
                                            .where((element) =>
                                                element['groupDeptCode'] ==
                                                results[i]['groupDeptCode'])
                                            .toList());

                                        provider.masterDepartmentFilterDummyData
                                            .clear();
                                        holdFilteredDataFromDepGroup.clear();
                                        holdFilteredDataFromDepGroup
                                            .addAll(depCasData);
                                      }
                                      provider.masterDepartmentFilterDummyData =
                                          depCasData.map((subjectdataa) {
                                        return MultiSelectItem(subjectdataa,
                                            subjectdataa['deptName']);
                                      }).toList();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MultiSelectDialogField(
                                  dialogHeight: 250,
                                  searchable: true,
                                  initialValue: provider
                                      .masterDepartmentSubGroupFilterValues,
                                  items: provider
                                      .masterDepartmentSubGroupFilterDummyData,
                                  title: const Text(
                                    "Dep.Sub Group",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Dep. Sub Group",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    // To show selected Filter when open filter Screen again
                                    setState(
                                      () {
                                        provider
                                            .masterDepartmentSubGroupFilterValues
                                            .clear();

                                        provider
                                            .masterDepartmentSubGroupFilterValues
                                            .addAll(results);
                                      },
                                    );

                                    if (provider.masterDepartmentFilterValues
                                        .isNotEmpty) {
                                      provider.masterDepartmentFilterValues
                                          .clear();
                                      provider
                                          .reOpenMasterFilterScreen(context);

                                      // customMenuBottomSheet();
                                    }

                                    if (results.isEmpty) {
                                      //to show all filter values again
                                      setState(() {
                                        provider.masterDepartmentFilterDummyData
                                            .clear();
                                        if (holdFilteredDataFromDepGroup
                                            .isNotEmpty) {
                                          provider
                                              .masterDepartmentSubGroupFilterDummyData
                                              .clear();
                                          for (int i = 0;
                                              i <
                                                  holdFilteredDataFromDepGroup
                                                      .length;
                                              i++) {
                                            setState(() {
                                              provider.masterDepartmentSubGroupFilterDummyData =
                                                  holdFilteredDataFromDepGroup
                                                      .map((subjectdataa) {
                                                return MultiSelectItem(
                                                    subjectdataa,
                                                    subjectdataa[
                                                        'subDeptName']);
                                              }).toList();

                                              // provider
                                              //     .masterDepartmentSubGroupFilterDummyData
                                              //     .add(
                                              //         holdFilteredDataFromDepGroup[
                                              //             i]);
                                            });
                                          }
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        provider.masterDepartmentFilterDummyData
                                            .clear();
                                      });
                                      List dataAfterFilter = [];
                                      for (var i = 0; i < results.length; i++) {
                                        dataAfterFilter.addAll(
                                          provider.departmentsF
                                              .where((element) =>
                                                  element['subDeptCode'] ==
                                                  results[i]['subDeptCode'])
                                              .toList(),
                                        );
                                      }
                                      provider.masterDepartmentFilterDummyData =
                                          dataAfterFilter.map((subjectdataa) {
                                        return MultiSelectItem(subjectdataa,
                                            subjectdataa['deptName']);
                                      }).toList();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MultiSelectDialogField(
                                  dialogHeight: 250,
                                  searchable: true,
                                  initialValue:
                                      provider.masterDepartmentFilterValues,
                                  items:
                                      provider.masterDepartmentFilterDummyData,
                                  title: const Text(
                                    "Department",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Department",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    setState(
                                      () {
                                        provider.masterDepartmentFilterValues
                                            .clear();
                                        provider.masterDepartmentFilterValues
                                            .addAll(results);
                                      },
                                    );
                                    if (results.isEmpty) {
                                      //to show all filter values again
                                      setState(() {
                                        provider
                                            .masterWorkProfileFilterDummyData
                                            .clear();
                                      });
                                    } else {
                                      setState(() {
                                        provider
                                            .masterWorkProfileFilterDummyData
                                            .clear();
                                      });

                                      List dataAfterFilter = [];
                                      for (var i = 0; i < results.length; i++) {
                                        dataAfterFilter.addAll(
                                            provider.workAreaF.where((element) {
                                          return element['departmentID'] ==
                                              results[i]['deptCode'];
                                        }).toList());
                                      }
                                      provider.masterWorkProfileFilterDummyData =
                                          dataAfterFilter.map((subjectdataa) {
                                        return MultiSelectItem(subjectdataa,
                                            subjectdataa['workProfile']);
                                      }).toList();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MultiSelectDialogField(
                                  dialogHeight: 250,
                                  searchable: true,
                                  initialValue:
                                      provider.masterWorkProfileValues,
                                  items:
                                      provider.masterWorkProfileFilterDummyData,
                                  title: const Text(
                                    "Work Profile",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Work Profile",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    setState(() {
                                      log("results $results");
                                      provider.masterWorkProfileValues.clear();

                                      provider.masterWorkProfileValues
                                          .addAll(results);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      value: provider
                                          .masterDepartmentExpEmpGroupValue,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            provider.masterDepartmentExpEmpGroupValue =
                                                value.toString();
                                          },
                                        );
                                        print(provider
                                            .masterDepartmentExpEmpGroupValue);
                                      },
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: '',
                                          child: Text(
                                            "Emp. Group Exp",
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
                                        ...provider.masterDepartmentExpEmpGroup
                                            .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value['gradeCode'],
                                                      child: Text(
                                                        value['grade'],
                                                        style: TextStyle(
                                                          color: Color(
                                                              CommonAppTheme
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
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<AllInProvider>(
                            builder: (context, value, child) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.totalFunExpMin.round()} ",
                                    ),
                                    Text(
                                      "- ${provider.totalFunExpMax.round()} ",
                                    ),
                                    const Text(
                                      "Years",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                RangeSlider(
                                  values: provider.totalFunExpMinTotalFunExpMax,
                                  max: 45,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    provider.totalFunExpMinTotalFunExpMax.start
                                        .round()
                                        .toString(),
                                    provider.totalFunExpMinTotalFunExpMax.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    provider.updatetotalFunExpMinTotalLocExpMax(
                                        values);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 0),
                        title: Row(
                          children: [
                            provider.masterRegionValues.isNotEmpty ||
                                    provider.masterProjectValues.isNotEmpty
                                ? dotForSelectedFilter()
                                : const SizedBox(),
                            const Text(" Regional/Location Exp."),
                          ],
                        ),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MultiSelectDialogField(
                                  dialogHeight: 250,
                                  searchable: true,
                                  initialValue: provider.masterRegionValues,
                                  items: provider.masterRegionFilterData,
                                  title: const Text(
                                    "Region",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Region",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    setState(
                                      () {
                                        provider.masterRegionValues.clear();
                                        provider.masterRegionValues
                                            .addAll(results);
                                      },
                                    );

                                    if (results.isEmpty) {
                                      //to show all filter values again
                                      setState(() {
                                        provider.masterProjectDummyData.clear();
                                        provider.masterProjectDummyData =
                                            provider.projectF
                                                .map((subjectdataa) {
                                          return MultiSelectItem(subjectdataa,
                                              subjectdataa['pCategory']);
                                        }).toList();
                                      });
                                    } else {
                                      setState(() {
                                        provider.masterProjectDummyData.clear();
                                      });
                                      List dataAfterFilter = [];
                                      for (var i = 0; i < results.length; i++) {
                                        print(results[i]['regionCode']
                                            .toInt()
                                            .runtimeType);
                                        dataAfterFilter.addAll(
                                            provider.projectF.where((element) {
                                          return element['regionID'] ==
                                              results[i]['regionCode']
                                                  .toInt()
                                                  .toString();
                                        }).toList());
                                      }

                                      provider.masterProjectDummyData =
                                          dataAfterFilter.map((subjectdataa) {
                                        return MultiSelectItem(subjectdataa,
                                            subjectdataa['pCategory']);
                                      }).toList();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MultiSelectDialogField(
                                  dialogHeight: 250,
                                  searchable: true,
                                  initialValue: provider.masterProjectValues,
                                  items: provider.masterProjectDummyData,
                                  title: const Text(
                                    "Project",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  selectedColor: Colors.black,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F6FA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  buttonIcon: Icon(Icons.arrow_drop_down,
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  buttonText: Text(
                                    "Project",
                                    style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      fontSize: 16,
                                    ),
                                  ),
                                  onConfirm: (results) {
                                    setState(() {
                                      provider.masterProjectValues.clear();
                                      provider.masterProjectValues
                                          .addAll(results);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<AllInProvider>(
                            builder: (context, value, child) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.totalLocExpMin.round()} ",
                                    ),
                                    Text(
                                      "- ${provider.totalLocExpMax.round()} ",
                                    ),
                                    const Text(
                                      "Years",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                RangeSlider(
                                  values: provider.totalLocExpMinTotalLocExpMax,
                                  max: 45,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    provider.totalLocExpMinTotalLocExpMax.start
                                        .round()
                                        .toString(),
                                    provider.totalLocExpMinTotalLocExpMax.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    provider.updatetotalLocExpMinTotalLocExpMax(
                                        values);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: Consumer<AllInProvider>(
                        builder: (context, value, child) => ExpansionTile(
                          tilePadding: const EdgeInsets.only(left: 0),
                          title: Row(
                            children: [
                              provider.keyPositionHoldingAsOnDate ||
                                      provider.keyPositionHoldedInPast
                                  ? dotForSelectedFilter()
                                  : const SizedBox(),
                              const Text(" Key Position"),
                            ],
                          ),
                          children: [
                            CheckboxListTile(
                              // controlAffinity: ListTileControlAffinity.leading,
                              value: provider.keyPositionHoldingAsOnDate,
                              onChanged: (value) {
                                provider
                                    .updateKeyPositionHoldingAsOnDate(value);
                                setState(() {});
                              },
                              title: const Text("Holding as on date"),
                            ),
                            CheckboxListTile(
                              value: provider.keyPositionHoldedInPast,
                              onChanged: (value) {
                                provider.updateKeyPositionHoldedInPast(value);
                                setState(() {});
                              },
                              title: const Text("Held in past"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.masterCategoryValues.isNotEmpty ||
                              provider.masterProjectCategoryValues.isNotEmpty ||
                              provider.masterCurrentProjectRegionValues
                                  .isNotEmpty ||
                              provider.masterCurrentProjectProjectValues
                                  .isNotEmpty ||
                              provider.masterCurrentProjectProjectLocationValues
                                  .isNotEmpty ||
                              provider
                                  .masterDepartmentDepartmentGroupFilterValues
                                  .isNotEmpty ||
                              provider
                                  .masterDepartmentDepartmentSubGroupFilterValues
                                  .isNotEmpty ||
                              provider.masterDepartmentDepartmentFilterValues
                                  .isNotEmpty ||
                              provider.masterDepartmentWorkProfileValues
                                  .isNotEmpty ||
                              provider.masterStatesValues.isNotEmpty ||
                              provider.masterEmployeeGroupValues.isNotEmpty ||
                              provider.masterGradeValues.isNotEmpty ||
                              provider
                                  .masterSubstantiveGradeValues.isNotEmpty ||
                              provider.masterLavelValues.isNotEmpty ||
                              provider.masterGenderSelectedValue != "" ||
                              provider.masterPHHearing ||
                              provider.masterPHOrtho ||
                              provider.masterPHVisual ||
                              provider.masterVigilanceSelectedValue == "1" ||
                              provider.masterVigilanceSelectedValue == "2" ||
                              provider.masterAssociationsCommitteesValues
                                  .isNotEmpty ||
                              provider
                                  .masterAssociationsMemberValues.isNotEmpty ||
                              provider
                                  .masterAssociationsFacultyValues.isNotEmpty ||
                              provider.masterInterestAwardInterestValues
                                  .isNotEmpty ||
                              provider.masterInterestAwardAchievementValues
                                  .isNotEmpty ||
                              provider.isAgeSelected ||
                              provider.isGeneralBalanceSelected
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" General "),
                    ],
                  ),
                  children: [
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.isAgeSelected
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Age"),
                        ],
                      ),
                      children: [
                        Consumer<AllInProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.generalAgeMin.round()} ",
                                  ),
                                  Text(
                                    "- ${provider.generalAgeMax.round()} ",
                                  ),
                                  const Text(
                                    "Years",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              RangeSlider(
                                values: provider.generalAgeMinMax,
                                min: 18,
                                max: 60,
                                divisions: 100,
                                labels: RangeLabels(
                                  provider.generalAgeMinMax.start
                                      .round()
                                      .toString(),
                                  provider.generalAgeMinMax.end
                                      .round()
                                      .toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  provider.isAgeSelected = true;
                                  provider.updateGeneralAge(values);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.isGeneralBalanceSelected
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Balance Service"),
                        ],
                      ),
                      children: [
                        Consumer<AllInProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.generalBalanceMin.round()} ",
                                  ),
                                  Text(
                                    "- ${provider.generalBalanceMax.round()} ",
                                  ),
                                  const Text(
                                    "Years",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              RangeSlider(
                                values: provider.generalBalanceServiceMinMax,
                                max: 45,
                                divisions: 100,
                                labels: RangeLabels(
                                  provider.generalBalanceServiceMinMax.start
                                      .round()
                                      .toString(),
                                  provider.generalBalanceServiceMinMax.end
                                      .round()
                                      .toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  provider.updateGeneralBalanceService(values);
                                  provider.isGeneralBalanceSelected = true;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterCategoryValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Category"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider.masterCategoryValues,
                                items: provider.mastCategoryFilter,
                                title: const Text(
                                  "Category",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Category",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {
                                    provider.masterCategoryValues.clear();
                                    provider.masterCategoryValues
                                        .addAll(results);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterProjectCategoryValues.isNotEmpty ||
                                  provider.masterCurrentProjectRegionValues
                                      .isNotEmpty ||
                                  provider.masterCurrentProjectProjectValues
                                      .isNotEmpty ||
                                  provider
                                      .masterCurrentProjectProjectLocationValues
                                      .isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Current Project"),
                        ],
                      ),
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: MultiSelectDialogField(
                                    dialogHeight: 250,
                                    searchable: true,
                                    initialValue:
                                        provider.masterProjectCategoryValues,
                                    items: provider
                                        .masterProjectCategoryFilterData,
                                    title: const Text(
                                      "Category",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    selectedColor: Colors.black,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF0F6FA),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    buttonIcon: Icon(Icons.arrow_drop_down,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor)),
                                    buttonText: Text(
                                      "Category",
                                      style: TextStyle(
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm: (results) {
                                      setState(() {
                                        provider.masterProjectCategoryValues
                                            .clear();
                                        provider.masterProjectCategoryValues
                                            .addAll(results);
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MultiSelectDialogField(
                                    dialogHeight: 250,
                                    searchable: true,
                                    initialValue: provider
                                        .masterCurrentProjectRegionValues,
                                    items: provider
                                        .masterCurrentProjectRegionDummyData,
                                    title: const Text(
                                      "Region",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    selectedColor: Colors.black,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF0F6FA),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    buttonIcon: Icon(Icons.arrow_drop_down,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor)),
                                    buttonText: Text(
                                      "Region",
                                      style: TextStyle(
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm: (results) {
                                      setState(() {
                                        provider
                                            .masterCurrentProjectRegionValues
                                            .clear();
                                        provider
                                            .masterCurrentProjectRegionValues
                                            .addAll(results);
                                      });

                                      if (results.isEmpty) {
                                        //to show all filter values again
                                        setState(() {
                                          provider
                                              .masterCurrentProjectProjectFilterData
                                              .clear();
                                          provider.masterCurrentProjectProjectFilterData =
                                              provider.projectF
                                                  .map((subjectdataa) {
                                            return MultiSelectItem(subjectdataa,
                                                subjectdataa['pCategory']);
                                          }).toList();
                                        });
                                      } else {
                                        setState(() {
                                          provider
                                              .masterCurrentProjectProjectFilterData
                                              .clear();
                                        });
                                        List dataAfterFilter = [];
                                        for (var i = 0;
                                            i < results.length;
                                            i++) {
                                          dataAfterFilter.addAll(provider
                                              .projectF
                                              .where((element) {
                                            return element['regionID'] ==
                                                results[i]['regionCode']
                                                    .toInt()
                                                    .toString();
                                          }).toList());
                                        }

                                        provider.masterCurrentProjectProjectFilterData =
                                            dataAfterFilter.map((subjectdataa) {
                                          return MultiSelectItem(subjectdataa,
                                              subjectdataa['pCategory']);
                                        }).toList();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: MultiSelectDialogField(
                                    dialogHeight: 250,
                                    searchable: true,
                                    initialValue: provider
                                        .masterCurrentProjectProjectValues,
                                    items: provider
                                        .masterCurrentProjectProjectFilterData,
                                    title: const Text(
                                      "Project",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    selectedColor: Colors.black,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF0F6FA),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    buttonIcon: Icon(Icons.arrow_drop_down,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor)),
                                    buttonText: Text(
                                      "Project",
                                      style: TextStyle(
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm: (results) {
                                      setState(() {
                                        provider
                                            .masterCurrentProjectProjectValues
                                            .clear();
                                        provider
                                            .masterCurrentProjectProjectValues
                                            .addAll(results);
                                      });

                                      if (results.isEmpty) {
                                        //to show all filter values again
                                        setState(() {
                                          provider
                                              .masterCurrentProjectProjectLocationDummyData
                                              .clear();
                                          provider.masterCurrentProjectProjectLocationDummyData =
                                              provider.projectAreasF
                                                  .map((subjectdataa) {
                                            return MultiSelectItem(subjectdataa,
                                                subjectdataa['projectArea']);
                                          }).toList();
                                        });
                                      } else {
                                        setState(() {
                                          provider
                                              .masterCurrentProjectProjectLocationDummyData
                                              .clear();
                                        });
                                        log("results $results");
                                        List dataAfterFilter = [];
                                        for (var i = 0;
                                            i < results.length;
                                            i++) {
                                          dataAfterFilter.addAll(provider
                                              .projectAreasF
                                              .where((element) {
                                            return element['projectID'] ==
                                                results[i]['pid'].toString();
                                          }).toList());
                                        }

                                        provider.masterCurrentProjectProjectLocationDummyData =
                                            dataAfterFilter.map((subjectdataa) {
                                          return MultiSelectItem(subjectdataa,
                                              subjectdataa['projectArea']);
                                        }).toList();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MultiSelectDialogField(
                                    dialogHeight: 250,
                                    searchable: true,
                                    initialValue: provider
                                        .masterCurrentProjectProjectLocationValues,
                                    items: provider
                                        .masterCurrentProjectProjectLocationDummyData,
                                    title: const Text(
                                      "Location",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    selectedColor: Colors.black,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF0F6FA),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    buttonIcon: Icon(Icons.arrow_drop_down,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor)),
                                    buttonText: Text(
                                      "Location",
                                      style: TextStyle(
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm: (results) {
                                      setState(() {
                                        provider
                                            .masterCurrentProjectProjectLocationValues
                                            .clear();
                                        provider
                                            .masterCurrentProjectProjectLocationValues
                                            .addAll(results);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 0),
                        title: Row(
                          children: [
                            provider.dobmin != "Date of Birth" ||
                                    provider.superannuationMin != "DOS" ||
                                    provider.dojProjectMin != "DOJ Project" ||
                                    provider.dOJDepartmentMin !=
                                        "DOJ Department" ||
                                    provider.dOEGradeMin != "DOE Grade"
                                ? dotForSelectedFilter()
                                : const SizedBox(),
                            const Text(" Date Search"),
                          ],
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                provider.dobmin != "Date of Birth"
                                    ? dotForSelectedFilter()
                                    : const SizedBox(),
                                Text(
                                  " DOB",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              returnDateUi(
                                provider,
                                provider.dobmin,
                                dobFrom,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              returnDateUi(
                                provider,
                                provider.dobMax,
                                dobTo,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                provider.superannuationMin != "DOS"
                                    ? dotForSelectedFilter()
                                    : const SizedBox(),
                                Text(
                                  " Date of Superannuation",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              returnDateUi(
                                provider,
                                provider.superannuationMin,
                                dOSFrom,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              returnDateUi(
                                provider,
                                provider.superannuationMax,
                                dOSTO,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                provider.dojProjectMin != "DOJ Project"
                                    ? dotForSelectedFilter()
                                    : const SizedBox(),
                                Text(
                                  " DOJ Project",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              returnDateUi(
                                provider,
                                provider.dojProjectMin,
                                doJPFrom,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              returnDateUi(
                                provider,
                                provider.dojProjectMax,
                                doJPTo,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                provider.dOJDepartmentMin != "DOJ Department"
                                    ? dotForSelectedFilter()
                                    : const SizedBox(),
                                Text(
                                  " DOJ Department",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              returnDateUi(
                                provider,
                                provider.dOJDepartmentMin,
                                doJDFrom,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              returnDateUi(
                                provider,
                                provider.dOJDepartmentMax,
                                doJDTo,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                provider.dOEGradeMin != "DOE Grade"
                                    ? dotForSelectedFilter()
                                    : const SizedBox(),
                                Text(
                                  " DOE Grade",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              returnDateUi(
                                provider,
                                provider.dOEGradeMin,
                                doEGFrom,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              returnDateUi(
                                provider,
                                provider.dOEGradeMax,
                                doEGTO,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterDepartmentDepartmentGroupFilterValues
                                      .isNotEmpty ||
                                  provider
                                      .masterDepartmentDepartmentSubGroupFilterValues
                                      .isNotEmpty ||
                                  provider
                                      .masterDepartmentDepartmentFilterValues
                                      .isNotEmpty ||
                                  provider.masterDepartmentWorkProfileValues
                                      .isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Department"),
                        ],
                      ),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                searchable: true,
                                dialogHeight: 250,
                                initialValue: provider
                                    .masterDepartmentDepartmentGroupFilterValues,
                                items: provider
                                    .masterDepartmentDepartmentGroupFilterData,
                                title: const Text(
                                  "Group",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Group",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  // To show all pervious selected filter when user open the filter screen again after applying filter
                                  setState(
                                    () {
                                      provider
                                          .masterDepartmentDepartmentGroupFilterValues
                                          .clear();
                                      provider
                                          .masterDepartmentDepartmentGroupFilterValues
                                          .addAll(results);
                                    },
                                  );
                                  //Clear Data of both deptSubGroup and Department while Select New Department Group
                                  if (provider
                                          .masterDepartmentDepartmentSubGroupFilterValues
                                          .isNotEmpty ||
                                      provider
                                          .masterDepartmentDepartmentFilterValues
                                          .isNotEmpty) {
                                    provider
                                        .masterDepartmentDepartmentSubGroupFilterValues
                                        .clear();
                                    provider
                                        .masterDepartmentDepartmentFilterValues
                                        .clear();
                                    provider.reOpenMasterFilterScreen(context);

                                    // customMenuBottomSheet();
                                  }
                                  if (results.isEmpty) {
                                    setState(
                                      () {
                                        provider
                                            .masterDepartmentDepartmentSubGroupFilterDummyData
                                            .clear();
                                        provider.masterDepartmentDepartmentSubGroupFilterDummyData =
                                            provider.subDepartmentsF
                                                .map((subjectdataa) {
                                          return MultiSelectItem(subjectdataa,
                                              subjectdataa['subDeptName']);
                                        }).toList();
                                        provider
                                            .masterDepartmentDepartmentFilterDummyData
                                            .clear();
                                        provider.masterDepartmentDepartmentFilterDummyData =
                                            provider.departmentsF
                                                .map((subjectdataa) {
                                          return MultiSelectItem(subjectdataa,
                                              subjectdataa['deptName']);
                                        }).toList();
                                      },
                                    );
                                  } else {
                                    // Show the avaialble filter of Department group and Department according to Department Group
                                    setState(() {
                                      provider
                                          .masterDepartmentDepartmentSubGroupFilterDummyData
                                          .clear();
                                    });
                                    List dummySubDeptGroupData = [];
                                    List depCasData = [];
                                    for (var i = 0; i < results.length; i++) {
                                      dummySubDeptGroupData.addAll(provider
                                          .subDepartmentsF
                                          .where((element) =>
                                              element['groupDeptCode'] ==
                                              results[i]['groupDeptCode'])
                                          .toList());
                                    }
                                    provider.masterDepartmentDepartmentSubGroupFilterDummyData =
                                        dummySubDeptGroupData
                                            .map((subjectdataa) {
                                      return MultiSelectItem(subjectdataa,
                                          subjectdataa['subDeptName']);
                                    }).toList();

                                    //Dep Cas data
                                    for (var i = 0; i < results.length; i++) {
                                      depCasData.addAll(provider.departmentsF
                                          .where((element) =>
                                              element['groupDeptCode'] ==
                                              results[i]['groupDeptCode'])
                                          .toList());

                                      provider
                                          .masterDepartmentDepartmentFilterDummyData
                                          .clear();
                                      holdFilteredDataFromGeneralDepartment
                                          .clear();
                                      holdFilteredDataFromGeneralDepartment
                                          .addAll(depCasData);
                                    }
                                    provider.masterDepartmentDepartmentFilterDummyData =
                                        depCasData.map((subjectdataa) {
                                      return MultiSelectItem(subjectdataa,
                                          subjectdataa['deptName']);
                                    }).toList();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider
                                    .masterDepartmentDepartmentSubGroupFilterValues,
                                items: provider
                                    .masterDepartmentDepartmentSubGroupFilterDummyData,
                                title: const Text(
                                  "Sub Group",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Sub Group",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  // To show selected Filter when open filter Screen again
                                  setState(
                                    () {
                                      provider
                                          .masterDepartmentDepartmentSubGroupFilterValues
                                          .clear();

                                      provider
                                          .masterDepartmentDepartmentSubGroupFilterValues
                                          .addAll(results);
                                    },
                                  );

                                  if (provider
                                      .masterDepartmentDepartmentFilterValues
                                      .isNotEmpty) {
                                    provider
                                        .masterDepartmentDepartmentFilterValues
                                        .clear();
                                    // Navigator.pop(context);

                                    // customMenuBottomSheet();
                                  }

                                  if (results.isEmpty) {
                                    //to show all filter values again
                                    setState(() {
                                      provider
                                          .masterDepartmentDepartmentFilterDummyData
                                          .clear();
                                      if (holdFilteredDataFromGeneralDepartment
                                          .isNotEmpty) {
                                        provider
                                            .masterDepartmentDepartmentFilterDummyData
                                            .clear();

                                        for (int i = 0;
                                            i <
                                                holdFilteredDataFromGeneralDepartment
                                                    .length;
                                            i++) {
                                          setState(() {
                                            provider.masterDepartmentDepartmentFilterDummyData =
                                                holdFilteredDataFromGeneralDepartment
                                                    .map((subjectdataa) {
                                              return MultiSelectItem(
                                                  subjectdataa,
                                                  subjectdataa['subDeptName']);
                                            }).toList();

                                            // provider
                                            //     .masterDepartmentDepartmentSubGroupFilterDummyData
                                            //     .add(
                                            //         holdFilteredDataFromGeneralDepartment[
                                            //             i]);
                                          });
                                        }
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      provider
                                          .masterDepartmentDepartmentFilterDummyData
                                          .clear();
                                    });
                                    List dataAfterFilter = [];
                                    for (var i = 0; i < results.length; i++) {
                                      dataAfterFilter.addAll(
                                        provider.departmentsF
                                            .where((element) =>
                                                element['subDeptCode'] ==
                                                results[i]['subDeptCode'])
                                            .toList(),
                                      );
                                    }
                                    provider.masterDepartmentDepartmentFilterDummyData =
                                        dataAfterFilter.map((subjectdataa) {
                                      return MultiSelectItem(subjectdataa,
                                          subjectdataa['deptName']);
                                    }).toList();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider
                                    .masterDepartmentDepartmentFilterValues,
                                items: provider
                                    .masterDepartmentDepartmentFilterDummyData,
                                title: const Text(
                                  "Department",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Department",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(
                                    () {
                                      provider
                                          .masterDepartmentDepartmentFilterValues
                                          .clear();
                                      provider
                                          .masterDepartmentDepartmentFilterValues
                                          .addAll(results);
                                    },
                                  );
                                  if (results.isEmpty) {
                                    //to show all filter values again
                                    setState(() {
                                      provider
                                          .masterDepartmentWorkProfileDummyData
                                          .clear();
                                    });
                                  } else {
                                    setState(() {
                                      provider
                                          .masterDepartmentWorkProfileDummyData
                                          .clear();
                                    });

                                    List dataAfterFilter = [];
                                    for (var i = 0; i < results.length; i++) {
                                      dataAfterFilter.addAll(
                                          provider.workAreaF.where((element) {
                                        return element['departmentID'] ==
                                            results[i]['deptCode'];
                                      }).toList());
                                    }
                                    provider.masterDepartmentWorkProfileDummyData =
                                        dataAfterFilter.map((subjectdataa) {
                                      return MultiSelectItem(subjectdataa,
                                          subjectdataa['workProfile']);
                                    }).toList();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue:
                                    provider.masterDepartmentWorkProfileValues,
                                items: provider
                                    .masterDepartmentWorkProfileDummyData,
                                title: const Text(
                                  "Work Profile",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Work Profile",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  log("result $results");
                                  setState(() {
                                    provider.masterDepartmentWorkProfileValues
                                        .clear();
                                    provider.masterDepartmentWorkProfileValues
                                        .addAll(results);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterStatesValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Domicile"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider.masterStatesValues,
                                items: provider.masterDomicileFilterData,
                                title: const Text(
                                  "Domicile",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Domicile",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {
                                    provider.masterStatesValues.clear();
                                    provider.masterStatesValues.addAll(results);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterEmployeeGroupValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Employee Group"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue:
                                    provider.masterEmployeeGroupValues,
                                items: provider.masterEmployeeGroupFilterData,
                                title: const Text(
                                  "Emp. Group",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Emp. Group",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(
                                    () {
                                      provider.masterEmployeeGroupValues
                                          .clear();
                                      provider.masterEmployeeGroupValues
                                          .addAll(results);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterGradeValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Grade"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider.masterGradeValues,
                                items: provider.masterGradeFilterData,
                                title: const Text(
                                  "Grade",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Grade",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(
                                    () {
                                      provider.masterGradeValues.clear();
                                      provider.masterGradeValues
                                          .addAll(results);
                                    },
                                  );
                                  if (results.isEmpty) {
                                    setState(() {
                                      provider.masterSubstantiveGradeFilterData =
                                          provider.table32F.map(
                                        (subjectdataa) {
                                          return MultiSelectItem(
                                              subjectdataa,
                                              subjectdataa[
                                                  'substantive_Grade_Text']);
                                        },
                                      ).toList();
                                    });
                                  } else {
                                    List dataAfterFilter = [];
                                    for (var i = 0; i < results.length; i++) {
                                      dataAfterFilter.addAll(
                                          provider.table32F.where((element) {
                                        return element['gradeCode'] ==
                                            results[i]['levelCode'];
                                      }).toList());
                                    }
                                    provider.masterSubstantiveGradeFilterData =
                                        dataAfterFilter.map((subjectdataa) {
                                      return MultiSelectItem(
                                          subjectdataa,
                                          subjectdataa[
                                              'substantive_Grade_Text']);
                                    }).toList();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterSubstantiveGradeValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Substantive Grade"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue:
                                    provider.masterSubstantiveGradeValues,
                                items:
                                    provider.masterSubstantiveGradeFilterData,
                                title: const Text(
                                  "Substantive Grade",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Substantive Grade",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(
                                    () {
                                      provider.masterSubstantiveGradeValues
                                          .clear();
                                      provider.masterSubstantiveGradeValues
                                          .addAll(results);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterLavelValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Designation"),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MultiSelectDialogField(
                                dialogHeight: 250,
                                searchable: true,
                                initialValue: provider.masterLavelValues,
                                items: provider.masterGeneralLevelFilterData,
                                title: const Text(
                                  "Designation",
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Colors.black,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: Icon(Icons.arrow_drop_down,
                                    color: Color(
                                        CommonAppTheme.buttonCommonColor)),
                                buttonText: Text(
                                  "Designation",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(
                                    () {
                                      provider.masterLavelValues.clear();
                                      provider.masterLavelValues
                                          .addAll(results);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterGenderSelectedValue != ""
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Gender"),
                        ],
                      ),
                      children: [
                        Row(
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
                                    value: provider.masterGenderSelectedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          provider.masterGenderSelectedValue =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      ...provider.masterGender
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value['value'],
                                                    child: Text(
                                                      value['text'],
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
                      ],
                    ),
                    Consumer<AllInProvider>(
                      builder: (context, value, child) => ExpansionTile(
                        title: Row(
                          children: [
                            provider.masterPHHearing ||
                                    provider.masterPHOrtho ||
                                    provider.masterPHVisual
                                ? dotForSelectedFilter()
                                : const SizedBox(),
                            const Text(" PH"),
                          ],
                        ),
                        tilePadding: const EdgeInsets.only(left: 0),
                        children: [
                          CheckboxListTile(
                            // controlAffinity: ListTileControlAffinity.leading,
                            value: provider.masterPHHearing,
                            onChanged: (value) {
                              provider.updatePhHearing(value);
                            },
                            title: const Text("HEARING HANDICAP Onl"),
                          ),
                          CheckboxListTile(
                            // controlAffinity: ListTileControlAffinity.leading,
                            value: provider.masterPHOrtho,
                            onChanged: (value) {
                              provider.updatePhOrtho(value);
                            },
                            title: const Text("ORTHO HANDICAP"),
                          ),
                          CheckboxListTile(
                            // controlAffinity: ListTileControlAffinity.leading,
                            value: provider.masterPHVisual,
                            onChanged: (value) {
                              provider.updatePhVisual(value);
                            },
                            title: const Text("VISUAL HANDICAP"),
                          ),
                          Consumer<AllInProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "PH Percentage",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.pHPerMin.round()} ",
                                    ),
                                    Text(
                                      "- ${provider.pHPerMax.round()} ",
                                    ),
                                    const Text(
                                      "%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                RangeSlider(
                                  values: provider.pHPerMinMax,
                                  max: 100,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    provider.pHPerMinMax.start
                                        .round()
                                        .toString(),
                                    provider.pHPerMinMax.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    provider.updatePHPer(values);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterVigilanceSelectedValue == "1" ||
                                  provider.masterVigilanceSelectedValue == "2"
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Vigilance/Disciplinary Cases"),
                        ],
                      ),
                      children: [
                        Row(
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
                                    value:
                                        provider.masterVigilanceSelectedValue,
                                    onChanged: (value) {
                                      print(value);
                                      setState(
                                        () {
                                          provider.masterVigilanceSelectedValue =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      ...provider.masterVigilance
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value['value'],
                                                    child: Text(
                                                      value['text'],
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
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterAssociationsCommitteesValues
                                      .isNotEmpty ||
                                  provider.masterAssociationsMemberValues
                                      .isNotEmpty ||
                                  provider.masterAssociationsFacultyValues
                                      .isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Associations"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue:
                              provider.masterAssociationsCommitteesValues,
                          items:
                              provider.masterAssociationsCommitteesFilterData,
                          title: const Text(
                            "Committees",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Associations Committees",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterAssociationsCommitteesValues
                                    .clear();
                                provider.masterAssociationsCommitteesValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterAssociationsMemberValues,
                          items: provider.masterAssociationsMembersFilterData,
                          title: const Text(
                            "Member",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Associations Member",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterAssociationsMemberValues.clear();
                                provider.masterAssociationsMemberValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue:
                              provider.masterAssociationsFacultyValues,
                          items: provider.masterAssociationsFacultyFilterData,
                          title: const Text(
                            "Faculty",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Associations Faculty",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterAssociationsFacultyValues
                                    .clear();
                                provider.masterAssociationsFacultyValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterInterestAwardInterestValues
                                      .isNotEmpty ||
                                  provider.masterInterestAwardAchievementValues
                                      .isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Interest/Award"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue:
                              provider.masterInterestAwardInterestValues,
                          items: provider.masterInterestAwardInterestFilterData,
                          title: const Text(
                            "Interest",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Interest",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterInterestAwardInterestValues
                                    .clear();
                                provider.masterInterestAwardInterestValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue:
                              provider.masterInterestAwardAchievementValues,
                          items:
                              provider.masterInterestAwardAchievementFilterData,
                          title: const Text(
                            "Achievements",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Achievements",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterInterestAwardAchievementValues
                                    .clear();
                                provider.masterInterestAwardAchievementValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.leaveHistorySelectedValue != "Leave Type"
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Leaves History "),
                    ],
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F6FA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                value: provider.leaveHistorySelectedValue,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      provider.leaveHistorySelectedValue =
                                          value.toString();
                                    },
                                  );
                                },
                                items: [
                                  ...provider.leaveHistoryData
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value['text'],
                                          child: Text(
                                            value['text'],
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
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                ),

                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AllInProvider>(
                      builder: (context, value, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Count",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${provider.leaveHistoryCountMin.round()} ",
                              ),
                              Text(
                                "- ${provider.leaveHistoryCountrMax.round()} ",
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: provider.leaveHistoryCountMinMax,
                            max: 500,
                            divisions: 500,
                            labels: RangeLabels(
                              provider.leaveHistoryCountMinMax.start
                                  .round()
                                  .toString(),
                              provider.leaveHistoryCountMinMax.end
                                  .round()
                                  .toString(),
                            ),
                            onChanged: (RangeValues values) {
                              provider.updateLeaveHistoryCount(values);
                            },
                          ),
                        ],
                      ),
                    ),
                    Consumer<AllInProvider>(
                      builder: (context, value, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Last n Years",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${provider.leaveSHistoryYearMax.round()} ",
                              ),
                              const Text(
                                "Years",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: provider.leaveSHistoryYearMax,
                            max: 10,
                            divisions: 100,
                            label: provider.leaveSHistoryYearMax
                                .round()
                                .toString(),
                            onChanged: (double value) {
                              setState(() {
                                provider.leaveSHistoryYearMax = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    // Consumer<AllInProvider>(
                    //   builder: (context, value, child) => Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Padding(
                    //         padding: EdgeInsets.only(left: 15),
                    //         child: Text(
                    //           "Years",
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "${provider.leaveHistoryYearMin.round()} ",
                    //           ),
                    //           Text(
                    //             "- ${provider.leaveHistoryYearMax.round()} ",
                    //           ),
                    //           const Text(
                    //             "Years",
                    //             style: TextStyle(fontWeight: FontWeight.bold),
                    //           )
                    //         ],
                    //       ),
                    //       RangeSlider(
                    //         values: provider.leaveHistoryYearMinMax,
                    //         max: 10,
                    //         divisions: 100,
                    //         labels: RangeLabels(
                    //           provider.leaveHistoryYearMinMax.start
                    //               .round()
                    //               .toString(),
                    //           provider.leaveHistoryYearMinMax.end
                    //               .round()
                    //               .toString(),
                    //         ),
                    //         onChanged: (RangeValues values) {
                    //           provider.updateLeaveHistoryYear(values);
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.iPDSelectedValue != "Select Type" ||
                              provider.oPDSelectedValue != "Select Type"
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Medical History "),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: provider.diagnosis,
                        decoration: const InputDecoration(
                          hintText: 'Diagnosis',
                        ),
                      ),
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.iPDSelectedValue != "Select Type"
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" IPD Cost"),
                        ],
                      ),
                      children: [
                        Row(
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
                                    value: provider.iPDSelectedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          provider.iPDSelectedValue =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      ...provider.iPDData
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value['text'],
                                                    child: Text(
                                                      value['text'],
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
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AllInProvider>(
                          builder: (context, value, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Cost",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.iPDCostMin.round()} ",
                                  ),
                                  Text(
                                    "- ${provider.iPDCostMax.round()} ",
                                  ),
                                ],
                              ),
                              RangeSlider(
                                values: provider.iPDCostMinMax,
                                max: 10000000,
                                divisions: 100,
                                labels: RangeLabels(
                                  provider.iPDCostMinMax.start
                                      .round()
                                      .toString(),
                                  provider.iPDCostMinMax.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  provider.updateIPDCostMax(values);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.oPDSelectedValue != "Select Type"
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" OPD Cost"),
                        ],
                      ),
                      children: [
                        Row(
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
                                    value: provider.oPDSelectedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          provider.oPDSelectedValue =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      ...provider.oPDData
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value['text'],
                                                    child: Text(
                                                      value['text'],
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
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AllInProvider>(
                          builder: (context, value, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Cost",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.oPDCostMin.round()} ",
                                  ),
                                  Text(
                                    "- ${provider.oPDCostMax.round()} ",
                                  ),
                                ],
                              ),
                              RangeSlider(
                                values: provider.oPDCostMinMax,
                                max: 10000000,
                                divisions: 100,
                                labels: RangeLabels(
                                  provider.oPDCostMinMax.start
                                      .round()
                                      .toString(),
                                  provider.oPDCostMinMax.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  provider.updateOPDCostMax(values);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.masterEntryModeValues.isNotEmpty ||
                              provider.masterQualificationValues.isNotEmpty ||
                              provider.masterBranchValues.isNotEmpty ||
                              provider.masterInstituteValues.isNotEmpty ||
                              provider.masterAreaOfRecruitmentValues.isNotEmpty
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Qualification "),
                    ],
                  ),
                  children: [
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterEntryModeValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Entry Mode"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterEntryModeValues,
                          items: provider.masterEntryModeFilterData,
                          title: const Text(
                            "Entry Mode",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Entry Mode",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterEntryModeValues.clear();
                                provider.masterEntryModeValues.addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterQualificationValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Qualification"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterQualificationValues,
                          items: provider.masterQualificationData,
                          title: const Text(
                            "Qualification",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Qualification",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterQualificationValues.clear();
                                provider.masterQualificationValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterBranchValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Branch"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterBranchValues,
                          items: provider.masterBranchData,
                          title: const Text(
                            "Branch",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Branch",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterBranchValues.clear();
                                provider.masterBranchValues.addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterInstituteValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Institute/University"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterInstituteValues,
                          items: provider.masterInstituteData,
                          title: const Text(
                            "Institute/University",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Institute/University",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterInstituteValues.clear();
                                provider.masterInstituteValues.addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: const EdgeInsets.only(left: 0),
                      title: Row(
                        children: [
                          provider.masterAreaOfRecruitmentValues.isNotEmpty
                              ? dotForSelectedFilter()
                              : const SizedBox(),
                          const Text(" Recruitment"),
                        ],
                      ),
                      children: [
                        MultiSelectDialogField(
                          dialogHeight: 250,
                          searchable: true,
                          initialValue: provider.masterAreaOfRecruitmentValues,
                          items: provider.masterAreaOfRecruitmentData,
                          title: const Text(
                            "Recruitment",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F6FA),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          buttonIcon: Icon(Icons.arrow_drop_down,
                              color: Color(CommonAppTheme.buttonCommonColor)),
                          buttonText: Text(
                            "Recruitment",
                            style: TextStyle(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(
                              () {
                                provider.masterAreaOfRecruitmentValues.clear();
                                provider.masterAreaOfRecruitmentValues
                                    .addAll(results);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.masterTrainingValues.isNotEmpty
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Training "),
                    ],
                  ),
                  children: [
                    MultiSelectDialogField(
                      dialogHeight: 250,
                      searchable: true,
                      initialValue: provider.masterTrainingValues,
                      items: provider.masterTrainingData,
                      title: const Text(
                        "Training",
                        style: TextStyle(color: Colors.black),
                      ),
                      selectedColor: Colors.black,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F6FA),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      buttonIcon: Icon(Icons.arrow_drop_down,
                          color: Color(CommonAppTheme.buttonCommonColor)),
                      buttonText: Text(
                        "Training",
                        style: TextStyle(
                          color: Color(CommonAppTheme.buttonCommonColor),
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(
                          () {
                            provider.masterTrainingValues.clear();
                            provider.masterTrainingValues.addAll(results);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        returnDateUi(
                          provider,
                          provider.tranningStartDate,
                          tranningDateFrom,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        returnDateUi(
                          provider,
                          provider.tranningEndDate,
                          tranningDateTo,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 0),
                  title: Row(
                    children: [
                      provider.ridValue != '' || provider.typeListID != ''
                          ? dotForSelectedFilter()
                          : const SizedBox(),
                      const Text(" Transfer History "),
                    ],
                  ),
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 0),
                        title: Row(
                          children: [
                            provider.ridValue != '' || provider.typeListID != ''
                                ? dotForSelectedFilter()
                                : const SizedBox(),
                            const Text(" MANAS Request"),
                          ],
                        ),
                        children: [
                          Row(
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
                                      underline: SizedBox(),
                                      value: provider.ridValue,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            provider.ridValue =
                                                value.toString();

                                            print(provider.ridValue);

                                            List data = provider
                                                .manasGroundTypeF
                                                .where((element) =>
                                                    element['requestType']
                                                        .toString() ==
                                                    provider.ridValue)
                                                .toList();
                                            print("Afer filter data $data");
                                            setState(() {
                                              provider.manasGroundTypeDummy =
                                                  data;
                                            });

                                            provider.requestTypeDataToShowAsSelectedFilter =
                                                data[0]['text_Val'];
                                          },
                                        );
                                      },
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: '',
                                          child: Text(
                                            "Request type list",
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
                                        ...provider.manasRequestTypeF
                                            .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value['text_Val']
                                                          .toString(),
                                                      child: Text(
                                                        value['text_Val'],
                                                        style: TextStyle(
                                                          color: Color(
                                                              CommonAppTheme
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
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
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
                                      underline: SizedBox(),
                                      value: provider.typeListID,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            provider.typeListID =
                                                value.toString();

                                            List data = provider
                                                .manasGroundTypeF
                                                .where((element) =>
                                                    element['id'].toString() ==
                                                    provider.typeListID)
                                                .toList();

                                            provider.typeListToShowSelectedValue =
                                                data[0]['text_Val'];
                                          },
                                        );
                                      },
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: '',
                                          child: Text(
                                            "Ground type list",
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
                                        ...provider.manasGroundTypeDummy
                                            .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value['id']
                                                          .toString(),
                                                      child: Text(
                                                        value['text_Val'],
                                                        style: TextStyle(
                                                          color: Color(
                                                              CommonAppTheme
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
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<AllInProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Years",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${provider.manasYearRequestMax.round()} ",
                                    ),
                                    const Text(
                                      "Years",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Slider(
                                  value: provider.manasYearRequestMax,
                                  max: 40,
                                  divisions: 100,
                                  label: provider.manasYearRequestMax
                                      .round()
                                      .toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      provider.manasYearRequestMax = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  provider.setRequiredFilterForOpenSearch(
                    context,
                    false,
                  );
                  provider.reOpenMasterFilterScreen(context);
                },
                child: const Text(
                  "Clear All",
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  provider.clearOpenSearchListData();
                  provider.applyMasterFilter(context, true);
                },
                child: const Text(
                  "Search",
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
