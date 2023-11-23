import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/allinprovider.dart';
import '../../theme/common_them.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Widget heading(headingTitle) {
    return Text(
      headingTitle,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget subHeading(headingTitle) {
    return Text(
      headingTitle,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget returnIcon(iconName, title) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(
              CommonAppTheme.buttonCommonColor,
            ),
            borderRadius: BorderRadius.circular(CommonAppTheme.borderRadious),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(
                  iconName,
                  size: 15,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: widgetGap,
        ),
        subHeading(title),
      ],
    );
  }

  final double widgetGap = 15;

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Help",
          style: TextStyle(color: Colors.black),
        ),
        leading: provider.isBack
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              )
            : const SizedBox(),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // heading("Key Position Monitoring"),
                // SizedBox(
                //   height: widgetGap,
                // ),
                Row(
                  children: [
                    returnIcon(
                        Icons.file_download_outlined, "Download Excel File"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    returnIcon(Icons.filter_list_outlined, "Filter"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/viewemp.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    subHeading("View Eligible Employees"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/key.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    subHeading("Key Position"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/men.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    subHeading("Retire In One Year"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/group1.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    subHeading("Long Leave"),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/tenplus.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    subHeading("Ten Plus Years In Project"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: widgetGap,
            ),
            // Column(
            //   children: [
            //     heading("E-Market Palce"),
            //   ],
            // ),
            // SizedBox(
            //   height: widgetGap,
            // ),
            // Column(
            //   children: [
            //     heading("Open Search"),
            //   ],
            // ),
            // SizedBox(
            //   height: widgetGap,
            // ),
            // Column(
            //   children: [
            //     heading("Succession Planning"),
            //   ],
            // ),
            // SizedBox(
            //   height: widgetGap,
            // ),
            // Column(
            //   children: [
            //     heading("Job Rotaion"),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
