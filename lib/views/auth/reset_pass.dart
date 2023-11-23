import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/theme/common_them.dart';
import 'package:provider/provider.dart';

import '../../database/database_halper.dart';
import '../../theme/common_dialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  bool _password = true;
  bool _confirmPass = true;
  // TextEditingController empcode = TextEditingController(text: "20000000");
  // TextEditingControlz̄ler password = TextEditingController(text: "Ntpc#786@");

  TextEditingController empcode = TextEditingController();
  TextEditingController oldPass = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  String captcha = "";
  @override
  void initState() {
    super.initState();
    dataBaseHelper.initializeDatabase().then(
          (value) => {
            print("Data base initializeDatabase "),
          },
        );
    captcha = getRandomString(5);
  }

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonAppTheme.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CommonAppTheme.screenPadding),
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Change Password",
                style: CommonAppTheme.textstyleWithColorBlackF20,
              ),
              SizedBox(
                height: CommonAppTheme.lineheightSpace40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Employee Code",
                    //   style: CommonAppTheme.textstyleWithColorBlack,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.number,
                    //   controller: empcode,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Enter Employee Code',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please Enter Employee Code';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(
                    //   height: CommonAppTheme.lineheightSpace20,
                    // ),
                    Text(
                      "Old Password",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: oldPass,
                      decoration: const InputDecoration(
                        hintText: 'Enter Old Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Old Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Text(
                      "New Password",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      obscureText: _password,
                      keyboardType: TextInputType.visiblePassword,
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Enter new password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _password = !_password;
                            });
                          },
                          child: Icon(
                            _password ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Text(
                      "Confirm Password",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      obscureText: _confirmPass,
                      keyboardType: TextInputType.visiblePassword,
                      controller: cpassword,
                      decoration: InputDecoration(
                        hintText: 'Enter Confirm password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _confirmPass = !_confirmPass;
                            });
                          },
                          child: Icon(
                            _password ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 270,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(CommonAppTheme.buttonCommonColor)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, String> loginData = {
                                  'emp_code': empcode.text,
                                  'old_pass': oldPass.text,
                                  'password': password.text,
                                };

                                bool passmatch =
                                    RegExp(r'(?=.*[a-z])(?=.*[A-Z]).{8,20}')
                                        .hasMatch(password.text);
                                print(passmatch);
                                print(loginData);
                                if (passmatch) {
                                  if (password.text != cpassword.text) {
                                    CommanDialog.showErrorDialog(context,
                                        description:
                                            "Confirm password did not match");
                                    return;
                                  }
                                  provider.changePassword(context, loginData);
                                } else {
                                  CommanDialog.passRgxMsg(context,
                                      description:
                                          "Password length (8 - 20 letters),Require at least one digit,Require at least one upper case and one lower case letter");
                                }
                              }
                            },
                            child: Text(
                              'Submit',
                              style: CommonAppTheme.textstyleWithColorWhiteF16,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ) /* add child content here */,
      ),
    );
  }
}
