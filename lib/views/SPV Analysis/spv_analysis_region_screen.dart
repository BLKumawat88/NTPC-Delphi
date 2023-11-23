import 'dart:io';
import 'dart:math';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../controllers/allinprovider.dart';
import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';

class SPVAnalysisRegionScreen extends StatefulWidget {
  SPVAnalysisRegionScreen({super.key});

  @override
  State<SPVAnalysisRegionScreen> createState() =>
      _SPVAnalysisRegionScreenState();
}

class _SPVAnalysisRegionScreenState extends State<SPVAnalysisRegionScreen> {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  final items1 = ["REGION", 'PROJECT', 'SPV DEPARMENT TYPE', "SPV DEPARMENT"];
  String selectedValue1 = '';
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
        "regionName": "Region",
        "total": "S",
        "p_Total": "P",
        "t_Total": "V",
      },
      ...provider.spvAnalysisRegionDataMain
    ];
    print("final download Data ${provider.spvAnalysisRegionDataMain}");

    for (int i = 0; i < excelData.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: i,
          ))
          .value = '${excelData[i]['regionName']}';

      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 1,
            rowIndex: i,
          ))
          .value = '${excelData[i]['total']}';

      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 2,
            rowIndex: i,
          ))
          .value = '${excelData[i]['p_Total']}';

      sheet
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 3,
            rowIndex: i,
          ))
          .value = '${excelData[i]['t_Total']}';
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
              "${directory.path}/  SPV Analysis - Region $randomNameToDownloadSameFileMultiTime.xlsx")
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

  String spv_Dept_Type_value = "";
  String gradeFilter = "";
  String spv_Dept_title = "";

  updateState() {
    setState(() {});
  }

  void showAvailableFilter(context) {
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
                                          "SearchBY",
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
                          ],
                        ),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
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
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
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
                                      if (provider
                                          .masterProjectValues.isNotEmpty) {
                                        provider.masterProjectValues.clear();
                                        Navigator.pop(context);
                                        showAvailableFilter(context);
                                      }

                                      provider.masterProjectDummyData.clear();
                                      provider.masterProjectDummyData =
                                          provider.projectF.map((subjectdataa) {
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
                                    print("fsdf ${dataAfterFilter.length} ");
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
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
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
                                        },
                                      ),
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
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F6FA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    value: gradeFilter.toString(),

                                    onChanged: (value) {
                                      setState(() {
                                        gradeFilter = value.toString();
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "",
                                        child: Text(
                                          "Grade",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...provider.spVGradeF
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value['grade'],
                                                    child: Text(
                                                      value['grade'].toString(),
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
                                    value: spv_Dept_Type_value.toString(),

                                    onChanged: (value) {
                                      setState(
                                        () {
                                          spv_Dept_Type_value =
                                              value.toString();

                                          if (spv_Dept_Type_value == "") {
                                            provider.spvDept.clear();
                                            provider.spvDept = provider.spVDeptF
                                                .map((subjectdataa) {
                                              return MultiSelectItem(
                                                  subjectdataa,
                                                  subjectdataa['textVal']);
                                            }).toList();
                                          } else {
                                            var spv_Dept_title = provider
                                                .spVDeptTypeF
                                                .firstWhere((element) =>
                                                    element['id'].toString() ==
                                                    value.toString());

                                            this.spv_Dept_title =
                                                spv_Dept_title['textVal'];
                                            print(
                                                "TIIT ${this.spv_Dept_title}");
                                            List dataAfterFilter = [];
                                            dataAfterFilter.addAll(provider
                                                .spVDeptF
                                                .where((element) {
                                              return element['dept_Type']
                                                      .toString() ==
                                                  spv_Dept_Type_value
                                                      .toString();
                                            }).toList());
                                            provider.spvDept = dataAfterFilter
                                                .map((subjectdataa) {
                                              return MultiSelectItem(
                                                  subjectdataa,
                                                  subjectdataa['textVal']);
                                            }).toList();
                                          }
                                        },
                                      );
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "",
                                        child: Text(
                                          "SPV Dept. Type",
                                          style: TextStyle(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                          ),
                                        ),
                                      ),
                                      ...provider.spVDeptTypeF
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value:
                                                        value['id'].toString(),
                                                    child: Text(
                                                      value['textVal']
                                                          .toString(),
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
                                      dialogHeight: 250,
                                      searchable: true,
                                      initialValue: provider.spvDeptValues,
                                      items: provider.spvDept,
                                      title: const Text(
                                        "SPV Dept.",
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
                                        "SPV Dept.",
                                        style: TextStyle(
                                          color: Color(
                                              CommonAppTheme.buttonCommonColor),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onConfirm: (results) {
                                        setState(() {
                                          provider.spvDeptValues.clear();
                                          provider.spvDeptValues
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
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Map<String, String>
                                        spvAnalysisRegionFilterData = {
                                      'Department': '',
                                      'Region': '',
                                      'ProjectCategory': '',
                                      'Project': '',
                                      'Grade': gradeFilter,
                                      'Spv_Dept_Type': '0',
                                      'Spv_Dept_Group': '0',
                                      'SortBy': '',
                                      'UserID': '${provider.empCode}',
                                      'UserRole': provider.userRole,
                                      'ProjectType':
                                          '${provider.empProjectType}',
                                      'RegionID': '${provider.empRegionID}',
                                    };
                                    provider.masterRegionValues.clear();
                                    provider.masterProjectValues.clear();
                                    provider.projectCategoryFilterValues
                                        .clear();
                                    provider.gradeFilterValues.clear();
                                    provider.spvDeptTypeValues.clear();
                                    provider.deptFilterValues.clear();

                                    spv_Dept_Type_value = "";
                                    updateState();

                                    provider.setSpvAnalysisRequiredFilters(
                                        context,
                                        1,
                                        spvAnalysisRegionFilterData,
                                        false,
                                        false);
                                  },
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
                                  updateState();
                                  applyFilter(context, true, false);
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

  applyFilter(context, isApplyingFilter, isClearingFilter) {
    AllInProvider provider = Provider.of(context, listen: false);

    provider.masterRegionIds.clear();
    provider.masterProjectIds.clear();
    provider.projectCategoryFilterIds.clear();

    // provider.spvDeptTypeIds.clear();
    provider.deptFilterIds.clear();

    for (int i = 0; i < provider.masterRegionValues.length; i++) {
      provider.masterRegionIds.add(
        provider.masterRegionValues[i]['regionCode'].toInt(),
      );
    }

    for (int i = 0; i < provider.masterProjectValues.length; i++) {
      provider.masterProjectIds.add(provider.masterProjectValues[i]['pid']);
    }

    for (int i = 0; i < provider.projectCategoryFilterValues.length; i++) {
      provider.projectCategoryFilterIds
          .add(provider.projectCategoryFilterValues[i]['projectTypeID']);
    }

    for (int i = 0; i < provider.spvDeptValues.length; i++) {
      provider.deptFilterIds.add(provider.spvDeptValues[i]['id']);
    }

    Map<String, String> spvAnalysisRegionFilterData = {
      'Department': provider.deptFilterIds.join(','),
      'Region': provider.masterRegionIds.join(','),
      'ProjectCategory': provider.projectCategoryFilterIds.join(','),
      'Project': provider.masterProjectIds.join(','),
      'Grade': gradeFilter,
      'Spv_Dept_Type': spv_Dept_Type_value,
      'Spv_Dept_Group': '0',
      'SortBy': '',
      'UserID': '${provider.empCode}',
      'UserRole': provider.userRole,
      'ProjectType': '${provider.empProjectType}',
      'RegionID': '${provider.empRegionID}',
      "SearchBY": selectedValue1
    };

    if (isApplyingFilter) {
      provider.setSpvAnalysisRequiredFilters(
          context, 1, spvAnalysisRegionFilterData, false, isClearingFilter);
    } else {
      Map<String, String> spvAnalysisProjectFilterData = {
        'SearchRegionID': provider.spvRegionId.toString(),
        'Department': provider.deptFilterIds.join(','),
        'Region': '',
        'ProjectCategory': provider.projectCategoryFilterIds.join(','),
        'Project': provider.masterProjectIds.join(','),
        'Grade': gradeFilter,
        'Spv_Dept_Type': spv_Dept_Type_value,
        'Spv_Dept_Group': '0',
        'SortBy': '',
        'UserID': '${provider.empCode}',
        'UserRole': provider.userRole,
        'ProjectType': '${provider.empProjectType}',
        'RegionID': '${provider.empRegionID}',
        "SearchBY": selectedValue1
      };
      print("Getting new screen $spvAnalysisRegionFilterData");
      provider.setSpvAnalysisRequiredFilters(
          context, 2, spvAnalysisProjectFilterData, true, false);
    }
  }

  returnOflfineSTotal() {
    AllInProvider provider = Provider.of(context, listen: false);
    int total = provider.spvAnalysisRegionDataMain
        .fold(0, (int sum, item) => sum + item['total'] as int);
    return total.toString();
  }

  returnOflfinePTotal() {
    AllInProvider provider = Provider.of(context, listen: false);
    int total = provider.spvAnalysisRegionDataMain
        .fold(0, (int sum, item) => sum + item['p_Total'] as int);
    return total.toString();
  }

  returnOflfineTTotal() {
    AllInProvider provider = Provider.of(context, listen: false);
    int total = provider.spvAnalysisRegionDataMain
        .fold(0, (int sum, item) => sum + item['t_Total'] as int);
    return total.toString();
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
        title: Text(
          "SPV Analysis",
          style: TextStyle(color: Colors.black),
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
                          color: Color(
                            CommonAppTheme.appthemeColorForText,
                          ),
                        ),
                      ),
                      backgroundColor: Color(
                        CommonAppTheme.headerCommonColor,
                      ),
                      collapsedBackgroundColor: Color(
                        CommonAppTheme.headerCommonColor,
                      ),
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
                                              fontWeight: FontWeight.bold,
                                            ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        showAvailableFilter(context);
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    color: Color(CommonAppTheme.whiteColor),
                                  ),
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        provider.spvRagionSearchFilter(value);
                                      },

                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                            color: Color(
                                                CommonAppTheme.whiteColor),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                            color: Color(
                                                CommonAppTheme.whiteColor),
                                          ),
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
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
                                                    CommonAppTheme.whiteColor),
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
                provider.masterRegionValues.isNotEmpty ||
                        provider.masterProjectValues.isNotEmpty ||
                        provider.projectCategoryFilterValues.isNotEmpty ||
                        provider.spvDeptValues.isNotEmpty ||
                        spv_Dept_Type_value != "" ||
                        gradeFilter != "" ||
                        selectedValue1 != ""
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
                                        Map<String, String>
                                            spvAnalysisRegionFilterData = {
                                          'Department': '',
                                          'Region': '',
                                          'ProjectCategory': '',
                                          'Project': '',
                                          'Grade': gradeFilter,
                                          'Spv_Dept_Type': '0',
                                          'Spv_Dept_Group': '0',
                                          'SortBy': '',
                                          'UserID': '${provider.empCode}',
                                          'UserRole': provider.userRole,
                                          'ProjectType':
                                              '${provider.empProjectType}',
                                          'RegionID': '${provider.empRegionID}',
                                        };
                                        gradeFilter = "";
                                        provider.masterRegionValues.clear();
                                        provider.spvDeptValues.clear();
                                        provider.masterProjectValues.clear();
                                        provider.projectCategoryFilterValues
                                            .clear();
                                        provider.gradeFilterValues.clear();
                                        provider.spvDeptTypeValues.clear();
                                        provider.deptFilterValues.clear();
                                        spv_Dept_Type_value = "";
                                        provider.setSpvAnalysisRequiredFilters(
                                            context,
                                            1,
                                            spvAnalysisRegionFilterData,
                                            false,
                                            true);
                                        setState(() {});
                                      },
                                      child: const Text(
                                        "Clear All  ",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    selectedValue1 != ""
                                        ? const Text("Grade: ")
                                        : const SizedBox(),
                                    selectedValue1 != ""
                                        ? Container(
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
                                                    selectedValue1,
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedValue1 = "";
                                                      });

                                                      applyFilter(
                                                          context, true, true);
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
                                    provider.masterRegionValues.isNotEmpty
                                        ? const Text("Region: ")
                                        : const SizedBox(),
                                    ...provider.masterRegionValues.map(
                                      (e) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                            borderRadius: BorderRadius.circular(
                                                CommonAppTheme.borderRadious)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${e['regionName']}",
                                                  style: TextStyle(
                                                    color: Color(
                                                      CommonAppTheme.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        provider
                                                            .masterRegionValues
                                                            .removeWhere((item) =>
                                                                item[
                                                                    'regionName'] ==
                                                                e['regionName']);
                                                      },
                                                    );
                                                    applyFilter(
                                                        context, true, true);
                                                  },
                                                  child: const Text(
                                                    " X ",
                                                    style: TextStyle(
                                                      color: Colors.red,
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
                                    ...provider.projectCategoryFilterValues.map(
                                      (e) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                            borderRadius: BorderRadius.circular(
                                                CommonAppTheme.borderRadious)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${e['projectType']}",
                                                  style: TextStyle(
                                                    color: Color(
                                                      CommonAppTheme.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    provider
                                                        .projectCategoryFilterValues
                                                        .removeWhere((item) =>
                                                            item[
                                                                'projectType'] ==
                                                            e['projectType']);
                                                    // applyMonitoringFilter(
                                                    //     false);
                                                  },
                                                  child: const Text(
                                                    " X ",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    provider.masterProjectValues.isNotEmpty
                                        ? const Text("Loc: ")
                                        : const SizedBox(),
                                    ...provider.masterProjectValues.map(
                                      (e) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                            borderRadius: BorderRadius.circular(
                                                CommonAppTheme.borderRadious)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${e['pCategory']}",
                                                style: TextStyle(
                                                  color: Color(
                                                    CommonAppTheme.whiteColor,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  print(provider
                                                      .masterProjectValues);

                                                  provider.masterProjectValues
                                                      .removeWhere((item) =>
                                                          item['pid'] ==
                                                          e['pid']);
                                                  setState(() {});
                                                  // applyMonitoringFilter(false);
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
                                      ),
                                    ),
                                    gradeFilter != ""
                                        ? const Text("Grade: ")
                                        : const SizedBox(),
                                    gradeFilter != ""
                                        ? Container(
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
                                                    gradeFilter,
                                                    style: TextStyle(
                                                      color: Color(
                                                        CommonAppTheme
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        gradeFilter = "";
                                                      });

                                                      applyFilter(
                                                          context, true, true);
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
                                    spv_Dept_Type_value != ""
                                        ? const Text("SPV Dept.Type: ")
                                        : const SizedBox(),
                                    spv_Dept_Type_value != ""
                                        ? Container(
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
                                                      "$spv_Dept_title",
                                                      style: TextStyle(
                                                        color: Color(
                                                          CommonAppTheme
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        spv_Dept_Type_value =
                                                            "";
                                                        setState(() {});
                                                        applyFilter(context,
                                                            true, true);
                                                      },
                                                      child: const Text(
                                                        " X ",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        : SizedBox(),
                                    provider.spvDeptValues.isNotEmpty
                                        ? const Text("SPV Dept: ")
                                        : const SizedBox(),
                                    ...provider.spvDeptValues.map(
                                      (e) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: Color(CommonAppTheme
                                                .buttonCommonColor),
                                            borderRadius: BorderRadius.circular(
                                                CommonAppTheme.borderRadious)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${e['textVal']}",
                                                style: TextStyle(
                                                  color: Color(
                                                    CommonAppTheme.whiteColor,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  provider.spvDeptValues
                                                      .removeWhere((item) =>
                                                          item['levelName'] ==
                                                          e['levelName']);
                                                  setState(() {});
                                                  applyFilter(
                                                      context, true, true);
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
                                      ),
                                    ),
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
                Consumer<AllInProvider>(builder: (context, person, _) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(0)),
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: 2,
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
                          label: returnTableColumnLable('Region'),
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
                      rows: provider.isOfflineData
                          ? <DataRow>[
                              ...provider.spvAnalysisRegionDataMain.map(
                                (e) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
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
                                            provider.spvRegionId =
                                                e['region_Code'];
                                            if (e['regionName'] !=
                                                "Grand Total") {
                                              Map<String, String>
                                                  spvAnalysisProjectFilterData =
                                                  {
                                                'SearchRegionID': provider
                                                    .spvRegionId
                                                    .toString(),
                                                'Department': '',
                                                'Region': '',
                                                'ProjectCategory': '',
                                                'Project': '',
                                                'Grade': gradeFilter,
                                                'Spv_Dept_Type':
                                                    spv_Dept_Type_value,
                                                'Spv_Dept_Group': '0',
                                                'SortBy': '',
                                                'UserID': '${provider.empCode}',
                                                'UserRole': provider.userRole,
                                                'ProjectType':
                                                    '${provider.empProjectType}',
                                                'RegionID':
                                                    '${provider.empRegionID}',
                                              };

                                              provider.selectedRegionName =
                                                  e['regionName'];

                                              if (provider.isOfflineData) {
                                                provider
                                                    .setOfflineFilterForSPVAnalysis(
                                                        context,
                                                        2,
                                                        e['region_Code']);
                                                print(e['region_Code']);
                                              } else {
                                                provider.setSpvAnalysisRequiredFilters(
                                                    context,
                                                    2,
                                                    spvAnalysisProjectFilterData,
                                                    true,
                                                    false);
                                              }
                                            } else {
                                              print("Clicked on Grand total");
                                            }
                                          },
                                          child: Text(
                                            provider.isOfflineData
                                                ? ' ${e['regionName']}'
                                                : ' ${e['searchName']}',
                                            style: TextStyle(
                                              color: Color(
                                                CommonAppTheme
                                                    .buttonCommonColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: returnRowData(
                                            ' ${e['total']}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: returnRowData(
                                            ' ${e['p_Total']}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        InkWell(
                                          onTap: () {
                                            // if (e['totalPositioned'] > 0) {
                                            //   provider.getKeyPostionPositionedEmpData(
                                            //       context, {
                                            //     "PositionID": "${e['positionID']}"
                                            //   });
                                            // }
                                          },
                                          child: Center(
                                            child: Text(
                                              '${e['t_Total']}',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                              DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.08);
                                  }
                                  return Colors.white; // Use the default value.
                                }),
                                cells: [
                                  DataCell(
                                    Text(
                                      " Grand Total",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.buttonCommonColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(returnOflfineSTotal()),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(returnOflfinePTotal()),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(returnOflfineTTotal()),
                                    ),
                                  ),
                                ],
                              )
                            ]
                          : <DataRow>[
                              ...provider.spvAnalysisRegionDataMain.map(
                                (e) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
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
                                            provider.spvRegionId =
                                                e['region_Code'];
                                            if (e['regionName'] !=
                                                "Grand Total") {
                                              Map<String, String>
                                                  spvAnalysisProjectFilterData =
                                                  {
                                                'SearchRegionID': provider
                                                    .spvRegionId
                                                    .toString(),
                                                'Department': '',
                                                'Region': '',
                                                'ProjectCategory': '',
                                                'Project': '',
                                                'Grade': gradeFilter,
                                                'Spv_Dept_Type': '0',
                                                'Spv_Dept_Group': '0',
                                                'SortBy': '',
                                                'UserID': '${provider.empCode}',
                                                'UserRole': provider.userRole,
                                                'ProjectType':
                                                    '${provider.empProjectType}',
                                                'RegionID':
                                                    '${provider.empRegionID}',
                                              };
                                              print(
                                                  "spvAnalysisProjectFilterData $spvAnalysisProjectFilterData");

                                              provider.selectedRegionName =
                                                  e['regionName'];

                                              if (provider.isOfflineData) {
                                                provider
                                                    .setOfflineFilterForSPVAnalysis(
                                                        context,
                                                        2,
                                                        e['region_Code']);
                                                print(e['region_Code']);
                                              } else {
                                                //                                       provider.setSpvAnalysisRequiredFilters(
                                                // context, 2, spvAnalysisRegionFilterData, true);
                                                applyFilter(
                                                    context, false, false);
                                              }
                                            } else {
                                              print("Clicked on Grand total");
                                            }
                                          },
                                          child: Text(
                                            ' ${e['searchName']}',
                                            style: TextStyle(
                                              color: Color(
                                                CommonAppTheme
                                                    .buttonCommonColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: returnRowData(
                                            ' ${e['total']}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: returnRowData(
                                            ' ${e['p_Total']}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        InkWell(
                                          onTap: () {
                                            // if (e['totalPositioned'] > 0) {
                                            //   provider.getKeyPostionPositionedEmpData(
                                            //       context, {
                                            //     "PositionID": "${e['positionID']}"
                                            //   });
                                            // }
                                          },
                                          child: Center(
                                            child: Text(
                                              '${e['t_Total']}',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
