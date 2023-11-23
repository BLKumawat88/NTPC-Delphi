import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/commonheader/common_header.dart';
import 'package:provider/provider.dart';
import '../../../theme/common_them.dart';

class JobRotation extends StatefulWidget {
  const JobRotation({super.key});

  @override
  State<JobRotation> createState() => _JobRotation();
}

class _JobRotation extends State<JobRotation> {
  bool isExpandedValue = false;

  TextEditingController byReqNo = TextEditingController();

  updateState() {
    setState(() {});
  }

  applyMjFilter() {
    AllInProvider provider = Provider.of(context, listen: false);

    Map<String, String> data1234 = {
      'Level': '0',
      'TotalExpMin': "${provider.totalJrExpMin.round()}",
      'TotalExpMax': "${provider.totalJrExpMax.round()}",
      'Region': provider.selectedRegionValue == ''
          ? "0"
          : provider.selectedRegionValue,
      'Project': provider.selectedProjectCatValue == ''
          ? "0"
          : provider.selectedProjectCatValue,
      'Location': provider.selectedLocationValue == ''
          ? "0"
          : provider.selectedLocationValue,
      'Department_Group': provider.selectedDepartGroupValue == ''
          ? "0"
          : provider.selectedDepartGroupValue,
      'Department_SubGroup': provider.selectedDepartSubGroupValue == ''
          ? "0"
          : provider.selectedDepartSubGroupValue,
      'Department': provider.selectedDepartmentValue == ''
          ? "0"
          : provider.selectedDepartmentValue,
      "SearchBy": provider.selectedValue1 == "Department Group"
          ? 'DEPTGROUP'
          : provider.selectedValue1 == "Department Subgroup"
              ? "DEPTSUBGROUP"
              : provider.selectedValue1 == "Department"
                  ? 'DEPARTMENT'
                  : 'DEPTGROUP',
    };

    print("data1234 $data1234");
    provider.getJobRotationDataList1(context, data1234, false);
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
                                          "Department Group",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...provider.jrSearchBy
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
                        Consumer<AllInProvider>(
                          builder: (context, value, child) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.totalJrExpMin.round()} ",
                                  ),
                                  Text(
                                    "- ${provider.totalJrExpMax.round()} ",
                                  ),
                                  const Text(
                                    "Years Exp.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              RangeSlider(
                                values: provider.totalExpMinMaxJobRotation,
                                max: 45,
                                divisions: 100,
                                labels: RangeLabels(
                                  provider.totalExpMinMaxJobRotation.start
                                      .round()
                                      .toString(),
                                  provider.totalExpMinMaxJobRotation.end
                                      .round()
                                      .toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  provider
                                      .updateTotalExpMinMaxJobRotation(values);
                                },
                              ),
                            ],
                          ),
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
                                    provider.appliedValue = '';
                                    provider.selectedRegionValue = '';
                                    provider.selectedProjectCatValue = '';
                                    provider.selectedLocationValue = '';
                                    provider.selectedDepartGroupValue = '';
                                    provider.selectedDepartSubGroupValue = '';
                                    provider.selectedDepartmentValue = '';
                                    provider.totalJrExpMin = 0;
                                    provider.totalJrExpMax = 0;

                                    provider.totalExpMinMaxJobRotation =
                                        const RangeValues(0, 0);
                                    /*provider.getJobRotationDataList1(
                                        context,
                                        provider
                                            .jobRotation_value,
                                        false);*/
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
          appBar: CommonHeaderClass.commonAppBarHeader("Job Rotation", context),
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
                    const SizedBox(
                      height: 20,
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
                                provider.publishedJobRotationSearch(value);
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
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
                                            setState(
                                              () {
                                                provider.regionNewList.clear();
                                                provider.locationNewList
                                                    .clear();
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
                                                provider
                                                    .mJDepartmentSubGroupList
                                                    .clear();
                                                provider.mJDepartmentList
                                                    .clear();

                                                provider.byTitle.text = '';
                                                provider.selectedValue1 = '';
                                                provider.appliedValue = '';
                                                provider.selectedRegionValue =
                                                    '';
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
                                                provider.totalJrExpMin = 0;
                                                provider.totalJrExpMax = 0;
                                                provider.totalExpMinMaxJobRotation =
                                                    const RangeValues(0, 0);
                                              },
                                            );
                                            applyMjFilter();
                                            /*  provider.getJobRotationDataList1(
                                          context,
                                          provider
                                              .jobRotation_value,
                                          false);*/
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
                    ...provider.jobRotationDataList
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Emp No. - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            " ${e['empNo']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Name -",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['firstName']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Grade - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['grade']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Designation - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['designation']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Project - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['project']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Location - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['location']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Department - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['groupDeptName']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text("Total Exp. - ",
                                              style: TextStyle(
                                                color: Color(
                                                  CommonAppTheme
                                                      .appthemeColorForText,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            "${e['totalExp']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    /*Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(
                                                        CommonAppTheme
                                                            .buttonCommonColor)),
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      "/search_job_view_details");
                                                },
                                                child: const Text('View Details'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )*/
                                  ],
                                ),
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
