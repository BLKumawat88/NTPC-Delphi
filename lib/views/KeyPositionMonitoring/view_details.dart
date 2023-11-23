import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';
import '../commoncard/common_card.dart';
import '../commonheader/common_header.dart';
import 'package:flutter/material.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({super.key});

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  bool isExpandedValue = false;
  bool qualifyingIsExpandedValue = false;
  bool nonMeasurableisExpandedValue = false;

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
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(CommonAppTheme.borderRadious),
                      color: Color(CommonAppTheme.buttonCommonColor)),
                  child: Center(
                    child: Text(
                      "Position Details - ${provider.keyPositionDetailData['positionDetail'][0]['title']}-${provider.keyPositionDetailData['positionDetail'][0]['projectName']}-${provider.keyPositionDetailData['positionDetail'][0]['departmentName']}",
                      style: CommonAppTheme.textstyleWithColorWhite,
                      textAlign: TextAlign.center,
                    ),
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
                      "Description",
                      style: CommonAppTheme.textstyleWithColorWhite,
                    ),
                    children: [
                      Container(
                        color: Color(CommonAppTheme.whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              description("Name Of Position:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['title']}"),
                              description("Type:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['positionType']}"),
                              description("Region:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['regionName']}"),
                              description("Project Category:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['projectCategory']}"),
                              description("Project:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['projectName']}"),
                              description("Name Of Position:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['title']}"),
                              description("Sanctioned Strength:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['totalPosition']}"),
                              description("Job Description:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['descriptions']}"),
                              description("Roles & Responsibility:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['roles']}"),
                              description("Skill & Traits:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['skillSet']}"),
                              description("Department Group:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['subDepartmentName']}"),
                              description("Department Sub Group:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['subDepartmentName']}"),
                              description("Department:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['departmentName']}"),
                              description("Grade:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['gradeName']}"),
                              description("Level:",
                                  "${provider.keyPositionDetailData['positionDetail'][0]['levelName']}"),
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
                                        " Qualify Grade Code:   ",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['gradeAll']}",
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
                                        " Qualify Designation:   ",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['qualifyDesignation']}",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['qualificationAll']}",
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
                                        " Branches Code:   ",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['branchsAll']}",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['currentRoleType']}",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['ageMin']}-${provider.keyPositionDetailData['positionDetail'][0]['ageMax']}",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['noOfRegionMin']}",
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
                                        " Min No. of project exp.",
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
                                        "${provider.keyPositionDetailData['positionDetail'][0]['noOfProjectMin']}",
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
                                      " Level.",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.appthemeColorForText,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${provider.keyPositionDetailData['positionDetail'][0]['levelAll']}",
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
                                      " Branch.",
                                      style: TextStyle(
                                        color: Color(
                                          CommonAppTheme.appthemeColorForText,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${provider.keyPositionDetailData['positionDetail'][0]['branchsAll']}",
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
                                      " Project Category Experience",
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
                                                  "Project Category",
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
                                        ...provider
                                            .keyPositionDetailData['projectExp']
                                            .map(
                                          (e) => TableRow(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              children: [
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
                                                    "${e['totalExp']}",
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
                                      ...provider
                                          .keyPositionDetailData['roleExp']
                                          .map(
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
                                                "Exp.",
                                                style: TextStyle(
                                                  color: Color(CommonAppTheme
                                                      .whiteColor),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ]),
                                      ...provider.keyPositionDetailData[
                                              'departmentExp']
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
                        nonMeasurableisExpandedValue = value;
                      });
                    }),
                    trailing: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(CommonAppTheme.whiteColor),
                      ),
                      child: Icon(
                        nonMeasurableisExpandedValue
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
                      "Non-Measurable",
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
                                      "Compentency Requirement",
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
                                TextFormField(
                                  maxLines: 8,

                                  initialValue:
                                      "${provider.keyPositionDetailData['positionDetail'][0]['requirements']}", //or null
                                  decoration: const InputDecoration.collapsed(
                                      enabled: false,
                                      hintText: "  Requirement"),
                                ),
                                SizedBox(
                                  height: CommonAppTheme.lineheightSpace20,
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
                provider.keyPositionDetailData['employeeData'].isEmpty
                    ? SizedBox()
                    : Text(
                        "Employee Detail",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                ...provider.keyPositionDetailData['employeeData']
                    .map(
                      (e) => CommonCardScreen(e: e),
                    )
                    .toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
