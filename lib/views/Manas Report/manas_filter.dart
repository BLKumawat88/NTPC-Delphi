import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:provider/provider.dart';

import '../../controllers/allinprovider.dart';
import '../../theme/common_dialog.dart';
import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';

class ManasFilterScreen extends StatefulWidget {
  const ManasFilterScreen({super.key});

  @override
  State<ManasFilterScreen> createState() => _ManasFilterScreenState();
}

class _ManasFilterScreenState extends State<ManasFilterScreen> {
  TextEditingController applicationID = TextEditingController();
  TextEditingController empNum = TextEditingController();
  TextEditingController requestStatus = TextEditingController();

  final items1 = ["All", 'Yes', 'No'];
  String selectedValue1 = '';
  String currentPID = "";
  String proposedProjectValue = "";
  String selectedValue2 = '';

  clearAllFilter() {
    setState(() {
      selectedValue1 = '';
      currentPID = "";
      proposedProjectValue = "";
      selectedValue2 = "";
      applicationID.text = "";
      empNum.text = "";
      requestStatus.text = "";
    });

    Navigator.pop(context);
    Navigator.pushNamed(context, "/manas_filter");
  }

  final items2 = [
    "All Status",
    'Not Updated',
    'Proposed',
    'Not Proposed',
    "Others"
  ];

  int dobMin = 1;
  int dobMax = 2;
  Widget returnDateUi(
    AllInProvider provider,
    text,
    Function datePickerMethodName,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            GestureDetector(
              onTap: () {
                datePickerMethodName();
              },
              child: const Icon(
                Icons.calendar_month,
              ),
            )
          ],
        ),
      ),
    );
  }

  dobFrom() {
    selectDate(
      context,
      dobMin,
      DateTime.now(),
      DateTime(1900),
      DateTime.now(),
    );
  }

  dobTo() {
    AllInProvider provider = Provider.of(context, listen: false);
    if (provider.reqDateFrom == "R Date From") {
      CommanDialog.showErrorDialog(context,
          description: "Please select Request date from");
    } else {
      List dummy = provider.dobmin.split("-");
      selectDate(
        context,
        dobMax,
        DateTime.now(),
        DateTime(int.parse(dummy[2]), int.parse(dummy[1]), int.parse(dummy[0])),
        DateTime.now(),
      );
    }
  }

  selectDate(context, type, DateTime currentDate, firstDate, lastDate) async {
    // DateTime currentDate = DateTime.now();
    // DateTime firstDate = DateTime(2023, 03, 03);
    // DateTime lastDate = DateTime.now();
    AllInProvider provider = Provider.of(context, listen: false);

    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (userSelectedDate == null) {
      return;
    } else {
      setState(
        () {
          currentDate = userSelectedDate;
          if (type == dobMin) {
            provider.reqDateFrom =
                '${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}-${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}-${currentDate.year}';
          } else if (type == dobMax) {
            provider.reqDateTo =
                '${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}-${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}-${currentDate.year}';
          } else {
            print("Route did not match");
          }
        },
      );
    }
  }

  appleManasFilter(context, AllInProvider provider) {
    provider.masterCurrentProjectProjectIds.clear();
    for (int i = 0;
        i < provider.masterCurrentProjectProjectValues.length;
        i++) {
      provider.masterCurrentProjectProjectIds
          .add(provider.masterCurrentProjectProjectValues[i]['pid']);
    }

    provider.requiredDataForFilter['SearchApplicationID'] = applicationID.text;
    provider.requiredDataForFilter['SearchEmpNo'] = empNum.text;
    provider.requiredDataForFilter['SearchRequestType'] = provider.ridValue;
    provider.requiredDataForFilter['SearchGroundType'] = provider.typeListID;
    provider.requiredDataForFilter['SearchRequestStatus'] = requestStatus.text;
    provider.requiredDataForFilter['SearchRequestDateF'] = '';
    provider.requiredDataForFilter['SearchRequestDateT'] = '';
    provider.requiredDataForFilter['ProjectChoices'] =
        provider.masterCurrentProjectProjectIds.join(',');
    provider.requiredDataForFilter['SearchProjectC'] = currentPID;
    provider.requiredDataForFilter['SearchProjectP'] = proposedProjectValue;
    provider.requiredDataForFilter['SearchSpouseData'] = '';
    provider.isLoadMore = false;
    provider.pageSizeManasReport = 20;
    provider.currentPageManasReport = 1;
    provider.getManasReportData(context, provider.requiredDataForFilter, false);
  }

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
        "Available Filters",
        context,
      ),
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
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: SizedBox(
                          // height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: applicationID,
                            style: TextStyle(
                                color: Color(CommonAppTheme.buttonCommonColor)),
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF0F6FA),
                              // labelText: "ddd",
                              hintText: 'Application ID',
                              hintStyle: TextStyle(
                                color: Color(
                                  CommonAppTheme.buttonCommonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: SizedBox(
                          // height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: empNum,
                            style: TextStyle(
                                color: Color(CommonAppTheme.buttonCommonColor)),
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF0F6FA),
                              // labelText: "ddd",
                              hintText: 'Employee Num',
                              hintStyle: TextStyle(
                                color: Color(
                                  CommonAppTheme.buttonCommonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: SizedBox(
                          // height: 50,
                          child: TextField(
                            autofocus: false,
                            controller: requestStatus,
                            style: TextStyle(
                                color: Color(CommonAppTheme.buttonCommonColor)),
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: const Color(0xFFF0F6FA),
                              // labelText: "ddd",
                              hintText: 'Request Status',
                              hintStyle: TextStyle(
                                color: Color(
                                  CommonAppTheme.buttonCommonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: provider.ridValue,
                            onChanged: (value) {
                              setState(
                                () {
                                  provider.ridValue = value.toString();
                                },
                              );
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: '',
                                child: Text(
                                  "Request type list",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                              ),
                              ...provider.manasRequestTypeF
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                            value: value['id'].toString(),
                                            child: Text(
                                              value['text_Val'],
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: provider.typeListID,
                            onChanged: (value) {
                              setState(
                                () {
                                  provider.typeListID = value.toString();
                                },
                              );
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: '',
                                child: Text(
                                  "Ground type list",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                              ),
                              ...provider.manasGroundTypeF
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                            value: value['id'].toString(),
                                            child: Text(
                                              value['text_Val'],
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    returnDateUi(
                      provider,
                      provider.reqDateFrom,
                      dobFrom,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    returnDateUi(
                      provider,
                      provider.reqDateTo,
                      dobTo,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            value: selectedValue2,
                            onChanged: (value) {
                              setState(
                                () {
                                  selectedValue2 = value.toString();
                                },
                              );
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: '',
                                child: Text(
                                  "Proposed Status",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                              ),
                              ...items2
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),

                            underline: const SizedBox(),
                          ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  "Spouse in NTPC",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),

                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            value: currentPID.toString(),
                            onChanged: (value) {
                              setState(
                                () {
                                  currentPID = value.toString();
                                },
                              );
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: "",
                                child: Text(
                                  "Current Project",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                              ),
                              ...provider.projectF
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                            value: value['pid'].toString(),
                                            child: Text(
                                              value['pCategory'].toString(),
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),

                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            value: proposedProjectValue.toString(),
                            onChanged: (value) {
                              setState(
                                () {
                                  proposedProjectValue = value.toString();
                                },
                              );
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: "",
                                child: Text(
                                  "Proposed Project",
                                  style: TextStyle(
                                    color:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                ),
                              ),
                              ...provider.projectF
                                  .map<DropdownMenuItem<String>>(
                                      (value) => DropdownMenuItem<String>(
                                            value: value['pid'].toString(),
                                            child: Text(
                                              value['pCategory'].toString(),
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
                              color: Color(CommonAppTheme.buttonCommonColor),
                            ),

                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MultiSelectDialogField(
                        dialogHeight: 250,
                        searchable: true,
                        initialValue:
                            provider.masterCurrentProjectProjectValues,
                        items: provider.masterCurrentProjectProjectFilterData,
                        title: const Text(
                          "Choices",
                          style: TextStyle(color: Colors.black),
                        ),
                        selectedColor: Colors.black,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF0F6FA),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonIcon: Icon(Icons.arrow_drop_down,
                            color: Color(CommonAppTheme.buttonCommonColor)),
                        buttonText: Text(
                          "Choices",
                          style: TextStyle(
                            color: Color(CommonAppTheme.buttonCommonColor),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          setState(() {
                            provider.masterCurrentProjectProjectValues.clear();
                            provider.masterCurrentProjectProjectValues
                                .addAll(results);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  provider.ridValue = "";
                  provider.typeListID = "";
                  provider.masterCurrentProjectProjectValues.clear();
                  provider.reqDateFrom = "R Date From";
                  provider.reqDateTo = "R Date To";
                  clearAllFilter();
                },
                child: const Text(
                  "Clear All",
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  appleManasFilter(
                    context,
                    provider,
                  );
                },
                child: const Text(
                  "Search",
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
