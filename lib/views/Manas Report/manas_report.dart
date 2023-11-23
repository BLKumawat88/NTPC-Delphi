import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/allinprovider.dart';
import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';

class ManasReportScreen extends StatefulWidget {
  const ManasReportScreen({super.key});

  @override
  State<ManasReportScreen> createState() => _ManasReportScreenState();
}

class _ManasReportScreenState extends State<ManasReportScreen> {
  late ScrollController _controller;
  TextEditingController searchUserDataByNameId = TextEditingController();
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

  @override
  void initState() {
    AllInProvider provider = Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
    _controller = ScrollController()
      ..addListener(
        () {
          provider.isLoadMore = true;
          if (_controller.position.maxScrollExtent ==
              _controller.position.pixels) {
            provider.getManasReportData(
                context, provider.requiredDataForFilter, false);
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ManasReportHeader.commonAppBarHeader(
        "Manas Report",
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
                          "Employees List (Total - ${provider.totalRecordOfManasReport} employees found )",
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
                  Consumer<AllInProvider>(
                    builder: (context, value, child) => provider
                            .manasReportDataDummay.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.manasReportDataDummay.length,
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
                                                provider.manasReportDataDummay[
                                                    index]['empNo']);
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                "https://delphi.ntpc.co.in/${provider.manasReportDataDummay[index]['imgPath']}"),
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${provider.manasReportDataDummay[index]['name']}(${provider.manasReportDataDummay[index]['pernr']})",
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
                                              "${provider.manasReportDataDummay[index]['grade']} ${provider.manasReportDataDummay[index]['designation']}",
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
                                              " ${provider.manasReportDataDummay[index]['department']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${provider.manasReportDataDummay[index]['project'].toLowerCase() == provider.manasReportDataDummay[index]['location'].toLowerCase() ? provider.manasReportDataDummay[index]['project'] : '${provider.manasReportDataDummay[index]['project']} ${provider.manasReportDataDummay[index]['location']}'}",
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
                                                provider.manasReportDataDummay[
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
                                                provider.manasReportDataDummay[
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
                                                      value: provider.manasReportDataDummay[
                                                                      index][
                                                                  'isEligibleEmp'] ==
                                                              "False"
                                                          ? false
                                                          : true,
                                                      onChanged: (value) {
                                                        print(provider
                                                                .manasReportDataDummay[
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
                                                              provider.manasReportDataDummay[
                                                                          index]
                                                                      [
                                                                      'isEligibleEmp'] =
                                                                  "true";
                                                            });
                                                            if (compareList.contains(
                                                                provider.manasReportDataDummay[
                                                                        index][
                                                                    'empNo'])) {
                                                              compareList.removeWhere((element) =>
                                                                  element ==
                                                                  provider.manasReportDataDummay[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            } else {
                                                              compareList.add(
                                                                  provider.manasReportDataDummay[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                              print(
                                                                  compareList);
                                                            }
                                                          }
                                                        } else {
                                                          setState(() {
                                                            provider.manasReportDataDummay[
                                                                        index][
                                                                    'isEligibleEmp'] =
                                                                "False";
                                                            if (compareList.contains(
                                                                provider.manasReportDataDummay[
                                                                        index][
                                                                    'empNo'])) {
                                                              compareList.removeWhere((element) =>
                                                                  element ==
                                                                  provider.manasReportDataDummay[
                                                                          index]
                                                                      [
                                                                      'empNo']);
                                                            } else {
                                                              compareList.add(
                                                                  provider.manasReportDataDummay[
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
                                                    " ${provider.manasReportDataDummay[index]['entrymode']}"),
                                                employeeDetail(
                                                    'Domicile State:',
                                                    " ${provider.manasReportDataDummay[index]['domicile_State']}"),
                                                employeeDetail(
                                                    "D.O.E. Project:",
                                                    " ${provider.manasReportDataDummay[index]['doE_Project']}"),
                                                employeeDetail("D.O.E. Grade:",
                                                    " ${provider.manasReportDataDummay[index]['doE_Grade']}"),
                                                employeeDetail("D.O.B.:",
                                                    " ${provider.manasReportDataDummay[index]['dob']} (${provider.manasReportDataDummay[index]['age']})"),
                                                employeeDetail("Prev. Proj.:",
                                                    " ${provider.manasReportDataDummay[index]['prev_Proj']}"),
                                                employeeDetail(
                                                  "Spouse in NTPC:",
                                                  provider.manasReportDataDummay[
                                                                  index]
                                                              ['spouseID'] ==
                                                          ""
                                                      ? " NO"
                                                      : " Yes",
                                                ),
                                                employeeDetail("Total Exp:",
                                                    " ${provider.manasReportDataDummay[index]['totalExp']}"),
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
                                                        "${provider.manasReportDataDummay[index]['locationExp']}",
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
                                                        "${provider.manasReportDataDummay[index]['department_Exp']}",
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
                                                    Text("Req. Type: ",
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
                                                        "${provider.manasReportDataDummay[index]['requestType']}",
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
                                                    Text("Ground Type: ",
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
                                                        "${provider.manasReportDataDummay[index]['groundType']}",
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
                                                    Text("Request: ",
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
                                                        "${provider.manasReportDataDummay[index]['request_text']}",
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
                                                    Text("Choices: ",
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
                                                        "${provider.manasReportDataDummay[index]['choice1']},${provider.manasReportDataDummay[index]['choice2']},${provider.manasReportDataDummay[index]['choice3']},${provider.manasReportDataDummay[index]['choice4']},${provider.manasReportDataDummay[index]['choice5']}",
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
                                                    Text("Comment: ",
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
                                                        "${provider.manasReportDataDummay[index]['comment_text']}",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Transfer Status: ",
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
                                                        "${provider.manasReportDataDummay[index]['transfer_Status']}",
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
