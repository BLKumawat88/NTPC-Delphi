import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:provider/provider.dart';

class CommanDialog {
  static showLoading(context, {String title = 'Loading...'}) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.black,
          ),
        );
      },
    );
  }

  static showLoadingForFilter(context, {String title = 'Please wait...'}) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/loadinggif.gif',
              width: 80,
            ),
          ),
        );
      },
    );
  }

  static refereshScreen(context, {String title = 'Loading...'}) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child:
              CircularProgressIndicator.adaptive(backgroundColor: Colors.black),
        );
      },
    );
  }

  static hideLoading(context) {
    Navigator.pop(context);
  }

  static showErrorDialog(
    context, {
    String title = "Oops Error",
    String description = "Something went wrong ",
  }) async {
    if (description == "Unauthorized") {
      final _storage = const FlutterSecureStorage();
      final readDta = await _storage.read(key: 'ntpctwo_isuser_login');

      String empCode;
      dynamic password;
      if (readDta != null) {
        print("In Red dat $readDta");
        final userInfo = json.decode(readDta);
        empCode = userInfo['user_name'];
        password = userInfo['user_password'];
        AllInProvider provider = Provider.of(context, listen: false);
        Map requiredUserInfo = {"emp_code": empCode, "password": password};
        print(requiredUserInfo);
        await _storage.delete(key: 'ntpctwo_isuser_login');
        provider.login(context, requiredUserInfo, true, 0);
      } else {}
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: 100,
              child: Column(children: [
                Text(description),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ]),
            ),
          );
        },
      );
    }
  }

  static passRgxMsg(
    context, {
    String title = "Oops Error",
    String description = "Something went wrong ",
  }) async {
    if (description == "Unauthorized") {
      print("QQQQQQQQ");
      final _storage = const FlutterSecureStorage();
      final readDta = await _storage.read(key: 'ntpctwo_isuser_login');

      int empCode;
      dynamic password;
      if (readDta != null) {
        print("In Red dat $readDta");
        final userInfo = json.decode(readDta);
        empCode = userInfo['empCode'];
        password = userInfo['user_password'];
        AllInProvider provider = Provider.of(context, listen: false);
        Map requiredUserInfo = {"emp_code": empCode, "password": password};
        print(requiredUserInfo);
        provider.login(context, requiredUserInfo, true, 0);
        await _storage.delete(key: 'ntpctwo_isuser_login');
      } else {}
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: 150,
              child: Column(children: [
                Text(description),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ]),
            ),
          );
        },
      );
    }
  }
}
