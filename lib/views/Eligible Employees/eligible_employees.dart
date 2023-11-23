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

class EligibleEmployeesScreen extends StatefulWidget {
  const EligibleEmployeesScreen({super.key});

  @override
  State<EligibleEmployeesScreen> createState() =>
      _EligibleEmployeesScreenState();
}

class _EligibleEmployeesScreenState extends State<EligibleEmployeesScreen> {
  bool isExpandedValue = false;
  List compareList = [];

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
      ...provider.eligibalEmpListDummy
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
              "${directory.path}/Applicants List $randomNameToDownloadSameFileMultiTime.xlsx")
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

  Widget employeeDetail(title, value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text("$title",
                  style: TextStyle(
                    color: Color(
                      CommonAppTheme.appthemeColorForText,
                    ),
                    fontWeight: FontWeight.bold,
                  )),
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

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
          provider.isApplicantsData ? "Applicants List" : "Eligible Employees",
          context),
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
            child: Consumer<AllInProvider>(
              builder: (context, value, _) => ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(CommonAppTheme.borderRadious),
                      color: Color(
                        CommonAppTheme.buttonCommonColor,
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          provider.isApplicantsData
                              ? "Applicants List For ${provider.eligibalEmpListHeadingTitle}"
                              : "Eligible Employees List For ${provider.eligibalEmpListHeadingTitle}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              CommonAppTheme.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      provider.isOfflineData
                          ? SizedBox()
                          : InkWell(
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
                      provider.isOfflineData
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                if (compareList.length >= 2) {
                                  String cmp = ",${compareList.join(',')},";
                                  provider.getEmpCompareSearchData(
                                      context, {'EmployeeIdList': cmp});
                                }
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
                              if (compareList.isNotEmpty) {
                                compareList.clear();
                                for (int i = 0;
                                    i < provider.eligibalEmpListDummy.length;
                                    i++) {
                                  provider.eligibalEmpListDummy[i]
                                      ['isEligibleEmp'] = "False";
                                }
                              }
                              provider.eligibleEmpSearch(value);
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
                  SizedBox(
                    height: CommonAppTheme.lineheightSpace20,
                  ),
                  Text(
                    "(Total - ${provider.eligibalEmpListDummy.length} records found)",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: CommonAppTheme.lineheightSpace20,
                  ),
                  ...provider.eligibalEmpListDummy
                      .map(
                        (e) => Padding(
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
                                        print(e);

                                        provider.viewProfile(
                                            context, e['empNo']);
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            "https://delphi.ntpc.co.in/${e['imgPath']}"),
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e['name']}(${e['pernr']})",
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
                                          "${e['grade']} ${e['designation']}",
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
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${e['department']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "${e['project'].toLowerCase() == e['location'].toLowerCase() ? e['project'] : '${e['project']} ${e['location']}'}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            e['keyPosition'] == ""
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Image.asset(
                                                      "assets/images/key.png",
                                                      width: 30,
                                                    ),
                                                  ),
                                            e['alertMsg'] == ""
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Image.asset(
                                                      "assets/images/men.png",
                                                      width: 30,
                                                    ),
                                                  ),
                                            // e['totalYearProject'] >= 10
                                            //     ? Padding(
                                            //         padding:
                                            //             const EdgeInsets
                                            //                     .only(
                                            //                 right: 5),
                                            //         child: Image.asset(
                                            //           "assets/images/tenplus.png",
                                            //           width: 30,
                                            //         ),
                                            //       )
                                            //     : const SizedBox(),
                                            Image.asset(
                                              "assets/images/group1.png",
                                              width: 30,
                                            ),
                                            provider.isOfflineData
                                                ? Expanded(
                                                    child: SizedBox(),
                                                  )
                                                : Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Switch(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        value:
                                                            e['isEligibleEmp'] ==
                                                                    "False"
                                                                ? false
                                                                : true,
                                                        onChanged: (value) {
                                                          print(e[
                                                              'isEligibleEmp']);
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
                                                                e['isEligibleEmp'] =
                                                                    "true";
                                                              });
                                                              if (compareList
                                                                  .contains(e[
                                                                      'empNo'])) {
                                                                compareList.removeWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        e['empNo']);
                                                              } else {
                                                                compareList.add(
                                                                    e['empNo']);
                                                              }
                                                            }
                                                          } else {
                                                            setState(() {
                                                              e['isEligibleEmp'] =
                                                                  "False";
                                                              if (compareList
                                                                  .contains(e[
                                                                      'empNo'])) {
                                                                compareList.removeWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        e['empNo']);
                                                              } else {
                                                                compareList.add(
                                                                    e['empNo']);
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
                                                " ${e['entrymode']}"),
                                            employeeDetail('Domicile State:',
                                                " ${e['domicile_State']}"),
                                            employeeDetail("D.O.E. Project:",
                                                " ${e['doE_Project']}"),
                                            employeeDetail("D.O.E. Grade:",
                                                " ${e['doE_Grade']}"),
                                            employeeDetail("D.O.B.:",
                                                " ${e['dob']} (${e['age']})"),
                                            employeeDetail("Prev. Proj.:",
                                                " ${e['prev_Proj']}"),
                                            employeeDetail(
                                              "Spouse in NTPC:",
                                              e['spouseID'] == ""
                                                  ? " NO"
                                                  : " Yes",
                                            ),
                                            employeeDetail("Total Exp:",
                                                " ${e['totalExp']}"),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Loc.Exp:   ",
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
                                                    "${e['locationExp']}",
                                                    style: const TextStyle(),
                                                    textAlign: TextAlign.left,
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
                                                    "${e['functionExp']}",
                                                    style: const TextStyle(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            provider.isApplicantsData
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text("AOE :",
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
                                                          "${e['expertise']}",
                                                          style:
                                                              const TextStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            provider.isApplicantsData
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text("Justification :",
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
                                                          "${e['descriptions']}",
                                                          style:
                                                              const TextStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox()
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
                      )
                      .toList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
