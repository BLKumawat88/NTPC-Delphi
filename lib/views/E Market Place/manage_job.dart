import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/commonheader/common_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';

class ManageJobScreen extends StatefulWidget {
  const ManageJobScreen({super.key});

  @override
  State<ManageJobScreen> createState() => _ManageJobScreenState();
}

class _ManageJobScreenState extends State<ManageJobScreen> {
  TextEditingController byReqNo = TextEditingController();
  TextStyle styleText = TextStyle(
    color: Color(CommonAppTheme.whiteColor),
    fontWeight: FontWeight.bold,
  );

  bool isExpandedValue = false;

  updateState() {
    setState(() {});
  }

  applyMjFilter() {
    AllInProvider provider = Provider.of(context, listen: false);

    Map<String, String> data1234 = {
      'SearchID': byReqNo.text,
      'SearchTitle': provider.byTitle.text,
      'Region': provider.selectedRegionValue,
      'Project': provider.selectedProjectCatValue,
      'Location': provider.selectedLocationValue,
      'Department_Group': provider.selectedDepartGroupValue,
      'Department_SubGroup': provider.selectedDepartSubGroupValue,
      'Department': provider.selectedDepartmentValue,
      'SortBy': '',
      'CurrentPage': '1',
      'PagingSize': '20',
      "isKeyPosition": provider.selectedValue1 == "All"
          ? '-1'
          : provider.selectedValue1 == "Yes"
              ? "1"
              : provider.selectedValue1 == "No"
                  ? '0'
                  : '0',
    };

    provider.getEMarketPalceManageJobDataNew1(context, data1234, false);
  }

  void customMenuBottomSheet() {
    AllInProvider provider = Provider.of(context, listen: false);

    print("object${provider.regionF.length}");
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
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
                                  controller: byReqNo,
                                  style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF0F6FA),
                                    hintText: 'Requirement No.',
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
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextField(
                                  autofocus: false,
                                  controller: provider.byTitle,
                                  style: TextStyle(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF0F6FA),
                                    hintText: 'Title',
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
                                    value: provider.selectedValue1,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          provider.selectedValue1 =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Key Position",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...provider.items1
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
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<double>(
                                    value: provider.selectedRegionValue.isEmpty
                                        ? null
                                        : double.parse(
                                            provider.selectedRegionValue),
                                    hint: const Text("Region"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedLocationValue = '';
                                        provider.selectedRegionValue =
                                            value.toString();
                                        provider.selectedRegionValue = provider
                                            .selectedRegionValue
                                            .replaceAll(".0", "");
                                        provider.mJLocationList.clear();
                                        provider.regionNewList.clear();

                                        for (int i = 0;
                                            i < provider.regionF.length;
                                            i++) {
                                          if (value ==
                                              provider.regionF[i]
                                                  ["regionCode"]) {
                                            provider.regionNewList
                                                .add(provider.regionF[i]);
                                          }
                                        }

                                        print(
                                            "object1234 ${provider.selectedRegionValue}");
                                        if (provider
                                            .selectedProjectCatValue.isEmpty) {
                                          for (int i = 0;
                                              i < provider.projectF.length;
                                              i++) {
                                            if (provider.selectedRegionValue ==
                                                provider.projectF[i]
                                                    ["regionID"]) {
                                              provider.mJLocationList
                                                  .add(provider.projectF[i]);
                                              print(
                                                  "object123 ${provider.mJLocationList.length}");
                                            }
                                          }
                                        } else {
                                          for (int i = 0;
                                              i < provider.projectF.length;
                                              i++) {
                                            if (provider.selectedRegionValue ==
                                                    provider.projectF[i]
                                                        ["regionID"] &&
                                                provider.selectedProjectCatValue ==
                                                    provider.projectF[i]
                                                        ["projectCategory"]) {
                                              provider.mJLocationList
                                                  .add(provider.projectF[i]);
                                              print(
                                                  "object123 ${provider.mJLocationList.length}");
                                            }
                                          }
                                        }
                                      });
                                    },
                                    items: [
                                      for (int i = 0;
                                          i < provider.regionF.length;
                                          i++)
                                        DropdownMenuItem<double>(
                                          value: provider.regionF[i]
                                              ["regionCode"],
                                          child: Text(
                                            provider.regionF[i]["regionName"],
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
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
                                  child: DropdownButton<int>(
                                    value: provider
                                            .selectedProjectCatValue.isEmpty
                                        ? null
                                        : int.parse(
                                            provider.selectedProjectCatValue),
                                    hint: const Text("Project"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedLocationValue = '';
                                        provider.selectedProjectCatValue =
                                            value.toString();
                                        provider.mJLocationList.clear();
                                        provider.projectNewList.clear();
                                        for (int i = 0;
                                            i <
                                                provider
                                                    .projectCategoryF.length;
                                            i++) {
                                          if (value ==
                                              provider.projectCategoryF[i]
                                                  ["projectTypeID"]) {
                                            provider.projectNewList.add(
                                                provider.projectCategoryF[i]);
                                          }
                                        }
                                        print(
                                            "object12345 ${provider.selectedProjectCatValue}");
                                        if (provider
                                            .selectedRegionValue.isEmpty) {
                                          for (int i = 0;
                                              i < provider.projectF.length;
                                              i++) {
                                            if (provider
                                                    .selectedProjectCatValue ==
                                                provider.projectF[i]
                                                    ["projectCategory"]) {
                                              provider.mJLocationList
                                                  .add(provider.projectF[i]);
                                              print(
                                                  "object1230 ${provider.mJLocationList.length}");
                                            }
                                          }
                                        } else {
                                          for (int i = 0;
                                              i < provider.projectF.length;
                                              i++) {
                                            if (provider.selectedProjectCatValue ==
                                                    provider.projectF[i]
                                                        ["projectCategory"] &&
                                                provider.selectedRegionValue ==
                                                    provider.projectF[i]
                                                        ["regionID"]) {
                                              provider.mJLocationList
                                                  .add(provider.projectF[i]);
                                              print(
                                                  "object1230 ${provider.mJLocationList.length}");
                                            }
                                          }
                                        }
                                      });
                                    },
                                    items: [
                                      for (int i = 0;
                                          i < provider.projectCategoryF.length;
                                          i++)
                                        DropdownMenuItem<int>(
                                          value: provider.projectCategoryF[i]
                                              ["projectTypeID"],
                                          child: Text(
                                            provider.projectCategoryF[i]
                                                ["projectType"],
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
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
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value:
                                        provider.selectedLocationValue.isEmpty
                                            ? null
                                            : provider.selectedLocationValue,
                                    hint: const Text("Location"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedLocationValue =
                                            value.toString();

                                        provider.locationNewList.clear();
                                        for (int i = 0;
                                            i < provider.projectF.length;
                                            i++) {
                                          if (value ==
                                              provider.projectF[i]["pid"]) {
                                            provider.locationNewList
                                                .add(provider.projectF[i]);
                                          }
                                        }
                                      });
                                    },

                                    items: [
                                      if (provider.mJLocationList.isNotEmpty)
                                        for (int i = 0;
                                            i < provider.mJLocationList.length;
                                            i++)
                                          DropdownMenuItem<String>(
                                            value: provider.mJLocationList[i]
                                                ["pid"],
                                            child: Text(
                                              provider.mJLocationList[i]
                                                  ["pCategory"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
                                      if (provider
                                              .selectedRegionValue.isEmpty &&
                                          provider
                                              .selectedProjectCatValue.isEmpty)
                                        for (int i = 0;
                                            i < provider.projectF.length;
                                            i++)
                                          DropdownMenuItem<String>(
                                            value: provider.projectF[i]["pid"],
                                            child: Text(
                                              provider.projectF[i]["pCategory"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
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
                                  child: DropdownButton<int>(
                                    value: provider
                                            .selectedDepartGroupValue.isEmpty
                                        ? null
                                        : int.parse(
                                            provider.selectedDepartGroupValue),
                                    hint: const Text("Depart. Group"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedDepartGroupValue =
                                            value.toString();
                                        provider.selectedDepartSubGroupValue =
                                            '';
                                        provider.selectedDepartmentValue = '';
                                        provider.mJDepartmentSubGroupList
                                            .clear();
                                        provider.mJDepartmentList.clear();

                                        provider.departGroupNewList.clear();
                                        for (int i = 0;
                                            i <
                                                provider
                                                    .groupDepartmentsF.length;
                                            i++) {
                                          if (value.toString() ==
                                              provider.groupDepartmentsF[i]
                                                      ["groupDeptCode"]
                                                  .toString()) {
                                            provider.departGroupNewList.add(
                                                provider.groupDepartmentsF[i]);
                                          }
                                        }

                                        print(
                                            "subDepLenghtid ${provider.selectedDepartGroupValue}");
                                        for (int i = 0;
                                            i < provider.subDepartmentsF.length;
                                            i++) {
                                          if (provider
                                                  .selectedDepartGroupValue ==
                                              provider.subDepartmentsF[i]
                                                      ["groupDeptCode"]
                                                  .toString()) {
                                            provider.mJDepartmentSubGroupList
                                                .add(provider
                                                    .subDepartmentsF[i]);
                                            print(
                                                "subDepLenght ${provider.mJDepartmentSubGroupList.length}  ${provider.subDepartmentsF.length}");
                                          }
                                        }

                                        for (int i = 0;
                                            i < provider.departmentsF.length;
                                            i++) {
                                          if (provider
                                                  .selectedDepartGroupValue ==
                                              provider.departmentsF[i]
                                                      ["groupDeptCode"]
                                                  .toString()) {
                                            provider.mJDepartmentList
                                                .add(provider.departmentsF[i]);
                                          }
                                        }
                                      });
                                    },
                                    items: [
                                      for (int i = 0;
                                          i < provider.groupDepartmentsF.length;
                                          i++)
                                        DropdownMenuItem<int>(
                                          value: provider.groupDepartmentsF[i]
                                              ["groupDeptCode"],
                                          child: Text(
                                            provider.groupDepartmentsF[i]
                                                ["groupDeptName"],
                                            style: TextStyle(
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                        ),
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
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<int>(
                                    value: provider
                                            .selectedDepartSubGroupValue.isEmpty
                                        ? null
                                        : int.parse(provider
                                            .selectedDepartSubGroupValue),
                                    hint: const Text("Depart. Sub Group"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedDepartSubGroupValue =
                                            value.toString();
                                        provider.selectedDepartmentValue = '';
                                        provider.mJDepartmentList.clear();

                                        provider.departSubGroupNewList.clear();
                                        for (int i = 0;
                                            i < provider.subDepartmentsF.length;
                                            i++) {
                                          if (value.toString() ==
                                              provider.subDepartmentsF[i]
                                                      ["subDeptCode"]
                                                  .toString()) {
                                            provider.departSubGroupNewList.add(
                                                provider.subDepartmentsF[i]);
                                          }
                                        }

                                        if (provider.selectedDepartSubGroupValue
                                                .isNotEmpty &&
                                            provider.selectedDepartGroupValue
                                                .isNotEmpty) {
                                          for (int i = 0;
                                              i < provider.departmentsF.length;
                                              i++) {
                                            if (provider.selectedDepartSubGroupValue ==
                                                    provider.departmentsF[i]
                                                            ["subDeptCode"]
                                                        .toString() &&
                                                provider.selectedDepartGroupValue ==
                                                    provider.departmentsF[i]
                                                            ["groupDeptCode"]
                                                        .toString()) {
                                              provider.mJDepartmentList.add(
                                                  provider.departmentsF[i]);
                                            }
                                          }
                                        } else if (provider
                                                .selectedDepartSubGroupValue
                                                .isEmpty &&
                                            provider.selectedDepartGroupValue
                                                .isNotEmpty) {
                                          for (int i = 0;
                                              i < provider.departmentsF.length;
                                              i++) {
                                            if (provider
                                                    .selectedDepartSubGroupValue ==
                                                provider.departmentsF[i]
                                                        ["subDeptCode"]
                                                    .toString()) {
                                              provider.mJDepartmentList.add(
                                                  provider.departmentsF[i]);
                                            }
                                          }
                                        } else if (provider
                                                .selectedDepartSubGroupValue
                                                .isNotEmpty &&
                                            provider.selectedDepartGroupValue
                                                .isEmpty) {
                                          for (int i = 0;
                                              i < provider.departmentsF.length;
                                              i++) {
                                            if (provider
                                                    .selectedDepartSubGroupValue ==
                                                provider.departmentsF[i]
                                                        ["groupDeptCode"]
                                                    .toString()) {
                                              provider.mJDepartmentList.add(
                                                  provider.departmentsF[i]);
                                            }
                                          }
                                        } else {
                                          provider.mJDepartmentList =
                                              provider.departmentsF;
                                        }
                                      });
                                    },
                                    items: [
                                      if (provider
                                          .mJDepartmentSubGroupList.isNotEmpty)
                                        for (int i = 0;
                                            i <
                                                provider
                                                    .mJDepartmentSubGroupList
                                                    .length;
                                            i++)
                                          DropdownMenuItem<int>(
                                            value: provider
                                                    .mJDepartmentSubGroupList[i]
                                                ["subDeptCode"],
                                            child: Text(
                                              provider.mJDepartmentSubGroupList[
                                                  i]["subDeptName"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
                                      if (provider
                                          .selectedDepartGroupValue.isEmpty)
                                        for (int i = 0;
                                            i < provider.subDepartmentsF.length;
                                            i++)
                                          DropdownMenuItem<int>(
                                            value: provider.subDepartmentsF[i]
                                                ["subDeptCode"],
                                            child: Text(
                                              provider.subDepartmentsF[i]
                                                  ["subDeptName"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
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
                                  child: DropdownButton<int>(
                                    value: provider
                                            .selectedDepartmentValue.isEmpty
                                        ? null
                                        : int.parse(
                                            provider.selectedDepartmentValue),
                                    hint: const Text("Department"),
                                    onChanged: (value) {
                                      setState(() {
                                        provider.selectedDepartmentValue =
                                            value.toString();

                                        provider.departmentNewList.clear();
                                        for (int i = 0;
                                            i < provider.departmentsF.length;
                                            i++) {
                                          if (value.toString() ==
                                              provider.departmentsF[i]
                                                      ["deptCode"]
                                                  .toString()) {
                                            provider.departmentNewList
                                                .add(provider.departmentsF[i]);
                                          }
                                        }
                                      });
                                    },
                                    items: [
                                      if (provider.selectedDepartGroupValue
                                              .isEmpty &&
                                          provider.selectedDepartSubGroupValue
                                              .isEmpty)
                                        for (int i = 0;
                                            i < provider.departmentsF.length;
                                            i++)
                                          DropdownMenuItem<int>(
                                            value: provider.departmentsF[i]
                                                ["deptCode"],
                                            child: Text(
                                              provider.departmentsF[i]
                                                  ["deptName"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
                                      if (provider.mJDepartmentList.isNotEmpty)
                                        for (int i = 0;
                                            i <
                                                provider
                                                    .mJDepartmentList.length;
                                            i++)
                                          DropdownMenuItem<int>(
                                            value: provider.mJDepartmentList[i]
                                                ["deptCode"],
                                            child: Text(
                                              provider.mJDepartmentList[i]
                                                  ["deptName"],
                                              style: TextStyle(
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                          ),
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
                                  ),
                                  onPressed: () {
                                    provider.regionNewList.clear();
                                    provider.locationNewList.clear();
                                    provider.projectNewList.clear();
                                    provider.departGroupNewList.clear();
                                    provider.departSubGroupNewList.clear();
                                    provider.departmentNewList.clear();

                                    provider.mJKeyPositionList.clear();
                                    provider.mJRegionList.clear();
                                    provider.mJProjectList.clear();
                                    provider.mJLocationList.clear();
                                    provider.mJDepartmentGroupList.clear();
                                    provider.mJDepartmentSubGroupList.clear();
                                    provider.mJDepartmentList.clear();

                                    provider.byTitle.text = '';
                                    provider.selectedValue1 = '';
                                    provider.selectedRegionValue = '';
                                    provider.selectedProjectCatValue = '';
                                    provider.selectedLocationValue = '';
                                    provider.selectedDepartGroupValue = '';
                                    provider.selectedDepartSubGroupValue = '';
                                    provider.selectedDepartmentValue = '';
                                    provider.getEMarketPalceManageJobDataNew1(
                                        context,
                                        provider
                                            .eMarketPalceManageJob_Post_filter_value,
                                        false);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Clear All")),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(
                                          CommonAppTheme.buttonCommonColor)),
                                  onPressed: () {
                                    updateState();
                                    applyMjFilter();
                                    Navigator.of(context).pop();
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

  Future<bool> _requestPermission(Permission pr) async {
    var status = await pr.request();
    print(status.isGranted);
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
  downloadExcelFile(AllInProvider provider) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    List excelData = [
      {
        "srNo": 1,
        "jobID": "Req. No",
        "title": "Title",
        "vacancies": 1,
        "startDate": "Start Date",
        "endDate": "End Date",
        "documentPath": "",
        "document_Title": "",
        "region": "",
        "projectCategoryName": "",
        "project": "Location",
        "deptName": "Department",
        "subDeptName": "",
        "groupDeptName": "",
        "isKeyPosition": false,
        "postedBy": "Posted by",
        "postedDate": "24/02/2023",
        "isClosed": 0,
        "isKeyClosed": 0,
        "totalApplicant": "Total Applicant"
      },
      ...provider.eMarketPalceManageJobDataList
    ];
    for (int i = 0; i < excelData.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: i,
          ))
          .value = '${excelData[i]['totalApplicant']}';

      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 1,
            rowIndex: i,
          ))
          .value = '${excelData[i]['jobID']}';

      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 2,
            rowIndex: i,
          ))
          .value = '${excelData[i]['title']}';

      sheet
              .cell(CellIndex.indexByColumnRow(
                columnIndex: 3,
                rowIndex: i,
              ))
              .value =
          '${excelData[i]['region']}//${excelData[i]['projectCategoryName']}//${excelData[i]['project']}';
      sheet
              .cell(CellIndex.indexByColumnRow(
                columnIndex: 4,
                rowIndex: i,
              ))
              .value =
          '${excelData[i]['subDeptName']}//${excelData[i]['groupDeptName']}//${excelData[i]['deptName']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 5,
            rowIndex: i,
          ))
          .value = '${excelData[i]['startDate']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 6,
            rowIndex: i,
          ))
          .value = '${excelData[i]['endDate']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 7,
            rowIndex: i,
          ))
          .value = '${excelData[i]['postedBy']}';
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
              "${directory.path}/Manage Job - Delphi - NTPC Manpower $randomNameToDownloadSameFileMultiTime.xlsx")
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

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Consumer<AllInProvider>(
      builder: (context, person, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CommonHeaderClass.commonAppBarHeader("Manage job", context),
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
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(CommonAppTheme.borderRadious),
                      ),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        onExpansionChanged: ((value) {
                          print(value);
                          setState(() {
                            isExpandedValue = value;
                          });
                        }),
                        trailing: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(CommonAppTheme.whiteColor),
                          ),
                          child: Icon(
                            isExpandedValue
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            size: 30,
                            color: Color(CommonAppTheme.appthemeColorForText),
                          ),
                        ),
                        backgroundColor:
                            Color(CommonAppTheme.headerCommonColor),
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
                                              "Vacancies - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              provider.eMarketPlaceManageJobSummaryData[
                                                  'tv'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Open - ",
                                                style: TextStyle(
                                                  color: Color(
                                                    CommonAppTheme
                                                        .appthemeColorForText,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                              "${int.parse(provider.eMarketPlaceManageJobSummaryData['tv']) - int.parse(provider.eMarketPlaceManageJobSummaryData['cv'])}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Closed - ",
                                                style: TextStyle(
                                                  color: Color(
                                                    CommonAppTheme
                                                        .appthemeColorForText,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                              provider.eMarketPlaceManageJobSummaryData[
                                                  'cv'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Open Key Position Vacancies - ${provider.eMarketPlaceManageJobSummaryData['okpv']}",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.appthemeColorForText,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            downloadExcelFile(provider);
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
                                  Text(
                                    " Excel ",
                                    style: TextStyle(
                                      color: Color(
                                        CommonAppTheme.whiteColor,
                                      ),
                                    ),
                                  ),
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
                            customMenuBottomSheet();
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
                                  Text(
                                    "Filter",
                                    style: TextStyle(
                                      color: Color(
                                        CommonAppTheme.whiteColor,
                                      ),
                                    ),
                                  ),
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
                      ],
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    /* Text(
                      "Selected Filters",
                      style: TextStyle(
                        color: Color(
                          CommonAppTheme.buttonCommonColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    provider.regionNewList.isNotEmpty ||
                            provider.locationNewList.isNotEmpty ||
                            provider.projectNewList.isNotEmpty ||
                            provider.departGroupNewList.isNotEmpty ||
                            provider.departSubGroupNewList.isNotEmpty ||
                            provider.departmentNewList.isNotEmpty ||
                            provider.selectedValue1 != ''
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                              provider.regionNewList.clear();
                                              provider.locationNewList.clear();
                                              provider.projectNewList.clear();
                                              provider.departGroupNewList
                                                  .clear();
                                              provider.departSubGroupNewList
                                                  .clear();
                                              provider.departmentNewList
                                                  .clear();

                                              provider.mJKeyPositionList
                                                  .clear();
                                              provider.mJRegionList.clear();
                                              provider.mJProjectList.clear();
                                              provider.mJLocationList.clear();
                                              provider.mJDepartmentGroupList
                                                  .clear();
                                              provider.mJDepartmentSubGroupList
                                                  .clear();
                                              provider.mJDepartmentList.clear();

                                              provider.byTitle.text = '';
                                              provider.selectedValue1 = '';
                                              provider.selectedRegionValue = '';
                                              provider.selectedProjectCatValue =
                                                  '';
                                              provider.selectedLocationValue =
                                                  '';
                                              provider.selectedDepartGroupValue =
                                                  '';
                                              provider.selectedDepartSubGroupValue =
                                                  '';
                                              provider.selectedDepartmentValue =
                                                  '';
                                            });
                                            provider.getEMarketPalceManageJobDataNew1(
                                                context,
                                                provider
                                                    .eMarketPalceManageJob_Post_filter_value,
                                                false);
                                          },
                                          child: const Text(
                                            "Clear All  ",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ...provider.regionNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${e['regionName']} ",
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
                                                    provider.selectedRegionValue =
                                                        '';
                                                    provider.regionNewList
                                                        .clear();
                                                    setState(() {});
                                                    applyMjFilter();
                                                  },
                                                  child: const Text(
                                                    "X   ",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ...provider.projectNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${e['projectType']}  ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      provider.selectedProjectCatValue =
                                                          '';
                                                      provider.projectNewList
                                                          .clear();
                                                      setState(() {});
                                                      print(
                                                          "mJProjectList ${provider.mJProjectList}");
                                                      applyMjFilter();
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
                                        ),
                                        ...provider.locationNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${e['pCategory']}  ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      provider.selectedLocationValue =
                                                          '';
                                                      provider.locationNewList
                                                          .clear();
                                                      setState(() {});
                                                      applyMjFilter();
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
                                        ),
                                        ...provider.departGroupNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${e['groupDeptName']}  ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      provider.selectedDepartGroupValue =
                                                          '';
                                                      provider
                                                          .departGroupNewList
                                                          .clear();
                                                      setState(() {});
                                                      applyMjFilter();
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
                                        ),
                                        ...provider.departSubGroupNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${e['subDeptName']}  ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      provider.selectedDepartSubGroupValue =
                                                          '';
                                                      provider
                                                          .departSubGroupNewList
                                                          .clear();
                                                      setState(() {});
                                                      applyMjFilter();
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
                                        ),
                                        ...provider.departmentNewList.map(
                                          (e) => Container(
                                            margin: const EdgeInsets.only(
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
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${e['deptName']}  ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      provider.selectedDepartmentValue =
                                                          '';
                                                      provider.departmentNewList
                                                          .clear();
                                                      setState(() {});
                                                      applyMjFilter();
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
                                        ),
                                        provider.selectedValue1 != ''
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                    color: Color(CommonAppTheme
                                                        .buttonCommonColor),
                                                    borderRadius: BorderRadius
                                                        .circular(CommonAppTheme
                                                            .borderRadious)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        provider.selectedValue1,
                                                        style: TextStyle(
                                                          color: Color(
                                                            CommonAppTheme
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.selectedValue1 =
                                                              '';
                                                          setState(() {});
                                                          applyMjFilter();
                                                        },
                                                        child: const Text(
                                                          "  X ",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: CommonAppTheme.lineheightSpace20,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    ...provider.eMarketPalceManageJobDataList
                        .map(
                          (emarket) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(
                                        CommonAppTheme.headerCommonColor)),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          CommonAppTheme.buttonCommonColor),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            CommonAppTheme.borderRadious),
                                        topRight: Radius.circular(
                                          CommonAppTheme.borderRadious,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${emarket['jobID']}-${emarket['title']}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  emarket['project'] != ""
                                                      ? Text(
                                                          "( ${emarket['project']} ",
                                                          style: styleText,
                                                        )
                                                      : emarket['project'] ==
                                                                  "" &&
                                                              emarket['region'] !=
                                                                  ""
                                                          ? Text(
                                                              "( ${emarket['region']} ",
                                                              style: styleText,
                                                            )
                                                          : emarket['project'] == "" &&
                                                                  emarket['region'] ==
                                                                      "" &&
                                                                  emarket['projectCategoryName'] !=
                                                                      ""
                                                              ? Text(
                                                                  "( ${emarket['projectCategoryName']} ",
                                                                  style:
                                                                      styleText,
                                                                )
                                                              : const SizedBox(),
                                                  (emarket['deptName'] != "" &&
                                                          emarket['subDeptName'] !=
                                                              "" &&
                                                          emarket['groupDeptName'] !=
                                                              "")
                                                      ? Text(
                                                          "-${emarket['deptName']} )",
                                                          style: styleText,
                                                        )
                                                      : (emarket['deptName'] ==
                                                                  "" &&
                                                              emarket['subDeptName'] !=
                                                                  "" &&
                                                              emarket['groupDeptName'] !=
                                                                  "")
                                                          ? Text(
                                                              "-${emarket['subDeptName']} )",
                                                              style: styleText,
                                                            )
                                                          : (emarket[
                                                                          'deptName'] ==
                                                                      "" &&
                                                                  emarket['subDeptName'] ==
                                                                      "" &&
                                                                  emarket['groupDeptName'] !=
                                                                      "")
                                                              ? Text(
                                                                  "-${emarket['groupDeptName']} )",
                                                                  style:
                                                                      styleText,
                                                                )
                                                              : const SizedBox(),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Applicants ",
                                            style: TextStyle(
                                              color: Color(
                                                CommonAppTheme
                                                    .appthemeColorForText,
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            "${emarket['totalApplicant']}",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Period ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            "${emarket['startDate']} - ${emarket['endDate']} ",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Posted By",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Text(
                                            "${emarket['postedBy']}",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            provider.getMjItemDetail(
                                              context,
                                              {
                                                "PositionID":
                                                    emarket['jobID'].toString()
                                              },
                                            );
                                            // Navigator.pushNamed(context,
                                            //     '/view_details_mj');
                                          },
                                          child: Column(
                                            children: [
                                              Icon(Icons.person,
                                                  color: Color(CommonAppTheme
                                                      .buttonCommonColor)),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text("Details"),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        provider.isOfflineData
                                            ? SizedBox()
                                            : InkWell(
                                                onTap: () {
                                                  provider.isApplicantsData =
                                                      false;
                                                  provider.eligibalEmpListHeadingTitle =
                                                      emarket['title'];
                                                  provider.getEligibalEmpList(
                                                    context,
                                                    emarket['jobID'],
                                                    "Main/Job_Eligible_Candidate_Search_Post",
                                                    true,
                                                  );

                                                  // Navigator.pushNamed(context,
                                                  //     '/e_market_place_manage_job_view_application');
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/viewemp.png",
                                                      width: 24,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("E Emp."),
                                                  ],
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        emarket['totalApplicant'] > 0
                                            ? InkWell(
                                                onTap: () {
                                                  provider.isApplicantsData =
                                                      true;
                                                  provider.eligibalEmpListHeadingTitle =
                                                      emarket['title'];
                                                  provider.getEligibalEmpList(
                                                      context,
                                                      emarket['jobID'],
                                                      "Main/Job_Applied_Candidate_Search",
                                                      true);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_red_eye,
                                                      color: Color(CommonAppTheme
                                                          .buttonCommonColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Applicants"),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        provider.isOfflineData
                                            ? SizedBox()
                                            : emarket['documentPath'] != ""
                                                ? InkWell(
                                                    onTap: () {
                                                      print(e);
                                                      provider.commonMethodForNTPCSafetyOpenPDF(
                                                          "${provider.imageUrl}/NewFolder1/${emarket['documentPath']}");
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .picture_as_pdf_rounded,
                                                          color: Color(
                                                              CommonAppTheme
                                                                  .buttonCommonColor),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                            "Attachment"),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox()
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
