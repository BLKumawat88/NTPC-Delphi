import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../theme/common_them.dart';
import '../../commonheader/common_header.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class SearchJobViewDetails extends StatefulWidget {
  const SearchJobViewDetails({super.key});

  @override
  State<SearchJobViewDetails> createState() => _SearchJobViewDetails();
}

class _SearchJobViewDetails extends State<SearchJobViewDetails> {
  // final _formKey = GlobalKey<FormState>();
  TextEditingController applyForTxt = TextEditingController();
  TextEditingController expertiseTxt = TextEditingController();
  TextEditingController justificationTxt = TextEditingController();
  TextEditingController docTitleTxt = TextEditingController();

  final double spaceHeightBitweenWidgets = 10;

  final double spaceHeightBitweenWidgetsHeiding = 5;
  final int textColor = 0xFFAFAFAF;
  String fileName = "";
  documentPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      print("Selected File name ${file.name}");

      print("File extension type ${file.extension}");

      print("Selected File Path ${file.path}");

      setState(
        () {
          fileName = file.name;
        },
      );
      refereshBottomSheet();
    } else {
      print("You did not select any PDF file or Image");
    }
  }

  refereshBottomSheet() {
    Navigator.pop(context);
    applyBottomSheet(context);
  }

  void applyBottomSheet(context) {
    AllInProvider provider = Provider.of(context, listen: false);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setState) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    // height: MediaQuery.of(context).size.height / 1.8,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(CommonAppTheme.screenPadding),
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
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            Container(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Apply for this Vacancy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(
                                      CommonAppTheme.buttonCommonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Job ID ${provider.jobDetailsData['jobID']} (Emp No. ${provider.empCode})",
                              ),
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            const Text("Apply For"),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF0F6FA),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  provider.jobDetailsData['title'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            const Text("Expertise"),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            TextFormField(
                              autofocus: false,
                              controller: expertiseTxt,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFF0F6FA),
                                hintText: 'Expertise',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            const Text("Justification"),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            TextFormField(
                              autofocus: false,
                              controller: justificationTxt,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFF0F6FA),
                                hintText: 'justification',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            InkWell(
                              onTap: () {
                                documentPicker();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF0F6FA),
                                ),
                                child: Icon(
                                  Icons.file_copy_sharp,
                                  size: 35,
                                  color:
                                      Color(CommonAppTheme.buttonCommonColor),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceHeightBitweenWidgets),
                            const Text("Attachment Title"),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            fileName != ""
                                ? Container(
                                    color: const Color(0xFFF0F6FA),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(fileName),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: CommonAppTheme.lineheightSpace20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(CommonAppTheme.redColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(" Close "),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(CommonAppTheme.buttonCommonColor),
                                  ),
                                  onPressed: () {
                                    print("onpressedCalled");
                                    Map<String, String> vacancyInfo = {
                                      'ApplicantID': '0',
                                      'JobID': provider.jobDetailsData['jobID']
                                          .toString(),
                                      'EmpID': provider.empCode.toString(),
                                      'Document_Title': applyForTxt.text,
                                      'Expertise': expertiseTxt.text,
                                      'Descriptions': justificationTxt.text,
                                      'DocumentPath': '.pdf',
                                      'fileBytes': ""
                                    };
                                    print("vacancyInfo $vacancyInfo");
                                    provider.applyForThisVacancy(
                                        context, vacancyInfo);
                                  },
                                  child: const Text(" Apply Now "),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
    );
  }

  TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget locationSection(title, value) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            "$title :",
            style: textStyle,
          ),
        ),
        Expanded(
          flex: 8,
          child: Text(value),
        )
      ],
    );
  }

  TextStyle headingStyle = TextStyle(
    color: Color(
      CommonAppTheme.buttonCommonColor,
    ),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget returnDevider() {
    return Container(
      width: double.infinity,
      color: Color(CommonAppTheme.buttonCommonColor),
      height: 1,
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
            child: ListView(children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CommonAppTheme.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: CommonAppTheme.lineheightSpace20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            (CommonAppTheme.screenPadding +
                                CommonAppTheme.screenPadding),
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(CommonAppTheme.buttonCommonColor2)),
                          onPressed: () {},
                          child: Text(
                            provider.jobDetailsData['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      Text("Justi : ", style: headingStyle),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 1000,
                              child: Html(
                                data: provider.jobDetailsData['descriptions'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Department : ",
                        style: headingStyle,
                      ),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection("Group",
                          provider.jobDetailsData['departmentGroupName']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection("Sub Group",
                          provider.jobDetailsData['subDepartmentName']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection("Department",
                          provider.jobDetailsData['departmentName']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      Text(
                        "Location  :",
                        style: headingStyle,
                      ),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Region", provider.jobDetailsData['regionName']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Project", provider.jobDetailsData['projectName']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Location", provider.jobDetailsData['locationName']),
                      SizedBox(
                        height: CommonAppTheme.lineheightSpace20,
                      ),
                      Text(
                        "Position  :",
                        style: headingStyle,
                      ),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Grade", provider.jobDetailsData['gradeAll']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Key position",
                          provider.jobDetailsData['grade'] == "True"
                              ? "Yes"
                              : "No"),
                      SizedBox(
                        height: CommonAppTheme.lineheightSpace20,
                      ),
                      Text(
                        "Details   :",
                        style: headingStyle,
                      ),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Role",
                          provider.jobDetailsData['keyRoleType'] == "0"
                              ? ""
                              : provider.jobDetailsData['keyRoleType']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection("Qualification",
                          provider.jobDetailsData['qualification']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Branch", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      Text(
                        "Qualifying Requirements   :",
                        style: headingStyle,
                      ),
                      SizedBox(height: spaceHeightBitweenWidgetsHeiding),
                      returnDevider(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Group", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Sub Group", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Dept", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Total Exp.", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Reg. Exp.", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      locationSection(
                          "Loc. Exp.", provider.jobDetailsData['branchs']),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      provider.jobDetailsData['isJobExpire'] == 0 &&
                              provider.applyDetailsData.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Application Details:",
                                  style: headingStyle,
                                ),
                                SizedBox(
                                    height: spaceHeightBitweenWidgetsHeiding),
                                returnDevider(),
                                SizedBox(height: spaceHeightBitweenWidgets),
                                locationSection(
                                    "Application ID ",
                                    provider.applyDetailsData[0]['applicantID']
                                        .toString()),
                                SizedBox(height: spaceHeightBitweenWidgets),
                                locationSection(
                                  "Descriptions ",
                                  provider.applyDetailsData[0]['descriptions']
                                      .toString(),
                                ),
                                SizedBox(height: spaceHeightBitweenWidgets),
                                locationSection(
                                  "Expertise ",
                                  provider.applyDetailsData[0]['expertise']
                                      .toString(),
                                ),
                                SizedBox(height: spaceHeightBitweenWidgets),
                                locationSection("Document ", "XYZabx.pdf"),
                                SizedBox(height: spaceHeightBitweenWidgets),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () {
                                      provider.withdrawApplication(context,
                                          provider.jobDetailsData['jobID']);
                                      print(provider.jobDetailsData);
                                    },
                                    child: const Text(
                                      'Withdraw application',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(height: spaceHeightBitweenWidgets),
                      provider.jobDetailsData['isEligible'] == 0 ||
                              provider.jobDetailsData['isApplied'] == 1
                          ? const SizedBox()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(CommonAppTheme
                                              .buttonCommonColor)),
                                      onPressed: () {
                                        applyBottomSheet(context);
                                      },
                                      child:
                                          const Text('Apply For This Vacancy'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: CommonAppTheme.lineheightSpace20,
                                ),
                              ],
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.jobDetailsData['isEligible'] == 0
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    '    You are not eligible for this job    ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : const SizedBox(),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: const Color(0xFFB9FFCD)),
                          //     onPressed: () {},
                          //     child: const Text(
                          //       '    You are eligible for this job    ',
                          //       style: TextStyle(color: Color(0xFF49935D)),
                          //     ),
                          //   ),
                        ],
                      ),
                      SizedBox(
                        height: CommonAppTheme.lineheightSpace20,
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
