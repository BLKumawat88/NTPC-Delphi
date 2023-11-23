import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';

class CommonAppTheme {
  static String backgroundImage = "assets/images/app_background.png";

  static double font22 = 22;

  static int buttonCommonColor = 0xFF0C6DAE;
  static int headerCommonColor = 0xFF20A8D8;
  static int buttonCommonColor2 = 0xFF194680;
  static int appthemeColorForText = 0xFF0C6DAE;
  static int appCommonGreenColor = 0xFF28A745;
  static int redColor = 0xFFDC3545;

  static double screenPadding = 10;

  static double lineheightSpace20 = 10;
  static double lineheightSpace40 = 40;
  static int whiteColor = 0xFFFFFFFF;

  static double borderRadious = 8;

  static TextStyle textstyleWithColorWhite = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textstyleWithColorWhiteF16 = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  static TextStyle textstyleWithColorBlackF18 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: AllInProvider.iPadSize ? 24 : 10,
  );

  static TextStyle textstyleWithColorBlackF20 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AllInProvider.iPadSize ? 24 : 20,
  );

  static TextStyle textstyleWithColorBlack = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AllInProvider.iPadSize ? 18 : 14,
  );
}
