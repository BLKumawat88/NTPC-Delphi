import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntpcsecond/views/Change%20Password/change_password.dart';
import 'package:ntpcsecond/views/Comparing%20Profile/comparing_profile.dart';
import 'package:ntpcsecond/views/E%20Market%20Place/Search%20Job/search_job_home_screen.dart';
import 'package:ntpcsecond/views/E%20Market%20Place/Search%20Job/search_job_view_detials.dart';
import 'package:ntpcsecond/views/E%20Market%20Place/e_market_place_home.dart';
import 'package:ntpcsecond/views/E%20Market%20Place/manage_job.dart';
import 'package:ntpcsecond/views/E%20Market%20Place/manage_job_view_app.dart';
import 'package:ntpcsecond/views/Eligible%20Employees/eligible_employees.dart';
import 'package:ntpcsecond/views/Home/home_screen.dart';
import 'package:ntpcsecond/views/KeyPositionMonitoring/key_position_monitoring.dart';
import 'package:ntpcsecond/views/KeyPositionMonitoring/key_position_positioned.dart';
import 'package:ntpcsecond/views/KeyPositionMonitoring/summaryy_1m_3m_6m.dart';
import 'package:ntpcsecond/views/KeyPositionMonitoring/view_details.dart';
import 'package:ntpcsecond/views/Manas%20Report/manas_filter.dart';
import 'package:ntpcsecond/views/Manas%20Report/manas_report.dart';
import 'package:ntpcsecond/views/Open%20Search/open_search.dart';
import 'package:ntpcsecond/views/Open%20Search/open_search_filter.dart';
import 'package:ntpcsecond/views/SPV%20Analysis/spv_analysis.dart';
import 'package:ntpcsecond/views/SPV%20Analysis/spv_analysis_project.dart';
import 'package:ntpcsecond/views/SPV%20Analysis/spv_analysis_region_screen.dart';
import 'package:ntpcsecond/views/SPV%20Analysis/spv_positions_deptType_dept_search.dart';
import 'package:ntpcsecond/views/SPV%20Analysis/spv_project_dept_type.dart';
import 'package:ntpcsecond/views/Succession%20Planning/succession_planning_screen.dart';
import 'package:ntpcsecond/views/auth/reset_pass.dart';
import 'package:ntpcsecond/views/auth/verify_otp.dart';
import 'package:ntpcsecond/views/help/help_screen.dart';
import 'package:ntpcsecond/views/isuser_logged_in/is_user_logged_in.dart';
import 'package:ntpcsecond/views/profile/profile_screen.dart';
import 'package:ntpcsecond/views/profile/view_profile.dart';
import 'package:ntpcsecond/views/profile/view_profile_offline.dart';
import 'package:provider/provider.dart';

import 'bottombar/bottom_bar_screen.dart';
import 'controllers/allinprovider.dart';
import 'views/E Market Place/view_details_mj.dart';
import 'views/Job Rotation/job_rotation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AllInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NTPC Delphi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: double.infinity,
          splash: SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          nextScreen: const IsUserLoggedInOrNot(),
        ),
        routes: {
          '/is_user_login_screen': (context) => const IsUserLoggedInOrNot(),
          '/bottom_bar_screen': (context) => const BottomBarScreen(),
          '/verify_screen': (context) => const VerifyOTPScreen(),
          '/home_screen': (context) => HomeScreen(),
          '/profile_screen': (context) => const ProfileScreen(),
          '/key_position_monitoring': (context) =>
              const KeyPositionMonitoringScreen(),
          '/eligible_employees': (context) => const EligibleEmployeesScreen(),
          '/comparing_profile': (context) => const ComparingProfile(),
          '/view_details': (context) => const ViewDetailsScreen(),
          '/open_search': (context) => const OpenSearchScreen(),
          '/change_password': (context) => const ChangePasswordScreen(),
          '/view_profile': (context) => const ViewProfileScreen(),
          '/view_profile_offline': (context) =>
              const ViewProfileScreenOffline(),
          '/spv_analysis': (context) => const SPVAnalysisScreen(),
          '/e_market_place': (context) => EMarketPlaceScreen(),
          '/e_market_place_manage_job': (context) => const ManageJobScreen(),
          '/e_market_place_manage_job_view_application': (context) =>
              const ManageJobViewApplicationScreen(),
          '/search_job_home_screen': (context) => const SearchJobHomeScreen(),
          '/search_job_view_details': (context) => const SearchJobViewDetails(),
          '/succession_planning': (context) => const SuccessionPlanning(),
          '/bottom_bar': (context) => const BottomBarScreen(),
          '/summy_onem_twom_sixm': (context) => const SummyOneMThreeMSixM(),
          '/key_postion_occupied_emp': (context) => KeyPostionOccupiedEmp(),
          '/open_search_filter': (context) => const OpenSearchFilter(),
          '/job_rotation': (context) => const JobRotation(),
          '/view_details_mj': (context) => const ViewDetailsMjScreen(),
          '/help': (context) => const HelpScreen(),
          '/manas_report': (context) => const ManasReportScreen(),
          '/manas_filter': (context) => const ManasFilterScreen(),
          '/spv_analysis_region_screen': (context) => SPVAnalysisRegionScreen(),
          '/spv_analysis_project_screen': (context) =>
              SPVAnalysisProjectScreen(),
          '/spv_positions_project_dept_Type_search': (context) =>
              SPVPositionsProjectDeptTypeSearch(),
          '/spv_dept_type_dept_search': (context) => SPVDeptTypeDeptSearch(),
          '/reset_pass': (context) => ResetPassword(),
        },
      ),
    );
  }
}
