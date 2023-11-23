import 'package:flutter/material.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/views/auth/login_screen.dart';
import 'package:provider/provider.dart';
import '../../bottombar/bottom_bar_screen.dart';
import '../../spalsh.dart';

class IsUserLoggedInOrNot extends StatefulWidget {
  const IsUserLoggedInOrNot({super.key});
  @override
  State<IsUserLoggedInOrNot> createState() => _IsUserLoggedInOrNotState();
}

class _IsUserLoggedInOrNotState extends State<IsUserLoggedInOrNot> {
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of<AllInProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.isUserLogedIn(),
      builder: (contect, authResult) {
        if (authResult.connectionState == ConnectionState.waiting) {
          return SpalshScreenMain();
        } else {
          print("Data $authResult");
          if (authResult.data == true) {
            return BottomBarScreen();
          }
          return const LoginScreen();
        }
      },
    );
  }
}
