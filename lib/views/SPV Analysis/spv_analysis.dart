import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/commonheader/common_header.dart';
import 'package:provider/provider.dart';
import '../../theme/common_them.dart';

class SPVAnalysisScreen extends StatefulWidget {
  const SPVAnalysisScreen({super.key});

  @override
  State<SPVAnalysisScreen> createState() => _SPVAnalysisScreenState();
}

class _SPVAnalysisScreenState extends State<SPVAnalysisScreen> {
  bool isExpandedValue = false;
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader("SPV Analysis", context),
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
                            Icon(
                              Icons.list,
                              color: Color(
                                CommonAppTheme.whiteColor,
                              ),
                            ),
                            Text(
                              " SPV Pos. Anal. Fix",
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
                    )
                  ],
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
                        "SPV Analysis List",
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
                ...provider.spvAnalysisData
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Name-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['title']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Type-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['positionType']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Project-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['project']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Department-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['departmentName']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Sanctioned-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['totalSanctioned']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Positioned-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['totalPositioned']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Vacant-",
                                        style: TextStyle(
                                          color: Color(
                                            CommonAppTheme.appthemeColorForText,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(
                                      " ${e['jobID']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
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
                    )
                    .toList(),
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
