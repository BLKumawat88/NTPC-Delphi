import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';
import 'package:flutter/material.dart';

class ViewDetailsMjScreen extends StatefulWidget {
  const ViewDetailsMjScreen({super.key});

  @override
  State<ViewDetailsMjScreen> createState() => _ViewDetailsMjScreenState();
}

class _ViewDetailsMjScreenState extends State<ViewDetailsMjScreen> {
  bool isExpandedValue = false;
  bool qualifyingIsExpandedValue = false;
  bool nonMeasurableisExpandedValue = false;
  TextStyle styleText = TextStyle(
    color: Color(CommonAppTheme.whiteColor),
    fontWeight: FontWeight.bold,
  );

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
      ],
    );
  }

  Widget description(title, value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader("View Details", context),
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(CommonAppTheme.borderRadious),
                      color: Color(CommonAppTheme.headerCommonColor)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider.mJobDetailData['jobDetails'][0]['title']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      provider.mJobDetailData['jobDetails'][0]['projectName'] !=
                              ""
                          ? Text(
                              "( ${provider.mJobDetailData['jobDetails'][0]['projectName']} ) ",
                              style: styleText,
                            )
                          : provider.mJobDetailData['jobDetails'][0]
                                          ['projectName'] ==
                                      "" &&
                                  provider.mJobDetailData['jobDetails'][0]
                                          ['regionName'] !=
                                      ""
                              ? Text(
                                  "( ${provider.mJobDetailData['jobDetails'][0]['regionName']} )",
                                  style: styleText,
                                )
                              : provider.mJobDetailData['jobDetails'][0]
                                              ['projectName'] ==
                                          "" &&
                                      provider.mJobDetailData['jobDetails'][0]
                                              ['regionName'] ==
                                          "" &&
                                      provider.mJobDetailData['jobDetails'][0]
                                              ['locationName'] !=
                                          ""
                                  ? Text(
                                      "( ${provider.mJobDetailData['jobDetails'][0]['locationName']} )",
                                      style: styleText,
                                    )
                                  : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      (provider.mJobDetailData['jobDetails'][0]['departmentName'] != "" &&
                              provider.mJobDetailData['jobDetails'][0]['subDepartmentName'] !=
                                  "" &&
                              provider.mJobDetailData['jobDetails'][0]
                                      ['departmentGroupName'] !=
                                  "")
                          ? Text(
                              "( ${provider.mJobDetailData['jobDetails'][0]['departmentName']} )",
                              style: styleText,
                            )
                          : (provider.mJobDetailData['jobDetails'][0]
                                          ['departmentName'] ==
                                      "" &&
                                  provider.mJobDetailData['jobDetails'][0]
                                          ['subDepartmentName'] !=
                                      "" &&
                                  provider.mJobDetailData['jobDetails'][0]
                                          ['departmentGroupName'] !=
                                      "")
                              ? Text(
                                  "-${provider.mJobDetailData['jobDetails'][0]['departmentGroupName']} )",
                                  style: styleText,
                                )
                              : (provider.mJobDetailData['jobDetails'][0]
                                              ['departmentName'] ==
                                          "" &&
                                      provider.mJobDetailData['jobDetails'][0]
                                              ['subDepartmentName'] ==
                                          "" &&
                                      provider.mJobDetailData['jobDetails'][0]
                                              ['departmentGroupName'] !=
                                          "")
                                  ? Text(
                                      "-${provider.mJobDetailData['jobDetails'][0]['departmentGroupName']} )",
                                      style: styleText,
                                    )
                                  : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
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
                      "Basic Information",
                      style: TextStyle(
                        color: Color(
                          CommonAppTheme.whiteColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Container(
                        color: Color(CommonAppTheme.whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              description("Req. No. : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['jobID']}"),
                              description("Posted By : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['postedBy']}"),
                              description("Posted Date : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['postedDate']}"),
                              description("No. Of Vacancies : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['vacancies']}"),
                              description("Start Date : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['startDate']}"),
                              description("End Date : ",
                                  "${provider.mJobDetailData['jobDetails'][0]['endDate']}"),
                              provider.isOfflineData
                                  ? SizedBox()
                                  : description("Doc. Title : ",
                                      "${provider.mJobDetailData['jobDetails'][0]['document_Title']}"),
                              provider.isOfflineData
                                  ? SizedBox()
                                  : description("Doc. Path : ",
                                      "${provider.mJobDetailData['jobDetails'][0]['documentPath']}"),
                              Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 4,
                                  //       child: Text("Key Position : ",
                                  //           style: TextStyle(
                                  //             color: Color(
                                  //               CommonAppTheme
                                  //                   .appthemeColorForText,
                                  //             ),
                                  //             fontWeight: FontWeight.bold,
                                  //           )),
                                  //     ),
                                  //     if (provider.mJobDetailData['jobDetails']
                                  //         [0]['isKeyPosition'])
                                  //       const Expanded(
                                  //         flex: 5,
                                  //         child: Text(
                                  //           " Yes",
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     if (!provider.mJobDetailData['jobDetails']
                                  //         [0]['isKeyPosition'])
                                  //       const Expanded(
                                  //         flex: 5,
                                  //         child: Text(
                                  //           " No",
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
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
                        qualifyingIsExpandedValue = value;
                      });
                    }),
                    trailing: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(CommonAppTheme.whiteColor),
                      ),
                      child: Icon(
                        qualifyingIsExpandedValue
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
                      "Qualifying Criteria",
                      style: TextStyle(
                        color: Color(
                          CommonAppTheme.whiteColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Container(
                        color: Color(CommonAppTheme.whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        CommonAppTheme.borderRadious,
                                      ),
                                      topRight: Radius.circular(
                                        CommonAppTheme.borderRadious,
                                      ),
                                    ),
                                    color: Color(0XFF194680),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Measurable",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        " Grade:   ",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['gradeAll']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                      flex: 4,
                                      child: Text(
                                        " Qualification:   ",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['qualificationAll']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                      flex: 4,
                                      child: Text(
                                        " Current Role:   ",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['keyRoleType']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                      flex: 4,
                                      child: Text(
                                        " Age:   ",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['ageMin']}-${provider.mJobDetailData['jobDetails'][0]['ageMax']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                      flex: 4,
                                      child: Text(
                                        " Total exp.",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['funExpMin']}-${provider.mJobDetailData['jobDetails'][0]['funExpMax']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                      flex: 4,
                                      child: Text(
                                        " Min No. of region exp.",
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
                                        "${provider.mJobDetailData['jobDetails'][0]['funExpMin']}-${provider.mJobDetailData['jobDetails'][0]['funExpMax']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
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
                                    Text(
                                      " Branch.:",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.appthemeColorForText,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${provider.mJobDetailData['jobDetails'][0]['branchsAll']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Region/Project Experience",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<AllInProvider>(
                                    builder: (context, person, _) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0)),
                                    child: Table(
                                      border: TableBorder.all(
                                        width: 1,
                                        color: Colors.black45,
                                      ), //table border
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                                color: Color(0xFF78C9FF)),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Region",
                                                  style: TextStyle(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Project",
                                                  style: TextStyle(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Type",
                                                  style: TextStyle(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Experience",
                                                  style: TextStyle(
                                                    color: Color(CommonAppTheme
                                                        .whiteColor),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ]),
                                        ...provider.mJobDetailData['projectExp']
                                            .map(
                                          (e) => TableRow(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${e['regionName']}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${e['projectName']}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${e['experienceTypeVar']}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${e['totalExpMin']} - ${e['totalExpMax']} Years",
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ]),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Role Wise Experience",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Table(
                                    border: TableBorder.all(
                                      width: 1,
                                      color: Colors.black45,
                                    ), //table border
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF78C9FF)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Role",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Experience",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ]),
                                      ...provider.mJobDetailData['roleExp'].map(
                                        (e) => TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['roleName']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['totalExpMin']} - ${e['totalExpMax']} Years",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Entry Mode",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Table(
                                    border: TableBorder.all(
                                      width: 1,
                                      color: Colors.black45,
                                    ), //table border
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF78C9FF)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Entry Mode",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Experience",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ]),
                                      ...provider.mJobDetailData['entryModeExp']
                                          .map(
                                        (e) => TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['entryMode']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['experienceTypeVar']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Grade Wise Experience",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Table(
                                    border: TableBorder.all(
                                      width: 1,
                                      color: Colors.black45,
                                    ), //table border
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF78C9FF)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Grade",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Substantive Grade",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Experience",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ]),
                                      ...provider.mJobDetailData['gradeExp']
                                          .map(
                                        (e) => TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['gradeName']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['substantiveGrade']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['totalExpMin']} - ${e['totalExpMax']} Years",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Current Department",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   width: MediaQuery.of(context).size.width,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(0)),
                                //   child: Table(
                                //     border: TableBorder.all(
                                //       width: 1,
                                //       color: Colors.black45,
                                //     ), //table border
                                //     children: [
                                //       TableRow(
                                //           decoration: BoxDecoration(
                                //               color: Color(0xFF78C9FF)),
                                //           children: [
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "Dept. Group",
                                //                 style: TextStyle(
                                //                   color: Color(CommonAppTheme
                                //                       .whiteColor),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "Dept. S. G.",
                                //                 style: TextStyle(
                                //                   color: Color(CommonAppTheme
                                //                       .whiteColor),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "Exp.",
                                //                 style: TextStyle(
                                //                   color: Color(CommonAppTheme
                                //                       .whiteColor),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //           ]),
                                //       TableRow(
                                //           decoration: BoxDecoration(
                                //               color: Colors.white),
                                //           children: [
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "${provider.mJobDetailData['jobDetails'][0]['dept_Group']}",
                                //                 style: const TextStyle(
                                //                   color: Color(0xFF767676),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "${provider.mJobDetailData['jobDetails'][0]['dept_SUbGroup']}",
                                //                 style: const TextStyle(
                                //                   color: Color(0xFF767676),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.all(8.0),
                                //               child: Text(
                                //                 "${provider.mJobDetailData['jobDetails'][0]['department']}",
                                //                 style: const TextStyle(
                                //                   color: Color(0xFF767676),
                                //                 ),
                                //                 textAlign: TextAlign.left,
                                //               ),
                                //             ),
                                //           ]),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                  child: const Center(
                                    child: Text(
                                      "Department Experience",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Table(
                                    border: TableBorder.all(
                                      width: 1,
                                      color: Colors.black45,
                                    ), //table border
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF78C9FF)),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Dept.G.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Dept.S.G.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Dept.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Type.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Exp.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ]),
                                      ...provider
                                          .mJobDetailData['departmentExp']
                                          .map(
                                        (e) => TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['deptGroupName']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['deptSubGroupName']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['deptName']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['experienceTypeVar']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${e['totalExpMin']} - ${e['totalExpMax']}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
