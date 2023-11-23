import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/commonheader/common_header.dart';
import 'package:provider/provider.dart';

import '../../model/subject_data_model.dart';
import '../../theme/common_them.dart';

class SuccessionPlanning extends StatefulWidget {
  const SuccessionPlanning({super.key});

  @override
  State<SuccessionPlanning> createState() => _SuccessionPlanningState();
}

class _SuccessionPlanningState extends State<SuccessionPlanning> {
  bool isExpandedValue = false;
  List subjectData = [];

  void customMenuBottomSheet() {
    AllInProvider provider = Provider.of(context, listen: false);
    provider.getSubjectData();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        enableDrag: true,
        isDismissible: true,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: MediaQuery.of(context).size.height / 1,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MultiSelectDialogField(
                          items: provider.dropDownData,
                          title: const Text(
                            "Published",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          buttonText: const Text(
                            "Select Published",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            subjectData = [];
                            for (var i = 0; i < results.length; i++) {
                              SubjectModel data = results[i] as SubjectModel;
                              print(data.subjectId);
                              print(data.subjectName);
                              subjectData.add(data.subjectId);
                            }
                            print("data $subjectData");

                            //_selectedAnimals = results;
                          },
                        ),
                        MultiSelectDialogField(
                          items: provider.dropDownData,
                          title: const Text(
                            "Published",
                            style: TextStyle(color: Colors.black),
                          ),
                          selectedColor: Colors.black,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          buttonText: const Text(
                            "Select Published",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            subjectData = [];
                            for (var i = 0; i < results.length; i++) {
                              SubjectModel data = results[i] as SubjectModel;
                              print(data.subjectId);
                              print(data.subjectName);
                              subjectData.add(data.subjectId);
                            }
                            print("data $subjectData");

                            //_selectedAnimals = results;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          CommonHeaderClass.commonAppBarHeader("Succession Planning ", context),
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
                    backgroundColor: Color(CommonAppTheme.buttonCommonColor),
                    collapsedBackgroundColor:
                        Color(CommonAppTheme.buttonCommonColor),
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
                                        const Text(
                                          '1193',
                                          style: TextStyle(
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
                                        const Text(
                                          '9178',
                                          style: TextStyle(
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
                                        const Text(
                                          '275',
                                          style: TextStyle(
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
                                  children: const [
                                    Text(
                                      "1 Mon. - 32",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "3 Mon. - 32",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "6 Mon. - 69",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                        "Published Jobs",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(
                            CommonAppTheme.whiteColor,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(
                          CommonAppTheme.buttonCommonColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(CommonAppTheme.borderRadious),
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
                    )
                  ],
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                Text(
                  "Selected Filters",
                  style: TextStyle(
                    color: Color(
                      CommonAppTheme.buttonCommonColor,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(CommonAppTheme.buttonCommonColor),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "APDRP x",
                                style: TextStyle(
                                  color: Color(
                                    CommonAppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(CommonAppTheme.buttonCommonColor),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "APDRP x",
                                style: TextStyle(
                                  color: Color(
                                    CommonAppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(CommonAppTheme.buttonCommonColor),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "APDRP x",
                                style: TextStyle(
                                  color: Color(
                                    CommonAppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(CommonAppTheme.buttonCommonColor),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "APDRP x",
                                style: TextStyle(
                                  color: Color(
                                    CommonAppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(CommonAppTheme.buttonCommonColor),
                                borderRadius: BorderRadius.circular(
                                    CommonAppTheme.borderRadious)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "APDRP x",
                                style: TextStyle(
                                  color: Color(
                                    CommonAppTheme.whiteColor,
                                  ),
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

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(0)),
                  child: DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 10,
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
                      const DataColumn(
                        label: Text(
                          'Head of.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          child: const Text(
                            'Project',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          child: Text(
                            'S',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          child: Text(
                            'P',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          child: Text(
                            'V',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          'View',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      ...provider.successionPlanningData.map(
                        (e) {
                          return DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.08);
                              }
                              return Colors.white; // Use the default value.
                            }),
                            cells: <DataCell>[
                              DataCell(
                                Text(
                                  '${e['title']}',
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    '${e['project']}',
                                    style: TextStyle(
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    '${e['totalSanctioned']}',
                                    style: TextStyle(
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    '${e['totalPositioned']}',
                                    style: TextStyle(
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                    '${e['jobID']}',
                                    style: TextStyle(
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {
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
                ),
                // ...provider.keyPositionMonitoringData
                //     .map(
                //       (e) => Padding(
                //         padding: const EdgeInsets.only(bottom: 10),
                //         child: Card(
                //           elevation: 5,
                //           margin: EdgeInsets.zero,
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text("Name-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['title']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Type-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['positionType']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Project-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['project']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Department-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['departmentName']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Sanctioned-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['totalSanctioned']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Positioned-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['totalPositioned']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Row(
                //                   children: [
                //                     Text("Vacant-",
                //                         style: TextStyle(
                //                           color: Color(
                //                             CommonAppTheme.appthemeColorForText,
                //                           ),
                //                           fontWeight: FontWeight.bold,
                //                         )),
                //                     Text(
                //                       " ${e['jobID']}",
                //                       style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(
                //                   height: CommonAppTheme.lineheightSpace20,
                //                 ),
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     InkWell(
                //                       onTap: () {
                //                         provider.getEligibalEmpList(
                //                             context, e['positionID']);
                //                       },
                //                       child: Column(
                //                         children: [
                //                           Image.asset(
                //                             "assets/images/viewemp.png",
                //                             width: 30,
                //                           ),
                //                           const SizedBox(
                //                             height: 5,
                //                           ),
                //                           const Text("View Emp."),
                //                         ],
                //                       ),
                //                     ),
                //                     InkWell(
                //                       onTap: () {
                //                         provider.getEligibalEmpList(
                //                             context, e['positionID']);
                //                       },
                //                       child: Container(
                //                         decoration: BoxDecoration(
                //                           color: Color(
                //                             CommonAppTheme.buttonCommonColor,
                //                           ),
                //                           borderRadius: BorderRadius.circular(
                //                               CommonAppTheme.borderRadious),
                //                         ),
                //                         child: Padding(
                //                           padding: const EdgeInsets.all(10.0),
                //                           child: Row(
                //                             children: [
                //                               Text(
                //                                 "View Details",
                //                                 style: TextStyle(
                //                                   color: Color(
                //                                     CommonAppTheme.whiteColor,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     )
                //     .toList(),
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
