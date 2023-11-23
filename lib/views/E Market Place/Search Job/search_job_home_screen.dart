import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';
import '../../../theme/common_them.dart';

class SearchJobHomeScreen extends StatefulWidget {
  const SearchJobHomeScreen({super.key});

  @override
  State<SearchJobHomeScreen> createState() => _SearchJobHomeScreenState();
}

class _SearchJobHomeScreenState extends State<SearchJobHomeScreen> {
  bool isExpandedValue = false;

  TextStyle styleText = TextStyle(
    color: Color(CommonAppTheme.whiteColor),
    fontWeight: FontWeight.bold,
  );

  TextEditingController byReqNo = TextEditingController();
  updateState() {
    setState(() {});
  }

  applyMjFilter() {
    AllInProvider provider = Provider.of(context, listen: false);

    Map<String, String> data1234 = {
      'SearchID': '',
      'SearchTitle': provider.byTitle.text,
      'Region': provider.selectedRegionValue,
      'Project': provider.selectedProjectCatValue,
      'Location': provider.selectedLocationValue,
      'Department_Group': provider.selectedDepartGroupValue,
      'Department_SubGroup': provider.selectedDepartSubGroupValue,
      'Department': provider.selectedDepartmentValue,
      "isKeyPosition": provider.selectedValue1 == "All"
          ? '-1'
          : provider.selectedValue1 == "Yes"
              ? "1"
              : provider.selectedValue1 == "No"
                  ? '0'
                  : '0',
      "isJobApplied": provider.appliedValue == "All"
          ? '0'
          : provider.appliedValue == "Applied"
              ? "1"
              : provider.appliedValue == "Not Applied"
                  ? '2'
                  : '0',
    };

    print("data1234 $data1234");
    provider.getEMarketPlaceSearchJobDataNew1(
        context, data1234, provider.empCode.toString(), false);
  }

  TextStyle textStyle = TextStyle(
    color: Color(CommonAppTheme.buttonCommonColor),
  );
  void customMenuBottomSheet() {
    AllInProvider provider = Provider.of(context, listen: false);

    print("object${provider.regionF.length}");
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
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
                                    hintStyle: textStyle,
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
                                    hint: Text(
                                      "Region",
                                      style: textStyle,
                                    ),
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
                                    hint: Text(
                                      "Project",
                                      style: textStyle,
                                    ),
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
                                    hint: Text(
                                      "Location",
                                      style: textStyle,
                                    ),
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
                                    hint: Text(
                                      "Depart. Group",
                                      style: textStyle,
                                    ),
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
                                    hint: Text(
                                      "Depart. Sub Group",
                                      style: textStyle,
                                    ),
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
                                    hint: Text(
                                      "Department",
                                      style: textStyle,
                                    ),
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
                                    value: provider.appliedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          provider.appliedValue =
                                              value.toString();
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Text(
                                          "Application",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...provider.applied
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
                                      borderRadius: BorderRadius.circular(30),
                                    ),
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
                                    provider.appliedValue = '';
                                    provider.selectedRegionValue = '';
                                    provider.selectedProjectCatValue = '';
                                    provider.selectedLocationValue = '';
                                    provider.selectedDepartGroupValue = '';
                                    provider.selectedDepartSubGroupValue = '';
                                    provider.selectedDepartmentValue = '';
                                    provider.getEMarketPlaceSearchJobDataNew1(
                                        context,
                                        provider.eMarketPalceSearch_job_value,
                                        provider.empCode.toString(),
                                        false);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Clear All")),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
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

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Consumer<AllInProvider>(
      builder: (context, person, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Vacancies List",
              style: const TextStyle(color: Colors.black),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            // actions: [
            //   PopupMenuButton(
            //     child: const Icon(
            //       Icons.more_vert,
            //     ),
            //     onSelected: (value) {
            //       print(value);
            //     },
            //     itemBuilder: (context) => [
            //       PopupMenuItem(
            //         height: 20,
            //         value: 0,
            //         child: Row(
            //           children: const [
            //             Text(
            //               'Applied Vacancies',
            //               style: TextStyle(fontWeight: FontWeight.bold),
            //             ),
            //             Icon(Icons.arrow_forward_ios)
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ],
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
                                              provider
                                                  .eMarketPlaceSearchJobSummaryData,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Applied - ",
                                                style: TextStyle(
                                                  color: Color(
                                                    CommonAppTheme
                                                        .appthemeColorForText,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                              // provider
                                              //     .eMarketPlaceSearchJobSummaryData,
                                              "${provider.totalApplicantCount}",
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
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Color(
                        //       CommonAppTheme.buttonCommonColor,
                        //     ),
                        //     borderRadius: BorderRadius.circular(
                        //         CommonAppTheme.borderRadious),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           " Excel ",
                        //           style: TextStyle(
                        //             color: Color(
                        //               CommonAppTheme.whiteColor,
                        //             ),
                        //           ),
                        //         ),
                        //         Icon(
                        //           Icons.file_download_outlined,
                        //           color: Color(
                        //             CommonAppTheme.whiteColor,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Color(CommonAppTheme.whiteColor),
                          ),
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: TextFormField(
                              onChanged: (value) {
                                provider.publishedSearchJobsSearch(value);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Color(CommonAppTheme.whiteColor),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                    color: Color(CommonAppTheme.whiteColor),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(
                                          CommonAppTheme.buttonCommonColor,
                                        )),
                                    child: Icon(
                                      Icons.search,
                                      color: Color(CommonAppTheme.whiteColor),
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
                    provider.regionNewList.isNotEmpty ||
                            provider.locationNewList.isNotEmpty ||
                            provider.projectNewList.isNotEmpty ||
                            provider.departGroupNewList.isNotEmpty ||
                            provider.departSubGroupNewList.isNotEmpty ||
                            provider.departmentNewList.isNotEmpty ||
                            provider.selectedValue1 != '' ||
                            provider.appliedValue != ''
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
                                              provider.appliedValue = '';
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
                                            provider.getEMarketPlaceSearchJobDataNew1(
                                                context,
                                                provider
                                                    .eMarketPalceSearch_job_value,
                                                provider.empCode.toString(),
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
                                        provider.appliedValue != ''
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
                                                        provider.appliedValue,
                                                        style: TextStyle(
                                                          color: Color(
                                                            CommonAppTheme
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.appliedValue =
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
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    ...provider.eMarketPlaceSearchJobDataList
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(
                                        CommonAppTheme.headerCommonColor)),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious),
                              ),
                              margin: EdgeInsets.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(e['isApplied'] == 1
                                          ? 0xFF3b8132
                                          : CommonAppTheme.buttonCommonColor),
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
                                          horizontal: 5, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${e['title']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              e['project'] != ""
                                                  ? Text(
                                                      "( ${e['project']} ",
                                                      style: styleText,
                                                    )
                                                  : e['project'] == "" &&
                                                          e['region'] != ""
                                                      ? Text(
                                                          "( ${e['project']} ",
                                                          style: styleText,
                                                        )
                                                      : e['project'] == "" &&
                                                              e['region'] ==
                                                                  "" &&
                                                              e['location'] !=
                                                                  ""
                                                          ? Text(
                                                              "( ${e['location']} ",
                                                              style: styleText,
                                                            )
                                                          : const SizedBox(),
                                              (e['department'] != "" &&
                                                      e['subDepartment'] !=
                                                          "" &&
                                                      e['departmentGroup'] !=
                                                          "")
                                                  ? Text(
                                                      "-${e['department']} )",
                                                      style: styleText,
                                                    )
                                                  : (e['department'] == "" &&
                                                          e['subDepartment'] !=
                                                              "" &&
                                                          e['departmentGroup'] !=
                                                              "")
                                                      ? Text(
                                                          "-${e['subDepartment']} )",
                                                          style: styleText,
                                                        )
                                                      : (e['department'] ==
                                                                  "" &&
                                                              e['subDepartment'] ==
                                                                  "" &&
                                                              e['departmentGroup'] !=
                                                                  "")
                                                          ? Text(
                                                              "-${e['departmentGroup']} )",
                                                              style: styleText,
                                                            )
                                                          : const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child:
                                                    Text("Total Vacancies - ",
                                                        style: TextStyle(
                                                          color: Color(
                                                            CommonAppTheme
                                                                .appthemeColorForText,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  " ${e['vacancies']}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "Grade - ",
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
                                            flex: 8,
                                            child: Text("${e['gradeAll']}"))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Text("End Date - ",
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .appthemeColorForText,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "   ${e['endDate']}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            provider.viewJobDetails(
                                                context, e['jobID']);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                            ),
                                          ),
                                        ),
                                        e['documentPath'] != ""
                                            ? InkWell(
                                                onTap: () {
                                                  provider.commonMethodForNTPCSafetyOpenPDF(
                                                      "${provider.imageUrl}/NewFolder1/${e['documentPath']}");
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Icon(
                                                    Icons
                                                        .picture_as_pdf_rounded,
                                                    color: Color(CommonAppTheme
                                                        .buttonCommonColor),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        if (e['isKeyPosition'])
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(
                                              "assets/images/key.png",
                                              width: 20,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
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
