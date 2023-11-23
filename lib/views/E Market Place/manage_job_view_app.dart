import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/commonheader/common_header.dart';
import 'package:provider/provider.dart';

import '../../theme/common_them.dart';

class ManageJobViewApplicationScreen extends StatefulWidget {
  const ManageJobViewApplicationScreen({super.key});

  @override
  State<ManageJobViewApplicationScreen> createState() =>
      _ManageJobViewApplicationScreenState();
}

class _ManageJobViewApplicationScreenState
    extends State<ManageJobViewApplicationScreen> {
  bool isExpandedValue = false;

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    String dropdownvalue = 'Sort By';
    // List of items in our dropdown menu
    var items = [
      'Sort By',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
          "Vacancy Applicant List", context),
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
                          fontSize: 14,
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
                    Expanded(
                      child: SizedBox(),
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(
                          CommonAppTheme.appCommonGreenColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(CommonAppTheme.borderRadious),
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
                              "Mark Shortlist",
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(
                          CommonAppTheme.appCommonGreenColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(CommonAppTheme.borderRadious),
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
                  ],
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                Text(
                  "(Total - ${provider.eligibalEmpList.length} records found)",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: CommonAppTheme.lineheightSpace20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Switch(value: false, onChanged: (_) {}),
                          ],
                        ),
                        ExpansionTile(
                          title: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 0.0, right: 0.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/profile.png"),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name : Ashok Kumar Kundu",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Emp. No :  003827",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // const Text(
                                //   "C & I ERECT",
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Emp. No :  ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                      ),
                                    ),
                                    Text(
                                      " 003827 ",
                                      style: const TextStyle(
                                        fontSize: 12,
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
                                      "Grade Designation : ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(
                                            CommonAppTheme.buttonCommonColor),
                                      ),
                                    ),
                                    Text(
                                      " E6",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
                                      Row(
                                        children: [
                                          Text(
                                            "Age Balance Service :-",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                          Text(
                                            " KARANPURA",
                                            style: const TextStyle(
                                              fontSize: 12,
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
                                            "Age Balance Service :-",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                          Text(
                                            " North Karanpura",
                                            style: const TextStyle(
                                              fontSize: 12,
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
                                            "Department Projects :",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                          Text(
                                            " North Karanpura",
                                            style: const TextStyle(
                                              fontSize: 12,
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
                                            "DOEP DOEG :-",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(CommonAppTheme
                                                  .buttonCommonColor),
                                            ),
                                          ),
                                          Text(
                                            " NGSL",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Total Exp Functional Exp.  Location Exp.",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "26.54HR- 12.85; R & R- 0.93; CORPORATE COMMUNICATION- 1.73; HR-EDC- 5.63; PMI- 5.15;AURAIYA(Auraiya)- 5.51; PMI-NOIDA(CC - EOC)- 6.31; PAKRI(Pakri Barwadih)- 6.85; RIHAND(Rihand)- 3.15; NOIDA(CC - EOC)- 4.47;"
                                            .toString(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Area of Expertise Justification :",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.buttonCommonColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Working in HR deptt from last 22 years. Worked in almost all areas of HR deptt including5 years in green field project i.e. Khargone.Interested only for the position of HOHR."),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
