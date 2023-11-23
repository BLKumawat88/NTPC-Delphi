import '../../theme/common_them.dart';
import '../commonheader/common_header.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _password = true;
  TextEditingController empcode = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonHeaderClass.commonAppBarHeader(
        "Change Password",
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Employee Code"),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: empcode,
                        decoration: const InputDecoration(
                          hintText: 'Enter Employee Code',
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
                      const Text("New Password"),
                      TextFormField(
                        obscureText: _password,
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        decoration: InputDecoration(
                          hintText: 'New password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _password = !_password;
                              });
                            },
                            child: Icon(
                              _password
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                      const Text("Confirm Password"),
                      TextFormField(
                        obscureText: _password,
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _password = !_password;
                              });
                            },
                            child: Icon(
                              _password
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                      SizedBox(
                        height: CommonAppTheme.lineheightSpace20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(CommonAppTheme.buttonCommonColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      )
                    ],
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
