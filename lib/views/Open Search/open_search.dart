import 'dart:developer' as loga;
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:excel/excel.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';
import 'package:flutter/material.dart';

class OpenSearchScreen extends StatefulWidget {
  const OpenSearchScreen({super.key});
  @override
  State<OpenSearchScreen> createState() => _OpenSearchScreenState();
}

class _OpenSearchScreenState extends State<OpenSearchScreen> {
  late ScrollController _controller;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  Future<bool> _requestPermission(Permission pr) async {
    var status = await pr.request();
    print(status.isGranted);
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  downloadExcelFile(AllInProvider provider) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    loga.log("${json.encode(provider.openSearchEmpDataDummy[0])}");
    List excelData = [
      {
        "name": "Name",
        "pernr": "Code",
        "grade": "Grade",
        "designation": "Designation",
        "department": "Department",
        "project": "Project",
        "location": "Location",
        "entrymode": "Entery Mode",
        "domicile_State": "Domicile State",
        "doE_Project": "DOE Project",
        "doE_Grade": "DOE Grade",
        "dob": "DOB",
        "age": "Age",
        "prev_Proj": "Prev Project",
        "suposeData": "Supose In NTPC",
        "totalExp": "Total Exp",
        "locationExp": "Location Exp",
        "department_Exp": "Department Exp",
        "srNo": 1,
        "empNo": 1773,
        "firstName": "Indu Gupta",
        "caste": "GENERAL",
        "gender": "Female",
        "balanceJob": 0.6,
        "totalYearProject": 0.93,
        "doJ_NTPC": "18/10/1982",
        "alertMsg": "Retirement In - 239 Days.",
        "imgPath": "../assets/images/imageset/00001773.jpg",
        "imgRealPath": "/assets/images/imageset/00001773.jpg",
        "keyPosition": "",
        "isEligibleEmp": "False",
        "functionExp": "FINANCE- 40.65; ",
        "workarea_Exp":
            "CLAIMS- 3.49; INVST. & FUNDS- 5.09; CASH FLOW- 6.50; FIN (MIS)- 7.31; CASH & BANK- 5.09; PENSION TRUST- 0.93; ",
        "spouseID": "",
        "isLongLeave": 0
      },
      ...provider.openSearchEmpDataDummy
    ];

    for (int i = 0; i < excelData.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: i,
          ))
          .value = '${excelData[i]['name']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 1,
            rowIndex: i,
          ))
          .value = '${excelData[i]['pernr']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 2,
            rowIndex: i,
          ))
          .value = '${excelData[i]['grade']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 3,
            rowIndex: i,
          ))
          .value = '${excelData[i]['designation']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 4,
            rowIndex: i,
          ))
          .value = '${excelData[i]['department']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 5,
            rowIndex: i,
          ))
          .value = '${excelData[i]['project']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 6,
            rowIndex: i,
          ))
          .value = '${excelData[i]['location']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 7,
            rowIndex: i,
          ))
          .value = '${excelData[i]['entrymode']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 8,
            rowIndex: i,
          ))
          .value = '${excelData[i]['domicile_State']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 9,
            rowIndex: i,
          ))
          .value = '${excelData[i]['doE_Project']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 10,
            rowIndex: i,
          ))
          .value = '${excelData[i]['doE_Grade']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 11,
            rowIndex: i,
          ))
          .value = '${excelData[i]['dob']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 12,
            rowIndex: i,
          ))
          .value = '${excelData[i]['age']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 13,
            rowIndex: i,
          ))
          .value = '${excelData[i]['prev_Proj']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 14,
            rowIndex: i,
          ))
          .value = '${excelData[i]['suposeData']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 15,
            rowIndex: i,
          ))
          .value = '${excelData[i]['totalExp']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 16,
            rowIndex: i,
          ))
          .value = '${excelData[i]['locationExp']}';
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 17,
            rowIndex: i,
          ))
          .value = '${excelData[i]['department_Exp']}';
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
              "${directory.path}/Open Search $randomNameToDownloadSameFileMultiTime.xlsx")
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
  void initState() {
    AllInProvider provider = Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
    _controller = ScrollController()
      ..addListener(
        () => {
          if (_controller.position.maxScrollExtent ==
              _controller.position.pixels)
            {provider.loadMoreData(context, false)}
        },
      );
  }

  TextEditingController searchUserDataByNameId = TextEditingController();
  bool isExpandedValue = false;
  List compareList = [];
  Widget employeeDetail(title, value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "$title",
                style: TextStyle(
                  color: Color(
                    CommonAppTheme.appthemeColorForText,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                " $value",
                style: const TextStyle(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  // List of items in our dropdown menu
  var items = [
    {'title': 'Sort By', 'value': ""},
    {"title": 'Emp No. Asc', "value": "Order By EmpNo"},
    {"title": 'Emp No. Desc', "value": "Order By EmpNo Desc"},
    {"title": 'Name Asc', "value": "Order By FirstName"},
    {'title': 'Name Desc', "value": "Order By FirstName DESC"}
  ];

  Widget displaySelectedFilter(
      filterTitle, selectedFilterName, applyFilterCat, providerAccess) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Color(CommonAppTheme.buttonCommonColor),
          borderRadius: BorderRadius.circular(CommonAppTheme.borderRadious)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              filterTitle,
              style: const TextStyle(color: Colors.white),
            ),
            ...applyFilterCat
                .map(
                  (e) => Text(
                    "${e['$selectedFilterName']} , ",
                    style: TextStyle(
                      color: Color(
                        CommonAppTheme.whiteColor,
                      ),
                    ),
                  ),
                )
                .toList(),
            InkWell(
              onTap: () {
                applyFilterCat.clear();
                providerAccess.clearOpenSearchListData();
                providerAccess.applyMasterFilter(context, false);
              },
              child: const Text(
                " X ",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnSelectedDateFilterValues(
      text, updateVariable, variableValue, value, providerAccess) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Color(CommonAppTheme.buttonCommonColor),
          borderRadius: BorderRadius.circular(CommonAppTheme.borderRadious)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "${text}${variableValue}",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (updateVariable == "dobmin" ||
                      updateVariable == "dobmax") {
                    providerAccess.dobmin = 'Date of Birth';
                    providerAccess.dobMax = 'Date of Birth';
                  }
                  providerAccess.clearOpenSearchListData();
                  providerAccess.applyMasterFilter(context, false);
                });
              },
              child: const Text(
                " X ",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phFilterSelected(
    text,
    type,
    providerAccess,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Color(CommonAppTheme.buttonCommonColor),
          borderRadius: BorderRadius.circular(CommonAppTheme.borderRadious)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "${text}",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (type == 1) {
                    providerAccess.masterPHHearing = false;
                  } else if (type == 2) {
                    providerAccess.masterPHOrtho = false;
                  } else if (type == 3) {
                    providerAccess.masterPHVisual = false;
                  }
                  providerAccess.clearOpenSearchListData();
                  providerAccess.applyMasterFilter(context, false);
                });
              },
              child: const Text(
                " X ",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: OpenSearchHeader.commonAppBarHeader(
        "Open Search",
        context,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(CommonAppTheme.screenPadding),
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(CommonAppTheme.borderRadious),
                        color: Color(CommonAppTheme.buttonCommonColor)),
                    child: Center(
                      child: Consumer<AllInProvider>(
                        builder: (context, value, child) => Text(
                          "Employees List(Total - ${provider.totalRecord} employees found out of ${provider.totalEmpCount})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 35,
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
                            controller: searchUserDataByNameId,
                            onChanged: (value) {
                              provider.searchUserByNameId = value;
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
                                child: InkWell(
                                  onTap: () {
                                    provider.clearOpenSearchListData();
                                    // searchUserDataByNameId.text = "";
                                    provider.applyMasterFilter(context, false);
                                    // provider.clearFilterValues(
                                    //   context,
                                    //   false,
                                    // );
                                  },
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
                            ),
                            // readOnly: true,ddhd
                            onTap: () {
                              //Go to the next screen
                            },
                            cursorColor: Colors.grey,
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 50,
                      ),
                      DropdownButton(
                        // Initial Value
                        value: provider.sortByValue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map(
                          (items) {
                            return DropdownMenuItem(
                              value: items['value'],
                              child: Text("${items['title']}"),
                            );
                          },
                        ).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            provider.sortByValue = newValue!;
                          });
                          provider.clearOpenSearchListData();
                          provider.applyMasterFilter(context, false);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: CommonAppTheme.lineheightSpace20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          downloadExcelFile(provider);
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
                                Image.asset(
                                  "assets/images/compare.png",
                                  width: 25,
                                  color: Color(CommonAppTheme.whiteColor),
                                ),
                                Text(
                                  "Export Emp.",
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
                    ],
                  ),
                  SizedBox(
                    height: CommonAppTheme.lineheightSpace20,
                  ),
                  Consumer<AllInProvider>(
                    builder: (context, value, child) => provider
                                .masterDepartmentGroupFilterValues.isNotEmpty ||
                            provider.masterDepartmentSubGroupFilterValues
                                .isNotEmpty ||
                            provider.masterDepartmentFilterValues.isNotEmpty ||
                            provider.masterWorkProfileValues.isNotEmpty ||
                            provider.masterDepartmentExpEmpGroupValue != "" ||
                            provider.masterRegionValues.isNotEmpty ||
                            provider.masterProjectValues.isNotEmpty ||
                            provider.masterCategoryValues.isNotEmpty ||
                            provider.masterProjectCategoryValues.isNotEmpty ||
                            provider
                                .masterCurrentProjectRegionValues.isNotEmpty ||
                            provider
                                .masterCurrentProjectProjectValues.isNotEmpty ||
                            provider.masterCurrentProjectProjectLocationValues
                                .isNotEmpty ||
                            provider.masterDepartmentDepartmentGroupFilterValues
                                .isNotEmpty ||
                            provider
                                .masterDepartmentDepartmentSubGroupFilterValues
                                .isNotEmpty ||
                            provider.masterDepartmentDepartmentFilterValues
                                .isNotEmpty ||
                            provider
                                .masterDepartmentWorkProfileValues.isNotEmpty ||
                            provider.masterStatesValues.isNotEmpty ||
                            provider.masterEmployeeGroupValues.isNotEmpty ||
                            provider.masterGradeValues.isNotEmpty ||
                            provider.masterSubstantiveGradeValues.isNotEmpty ||
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
                            provider
                                .masterInterestAwardInterestValues.isNotEmpty ||
                            provider.masterInterestAwardAchievementValues
                                .isNotEmpty ||
                            provider.isAgeSelected ||
                            provider.isGeneralBalanceSelected ||
                            provider.masterEntryModeValues.isNotEmpty ||
                            provider.masterQualificationValues.isNotEmpty ||
                            provider.masterBranchValues.isNotEmpty ||
                            provider.masterInstituteValues.isNotEmpty ||
                            provider.masterAreaOfRecruitmentValues.isNotEmpty ||
                            provider.masterTrainingValues.isNotEmpty ||
                            provider.tranningStartDate != "Start Date" ||
                            provider.tranningEndDate != 'End Date' ||
                            provider.ridValue != "" ||
                            provider.typeListID != "" ||
                            provider.dobmin != "Date of Birth"
                        // provider.superannuationMin != "DOS" ||
                        // provider.dojProjectMin != "DOJ Project" ||
                        // provider.dOJDepartmentMin != "DOJ Department" ||
                        // provider.dOEGradeMin != "DOE Grade"
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            provider.clearOpenSearchListData();
                                            provider.clearFilterValues(
                                                context, false);
                                          },
                                          child: const Text(
                                            "Clear All  ",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        provider.masterVigilanceSelectedValue ==
                                                    "1" ||
                                                provider.masterVigilanceSelectedValue ==
                                                    "2"
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
                                                        "Vigilance : ${provider.masterVigilanceSelectedValue == "1" ? "Included" : "Excluded"}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            provider.masterVigilanceSelectedValue =
                                                                "0";
                                                          });

                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                            context,
                                                            false,
                                                          );
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
                                            : SizedBox(),
                                        provider.isGeneralBalanceSelected
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
                                                        "Balance Service : ${provider.generalBalanceMin.round()} - ${provider.generalBalanceMax.round()} Years",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              provider.isGeneralBalanceSelected =
                                                                  false;
                                                            },
                                                          );
                                                          provider
                                                              .generalBalanceMin = 0;
                                                          provider.generalBalanceMax =
                                                              45;
                                                          provider.generalBalanceServiceMinMax =
                                                              const RangeValues(
                                                                  0, 45);
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                            context,
                                                            false,
                                                          );
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
                                            : SizedBox(),
                                        provider.isAgeSelected
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
                                                        "Age : ${provider.generalAgeMin.round()} - ${provider.generalAgeMax.round()} Years",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              provider.isAgeSelected =
                                                                  false;
                                                            },
                                                          );
                                                          provider.generalAgeMin =
                                                              18;
                                                          provider.generalAgeMax =
                                                              60;
                                                          provider.generalAgeMinMax =
                                                              const RangeValues(
                                                                  18, 60);
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                            context,
                                                            false,
                                                          );
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
                                            : SizedBox(),
                                        provider.masterDepartmentGroupFilterValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Dept. Group : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterDepartmentGroupFilterValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['groupDeptName']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterDepartmentGroupFilterValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          250,
                                                                          170,
                                                                          164),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterDepartmentSubGroupFilterValues
                                                .isNotEmpty
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
                                                      const Text(
                                                        "Sub. Group:  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ...provider
                                                          .masterDepartmentSubGroupFilterValues
                                                          .map(
                                                            (e) => Text(
                                                              "${e['subDeptName']} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      InkWell(
                                                        onTap: () {
                                                          provider
                                                              .masterDepartmentSubGroupFilterValues
                                                              .clear();
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterDepartmentFilterValues
                                                .isNotEmpty
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
                                                      const Text(
                                                        "Dept:  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ...provider
                                                          .masterDepartmentFilterValues
                                                          .map(
                                                            (e) => Text(
                                                              "${e['deptName']} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      InkWell(
                                                        onTap: () {
                                                          provider
                                                              .masterDepartmentFilterValues
                                                              .clear();
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterWorkProfileValues
                                                .isNotEmpty
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
                                                      const Text(
                                                        "Work Profile:  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ...provider
                                                          .masterWorkProfileValues
                                                          .map(
                                                            (e) => Text(
                                                              "${e['workProfile']} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      InkWell(
                                                        onTap: () {
                                                          provider
                                                              .masterWorkProfileValues
                                                              .clear();
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterDepartmentExpEmpGroupValue !=
                                                ""
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
                                                      const Text(
                                                        "Emp. Group Exp :  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        provider
                                                            .masterDepartmentExpEmpGroupValue,
                                                        style: TextStyle(
                                                          color: Color(
                                                            CommonAppTheme
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.masterDepartmentExpEmpGroupValue =
                                                              "";
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterRegionValues.isNotEmpty
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
                                                      const Text(
                                                        "Region Loc. Exp.:  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ...provider
                                                          .masterRegionValues
                                                          .map(
                                                            (e) => Text(
                                                              "${e['regionName']} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      InkWell(
                                                        onTap: () {
                                                          provider
                                                              .masterRegionValues
                                                              .clear();
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterProjectValues.isNotEmpty
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
                                                      const Text(
                                                        "Project Loc. Exp.:  ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ...provider
                                                          .masterProjectValues
                                                          .map(
                                                            (e) => Text(
                                                              "${e['pCategory']} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      InkWell(
                                                        onTap: () {
                                                          provider
                                                              .masterProjectValues
                                                              .clear();
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
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
                                        provider.masterCategoryValues.isNotEmpty
                                            ? displaySelectedFilter(
                                                "Gen. Cate :",
                                                "categoryName",
                                                provider.masterCategoryValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterProjectCategoryValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Gen.Proj.Cate :",
                                                "projectType",
                                                provider
                                                    .masterProjectCategoryValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterCurrentProjectRegionValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Gen.Proj.Region :",
                                                "regionName",
                                                provider
                                                    .masterCurrentProjectRegionValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterCurrentProjectProjectValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Gen.Proj.Project :",
                                                "pCategory",
                                                provider
                                                    .masterCurrentProjectProjectValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterCurrentProjectProjectLocationValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Gen.Proj.Project Loc. :",
                                                "projectArea",
                                                provider
                                                    .masterCurrentProjectProjectLocationValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterDepartmentDepartmentGroupFilterValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Department Dept.G.:",
                                                "groupDeptName",
                                                provider
                                                    .masterDepartmentDepartmentGroupFilterValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterDepartmentDepartmentSubGroupFilterValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Department Dept.S.G.:",
                                                "subDeptName",
                                                provider
                                                    .masterDepartmentDepartmentSubGroupFilterValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterDepartmentDepartmentFilterValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Department Dept:",
                                                "deptName",
                                                provider
                                                    .masterDepartmentDepartmentFilterValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterDepartmentWorkProfileValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "Department work profile:",
                                                "workProfile",
                                                provider
                                                    .masterDepartmentWorkProfileValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterStatesValues.isNotEmpty
                                            ? displaySelectedFilter(
                                                "General Domicile:",
                                                "stateName",
                                                provider.masterStatesValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterEmployeeGroupValues
                                                .isNotEmpty
                                            ? displaySelectedFilter(
                                                "General Emp.Group:",
                                                "grade",
                                                provider
                                                    .masterEmployeeGroupValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.masterGradeValues.isNotEmpty
                                            ? displaySelectedFilter(
                                                "General Grade:",
                                                "levelName",
                                                provider.masterGradeValues,
                                                provider)
                                            : const SizedBox(),
                                        provider.dobmin != "Date of Birth"
                                            ? returnSelectedDateFilterValues(
                                                "DOB From:",
                                                "dobmin",
                                                provider.dobmin,
                                                "Date of Birth",
                                                provider,
                                              )
                                            : SizedBox(),
                                        provider.dobMax != "Date of Birth"
                                            ? returnSelectedDateFilterValues(
                                                "DOB to:",
                                                "dobmax",
                                                provider.dobMax,
                                                "Date of Birth",
                                                provider,
                                              )
                                            : SizedBox(),
                                        provider.masterPHHearing
                                            ? phFilterSelected(
                                                "PH Hearing",
                                                1,
                                                provider,
                                              )
                                            : SizedBox(),
                                        provider.masterPHOrtho
                                            ? phFilterSelected(
                                                "PH Ortho",
                                                2,
                                                provider,
                                              )
                                            : SizedBox(),
                                        provider.masterPHVisual
                                            ? phFilterSelected(
                                                "PH Visual",
                                                3,
                                                provider,
                                              )
                                            : SizedBox(),
                                        provider.masterGenderSelectedValue != ""
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
                                                        provider
                                                            .masterGenderSelectedValue,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.masterGenderSelectedValue =
                                                              "";
                                                          provider
                                                              .clearOpenSearchListData();
                                                          provider
                                                              .applyMasterFilter(
                                                                  context,
                                                                  false);
                                                        },
                                                        child: const Text(
                                                          " X ",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        provider.masterAssociationsCommitteesValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Associations Committees : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterAssociationsCommitteesValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['text_val']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterAssociationsCommitteesValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterAssociationsMemberValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Associations Member : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterAssociationsMemberValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['text_val']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterAssociationsMemberValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterAssociationsFacultyValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Associations Faculty : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterAssociationsFacultyValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['text_val']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterAssociationsFacultyValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterInterestAwardInterestValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Interest : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterInterestAwardInterestValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['text_val']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterInterestAwardInterestValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterInterestAwardAchievementValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Achievements: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterInterestAwardAchievementValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['text_val']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterInterestAwardAchievementValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterEntryModeValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Entry Mode: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterEntryModeValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['textVal']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterEntryModeValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterQualificationValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Qualification : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterQualificationValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['qualification1']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterQualificationValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterBranchValues.isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Branch : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterBranchValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['branchName']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterBranchValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterInstituteValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Institute/University : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterInstituteValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['institute']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterInstituteValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterInstituteValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Institute/University : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterInstituteValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['institute']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterInstituteValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                " X ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.masterAreaOfRecruitmentValues
                                                .isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Recruitment: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ...provider
                                                                .masterAreaOfRecruitmentValues
                                                                .map(
                                                                  (e) => Text(
                                                                    "${e['recruitment']} , ",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Color(
                                                                        CommonAppTheme
                                                                            .whiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .masterAreaOfRecruitmentValues
                                                                    .clear();
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.tranningStartDate !=
                                                'Start Date'
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Training Start Date: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "${provider.tranningStartDate} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider.tranningStartDate =
                                                                    'Start Date';
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.tranningEndDate != 'End Date'
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Training End Date: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "${provider.tranningEndDate} , ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider.tranningEndDate =
                                                                    'End Date';
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                  context,
                                                                  false,
                                                                );
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.ridValue != ""
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Request Type List: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "${provider.requestTypeDataToShowAsSelectedFilter} ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider.ridValue =
                                                                    "";
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
                                              )
                                            : const SizedBox(),
                                        provider.typeListID != ""
                                            ? Column(
                                                children: [
                                                  Container(
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
                                                            const Text(
                                                              "Ground Type List: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              "${provider.typeListToShowSelectedValue} ",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  CommonAppTheme
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                provider.typeListID =
                                                                    '';
                                                                provider
                                                                    .clearOpenSearchListData();
                                                                provider
                                                                    .applyMasterFilter(
                                                                        context,
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
                                                ],
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
                  ),
                  Consumer<AllInProvider>(
                    builder: (context, value, child) => provider
                            .openSearchEmpDataDummy.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.openSearchEmpDataDummy.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ExpansionTile(
                                      title: ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        leading: InkWell(
                                          onTap: () {
                                            provider.viewProfile(
                                                context,
                                                provider.openSearchEmpDataDummy[
                                                    index]['empNo']);
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                "${provider.imageUrl}/${provider.openSearchEmpDataDummy[index]['imgPath']}"),
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${provider.openSearchEmpDataDummy[index]['name']}(${provider.openSearchEmpDataDummy[index]['pernr']})",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(CommonAppTheme
                                                    .buttonCommonColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${provider.openSearchEmpDataDummy[index]['grade']} ${provider.openSearchEmpDataDummy[index]['designation']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " ${provider.openSearchEmpDataDummy[index]['department']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${provider.openSearchEmpDataDummy[index]['project'].toLowerCase() == provider.openSearchEmpDataDummy[index]['location'].toLowerCase() ? provider.openSearchEmpDataDummy[index]['project'] : '${provider.openSearchEmpDataDummy[index]['project']} ${provider.openSearchEmpDataDummy[index]['location']}'}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                provider.openSearchEmpDataDummy[
                                                                index]
                                                            ['keyPosition'] ==
                                                        ""
                                                    ? const SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Image.asset(
                                                          "assets/images/key.png",
                                                          width: 30,
                                                        ),
                                                      ),
                                                provider.openSearchEmpDataDummy[
                                                                index]
                                                            ['alertMsg'] ==
                                                        ""
                                                    ? const SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Image.asset(
                                                          "assets/images/men.png",
                                                          width: 30,
                                                        ),
                                                      ),
                                                Image.asset(
                                                  "assets/images/group1.png",
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Switch(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value: provider.openSearchEmpDataDummy[
                                                                      index][
                                                                  'isEligibleEmp'] ==
                                                              "False"
                                                          ? false
                                                          : true,
                                                      onChanged: (value) {
                                                        print(provider
                                                                .openSearchEmpDataDummy[
                                                            index]['empNo']);
                                                        if (value) {
                                                          if (compareList
                                                                  .length >=
                                                              3) {
                                                            CommanDialog
                                                                .showErrorDialog(
                                                                    context,
                                                                    description:
                                                                        "You can not compare more than 3 employees.");
                                                          } else {
                                                            setState(() {
                                                              provider.openSearchEmpDataDummy[
                                                                          index]
                                                                      [
                                                                      'isEligibleEmp'] =
                                                                  "true";
                                                            });
                                                            if (compareList.contains(
                                                                provider.openSearchEmpDataDummy[
                                                                        index][
                                                                    'empNo'])) {
                                                              compareList.removeWhere((element) =>
                                                                  element ==
                                                                  provider.openSearchEmpDataDummy[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            } else {
                                                              compareList.add(
                                                                  provider.openSearchEmpDataDummy[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            }
                                                          }
                                                        } else {
                                                          setState(() {
                                                            provider.openSearchEmpDataDummy[
                                                                        index][
                                                                    'isEligibleEmp'] =
                                                                "False";
                                                            if (compareList.contains(
                                                                provider.openSearchEmpDataDummy[
                                                                        index][
                                                                    'empNo'])) {
                                                              compareList.removeWhere((element) =>
                                                                  element ==
                                                                  provider.openSearchEmpDataDummy[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            } else {
                                                              compareList.add(
                                                                  provider.openSearchEmpDataDummy[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            }
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          color: const Color(0xFFE3EEF6),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                employeeDetail('Hiring Mode:',
                                                    " ${provider.openSearchEmpDataDummy[index]['entrymode']}"),
                                                employeeDetail(
                                                    'Domicile State:',
                                                    " ${provider.openSearchEmpDataDummy[index]['domicile_State']}"),
                                                employeeDetail(
                                                    "D.O.E. Project:",
                                                    " ${provider.openSearchEmpDataDummy[index]['doE_Project']}"),
                                                employeeDetail("D.O.E. Grade:",
                                                    " ${provider.openSearchEmpDataDummy[index]['doE_Grade']}"),
                                                employeeDetail("D.O.B.:",
                                                    " ${provider.openSearchEmpDataDummy[index]['dob']} (${provider.openSearchEmpDataDummy[index]['age']})"),
                                                employeeDetail("Prev. Proj.:",
                                                    " ${provider.openSearchEmpDataDummy[index]['prev_Proj']}"),
                                                employeeDetail(
                                                  "Spouse in NTPC:",
                                                  provider.openSearchEmpDataDummy[
                                                                  index]
                                                              ['spouseID'] ==
                                                          ""
                                                      ? " NO"
                                                      : " Yes",
                                                ),
                                                employeeDetail("Total Exp:",
                                                    " ${provider.openSearchEmpDataDummy[index]['totalExp']}"),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Loc.Exp:   ",
                                                      style: TextStyle(
                                                        color: Color(
                                                          CommonAppTheme
                                                              .appthemeColorForText,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${provider.openSearchEmpDataDummy[index]['locationExp']}",
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Dept.Exp :",
                                                        style: TextStyle(
                                                          color: Color(
                                                            CommonAppTheme
                                                                .appthemeColorForText,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    Flexible(
                                                      child: Text(
                                                        "${provider.openSearchEmpDataDummy[index]['functionExp']}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (compareList.length >= 2) {
            String cmp = ",${compareList.join(',')},";
            provider.getEmpCompareSearchData(context, {'EmployeeIdList': cmp});
          }
        },
        label: Row(
          children: [
            Image.asset(
              "assets/images/compare.png",
              width: 25,
              color: Color(CommonAppTheme.whiteColor),
            ),
            Text(
              "Compare",
              style: TextStyle(
                color: Color(
                  CommonAppTheme.whiteColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
