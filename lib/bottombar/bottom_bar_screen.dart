import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntpcsecond/controllers/allinprovider.dart';
import 'package:ntpcsecond/theme/common_them.dart';
import 'package:ntpcsecond/views/help/help_screen.dart';
import 'package:provider/provider.dart';

import '../views/E Market Place/e_market_place_home.dart';
import '../views/Home/home_screen.dart';
import '../views/profile/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AllInProvider provider = Provider.of(context, listen: false);
      provider.getHomeScreenModuleBasedOnUserRole(context);
    });
  }

  int currentTeb = 0;
  final List<Widget> screens = [
    HomeScreen(),
    EMarketPlaceScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  final headingTitle = [
    "Home ",
    "E-Market Place",
    "Help",
    "Profile",
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   // backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: Text(headingTitle[currentTeb]),
      // ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 5),
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     child: const Icon(
      //       Icons.add_circle,
      //       size: 30,
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(CommonAppTheme.buttonCommonColor),
        unselectedItemColor: const Color(0xFF0E1133),
        // iconSize: 20,
        selectedFontSize: AllInProvider.iPadSize ? 20 : 14,
        unselectedFontSize: AllInProvider.iPadSize ? 18 : 12,

        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTeb,
        onTap: (index) => setState(
          () {
            if (index == 2) {
              currentTeb = index;
              provider.isBack = false;
              currentScreen = const HelpScreen();
            } else if (index == 1) {
              // currentTeb = index;
              provider.isBack = true;
              provider.getHomeScreenSubModuleMenuBasedOnUserRole(
                context,
              );
              // currentScreen = EMarketPlaceScreen();
            } else if (index == 0) {
              currentTeb = index;
              currentScreen = HomeScreen();
            } else if (index == 3) {
              // currentTeb = index;
              provider.viewProfile(context, provider.empCode);
              // currentScreen = const ProfileScreen();
            }
          },
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: "Home",

            // backgroundColor: Colors.grey,
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.article),
          //     label: "Book",
          //     backgroundColor: Colors.grey),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "E-Market Place",
            // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Help",
            // backgroundColor: Colors.grey
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
