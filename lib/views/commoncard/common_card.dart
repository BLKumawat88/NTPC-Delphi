import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/allinprovider.dart';
import '../../theme/common_them.dart';

class CommonCardScreen extends StatelessWidget {
  final dynamic e;

  const CommonCardScreen({
    super.key,
    required this.e,
  });
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
                  color: Color(0xFF2E2E2E),
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
    return Padding(
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
                contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                leading: InkWell(
                  onTap: () {
                    provider.viewProfile(context, e['empNo']);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://delphi.ntpc.co.in/${e['imgPath']}"),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${e['name']}(${e['empID']})",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(CommonAppTheme.buttonCommonColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${e['grade']} ${e['designation']}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF818181),
                      ),
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
                            color: Color(0xFF818181),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "${e['project'].toLowerCase() == e['location'].toLowerCase() ? e['project'] : '${e['project']} ${e['location']}'}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF818181),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        e['keyPosition'] == ""
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "assets/images/key.png",
                                  width: 30,
                                ),
                              ),
                        e['alertMsg'] == ""
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "assets/images/men.png",
                                  width: 30,
                                ),
                              ),
                        e['totalYearProject'] >= 10
                            ? Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "assets/images/tenplus.png",
                                  width: 30,
                                ),
                              )
                            : const SizedBox(),
                        Image.asset(
                          "assets/images/group1.png",
                          width: 30,
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
                        employeeDetail('Hiring Mode:', " ${e['entryMode']}"),
                        employeeDetail(
                            'Domicile State:', " ${e['domicile_State']}"),
                        employeeDetail(
                            "D.O.E. Project:", " ${e['doE_Project']}"),
                        employeeDetail("D.O.E. Grade:", " ${e['doE_Grade']}"),
                        employeeDetail("D.O.B.:", " ${e['dob']} (${e['age']})"),
                        employeeDetail("Prev. Proj.:", " ${e['prev_Proj']}"),
                        employeeDetail(
                          "Spouse in NTPC:",
                          e['spouseID'] == "" ? " NO" : " Yes",
                        ),
                        employeeDetail("Total Exp:", " ${e['totalExp']}"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loc.Exp:   ",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.appthemeColorForText,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "${e['location_Exp']}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Dept.Exp :",
                              style: TextStyle(
                                color: Color(
                                  CommonAppTheme.appthemeColorForText,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "${e['department_Exp']}",
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
    );
  }
}
