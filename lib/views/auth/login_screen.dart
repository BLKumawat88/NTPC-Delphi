import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/theme/common_dialog.dart';
import 'package:ntpcsecond/theme/common_them.dart';
import 'package:provider/provider.dart';

import '../../database/database_halper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  bool _password = true;
  // TextEditingController empcode = TextEditingController(text: "20000000");
  // TextEditingControlz̄ler password = TextEditingController(text: "Ntpc#786@");

  TextEditingController empcode = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController captchText = TextEditingController();

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
                "Welcome to Your",
                style: CommonAppTheme.textstyleWithColorBlackF20,
              ),
              Text(
                "Login Account",
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
                    Text(
                      "Employee Code",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: empcode,
                      decoration: InputDecoration(
                        hintText: 'Enter Employee Code',
                        hintStyle: CommonAppTheme.textstyleWithColorBlack,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Employee Code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Text(
                      "Password",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      obscureText: _password,
                      keyboardType: TextInputType.visiblePassword,
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        hintStyle: CommonAppTheme.textstyleWithColorBlack,
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
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pushNamed(context, '/reset_pass');
                    //     },
                    //     child: Text(
                    //       "Forget password?",
                    //       textAlign: TextAlign.end,
                    //       style: TextStyle(
                    //         fontSize: AllInProvider.iPadSize ? 18 : 14,
                    //         color: Color(CommonAppTheme.buttonCommonColor),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://codingnepalweb.com/demos/custom-captcha-in-javascript/captcha-bg.png",
                                  width: 150,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      captcha = getRandomString(5);
                                    });
                                  },
                                  child: Icon(
                                    Icons.restart_alt,
                                    size: 30,
                                    color: Color(
                                      CommonAppTheme.buttonCommonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 30,
                              top: 10,
                              child: Text(
                                captcha,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(
                                    CommonAppTheme.buttonCommonColor,
                                  ),
                                  letterSpacing: 5,
                                ),
                              ),
                            ),

                            // Image.asset(
                            //   "assets/images/cp.png",
                            //   width: 150,
                            // ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace40,
                    ),
                    Text(
                      "Enter the text you see above",
                      style: CommonAppTheme.textstyleWithColorBlack,
                    ),
                    TextFormField(
                      controller: captchText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          // hintText: 'Please Re-enter new password',
                          ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter password';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(
                      height: CommonAppTheme.lineheightSpace40,
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
                                if (captcha != captchText.text) {
                                  CommanDialog.showErrorDialog(context,
                                      description: "Captcha did not match");
                                  return;
                                }
                                Map<String, String> loginData = {
                                  'emp_code': empcode.text,
                                  'password': password.text,
                                };
                                provider.login(context, loginData, false, 1);
                              }
                            },
                            child: Text(
                              'Sign in',
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
