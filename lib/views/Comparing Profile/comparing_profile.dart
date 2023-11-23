import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';

import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';

class ComparingProfile extends StatefulWidget {
  const ComparingProfile({super.key});

  @override
  State<ComparingProfile> createState() => _ComparingProfileState();
}

class _ComparingProfileState extends State<ComparingProfile> {
  bool isExpandedValue = false;
  bool isExpandedValue1 = false;
  bool isExpandedValue2 = false;
  bool isExpandedValue3 = false;
  bool isExpandedValue4 = false;
  bool isExpandedValue5 = false;
  bool isExpandedValue6 = false;
  bool isExpandedValue7 = false;
  bool isExpandedValue8 = false;
  bool isExpandedValue9 = false;
  bool isExpandedValue10 = false;
  bool isExpandedValue11 = false;
  bool isExpandedValue12 = false;
  bool isExpandedValue13 = false;
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader("Compare", context),
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
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ...provider.empCompareSearchData.map(
                          (e) => Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  provider.viewProfile(context, e['empNo']);
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "${provider.imageUrl}/${e['imgPathReal']}",
                                  ),
                                  radius: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...provider.empCompareSearchData.map(
                          (e) => Expanded(
                            child: Text(
                              "${e['name']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        ...provider.empCompareSearchData.map(
                          (e) => Expanded(
                            child: Text(
                              "${e['empNo']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          border: TableBorder.all(
                            width: 1,
                            color: Colors.black45,
                          ), //table border
                          children: [
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['age']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['gender']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['entryMode']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['grade']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['designation']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['project']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['location']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['department']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['prev_Proj']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['domicile_State']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  ...provider.empCompareSearchData.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e['totalExp']}",
                                        style: const TextStyle(
                                          color: Color(0xFF767676),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),

                        // Consumer<AllInProvider>(builder: (context, person, _) {
                        //   return Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(0)),
                        //     child: DataTable(
                        //       // horizontalMargin: 5,
                        //       // columnSpacing: 10,
                        //       border: TableBorder.all(
                        //           color: Colors.grey,
                        //           borderRadius: BorderRadius.circular(0)),
                        //       headingRowColor: MaterialStateProperty.all(
                        //         Colors.white,
                        //       ),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(0),
                        //       ),
                        //       columns: <DataColumn>[
                        //         ...provider.empCompareSearchData.map(
                        //           (e) => DataColumn(
                        //             label: Text(
                        //               "${e['age']}",
                        //               style: const TextStyle(
                        //                 color: Color(0xFF767676),
                        //               ),
                        //               textAlign: TextAlign.left,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //       rows: <DataRow>[
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['gender']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['entryMode']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['grade']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['designation']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['project']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['location']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['department']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['prev_Proj']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['domicile_State']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //         DataRow(
                        //           color:
                        //               MaterialStateProperty.resolveWith<Color?>(
                        //                   (Set<MaterialState> states) {
                        //             if (states
                        //                 .contains(MaterialState.selected)) {
                        //               return Theme.of(context)
                        //                   .colorScheme
                        //                   .primary
                        //                   .withOpacity(0.08);
                        //             }
                        //             return Colors
                        //                 .white; // Use the default value.
                        //           }),
                        //           cells: <DataCell>[
                        //             ...provider.empCompareSearchData.map(
                        //               (e) {
                        //                 return DataCell(
                        //                   Center(
                        //                     child: Text(
                        //                       "${e['totalExp']}",
                        //                       style: const TextStyle(
                        //                         color: Color(0xFF767676),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList()
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   );
                        // }),
                        SizedBox(
                          height: CommonAppTheme.lineheightSpace20,
                        ),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonAppTheme.borderRadious),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            onExpansionChanged: ((value) {
                              print(value);
                              setState(() {
                                isExpandedValue13 = value;
                              });
                            }),
                            trailing: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(CommonAppTheme.whiteColor),
                              ),
                              child: Icon(
                                isExpandedValue13
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 30,
                                color:
                                    Color(CommonAppTheme.appthemeColorForText),
                              ),
                            ),
                            backgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            collapsedBackgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            title: Text(
                              "Dates",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.whiteColor,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ...provider.empCompareSearchData
                                            .map((e) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${e['name']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          CommonAppTheme
                                                              .buttonCommonColor,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "DOB: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            "${e['dob']}",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "DOJ NTPC: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            "${e['doJ_NTPC']}",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "DOE Grade: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            "${e['doE_Grade']}",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "DOE Project :",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                CommonAppTheme
                                                                    .buttonCommonColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            "${e['doE_Project']}",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ))
                                            .toList(),
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
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonAppTheme.borderRadious),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            onExpansionChanged: ((value) {
                              print(value);
                              setState(() {
                                isExpandedValue10 = value;
                              });
                            }),
                            trailing: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(CommonAppTheme.whiteColor),
                              ),
                              child: Icon(
                                isExpandedValue10
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 30,
                                color:
                                    Color(CommonAppTheme.appthemeColorForText),
                              ),
                            ),
                            backgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            collapsedBackgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            title: Text(
                              "Location Experience",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.whiteColor,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ...provider.empCompareSearchData
                                            .map((e) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${e['name']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          CommonAppTheme
                                                              .buttonCommonColor,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${e['locationExp']}",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
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
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonAppTheme.borderRadious),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            onExpansionChanged: ((value) {
                              print(value);
                              setState(() {
                                isExpandedValue11 = value;
                              });
                            }),
                            trailing: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(CommonAppTheme.whiteColor),
                              ),
                              child: Icon(
                                isExpandedValue11
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 30,
                                color:
                                    Color(CommonAppTheme.appthemeColorForText),
                              ),
                            ),
                            backgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            collapsedBackgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            title: Text(
                              "Functional Experience",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.whiteColor,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ...provider.empCompareSearchData
                                            .map((e) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${e['name']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          CommonAppTheme
                                                              .buttonCommonColor,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${e['functionExp']}",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
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
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonAppTheme.borderRadious),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            onExpansionChanged: ((value) {
                              print(value);
                              setState(() {
                                isExpandedValue12 = value;
                              });
                            }),
                            trailing: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(CommonAppTheme.whiteColor),
                              ),
                              child: Icon(
                                isExpandedValue12
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 30,
                                color:
                                    Color(CommonAppTheme.appthemeColorForText),
                              ),
                            ),
                            backgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            collapsedBackgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            title: Text(
                              "Department Experience",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.whiteColor,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ...provider.empCompareSearchData
                                            .map((e) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${e['name']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          CommonAppTheme
                                                              .buttonCommonColor,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${e['departmentExp']}",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
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
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonAppTheme.borderRadious),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            onExpansionChanged: ((value) {
                              setState(
                                () {
                                  isExpandedValue13 = value;
                                },
                              );
                            }),
                            trailing: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(CommonAppTheme.whiteColor),
                              ),
                              child: Icon(
                                isExpandedValue13
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 30,
                                color:
                                    Color(CommonAppTheme.appthemeColorForText),
                              ),
                            ),
                            backgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            collapsedBackgroundColor:
                                Color(CommonAppTheme.buttonCommonColor),
                            title: Text(
                              "Work Area Experience",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.whiteColor,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ...provider.empCompareSearchData
                                            .map(
                                              (e) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${e['name']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(
                                                        CommonAppTheme
                                                            .buttonCommonColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${e['workareaExp']}",
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
