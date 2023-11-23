import 'package:flutter/material.dart';
import 'package:ntpcsecond/theme/common_dialog.dart';
import 'package:ntpcsecond/theme/common_them.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../controllers/allinprovider.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   AllInProvider provider = Provider.of(context, listen: false);
    //   print("Build Completed");
    //   provider.getAvailableFilter(context);
    // });
  }

  String otp = "112233";
  String enteredOtp = "";
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
                "Verify User",
                style: CommonAppTheme.textstyleWithColorBlackF20,
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter OTP",
                    style: CommonAppTheme.textstyleWithColorBlack,
                  ),
                ],
              ),
              SizedBox(
                height: CommonAppTheme.lineheightSpace20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                child: PinCodeTextField(
                  appContext: context,

                  length: 6,
                  // obscureText: true,
                  // obscuringCharacter: '*',

                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 45,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    activeColor: Colors.white,
                    selectedColor: Colors.white,
                    selectedFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,

                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    enteredOtp = value;
                    debugPrint(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              SizedBox(
                height: CommonAppTheme.lineheightSpace20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "OTP valid for :7 Minutes ,47 Seconds",
                    style: CommonAppTheme.textstyleWithColorBlack,
                  ),
                ],
              ),
              SizedBox(
                height: CommonAppTheme.lineheightSpace20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(CommonAppTheme.buttonCommonColor)),
                      onPressed: () {
                        if (enteredOtp == provider.empOtp) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/bottom_bar', (Route<dynamic> route) => false);
                          // Navigator.pushNamed(context, '/home_screen');
                        } else {
                          CommanDialog.showErrorDialog(context,
                              description: "OTP did not match");
                          print("OTP did not match");
                        }
                      },
                      child: const Text('Verify'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: CommonAppTheme.lineheightSpace20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn’t receive code?"),
                  InkWell(
                    onTap: () {
                      provider.resendOtp(context);
                    },
                    child: Text(
                      " Resend OTP",
                      style: TextStyle(
                          color: Color(CommonAppTheme.buttonCommonColor)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ) /* add child content here */,
      ),
    );
  }
}
