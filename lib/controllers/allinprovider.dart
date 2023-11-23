import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ntpcsecond/theme/common_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/database_halper.dart';
import '../model/subject_data_model.dart';

class AllInProvider with ChangeNotifier {
  // String apiBaseUrl = "http://ntpchrmapi.solarman.in/api";
  String apiBaseUrl = "http://ntpchrm.solarman.in/api";
  // String imageUrl = "https://delphi.ntpc.co.in";
  String imageUrl = "https://delphi.ntpc.co.in";

  String accessToken = "";
  bool isBack = false;
  int empCode = 8694;
  String empOtp = "";
  bool isOfflineData = false;
  int isManasReportShow = 0;

  dynamic userRole = "";
  int empProjectType = 0;
  int empRegionID = 0;
  String dateOfLastDownloadedDataOffline = "";

  Map holdUserEnteredInfoToResendOTP = {};

  Future<void> login(context, Map requiredUserInfo, sessionExpiredStatus,
      isOTPRequired) async {
    holdUserEnteredInfoToResendOTP = requiredUserInfo;
    CommanDialog.showLoading(context);
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/Main/User_Login'));
    request.fields.addAll({
      'LoginId': '${requiredUserInfo['emp_code']}',
      'LoginPassword': '${requiredUserInfo['password']}',
      'is_otp_require': isOTPRequired.toString()
    });

    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());

        log("Res $data");
        if (data['code'] == 200) {
          accessToken = data['token'];
          empOtp = data['otPcode'];
          isManasReportShow = data['data']['table'][0]['isManasReportShow'];
          print("empOtp $empOtp");
          empCode = data['data']['table'][0]['empCode'];
          userRole = data['data']['table'][0]['userRole'];
          empRegionID = data['data']['table'][0]['emp_RegionID'];
          empProjectType = data['data']['table'][0]['emp_ProjectType'];
          log("EMP CODE 12345 ${data['data']['table'][0]['empCode']}");

          Map userInfo = {
            "empCode": empCode,
            "user_name": requiredUserInfo['emp_code'],
            "accessToken": accessToken,
            "userRole": userRole,
            "empRegionID": empRegionID,
            "empProjectType": empProjectType,
            "user_password": requiredUserInfo['password'],
            "isManasReportShow": isManasReportShow
          };
          final _storage = const FlutterSecureStorage();
          final userDataLocal = json.encode(userInfo);
          await _storage.write(
              key: 'ntpctwo_isuser_login', value: userDataLocal);

          if (sessionExpiredStatus) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/bottom_bar_screen', (Route<dynamic> route) => false);
          } else {
            if (data['data']['table'][0]['isOTP_Required'] == 1) {
              Navigator.pushNamed(context, '/verify_screen');
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/bottom_bar_screen', (Route<dynamic> route) => false);
            }
          }
        } else {
          print("Else 1234 apart $data");
          CommanDialog.showErrorDialog(context, description: "$data");
        }

        print("API Send Media Respionse $accessToken");
      } else {
        CommanDialog.showErrorDialog(context,
            description: "Invalid Emp. Code or Password");
        print("response.reasonPhrase ${response.reasonPhrase}");
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> resendOtp(context) async {
    CommanDialog.showLoading(context);
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/Main/User_Login'));
    request.fields.addAll({
      'LoginId': '${holdUserEnteredInfoToResendOTP['emp_code']}',
      'LoginPassword': '${holdUserEnteredInfoToResendOTP['password']}'
    });

    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          accessToken = data['token'];
          empOtp = data['otPcode'];
          CommanDialog.showErrorDialog(context,
              description: "Resend OTP Success");
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
        print("API Send Media Respionse $accessToken");
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> changePassword(context, Map requiredUserInfo) async {
    print(requiredUserInfo);

    CommanDialog.showLoading(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/User_Change_Pwd'));
    request.fields.addAll({
      'LoginId': "$empCode",
      'LoginPassword': '${requiredUserInfo['password']}',
      'OldPassword': '${requiredUserInfo['old_pass']}'
    });
    var headers = {'Authorization': 'Bearer $accessToken'};
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();
        if (data == "Invalid Old Password") {
          CommanDialog.showErrorDialog(context, description: data);
        } else {
          Navigator.pop(context);
          CommanDialog.showErrorDialog(context, description: data);
        }

        print(" Reset pass response $data");

        print("API Send Media Respionse $accessToken");
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(" Reset pass response");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  // Manas Report

  List manasReportDataMain = [];
  List manasReportDataDummay = [];
  int pageSizeManasReport = 20;
  int currentPageManasReport = 1;

  String totalRecordOfManasReport = "0";
  Map<String, String> requiredDataForFilter = {
    'SearchApplicationID': '',
    'SearchEmpNo': '',
    'SearchRequestType': '0',
    'SearchGroundType': '0',
    'SearchRequestStatus': '',
    'SearchRequestDateF': '',
    'SearchRequestDateT': '',
    'ProjectChoices': '',
    'SearchProjectC': '0',
    'SearchProjectP': '0',
    'SearchSpouseData': '',
    'CurrentPage': '1',
    'PagingSize': '20',
    'TotalRecord': '0'
  };
  bool isLoadMore = false;
  Future<void> getManasReportData(
      context, Map<String, String> requiedRequestData, routingStatus) async {
    if (routingStatus) {
      masterCurrentProjectProjectFilterData = projectF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
      }).toList();
    }
    requiedRequestData['CurrentPage'] = currentPageManasReport.toString();
    requiedRequestData['PagingSize'] = pageSizeManasReport.toString();
    log("message $requiedRequestData");

    manasReportDataMain.clear();
    manasReportDataDummay.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/Manas_Search_Post'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          print("Total record $totalRecord");
          totalRecordOfManasReport = data['totalRecord'].toString();
          manasReportDataDummay = data['data'];
          manasReportDataMain = data['data'];
          pageSizeManasReport += 20;
          currentPageManasReport++;

          print("Manas report data length ${manasReportDataDummay}");
          // manasReportDataDummay.addAll(data['data']);
          CommanDialog.hideLoading(context);
          // manasReportDataMain.addAll(data['data']);
          notifyListeners();
          if (routingStatus) {
            Navigator.pushNamed(context, '/manas_report');
          } else {
            if (isLoadMore) {
            } else {
              Navigator.pop(context);
            }
          }
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      // CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  int totalEmpCount = 0;
  getTotalEmpCount(context) async {
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/TotalEmployees'));
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        totalEmpCount = data['data'][0]['totalEmployee'];
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Map keyPositionMonitoringSummaryData = {
    "s": "0",
    "p": "0",
    "v": "0",
    "1mon": "0",
    "3mon": "0",
    "6mon": "0"
  };

  Map<String, String> keyPositionSearch_Post_filter_value = {
    'SearchID': '',
    'SearchTitle': '',
    'Department': '',
    'DepartmentGroup': '',
    'DepartmentSubGroup': '',
    "ProjectCategory": "",
    'Project': '',
    'Location': '',
    'Grade': '',
    'Level': '',
    'PositionType': '',
    'isPublished': '0',
    'VacentStatus': '0'
  };

  Map<String, String> keyProjectionSearchPostfiltervalue = {
    'SearchID': '',
    'SearchTitle': '',
    'Department': '',
    'DepartmentGroup': '',
    'DepartmentSubGroup': '',
    'ProjectCategory': '',
    'Project': '',
    'Grade': '',
    'Level': '',
    'PositionType': ''
  };

  List departGroupFilterIds = [];
  List departSubGroupFilterIds = [];
  List departFilterIds = [];
  List projectCategoryFiltersIds = [];
  List locationFiltersIds = [];
  List gradeFiltersIds = [];
  List levelFiltersIds = [];

  List deptGroupFilterValues = [];
  List deptsubGroupFilterValues = [];
  List deptFilterValues = [];
  List projectCategoryFilterValues = [];
  List locationFilterValues = [];
  List gradeFilterValues = [];
  List levelFilterValues = [];

  //Projection Filter Value
  List pDep = [];
  List pProject = [];

  bool statusForshowKeyPositionMonitoringDataOrProjectionData = false;
  List keyPositionMonitoringData = [];
  List keyPositionMonitoringDataMain = [];
  bool showProjectionStatusForSucessionPlanning = true;

  Future<void> getKeyPositionMonitoringData(
      context,
      data,
      status,
      routingStatus,
      apiendpoint,
      showProjectionStatusForSucessionPlanning) async {
    statusForshowKeyPositionMonitoringDataOrProjectionData = false;
    this.showProjectionStatusForSucessionPlanning =
        showProjectionStatusForSucessionPlanning;
    notifyListeners();
    if (status || routingStatus) {
      CommanDialog.showLoading(context);
    }
    keyPositionMonitoringData.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/$apiendpoint'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];
          keyPositionMonitoringData.addAll(data['data']);
          keyPositionMonitoringDataMain.addAll(data['data']);
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          if (routingStatus) {
            Navigator.pushNamed(context, '/key_position_monitoring');
          }

          notifyListeners();
        } else {
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        if (status || routingStatus) {
          CommanDialog.hideLoading(context);
        }
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      if (status || routingStatus) {
        CommanDialog.hideLoading(context);
      }
      print("Error $error");
    }
  }

  //SPV Analysis Region
  List spvAnalysisRegionData = [];
  List spvAnalysisRegionDataMain = [];
  Future<void> getSPVAnalysisRegionData(
      context, data, statusForRouting, isClearingApplyedFilter) async {
    spvAnalysisRegionData.clear();
    spvAnalysisRegionDataMain.clear();
    log("Required1234 $data");
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/SPV_Positions_Region_Search'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];

          spvAnalysisRegionData.addAll(data['data']);

          spvAnalysisRegionDataMain.addAll(data['data']);
          if (isOfflineData) {
            spvAnalysisRegionData.removeLast();
            spvAnalysisRegionDataMain.removeLast();
          }

          notifyListeners();
          if (statusForRouting) {
            Navigator.pushNamed(context, '/spv_analysis_region_screen');
          } else {
            if (isClearingApplyedFilter) {
            } else {
              Navigator.pop(context);
            }
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  spvRagionSearchFilter(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty $enteredKeyword");
      // if the search field is empty or only contains white-space, we'll display all users
      results = spvAnalysisRegionData;
    } else {
      results = spvAnalysisRegionData
          .where(
            (user) => isOfflineData
                ? user["regionName"].toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    )
                : user["searchName"].toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ),
          )
          .toList();

      print("resulr $results");
    }

    spvAnalysisRegionDataMain = results;
    notifyListeners();
  }

  //SPV Analysis Project

  List spvAnalysisProjectData = [];
  List spvAnalysisProjectDataMain = [];
  String selectedRegionName = "";
  String selectedProjectName = "";
  String selectedProjectDeptTypeName = "";
  dynamic spvRegionId = 0;
  dynamic spvProjectId = 0;
  dynamic spvProjectDepTypeID = 0;

  Future<void> getSPVAnalysisProjectData(
      context, data, statusForRouting, isClearingApplyedFilter) async {
    spvAnalysisProjectData.clear();
    spvAnalysisProjectDataMain.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest('POST',
        Uri.parse('$apiBaseUrl/Main/SPV_Positions_Region_Project_Search'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];

          spvAnalysisProjectData.addAll(data['data']);
          spvAnalysisProjectDataMain.addAll(data['data']);
          if (isOfflineData) {
            spvAnalysisProjectData.removeLast();
            spvAnalysisProjectDataMain.removeLast();
          }
          notifyListeners();
          if (statusForRouting) {
            Navigator.pushNamed(context, '/spv_analysis_project_screen');
          } else {
            if (isClearingApplyedFilter) {
            } else {
              Navigator.pop(context);
            }
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  List spvAnalysisProjectDeptTypeData = [];
  List spvAnalysisProjectDeptTypeDataMain = [];
  Future<void> getSPVAnalysisProjectDeptTypeData(
      context, data, statusForRouting, isClearingApplyedFilter) async {
    spvAnalysisProjectDeptTypeData.clear();
    spvAnalysisProjectDeptTypeDataMain.clear();

    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest('POST',
        Uri.parse('$apiBaseUrl/Main/SPV_Positions_Project_DeptType_Search'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];

          spvAnalysisProjectDeptTypeData.addAll(data['data']);
          spvAnalysisProjectDeptTypeDataMain.addAll(data['data']);
          if (isOfflineData) {
            spvAnalysisProjectDeptTypeData.removeLast();
            spvAnalysisProjectDeptTypeDataMain.removeLast();
          }
          notifyListeners();
          if (statusForRouting) {
            Navigator.pushNamed(
                context, '/spv_positions_project_dept_Type_search');
          } else {
            if (isClearingApplyedFilter) {
            } else {
              Navigator.pop(context);
            }
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  List spvAnalysisProjectDeptTypeDeptData = [];
  List spvAnalysisProjectDeptTypeDeptDataMain = [];
  Future<void> getSPVAnalysisProjectDeptTypeDeptData(
      context, data, statusForRouting, isClearingApplyedFilter) async {
    log("Data $data");
    spvAnalysisProjectDeptTypeDeptData.clear();
    spvAnalysisProjectDeptTypeDeptDataMain.clear();

    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest('POST',
        Uri.parse('$apiBaseUrl/Main/SPV_Positions_DeptType_Dept_Search'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];

          spvAnalysisProjectDeptTypeDeptData.addAll(data['data']);
          spvAnalysisProjectDeptTypeDeptDataMain.addAll(data['data']);
          if (isOfflineData) {
            spvAnalysisProjectDeptTypeDeptData.removeLast();
            spvAnalysisProjectDeptTypeDeptDataMain.removeLast();
          }
          notifyListeners();
          if (statusForRouting) {
            Navigator.pushNamed(context, '/spv_dept_type_dept_search');
          } else {
            if (isClearingApplyedFilter) {
            } else {
              Navigator.pop(context);
            }
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  Future<void> getKeyPositionMonitoringData1(
      context, filterData, status, apiEndPoint) async {
    CommanDialog.showLoading(context);
    keyPositionMonitoringDataMain.clear();
    keyPositionMonitoringData.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/$apiEndPoint'));
    request.fields.addAll(filterData);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print("RESULT $response");
      if (response.statusCode == 200) {
        CommanDialog.hideLoading(context);
        if (status) {
          CommanDialog.hideLoading(context);
        }

        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];
          keyPositionMonitoringDataMain.addAll(data['data']);
          keyPositionMonitoringData.addAll(data['data']);
          print("DATA LENGTH ${keyPositionMonitoringData.length}");
          notifyListeners();
        } else {
          print("API RESPONSE $data");
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  List eligibalEmpList = [];
  List eligibalEmpListDummy = [];
  String eligibalEmpListHeadingTitle = "";
  bool isApplicantsData = false;

  Future<void> getEligibalEmpList(
      context, id, apiendpoint, statusForKeyIDorJOBID) async {
    eligibalEmpList.clear();
    eligibalEmpListDummy.clear();
    if (apiendpoint == "Main/Job_Applied_Candidate_Search" && isOfflineData) {
      print("offline");
      List result =
          await dataBaseHelper.getApplicantDataOffline(jobPost_Applied_Emp, id);
      eligibalEmpList.addAll(result);
      eligibalEmpListDummy.addAll(result);
      Navigator.pushNamed(context, '/eligible_employees');
    } else {
      CommanDialog.showLoading(context);
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request =
          http.MultipartRequest('POST', Uri.parse('$apiBaseUrl/$apiendpoint'));
      request.fields.addAll({
        statusForKeyIDorJOBID ? 'JobID' : "id": '$id',
        'empName': '',
        'ProjectCatID': '',
        'RegionHQ': '',
        'Project': '',
        'Location': '',
        'Department_Group': '',
        'Department_SubGroup': '',
        'Department': '',
        'WorkProfile': '',
        'DobFrom': '',
        'DobTo': '',
        'DoJ_NtpcFrom': '',
        'DoJ_NtpcTo': '',
        'DoE_ProjectFrom': '',
        'DoE_ProjectTo': '',
        'DoE_DeptFrom': '',
        'DoE_DeptTo': '',
        'DoE_GradeFrom': '',
        'DoE_GradeTo': '',
        'DoE_LevelFrom': '',
        'DoE_LevelTo': '',
        'DoRetireFrom': '',
        'DoRetireTo': '',
        'Gender': '',
        'Caste_Category': '',
        'Emp_Group': '',
        'Emp_Grade': '',
        'Substantive_Grade': '',
        'Emp_Designation': '',
        'Emp_EntryMode': '',
        'PH': '',
        'PH_PerFrom': '',
        'PH_PerTo': '',
        'Qual': '',
        'Branch': '',
        'Institute': '',
        'Recuitment': '',
        'Domicile': '',
        'AgeMin': '0',
        'AgeMax': '0',
        'JobBalMin': '0',
        'JobBalMax': '0',
        'Awards': '',
        'Interests': '',
        'Interest_Type': '',
        'Committies': '',
        'MemberShip': '',
        'faculty': '',
        'TrainingName': '',
        'TrainingDateFrom': '',
        'TrainingDateTo': '',
        'OpdFor': '',
        'OpdTotalCostMin': '0',
        'OpdTotalCostMax': '0',
        'IpdFor': '',
        'IpdTotalCostMin': '0',
        'IpdTotalCostMax': '0',
        'DiagnosisFor': '',
        'LeaveType': '',
        'TotalLeaveYear': '0',
        'TotalLeaveMin': '0',
        'TotalLeaveMax': '0',
        'ManasRequestType': '',
        'ManasGroundType': '',
        'ManasTotalYears': '0',
        'EmpGroupExpIDs': '',
        'WorkProfileIDs': '',
        'DepartmentIDs': '',
        'DeptSubIds': '',
        'DeptGroupIds': '',
        'TotalFunExpMin': '0',
        'TotalFunExpMax': '0',
        'LocExpRegionIDs': '',
        'LocExpProjectIDs': '',
        'TotalLocExpMin': '0',
        'TotalLocExpMax': '0',
        'RegExpRegionIDs': '',
        'TotalRegExpMin': '0',
        'TotalRegExpMax': '0',
        'ProjCat_ExpIDs': '',
        'TotalProjCatExpMin': '0',
        'TotalProjCatExpMax': '0',
        'isVigilanceinclude': '0',
        'isHeldKeyPosition': '0',
        'Vigilance': '0',
        'UserID': '$empCode',
        'UserRole': userRole,
        'ProjectType': '$empProjectType',
        'RegionID': '$empRegionID',
        'SortBy': '',
        'CurrentPage': '1',
        'PagingSize': '20000',
        'TotalRecord': '0'
      });
      request.headers.addAll(headers);

      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());
          log("data $data");
          if (data['code'] == 200) {
            eligibalEmpList.addAll(data['data']);
            eligibalEmpListDummy.addAll(data['data']);
            CommanDialog.hideLoading(context);

            print("eligibalEmpListDummy $eligibalEmpListDummy");

            Navigator.pushNamed(context, '/eligible_employees');
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        CommanDialog.hideLoading(context);
        print("Error $error");
      }
    }
  }

  List profileInfo = [];

  List profileForProfileScreen = [];

  List funExp = [];
  List locExp = [];
  List movementHistory = [];
  List workArea = [];
  List training = [];
  List awards = [];
  List committees = [];
  List membership = [];

  List trainingCareer = [];
  List manas = [];
  List medicalHistory = [];
  List qualification = [];

  Future<void> getUserProfile(context) async {
    profileInfo.clear();
    profileForProfileScreen.clear();

    if (isOfflineData) {
      List result = await dataBaseHelper.getUserProfileOffline(
          'employee_Details', empCode);
      print("user offline profile $result");
      profileInfo.addAll(result);
      profileForProfileScreen.addAll(result);
      notifyListeners();
    } else {
      profileInfo.clear();
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Emp_Profile_Data'));
      request.fields.addAll({'EmpNo': '$empCode'});
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());
          if (data['code'] == 200) {
            // log("Data ${data['data']}");
            profileInfo.addAll(data['data']['profile']);
            profileForProfileScreen.addAll(data['data']['profile']);
            notifyListeners();
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        print("Error $error");
      }
    }
  }

  Future<void> viewProfile(context, empCodeID) async {
    if (isOfflineData) {
      try {
        profileInfo.clear();
        print("Offline usr id  $empCodeID");
        List userProfileOffineData = await dataBaseHelper.getUserProfileOffline(
            "employee_Details", empCodeID);
        log("User offline profile ${userProfileOffineData[0]['keyPosition']}");
        profileInfo.addAll(userProfileOffineData);
        Navigator.pushNamed(context, '/view_profile_offline');
      } catch (error) {
        CommanDialog.hideLoading(context);
        print("Error $error");
      }
    } else {
      profileInfo.clear();
      funExp.clear();
      locExp.clear();
      movementHistory.clear();
      workArea.clear();
      training.clear();
      awards.clear();
      committees.clear();
      membership.clear();

      trainingCareer.clear();
      manas.clear();
      medicalHistory.clear();
      qualification.clear();
      CommanDialog.showLoading(context);

      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Emp_Profile_Data'));
      request.fields.addAll({'EmpNo': '$empCodeID'});

      request.headers.addAll(headers);

      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());
          if (data['code'] == 200) {
            CommanDialog.hideLoading(context);
            // log("Data ${data['data']}");
            profileInfo.addAll(data['data']['profile']);

            funExp.addAll(data['data']['funExp']);
            locExp.addAll(data['data']['locExp']);
            movementHistory.addAll(data['data']['movementHistory']);
            workArea.addAll(data['data']['workArea']);
            training.addAll(data['data']['training']);
            awards.addAll(data['data']['awards']);
            committees.addAll(data['data']['committees']);
            membership.addAll(data['data']['membership']);

            trainingCareer.addAll(data['data']['trainingCareer']);
            manas.addAll(data['data']['manas']);
            medicalHistory.addAll(data['data']['medical']);
            qualification.addAll(data['data']['qualification']);

            log("profileInfo $profileInfo");

            Navigator.pushNamed(context, '/view_profile');
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        CommanDialog.hideLoading(context);
        print("Error $error");
      }
    }
  }

  // SPV Analysis Section Start
  List spvAnalysisData = [];
  Future<void> getSPVAnalysisData(context) async {
    spvAnalysisData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$apiBaseUrl/Main/Master_KeyPostions_Search?SearchID=&SearchTitle=&Department=&DepartmentGroup=&DepartmentSubGroup=&Project=&Grade=&Level=&PositionType=&isPublished=0'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          log("Data ${data['data']}");
          spvAnalysisData.addAll(data['data']);
          CommanDialog.hideLoading(context);
          Navigator.pushNamed(context, '/spv_analysis');
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  //SPV Analysis Section END

  // E Market Place Section Start
  List eMarketPalceManageJobData = [];
  Future<void> getEMarketPalceManageJobData(context) async {
    eMarketPalceManageJobData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$apiBaseUrl/Main/Master_KeyPostions_Search?SearchID=&SearchTitle=&Department=&DepartmentGroup=&DepartmentSubGroup=&Project=&Grade=&Level=&PositionType=&isPublished=0'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          log("Data ${data['data']}");
          eMarketPalceManageJobData.addAll(data['data']);
          CommanDialog.hideLoading(context);
          Navigator.pushNamed(context, '/e_market_place_manage_job');
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  List eMarketPalceSearchJobData = [];
  Future<void> getEMarketPalceSearchJobData(context) async {
    eMarketPalceSearchJobData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$apiBaseUrl/Main/Master_KeyPostions_Search?SearchID=&SearchTitle=&Department=&DepartmentGroup=&DepartmentSubGroup=&Project=&Grade=&Level=&PositionType=&isPublished=0'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          log("Data ${data['data']}");
          eMarketPalceSearchJobData.addAll(data['data']);
          CommanDialog.hideLoading(context);
          Navigator.pushNamed(context, '/search_job_home_screen');
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }
  //E Market Place Section End

  List<SubjectModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];

  getSubjectData() {
    subjectData.clear();
    dropDownData.clear();

    Map<String, dynamic> apiResponse = {
      "code": 200,
      "message": "Course subject lists.",
      "data": [
        {"subject_id": "1", "subject_name": "Xyz"},
        {"subject_id": "2", "subject_name": "SD Dep"},
        {"subject_id": "3", "subject_name": "FF fdg"},
        {"subject_id": "4", "subject_name": "GG YYY"},
        {"subject_id": "5", "subject_name": "MM DD"},
        {"subject_id": "6", "subject_name": "TT CC"},
        {"subject_id": "7", "subject_name": "JJFF"},
        {"subject_id": "8", "subject_name": "GGGGG"}
      ]
    };

    if (apiResponse['code'] == 200) {
      // List<SubjectModel> tempSubjectData = [];
      // apiResponse['data'].forEach(
      //   (data) {
      //     tempSubjectData.add(
      //       SubjectModel(
      //         subjectId: data['subject_id'],
      //         subjectName: data['subject_name'],
      //       ),
      //     );
      //   },
      // );
      // subjectData.addAll(tempSubjectData);

      List dataaa = [
        {"subject_id": "1", "subject_name": "Xyz"},
        {"subject_id": "2", "subject_name": "SD Dep"},
        {"subject_id": "3", "subject_name": "FF fdg"},
        {"subject_id": "4", "subject_name": "GG YYY"},
        {"subject_id": "5", "subject_name": "MM DD"},
        {"subject_id": "6", "subject_name": "TT CC"},
        {"subject_id": "7", "subject_name": "JJFF"},
        {"subject_id": "8", "subject_name": "GGGGG"}
      ];
      dropDownData = dataaa.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['subject_name']);
      }).toList();
    } else if (apiResponse['code'] == 400) {
    } else {}
  }

  // Filter APi

  List<MultiSelectItem> deptGroup = [];

  List<MultiSelectItem> deptSubGroup = [];
  List<MultiSelectItem> deptSubGroupDummy = [];

  List<MultiSelectItem> dept = [];
  List<MultiSelectItem> deptDummy = [];

  List<MultiSelectItem> projectCategory = [];
  List<MultiSelectItem> projectCategoryDummy = [];

  List<MultiSelectItem> location = [];
  List<MultiSelectItem> locationDummy = [];

  List<MultiSelectItem> grade = [];
  List<MultiSelectItem> level = [];
  List<MultiSelectItem> levelDummy = [];

  // Selected Filters to get New Data

  // All Available Filters
  List departmentsF = [];
  List subDepartmentsF = [];
  List groupDepartmentsF = [];
  List qualificationF = [];
  List qualificationBranchF = [];
  List institutesF = [];
  List recruitmentsF = [];
  List interestLevelF = [];
  List interestsF = [];
  List awardsF = [];
  List committeesF = [];
  List membershipF = [];
  List facultyF = [];
  List empGroupF = [];
  List empGradeF = [];
  List eEmpGradeF = [];
  List empLevelDesignationF = [];
  List categoryF = [];
  List regionF = [];
  List projectCategoryF = [];
  List projectF = [];
  List workAreaF = [];
  List manasRequestTypeF = [];
  List manasGroundTypeF = [];
  List manasGroundTypeDummy = [];
  List tranningsF = [];
  List pHCodeF = [];
  List entryModeF = [];
  List statesF = [];
  List spVDeptTypeF = [];
  List spVDeptF = [];

  List spVDeptLinkF = [];
  List projectAreasF = [];
  List substantiveGradeF = [];

  List spVGradeF = [];
  List table32F = [];
  //All Available Filters End

  Future<void> getAvailableFilter(context) async {
    if (!await checkInternetAvailableOrNot()) {
      // CommanDialog.showErrorDialog(context,
      //     description: "No Internet Connection");
      isOfflineData = true;
      notifyListeners();
      return;
    }

    CommanDialog.showLoadingForFilter(context);
    //All Available Filter Clean Start
    departmentsF.clear();
    subDepartmentsF.clear();
    groupDepartmentsF.clear();
    qualificationF.clear();
    qualificationBranchF.clear();
    institutesF.clear();
    recruitmentsF.clear();
    interestLevelF.clear();
    interestsF.clear();
    awardsF.clear();
    committeesF.clear();
    membershipF.clear();
    facultyF.clear();
    empGroupF.clear();
    empGradeF.clear();
    eEmpGradeF.clear();
    empLevelDesignationF.clear();
    categoryF.clear();
    regionF.clear();
    projectCategoryF.clear();
    projectF.clear();
    workAreaF.clear();
    manasRequestTypeF.clear();
    manasGroundTypeF.clear();
    tranningsF.clear();
    pHCodeF.clear();
    entryModeF.clear();
    statesF.clear();
    spVDeptTypeF.clear();
    spVDeptF.clear();
    spVDeptLinkF.clear();
    projectAreasF.clear();
    substantiveGradeF.clear();
    spVGradeF.clear();
    table32F.clear();
    //All Available filter Clean End

    deptGroup.clear();
    deptSubGroup.clear();
    dept.clear();
    projectCategory.clear();
    location.clear();
    grade.clear();
    level.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'GET', Uri.parse('$apiBaseUrl/Main/adm_Masters_All'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          //All Filter Data Add in list Start
          departmentsF.addAll(data['data']['departments']);
          subDepartmentsF.addAll(data['data']['subDepartments']);
          groupDepartmentsF.addAll(data['data']['groupDepartments']);
          qualificationF.addAll(data['data']['qualification']);
          qualificationBranchF.addAll(data['data']['qualificationBranch']);
          institutesF.addAll(data['data']['institutes']);
          recruitmentsF.addAll(data['data']['recruitments']);
          interestLevelF.addAll(data['data']['interestLevel']);
          interestsF.addAll(data['data']['interests']);
          awardsF.addAll(data['data']['awards']);
          committeesF.addAll(data['data']['committees']);
          membershipF.addAll(data['data']['membership']);
          facultyF.addAll(data['data']['faculty']);
          empGroupF.addAll(data['data']['empGroup']);
          empGradeF.addAll(data['data']['empGrade']);
          eEmpGradeF.addAll(data['data']['e_EmpGrade']);
          empLevelDesignationF.addAll(data['data']['empLevel_Designation']);
          categoryF.addAll(data['data']['category']);
          regionF.addAll(data['data']['region']);
          projectCategoryF.addAll(data['data']['projectCategory']);
          projectF.addAll(data['data']['project']);
          workAreaF.addAll(data['data']['workArea']);
          manasRequestTypeF.addAll(data['data']['manasRequestType']);
          manasGroundTypeF.addAll(data['data']['manasGroundTypeR']);
          manasGroundTypeDummy.addAll(data['data']['manasGroundTypeR']);
          tranningsF.addAll(data['data']['trannings']);
          pHCodeF.addAll(data['data']['pH_Code']);
          entryModeF.addAll(data['data']['entryMode']);
          statesF.addAll(data['data']['states']);

          spVDeptTypeF.addAll(data['data']['spV_Dept_Type']);
          spVDeptF.addAll(data['data']['spV_Dept']);
          spVDeptLinkF.addAll(data['data']['spV_Dept_Link']);
          projectAreasF.addAll(data['data']['projectAreas']);
          substantiveGradeF.addAll(data['data']['substantive_Grade']
              .where((value) => value['empl_Group'] == 'E'));
          spVGradeF.addAll(data['data']['spV_Grade']);
          // table32F.addAll(data['data']['table32']);
          //All Filter Data Add in list End

          List dgf = [];
          List subDepartments = [];
          List departments = [];
          List pCategory = [];
          List locationd = [];
          List eEmpGrade = [];
          List levela = [];

          // dgf.addAll(data['data']['departments']);
          subDepartments.addAll(data['data']['subDepartments']);
          departments.addAll(data['data']['departments']);
          // departments.addAll(data['data']['groupDepartments']);
          pCategory.addAll(data['data']['projectCategory']);
          locationd.addAll(data['data']['project']);
          eEmpGrade.addAll(data['data']['e_EmpGrade']); // levelCode  CC levela
          levela.addAll(data['data']['empLevel_Designation'].where((value) =>
              value['empGrp_Code'] ==
              'E')); //  only those values empGrp_Code -> empGrp_Code
          // CC levelCode
          dgf.addAll(data['data']['groupDepartments']);
          deptGroup = dgf.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['groupDeptName']);
          }).toList();

          deptSubGroup = subDepartments.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
          }).toList();

          deptSubGroupDummy = subDepartments.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
          }).toList();

          dept = departments.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
          }).toList();

          deptDummy = departments.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
          }).toList();

          projectCategory = pCategory.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
          }).toList();

          projectCategoryDummy = pCategory.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
          }).toList();

          location = locationd.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
          }).toList();

          locationDummy = locationd.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
          }).toList();

          grade = eEmpGrade.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['levelName']);
          }).toList();

          level = levela.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
          }).toList();

          levelDummy = levela.map((subjectdataa) {
            return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
          }).toList();

          log("depbb $deptGroup");
          CommanDialog.hideLoading(context);
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print("Error  122 ");
      }
    } catch (error) {
      print("Error $error");
    }
  }

  //FIlter api end

  //Succession Planning Work Start

  List successionPlanningData = [];
  Future<void> getSuccessionPlanningData(context) async {
    successionPlanningData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$apiBaseUrl/Main/Master_KeyPostions_Search?SearchID=&SearchTitle=&Department=&DepartmentGroup=&DepartmentSubGroup=&Project=&Grade=&Level=&PositionType=&isPublished=0'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          log("Data ${data['data']}");
          successionPlanningData.addAll(data['data']);
          CommanDialog.hideLoading(context);
          Navigator.pushNamed(context, '/succession_planning');
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  //Succession Planning Work END

  // 1 Key Position Monitoring Start

  List summarySectionOneMTwoMThreeMData = [];
  Future<void> getSummySectonOneMTwoMSixMData(
      context, Map<String, String> requiedRequestData) async {
    summarySectionOneMTwoMThreeMData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/KeyPostion_Occupied_Emp_Retire'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());

        if (data['code'] == 200) {
          summarySectionOneMTwoMThreeMData.addAll(data['data']);
          print(summarySectionOneMTwoMThreeMData.length);
          Navigator.pushNamed(context, '/summy_onem_twom_sixm');
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  List keyPostionPositionedEmpData = [];
  Future<void> getKeyPostionPositionedEmpData(
      context, Map<String, String> requiedRequestData) async {
    keyPostionPositionedEmpData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/KeyPostion_Occupied_Emp'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        print("Datra $data");
        if (data['code'] == 200) {
          keyPostionPositionedEmpData.addAll(data['data']);
          Navigator.pushNamed(context, '/key_postion_occupied_emp');
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  List empCompareSearchData = [];
  Future<void> getEmpCompareSearchData(
      context, Map<String, String> requiedRequestData) async {
    empCompareSearchData.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/OpenSearch/Emp_Compare_Search'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        print("Datra $data");
        if (data['code'] == 200) {
          empCompareSearchData.addAll(data['data']);
          print(empCompareSearchData.length);
          Navigator.pushNamed(context, '/comparing_profile');
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  Map keyPositionDetailData = {};

  Future<void> getKeyPositionDetail(
      context, Map<String, String> requiedRequestData) async {
    keyPositionDetailData.clear();

    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/KeyPositions_Details'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());

        if (data['code'] == 200) {
          keyPositionDetailData.addAll(data['data']);
          Navigator.pushNamed(context, '/view_details');
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  Future<void> getKeyPositionDetailOfflineData(
      context, positionId, description) async {
    keyPositionDetailData.clear();
    print("Getting Data from Offline");
    CommanDialog.showLoading(context);

    try {
      List resultDepartmentExp = await dataBaseHelper.getKeyPositionDetails(
          'departmentExp', positionId);
      print("resultDepartmentExp $resultDepartmentExp");

      List resultProjectExp =
          await dataBaseHelper.getKeyPositionDetails('projectExp', positionId);
      print("resultProjectExp $resultProjectExp");

      List resultRoleExp =
          await dataBaseHelper.getKeyPositionDetails('roleExp', positionId);
      print("resultRoleExp $resultRoleExp");
      CommanDialog.hideLoading(context);
      Map response = {
        "code": 200,
        "status": "Ok",
        "data": {
          "positionDetail": [description],
          "departmentExp": resultDepartmentExp,
          "projectExp": resultProjectExp,
          "roleExp": resultRoleExp,
          "employeeData": []
        }
      };
      keyPositionDetailData.addAll(response['data']);
      Navigator.pushNamed(context, '/view_details');

      print("Final result of key position details $response");
    } catch (error) {
      CommanDialog.hideLoading(context);

      print("Error $error");
    }
  }

  List keyProjectionMonitoringData = [];
  List keyProjectionMonitoringDataMain = [];
  Future<void> getKeyProjectionMonitoringData(context, data, status) async {
    print(data);
    statusForshowKeyPositionMonitoringDataOrProjectionData = true;
    notifyListeners();
    keyProjectionMonitoringData.clear();
    keyProjectionMonitoringDataMain.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/KeyPositions_Projection_Search'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
          keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
          // keyPositionMonitoringSummaryData["v"] = data[''];
          keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
          keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
          keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];
          keyProjectionMonitoringData.addAll(data['data']);
          keyProjectionMonitoringDataMain.addAll(data['data']);
          print("LENNNNNN ${keyPositionMonitoringData.length}");
          notifyListeners();
          if (status) {
            CommanDialog.hideLoading(context);
          }
          CommanDialog.hideLoading(context);
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  monitoringSearch(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = keyPositionMonitoringDataMain;
    } else {
      results = keyPositionMonitoringDataMain.where((user) {
        return user["departmentName"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            user[isOfflineData ? "projectName" : "location"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase());
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive

      print("resulr $results");
    }

    // Refresh the UI

    keyPositionMonitoringData = results;
    notifyListeners();
  }

  monitoringProjectiionSearch(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = keyProjectionMonitoringDataMain;
    } else {
      print("else");
      results = keyProjectionMonitoringDataMain
          .where(
            (user) =>
                user["departmentName"].toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ) ||
                user["location"].toLowerCase().contains(
                      enteredKeyword.toLowerCase(),
                    ),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive

      print("resulr $results");
    }

    // Refresh the UI

    keyProjectionMonitoringData = results;
    notifyListeners();
  }

  eligibleEmpSearch(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = eligibalEmpList;
    } else {
      print("else");
      results = eligibalEmpList
          .where((user) =>
              user["name"].toLowerCase().contains(
                    enteredKeyword.toLowerCase(),
                  ) ||
              user["pernr"].toLowerCase().contains(
                    enteredKeyword.toLowerCase(),
                  ) ||
              user["project"].toLowerCase().contains(
                    enteredKeyword.toLowerCase(),
                  ) ||
              user["department"].toLowerCase().contains(
                    enteredKeyword.toLowerCase(),
                  ))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive

      print("resulr $results");
    }

    // Refresh the UI

    eligibalEmpListDummy = results;
    notifyListeners();
  }

  // Key POssition Monitoring End

  clearLocationData() {
    locationFilterValues.clear();
    print("locationFilterValues ${locationFilterValues}");
    notifyListeners();
  }

  //2. Open Search Section Start

  String searchUserByNameId = "";
  String sortByValue = '';

  List openSearchEmpDataMain = [];
  List openSearchEmpDataDummy = [];

  int totalRecord = 0;

  Future<void> getOpenSearchEmpData(
      context, Map<String, String> requiedRequestData, status) async {
    // openSearchEmpDataMain.clear();
    // openSearchEmpDataDummy.clear();
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/OpenSearch/Emp_Open_Search'));
    request.fields.addAll(requiedRequestData);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          totalRecord = data['totalRecord'];
          print("Total record found ${data['totalRecord']}");

          openSearchEmpDataDummy.addAll(data['data']);
          CommanDialog.hideLoading(context);
          openSearchEmpDataMain.addAll(data['data']);
          notifyListeners();
          if (status) {
            CommanDialog.hideLoading(context);
          }
        } else {
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.hideLoading(context);
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      // CommanDialog.hideLoading(context);
      print("Error $error");
    }
  }

  // Open Search Section End

  //Master Filter Section For Multi Selection Start Key->  Master1

  //1.1 Overall Experience -> Functional Exp
  List masterDepartmentGroupFilterIds = [];
  List masterDepartmentGroupFilterValues = [];
  List<MultiSelectItem> mastDepartmentGroupFilter = [];

  List masterDepartmentSubGroupFilterIds = [];
  List masterDepartmentSubGroupFilterValues = [];
  List<MultiSelectItem> masterDepartmentSubGroupFilterDummyData = [];

  List masterDepartmentFilterIds = [];
  List masterDepartmentFilterValues = [];
  List<MultiSelectItem> masterDepartmentFilterDummyData = [];

  List masterDepartmentExpEmpGroup = []; //Single Selection
  String masterDepartmentExpEmpGroupValue = "";
  String masterDepartmentExpEmpGroupValueToShowAsSelectedFilter = "";

  List masterWorkProfileIds = [];
  List masterWorkProfileValues = [];
  List<MultiSelectItem> masterWorkProfileFilterDummyData = [];

  RangeValues totalFunExpMinTotalFunExpMax = const RangeValues(0, 45);
  double totalFunExpMin = 0;
  double totalFunExpMax = 0;

  updatetotalFunExpMinTotalLocExpMax(RangeValues value) {
    totalFunExpMinTotalFunExpMax = value;
    totalFunExpMin = value.start;
    totalFunExpMax = value.end;
    notifyListeners();
  }

  //1.2 Overall Experience -> Regional/Location Exp.
  List masterRegionIds = [];
  List masterRegionValues = [];
  List<MultiSelectItem> masterRegionFilterData = [];

  List masterProjectIds = [];
  List masterProjectValues = [];
  List<MultiSelectItem> masterProjectDummyData = [];

  RangeValues totalLocExpMinTotalLocExpMax = const RangeValues(0, 45);
  double totalLocExpMin = 0;
  double totalLocExpMax = 0;

  updatetotalLocExpMinTotalLocExpMax(RangeValues value) {
    totalLocExpMinTotalLocExpMax = value;
    totalLocExpMin = value.start;
    totalLocExpMax = value.end;
    notifyListeners();
  }

  //1.3 Overall Experience -> Key Position
  bool keyPositionHoldingAsOnDate = false;
  bool keyPositionHoldedInPast = false;
  updateKeyPositionHoldingAsOnDate(value) {
    keyPositionHoldingAsOnDate = value;
    notifyListeners();
  }

  updateKeyPositionHoldedInPast(value) {
    keyPositionHoldedInPast = value;
    notifyListeners();
  }

  //2.1 General -> Category

  //->>> General Age  Start
  RangeValues generalAgeMinMax = const RangeValues(18, 60);
  double generalAgeMin = 18;
  double generalAgeMax = 60;
  bool isAgeSelected = false;

  updateGeneralAge(RangeValues value) {
    generalAgeMinMax = value;
    generalAgeMin = value.start;
    generalAgeMax = value.end;
    notifyListeners();
  }
  //->>> General Age  END

  //->>> General Balance Service Start
  RangeValues generalBalanceServiceMinMax = const RangeValues(0, 45);
  double generalBalanceMin = 0;
  double generalBalanceMax = 45;
  bool isGeneralBalanceSelected = false;

  updateGeneralBalanceService(RangeValues value) {
    generalBalanceServiceMinMax = value;
    generalBalanceMin = value.start;
    generalBalanceMax = value.end;
    notifyListeners();
  }

  //->>> General Balance Service  END

  //General -> Category
  List masterCategoryIds = [];
  List masterCategoryValues = [];
  List<MultiSelectItem> mastCategoryFilter = [];

  //2.2 General -> Current Project
  List masterProjectCategoryIds = [];
  List masterCurrentProjectRegionIds = [];
  List masterCurrentProjectProjectIds = [];
  List masterCurrentProjectProjectLocationIds = [];

  List masterProjectCategoryValues = [];
  List masterCurrentProjectRegionValues = [];
  List masterCurrentProjectProjectValues = [];
  List masterCurrentProjectProjectLocationValues = [];

  List<MultiSelectItem> masterProjectCategoryFilterData = [];
  List<MultiSelectItem> masterCurrentProjectRegionDummyData = [];
  List<MultiSelectItem> masterCurrentProjectProjectFilterData = [];
  List<MultiSelectItem> masterCurrentProjectProjectLocationDummyData = [];

  //2.3 General -> Department
  List masterDepartmentDepartmentGroupFilterIds = [];
  List masterDepartmentDepartmentGroupFilterValues = [];
  List<MultiSelectItem> masterDepartmentDepartmentGroupFilterData = [];

  List masterDepartmentDepartmentSubGroupFilterIds = [];
  List masterDepartmentDepartmentSubGroupFilterValues = [];
  List<MultiSelectItem> masterDepartmentDepartmentSubGroupFilterDummyData = [];

  List masterDepartmentDepartmentFilterIds = [];
  List masterDepartmentDepartmentFilterValues = [];
  List<MultiSelectItem> masterDepartmentDepartmentFilterDummyData = [];

  List masterDepartmentWorkProfileIds = [];
  List masterDepartmentWorkProfileValues = [];
  List<MultiSelectItem> masterDepartmentWorkProfileDummyData = [];

  //2.4 General - > Domicile
  List masterStatesIds = [];
  List masterStatesValues = [];
  List<MultiSelectItem> masterDomicileFilterData = [];

  //2.5 General -> Employee Group
  List masterEmployeeGroupIds = [];
  List masterEmployeeGroupValues = [];
  List<MultiSelectItem> masterEmployeeGroupFilterData = [];

  //2.6 General -> Grade
  List masterGradeIds = [];
  List masterGradeValues = [];
  List<MultiSelectItem> masterGradeFilterData = [];

  //2.7 General ->Substantive Grade
  List masterSubstantiveGradeIds = [];
  List masterSubstantiveGradeValues = [];
  List<MultiSelectItem> masterSubstantiveGradeFilterData = [];

  //2.8 General ->Lavel Grade
  List masterLavelIds = [];
  List masterLavelValues = [];
  List<MultiSelectItem> masterGeneralLevelFilterData = [];

  String masterGenderSelectedValue = "";
  List masterGender = [
    {
      "text": "Select Gender",
      "value": "",
    },
    {
      "text": "Male",
      "value": "Male",
    },
    {
      "text": "Female",
      "value": "Female",
    },
  ];

  bool masterPHHearing = false;
  bool masterPHOrtho = false;
  bool masterPHVisual = false;
  updatePhHearing(value) {
    masterPHHearing = value;
    notifyListeners();
  }

  updatePhOrtho(value) {
    masterPHOrtho = value;
    notifyListeners();
  }

  updatePhVisual(value) {
    masterPHVisual = value;
    notifyListeners();
  }

  RangeValues pHPerMinMax = const RangeValues(0, 100);
  double pHPerMin = 0;
  double pHPerMax = 100;

  updatePHPer(RangeValues value) {
    pHPerMinMax = value;
    pHPerMin = value.start;
    pHPerMax = value.end;
    notifyListeners();
  }

  String masterVigilanceSelectedValue = "0";
  List masterVigilance = [
    {
      "text": "Show All",
      "value": "0",
    },
    {
      "text": "Included",
      "value": "1",
    },
    {
      "text": "Excluded",
      "value": "2",
    },
  ];

  //2.9 General -> PH
  List masterPHIds = [];
  List masterPHValues = [];

  //2.9 General -> Associations
  List masterAssociationsCommitteesIds = [];
  List masterAssociationsCommitteesValues = [];
  List<MultiSelectItem> masterAssociationsCommitteesFilterData = [];

  List masterAssociationsMemberIds = [];
  List masterAssociationsMemberValues = [];
  List<MultiSelectItem> masterAssociationsMembersFilterData = [];

  List masterAssociationsFacultyIds = [];
  List masterAssociationsFacultyValues = [];
  List<MultiSelectItem> masterAssociationsFacultyFilterData = [];

  //2.10 General -> Interest/Award
  List masterInterestAwardInterestIds = [];
  List masterInterestAwardInterestValues = [];
  List<MultiSelectItem> masterInterestAwardInterestFilterData = [];

  List masterInterestAwardAchievementIds = [];
  List masterInterestAwardAchievementValues = [];
  List<MultiSelectItem> masterInterestAwardAchievementFilterData = [];

  //Leaces History

  String leaveHistorySelectedValue = "Leave Type";
  List leaveHistoryData = [
    {
      "text": "Leave Type",
      "value": "0",
    },
    {
      "text": "CCL",
      "value": "1",
    },
    {
      "text": "DZL",
      "value": "2",
    },
    {
      "text": "EOL",
      "value": "3",
    },
    {
      "text": "EOML",
      "value": "4",
    },
    {
      "text": "ML",
      "value": "5",
    },
    {
      "text": "MLT",
      "value": "6",
    },
    {
      "text": "MTP",
      "value": "7",
    },
    {
      "text": "PL",
      "value": "8",
    },
    {
      "text": "QL",
      "value": "9",
    },
    {
      "text": "SCCL",
      "value": "10",
    },
    {
      "text": "SDL",
      "value": "11",
    },
    {
      "text": "SDLT",
      "value": "12",
    },
    {
      "text": "SLU",
      "value": "13",
    },
    {
      "text": "UA",
      "value": "14",
    },
    {
      "text": "UANS",
      "value": "15",
    },
  ];

  RangeValues leaveHistoryCountMinMax = const RangeValues(0, 500);
  double leaveHistoryCountMin = 0;
  double leaveHistoryCountrMax = 500;

  updateLeaveHistoryCount(RangeValues value) {
    leaveHistoryCountMinMax = value;
    leaveHistoryCountMin = value.start;
    leaveHistoryCountrMax = value.end;
    notifyListeners();
  }

  RangeValues leaveHistoryYearMinMax = const RangeValues(0, 10);
  double leaveHistoryYearMin = 0;
  double leaveHistoryYearMax = 10;

  updateLeaveHistoryYear(RangeValues value) {
    leaveHistoryYearMinMax = value;
    leaveHistoryYearMin = value.start;
    leaveHistoryYearMax = value.end;
    notifyListeners();
  }

  //Medical History
  TextEditingController diagnosis = TextEditingController();

  String iPDSelectedValue = "Select Type";
  List iPDData = [
    {
      "text": "Select Type",
      "value": "0",
    },
    {
      "text": "Self",
      "value": "1",
    },
    {
      "text": "Family",
      "value": "2",
    },
  ];

  RangeValues iPDCostMinMax = const RangeValues(0, 10000000);
  double iPDCostMin = 0;
  double iPDCostMax = 10000000;

  updateIPDCostMax(RangeValues value) {
    iPDCostMinMax = value;
    iPDCostMin = value.start;
    iPDCostMax = value.end;
    notifyListeners();
  }

  String oPDSelectedValue = "Select Type";
  List oPDData = [
    {
      "text": "Select Type",
      "value": "0",
    },
    {
      "text": "Self",
      "value": "1",
    },
    {
      "text": "Family",
      "value": "2",
    },
  ];

  RangeValues oPDCostMinMax = const RangeValues(0, 10000000);
  double oPDCostMin = 0;
  double oPDCostMax = 10000000;

  updateOPDCostMax(RangeValues value) {
    oPDCostMinMax = value;
    oPDCostMin = value.start;
    oPDCostMax = value.end;
    notifyListeners();
  }

  //3.1 Qualification -> Entry Mode
  List masterEntryModeIds = [];
  List masterEntryModeValues = [];
  List<MultiSelectItem> masterEntryModeFilterData = [];

  //3.2 Qualification -> Qualification
  List masterQualificationIds = [];
  List masterQualificationValues = [];
  List<MultiSelectItem> masterQualificationData = [];

  //3.3 Qualification -> Branch
  List masterBranchIds = [];
  List masterBranchValues = [];
  List<MultiSelectItem> masterBranchData = [];

  //3.4 Qualification -> Institute
  List masterInstituteIds = [];
  List masterInstituteValues = [];
  List<MultiSelectItem> masterInstituteData = [];

  //3.4 Qualification -> Recruitment
  List masterAreaOfRecruitmentIds = [];
  List masterAreaOfRecruitmentValues = [];
  List<MultiSelectItem> masterAreaOfRecruitmentData = [];

  //3.4 Training -> Training
  List masterTrainingIds = [];
  List masterTrainingValues = [];
  List<MultiSelectItem> masterTrainingData = [];
  String tranningStartDate = 'Start Date';
  String tranningEndDate = 'End Date';
  //manas Request

  double manasYearRequestMax = 0;
  double leaveSHistoryYearMax = 0;

  // General date search
  String dobmin = 'Date of Birth';
  String dobMax = 'Date of Birth';

  String reqDateFrom = "R Date From";
  String reqDateTo = "R Date To";

  String superannuationMin = 'DOS';
  String superannuationMax = 'DOS';

  String dojProjectMin = 'DOJ Project';
  String dojProjectMax = 'DOJ Project';

  String dOJDepartmentMin = 'DOJ Department';
  String dOJDepartmentMax = 'DOJ Department';

  String dOEGradeMin = 'DOE Grade';
  String dOEGradeMax = 'DOE Grade';

  //To show Dots for selected filter  Start

  //TO show Dots for selected filter End

  setRequiredFilterForOpenSearch(
      context, statusToClearAllFilterNotToDoRouting) {
    //Clear All Selected filter Values when open Open Search  Start

    totalFunExpMin = 0;
    totalFunExpMax = 0;
    totalFunExpMinTotalFunExpMax = const RangeValues(0, 45);
    totalLocExpMin = 0;
    totalLocExpMax = 0;
    totalLocExpMinTotalLocExpMax = const RangeValues(0, 45);
    generalAgeMinMax = const RangeValues(18, 60);
    generalAgeMin = 18;
    generalAgeMax = 60;
    isAgeSelected = false;
    generalBalanceServiceMinMax = const RangeValues(0, 45);
    generalBalanceMin = 0;
    generalBalanceMax = 45;
    isGeneralBalanceSelected = false;
    pHPerMinMax = const RangeValues(0, 100);
    pHPerMin = 0;
    pHPerMax = 100;
    leaveHistoryCountMinMax = const RangeValues(0, 500);
    leaveHistoryCountMin = 0;
    leaveHistoryCountrMax = 500;

    keyPositionHoldingAsOnDate = false;
    keyPositionHoldedInPast = false;
    leaveHistorySelectedValue = "Leave Type";
    iPDSelectedValue = "Select Type";
    oPDSelectedValue = "Select Type";
    dobmin = 'Date of Birth';
    dobMax = 'Date of Birth';
    superannuationMin = 'DOS';
    superannuationMax = 'DOS';
    dojProjectMin = 'DOJ Project';
    dojProjectMax = 'DOJ Project';
    dOJDepartmentMin = 'DOJ Department';
    dOJDepartmentMax = 'DOJ Department';
    dOEGradeMin = 'DOE Grade';
    dOEGradeMax = 'DOE Grade';
    tranningStartDate = 'Start Date';
    tranningEndDate = 'End Date';
    ridValue = '';
    typeListID = '';
    generalBalanceMin = 0;
    generalBalanceMax = 45;
    generalAgeMin = 18;
    generalAgeMax = 60;
    generalAgeMinMax = const RangeValues(18, 60);
    generalBalanceServiceMinMax = const RangeValues(0, 45);
    diagnosis.text = "";

    masterDepartmentGroupFilterValues.clear();
    masterDepartmentSubGroupFilterValues.clear();
    masterDepartmentFilterValues.clear();
    masterWorkProfileValues.clear();
    masterDepartmentExpEmpGroupValue = "";
    masterRegionValues.clear();
    masterProjectValues.clear();
    masterCategoryValues.clear();
    masterDepartmentDepartmentGroupFilterValues.clear();
    masterDepartmentDepartmentSubGroupFilterValues.clear();
    masterDepartmentDepartmentFilterValues.clear();
    masterDepartmentWorkProfileValues.clear();
    masterStatesValues.clear();
    masterEmployeeGroupValues.clear();
    masterGradeValues.clear();
    masterSubstantiveGradeValues.clear();
    masterLavelValues.clear();
    masterProjectCategoryValues.clear();
    masterCurrentProjectRegionValues.clear();
    masterCurrentProjectProjectValues.clear();
    masterCurrentProjectProjectLocationValues.clear();
    masterGenderSelectedValue = "";
    masterAssociationsCommitteesValues.clear();
    masterAssociationsMemberValues.clear();
    masterAssociationsFacultyValues.clear();
    masterInterestAwardInterestValues.clear();
    masterInterestAwardAchievementValues.clear();
    masterEntryModeValues.clear();
    masterQualificationValues.clear();
    masterBranchValues.clear();
    masterInstituteValues.clear();
    masterTrainingValues.clear();
    masterAreaOfRecruitmentValues.clear();

    manasYearRequestMax = 40;

    //Clear All Selected filter Values when open Open Search   END

    openSearchEmpDataMain.clear();
    openSearchEmpDataDummy.clear();
    //set OverAll Experience Section Filter Start

    mastDepartmentGroupFilter.clear();
    masterDepartmentSubGroupFilterDummyData.clear();
    masterDepartmentFilterDummyData.clear();

    //1.1 Overall Experience -> Functional Exp
    mastDepartmentGroupFilter = groupDepartmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['groupDeptName']);
      },
    ).toList();

    masterDepartmentSubGroupFilterDummyData = subDepartmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
      },
    ).toList();

    masterDepartmentFilterDummyData = departmentsF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
    }).toList();
    masterDepartmentExpEmpGroup.clear();
    masterDepartmentExpEmpGroup.addAll(empGroupF);

    //1.2 Overall Experience -> Regional/Location Exp.
    masterRegionFilterData = regionF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['regionName']);
    }).toList();

    masterProjectDummyData = projectF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();

    //set OverAll Experience Section Filter END

    //set General Filter Start Start
    mastCategoryFilter = categoryF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['categoryName']);
    }).toList();

    //general-> Current Project
    masterProjectCategoryFilterData = projectCategoryF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
    }).toList();
    masterCurrentProjectRegionDummyData = regionF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['regionName']);
    }).toList();
    masterCurrentProjectProjectFilterData = projectF.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();
    masterCurrentProjectProjectLocationDummyData = projectAreasF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['projectArea']);
      },
    ).toList();

    //general-> department

    masterDepartmentDepartmentGroupFilterData = groupDepartmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(
          subjectdataa,
          subjectdataa['groupDeptName'],
        );
      },
    ).toList();
    masterDepartmentDepartmentSubGroupFilterDummyData = subDepartmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
      },
    ).toList();
    masterDepartmentDepartmentFilterDummyData = departmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
      },
    ).toList();

    //general -> domicile
    masterDomicileFilterData = statesF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['stateName']);
      },
    ).toList();
    //general -> EMPGroup
    masterEmployeeGroupFilterData = empGroupF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['grade']);
      },
    ).toList();
    masterGradeFilterData = eEmpGradeF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['levelName']);
      },
    ).toList();

    // List masterSubstantiveGradeFilterDataDummy = [];

    // masterSubstantiveGradeFilterDataDummy.addAll(table32F.where(
    //     (value) => value['empl_Group'] == 'E' || value['empl_Group'] == 'W'));
    masterSubstantiveGradeFilterData = substantiveGradeF.map(
      (subjectdataa) {
        return MultiSelectItem(
            subjectdataa, subjectdataa['substantive_Grade_Text']);
      },
    ).toList();

    masterGeneralLevelFilterData = empLevelDesignationF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
      },
    ).toList();

    masterAssociationsCommitteesFilterData = committeesF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['text_val']);
      },
    ).toList();

    masterAssociationsMembersFilterData = membershipF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['text_val']);
      },
    ).toList();

    masterAssociationsFacultyFilterData = facultyF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['text_val']);
      },
    ).toList();

    masterInterestAwardInterestFilterData = interestsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['text_val']);
      },
    ).toList();

    masterInterestAwardAchievementFilterData = awardsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['text_val']);
      },
    ).toList();

    //Qalification Entry Mode

    masterEntryModeFilterData = entryModeF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
      },
    ).toList();
    //Qalification ->Qalification
    masterQualificationData = qualificationF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['qualification1']);
      },
    ).toList();

    //Qalification ->Branch
    masterBranchData = qualificationBranchF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['branchName']);
      },
    ).toList();

    //Qalification ->Institute
    masterInstituteData = institutesF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['institute']);
      },
    ).toList();
    masterAreaOfRecruitmentData = recruitmentsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['recruitment']);
      },
    ).toList();
    masterTrainingData = tranningsF.map(
      (subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['tranningName']);
      },
    ).toList();

    if (statusToClearAllFilterNotToDoRouting) {
      Navigator.pushNamed(context, '/open_search');
    }
  }

  String ridValue = '';
  String requestTypeDataToShowAsSelectedFilter = "";
  String typeListID = '';
  String typeListToShowSelectedValue = "";

  int currentPage = 1;
  int pageSize = 20;

  void loadMoreData(context, status) {
    applyMasterFilter(context, status);
  }

  void clearOpenSearchListData() {
    openSearchEmpDataMain.clear();
    openSearchEmpDataDummy.clear();
    currentPage = 1;
    pageSize = 20;
    totalRecord = 0;
    notifyListeners();
  }

  applyMasterFilter(context, status) {
    if (totalRecord == 0 || pageSize <= totalRecord) {
      masterDepartmentGroupFilterIds.clear();
      masterDepartmentSubGroupFilterIds.clear();
      masterDepartmentFilterIds.clear();
      masterWorkProfileIds.clear();

      masterRegionIds.clear();
      masterProjectIds.clear();

      masterCategoryIds.clear();
      masterDepartmentDepartmentGroupFilterIds.clear();
      masterDepartmentDepartmentSubGroupFilterIds.clear();
      masterDepartmentDepartmentFilterIds.clear();
      masterDepartmentWorkProfileIds.clear();

      masterProjectCategoryIds.clear();
      masterCurrentProjectRegionIds.clear();
      masterCurrentProjectProjectIds.clear();
      masterCurrentProjectProjectLocationIds.clear();

      masterStatesIds.clear(); // It is Domicile
      masterEmployeeGroupIds.clear(); //General->empgroup
      masterGradeIds.clear();
      masterSubstantiveGradeIds.clear();
      masterLavelIds.clear();
      masterAssociationsCommitteesIds.clear();
      masterAssociationsMemberIds.clear();
      masterAssociationsFacultyIds.clear();
      masterInterestAwardInterestIds.clear();
      masterInterestAwardAchievementIds.clear();
      masterEntryModeIds.clear();
      masterQualificationIds.clear();
      masterBranchIds.clear();
      masterInstituteIds.clear();
      masterTrainingIds.clear();
      masterAreaOfRecruitmentIds.clear();

      log("$masterDepartmentGroupFilterValues");

      //OverallExp
      for (int i = 0; i < masterDepartmentGroupFilterValues.length; i++) {
        masterDepartmentGroupFilterIds
            .add(masterDepartmentGroupFilterValues[i]['groupDeptCode']);
      }
      print(masterDepartmentGroupFilterIds);

      for (int i = 0; i < masterDepartmentSubGroupFilterValues.length; i++) {
        masterDepartmentSubGroupFilterIds
            .add(masterDepartmentSubGroupFilterValues[i]['subDeptCode']);
      }

      for (int i = 0; i < masterDepartmentFilterValues.length; i++) {
        masterDepartmentFilterIds
            .add(masterDepartmentFilterValues[i]['deptCode']);
      }

      log("message $masterWorkProfileValues");
      for (int i = 0; i < masterWorkProfileValues.length; i++) {
        masterWorkProfileIds.add(masterWorkProfileValues[i]['areaID']);
      }

      //Overall -> Regional

      for (int i = 0; i < masterRegionValues.length; i++) {
        masterRegionIds.add(
          masterRegionValues[i]['regionCode'].toInt(),
        );
      }

      for (int i = 0; i < masterProjectValues.length; i++) {
        masterProjectIds.add(masterProjectValues[i]['pid']);
      }

      //General

      for (int i = 0; i < masterCategoryValues.length; i++) {
        masterCategoryIds.add(masterCategoryValues[i]['categoryName']);
      }

      for (int i = 0;
          i < masterDepartmentDepartmentGroupFilterValues.length;
          i++) {
        masterDepartmentDepartmentGroupFilterIds.add(
            masterDepartmentDepartmentGroupFilterValues[i]['groupDeptCode']);
      }

      for (int i = 0;
          i < masterDepartmentDepartmentSubGroupFilterValues.length;
          i++) {
        masterDepartmentDepartmentSubGroupFilterIds.add(
            masterDepartmentDepartmentSubGroupFilterValues[i]['subDeptCode']);
      }

      for (int i = 0; i < masterDepartmentDepartmentFilterValues.length; i++) {
        masterDepartmentDepartmentFilterIds
            .add(masterDepartmentDepartmentFilterValues[i]['deptCode'].toInt());
      }

      for (int i = 0; i < masterDepartmentWorkProfileValues.length; i++) {
        masterDepartmentWorkProfileIds
            .add(masterDepartmentWorkProfileValues[i]['areaID']);
      }

      // Current Project

      for (int i = 0; i < masterProjectCategoryValues.length; i++) {
        masterProjectCategoryIds
            .add(masterProjectCategoryValues[i]['projectTypeID']);
      }
      for (int i = 0; i < masterCurrentProjectRegionValues.length; i++) {
        masterCurrentProjectRegionIds
            .add(masterCurrentProjectRegionValues[i]['regionCode'].toInt());
      }
      for (int i = 0; i < masterCurrentProjectProjectValues.length; i++) {
        masterCurrentProjectProjectIds
            .add(masterCurrentProjectProjectValues[i]['pid']);
      }
      for (int i = 0;
          i < masterCurrentProjectProjectLocationValues.length;
          i++) {
        masterCurrentProjectProjectLocationIds
            .add(masterCurrentProjectProjectLocationValues[i]['projectAreaID']);
      }

      //domicile
      for (int i = 0; i < masterStatesValues.length; i++) {
        masterStatesIds.add(masterStatesValues[i]['stateName']);
      }
      for (int i = 0; i < masterEmployeeGroupValues.length; i++) {
        masterEmployeeGroupIds.add(masterEmployeeGroupValues[i]['gradeCode']);
      }
      for (int i = 0; i < masterGradeValues.length; i++) {
        masterGradeIds.add(masterGradeValues[i]['levelCode']);
      }

      for (int i = 0; i < masterSubstantiveGradeValues.length; i++) {
        masterSubstantiveGradeIds
            .add(masterSubstantiveGradeValues[i]['substantive_Grade1']);
      }
      for (int i = 0; i < masterLavelValues.length; i++) {
        masterLavelIds.add(masterLavelValues[i]['id']);
      }

      for (int i = 0; i < masterAssociationsCommitteesValues.length; i++) {
        masterAssociationsCommitteesIds
            .add(masterAssociationsCommitteesValues[i]['text_val']);
      }

      for (int i = 0; i < masterAssociationsMemberValues.length; i++) {
        masterAssociationsMemberIds
            .add(masterAssociationsMemberValues[i]['text_val']);
      }

      for (int i = 0; i < masterAssociationsFacultyValues.length; i++) {
        masterAssociationsFacultyIds
            .add(masterAssociationsFacultyValues[i]['text_val']);
      }

      for (int i = 0; i < masterInterestAwardInterestValues.length; i++) {
        masterInterestAwardInterestIds
            .add(masterInterestAwardInterestValues[i]['id']);
      }

      for (int i = 0; i < masterInterestAwardAchievementValues.length; i++) {
        masterInterestAwardAchievementIds
            .add(masterInterestAwardAchievementValues[i]['id']);
      }

      // Qualification -> Entry Mode
      for (int i = 0; i < masterEntryModeValues.length; i++) {
        masterEntryModeIds.add(masterEntryModeValues[i]['textVal']);
      }
      // Qualification -> Qualification
      for (int i = 0; i < masterQualificationValues.length; i++) {
        masterQualificationIds
            .add(masterQualificationValues[i]['qualificationID']);
      }

      // Qualification -> Branch
      for (int i = 0; i < masterBranchValues.length; i++) {
        masterBranchIds.add(masterBranchValues[i]['branchID']);
      }
      // Qualification -> Branch
      for (int i = 0; i < masterInstituteValues.length; i++) {
        masterInstituteIds.add(masterInstituteValues[i]['instituteID']);
      }
      // Qualification -> Recuritment
      for (int i = 0; i < masterAreaOfRecruitmentValues.length; i++) {
        masterAreaOfRecruitmentIds
            .add(masterAreaOfRecruitmentValues[i]['recruitment']);
      }
      // Training
      for (int i = 0; i < masterTrainingValues.length; i++) {
        masterTrainingIds.add(masterTrainingValues[i]['tranningID']);
      }
      print("TYPE lilst $typeListID");
      //Required Data to apply Filter to master

      List phValue = [];

      if (masterPHHearing) {
        phValue.add("HEARING HANDICAP Onl");
      }
      if (masterPHOrtho) {
        phValue.add("ORTHO HANDICAP");
      }
      if (masterPHVisual) {
        phValue.add("VISUAL HANDICAP");
      }
      String finalVaueToSend = phValue.join(',');

      Map<String, String> openSearchRequiedFieldsToGetData = {
        'empName': searchUserByNameId,

        //Current Project Start
        'ProjectCatID': masterProjectCategoryIds.join(','),
        'RegionHQ': masterCurrentProjectRegionIds.join(','),
        'Project': masterCurrentProjectProjectIds.join(','),
        'Location': masterCurrentProjectProjectLocationIds.join(','),
        //Current Project End

        'Department_Group': masterDepartmentDepartmentGroupFilterIds.join(','),
        'Department_SubGroup':
            masterDepartmentDepartmentSubGroupFilterIds.join(','),
        'Department': masterDepartmentDepartmentFilterIds.join(','),
        'WorkProfile': masterDepartmentWorkProfileIds.join(','),

        'DobFrom': dobmin == "Date of Birth" ? '' : dobmin,
        'DobTo': dobMax == "Date of Birth" ? '' : dobMax,

        'DoJ_NtpcFrom': '', //blank
        'DoJ_NtpcTo': '', //blank

        "DoE_ProjectFrom": dojProjectMin == "DOJ Project"
            ? ''
            : dojProjectMin, //added from web
        "DoE_ProjectTo": dojProjectMax == "DOJ Project"
            ? ''
            : dojProjectMax, //added from web

        "DoE_DeptFrom": dOJDepartmentMin == "DOJ Department"
            ? ''
            : dOJDepartmentMin, //added from web
        "DoE_DeptTo": dOJDepartmentMax == "DOJ Department"
            ? ''
            : dOJDepartmentMax, //added from web

        'DoE_GradeFrom': dOEGradeMin == "DOE Grade" ? '' : dOEGradeMin,
        'DoE_GradeTo': dOEGradeMax == "DOE Grade" ? '' : dOEGradeMax,

        'DoE_LevelFrom': '', //blank
        'DoE_LevelTo': '', //blank

        "DoRetireFrom": superannuationMin == "DOS"
            ? ''
            : superannuationMin, //added from web
        "DoRetireTo": superannuationMax == "DOS"
            ? ''
            : superannuationMax, //added from web

        'Gender': masterGenderSelectedValue,
        'Caste_Category': masterCategoryIds.join(','),
        'Emp_Group': masterEmployeeGroupIds.join(','),
        'Emp_Grade': masterGradeIds.join(','),
        'Substantive_Grade': masterSubstantiveGradeIds.join(','),
        'Emp_Designation': masterLavelIds.join(','),
        'Emp_EntryMode': masterEntryModeIds.join(','),
        'PH': finalVaueToSend,
        // 'PH':
        //     "${masterPHHearing ? 'HEARING HANDICAP Onl' : ''} ${masterPHOrtho ? ',' : ''} ${masterPHOrtho ? 'ORTHO HANDICAP' : ''}${masterPHVisual ? ',' : ''}${masterPHVisual ? 'VISUAL HANDICAP' : ''}", // "s,s,s",
        'PH_PerFrom':
            "${pHPerMin.round() == 0 && pHPerMax.round() == 100 ? "0" : pHPerMin.round()}",
        'PH_PerTo':
            "${pHPerMin.round() == 0 && pHPerMax.round() == 100 ? "0" : pHPerMax.round()}",
        'Qual': masterQualificationIds.join(),
        'Branch': masterBranchIds.join(','),
        'Institute': masterInstituteIds.join(','),
        'Recuitment': masterAreaOfRecruitmentIds.join(','),
        'Domicile': masterStatesIds.join(','),
        'AgeMin': "${generalAgeMin.round()}",
        'AgeMax': "${generalAgeMax.round()}",
        'JobBalMin': "${generalBalanceMin.round()}",
        'JobBalMax': "${generalBalanceMax.round()}",
        'Awards': masterInterestAwardAchievementIds.join(','),
        'Interests': masterInterestAwardInterestIds.join(','),
        'Interest_Type': '',
        'Committies': masterAssociationsCommitteesIds
            .join(','), // issue not getting data as web
        'MemberShip': masterAssociationsMemberIds
            .join(','), // issue not getting data as web
        'faculty': masterAssociationsFacultyIds
            .join(','), // issue not getting data as web
        'TrainingName': masterTrainingIds.join(','),
        'TrainingDateFrom':
            tranningStartDate == 'Start Date' ? "" : tranningStartDate,
        'TrainingDateTo': tranningEndDate == 'End Date' ? "" : tranningEndDate,
        'OpdFor':
            oPDSelectedValue, //Medial history section OPD cost Select type with same value whice showing
        'OpdTotalCostMin':
            '${oPDCostMin.round() == 0 && oPDCostMax.round() == 10000000 ? "0" : oPDCostMin.round()}',
        'OpdTotalCostMax':
            '${oPDCostMin.round() == 0 && oPDCostMax.round() == 10000000 ? "0" : oPDCostMax.round()}',
        'IpdFor':
            iPDSelectedValue, //Medial history section IPD cost Select type with same value whice showing
        'IpdTotalCostMin':
            '${iPDCostMin.round() == 0 && iPDCostMax.round() == 10000000 ? "0" : iPDCostMin.round()}',
        'IpdTotalCostMax':
            '${iPDCostMin.round() == 0 && iPDCostMax.round() == 10000000 ? "0" : iPDCostMax.round()}',
        'DiagnosisFor':
            '${diagnosis.text}', //Medial history section Diagnosis text value
        'LeaveType':
            '$leaveHistorySelectedValue', // '$leaveHistorySelectedValue', //Need to send same text as value which is showing in drip down
        'TotalLeaveYear':
            ' ${leaveSHistoryYearMax.round()}', //single selection leave history years no range value
        'TotalLeaveMin':
            "${leaveHistoryCountrMax.round() == 500 && leaveHistoryCountMin.round() == 0 ? '0' : leaveHistoryCountMin.round()} ", //need to COnvert it in round
        'TotalLeaveMax':
            "${leaveHistoryCountrMax.round() == 500 && leaveHistoryCountMin.round() == 0 ? '0' : leaveHistoryCountrMax.round()}",
        'ManasRequestType': ridValue,
        'ManasGroundType': typeListID,
        'ManasTotalYears':
            '${manasYearRequestMax.round() == 40 ? "0" : manasYearRequestMax.round()}',
        'EmpGroupExpIDs': masterDepartmentExpEmpGroupValue,
        'WorkProfileIDs': masterWorkProfileIds.join(','),
        'DepartmentIDs': masterDepartmentFilterIds.join(','),
        'DeptSubIds': masterDepartmentSubGroupFilterIds.join(','),
        'DeptGroupIds': masterDepartmentGroupFilterIds.join(','),
        'TotalFunExpMin': '${totalFunExpMin.round()}',
        'TotalFunExpMax': '${totalFunExpMax.round()}',
        'LocExpRegionIDs': masterRegionIds.join(','),
        'LocExpProjectIDs': masterProjectIds.join(','),
        'TotalLocExpMin': '${totalLocExpMin.round()}',
        'TotalLocExpMax': '${totalLocExpMax.round()}',
        'RegExpRegionIDs': '', //blank
        'TotalRegExpMin': '0', //blank
        'TotalRegExpMax': '0', //blank
        'ProjCat_ExpIDs': '', //blank
        'TotalProjCatExpMin': '0', //blank
        'TotalProjCatExpMax': '0', //blank
        'isVigilanceinclude': '0',
        'isHeldKeyPosition':
            (keyPositionHoldingAsOnDate && keyPositionHoldedInPast)
                ? '3'
                : keyPositionHoldingAsOnDate
                    ? '1'
                    : keyPositionHoldedInPast
                        ? '2'
                        : '0',
        'Vigilance': masterVigilanceSelectedValue,
        'UserID': '$empCode',
        'UserRole': userRole,
        'ProjectType': empProjectType.toString(),
        'RegionID': empRegionID.toString(),
        'SortBy': sortByValue,
        'CurrentPage': currentPage.toString(),
        'PagingSize': '20',
        'TotalRecord': '0'
      };

      log(json.encode(openSearchRequiedFieldsToGetData));
      pageSize += 20;
      currentPage++;
      getOpenSearchEmpData(context, openSearchRequiedFieldsToGetData, status);
    } else {
      print("Else part");
    }
  }

  // Master Filter Section For Multi Selection End ->  Key-> Master1

  //SPV Analysis Set required Filters

  List<MultiSelectItem> spvDeptType = [];
  List spvDeptTypeIds = [];
  List spvDeptTypeValues = [];

  List<MultiSelectItem> spvDept = [];
  List spvDeptIds = [];
  List spvDeptValues = [];

  List projectCategoryFilterIds = [];
  List gradeFilterIds = [];
  List deptFilterIds = [];
  String grandFilterValue = "";
  String spv_Dept_Type = "";
  String spv_Dept_title = "";
  setSpvAnalysisRequiredFilters(context, type, requiredDataForFilter,
      statusForRouting, isClearingApplyedFilter) {
    grandFilterValue = requiredDataForFilter['Grade'];
    spv_Dept_Type = requiredDataForFilter['Spv_Dept_Type'];
    // spv_Dept_title=requiredDataForFilter['Spv_Dept_Type'];

    print("grandFilterValue123 $requiredDataForFilter");

    if (statusForRouting) {
      // masterRegionValues.clear();
      // masterProjectValues.clear();
      // projectCategoryFilterValues.clear();
      // gradeFilterValues.clear();
      // spvDeptTypeValues.clear();
      // spvDeptValues.clear();
      // deptFilterValues.clear();

      masterRegionFilterData = regionF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['regionName']);
      }).toList();

      masterProjectDummyData = projectF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
      }).toList();

      spvDept = spVDeptF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
      }).toList();

      spvDeptType = spVDeptTypeF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
      }).toList();

      masterDepartmentFilterDummyData = departmentsF.map((subjectdataa) {
        return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
      }).toList();
    }

    if (type == 1) {
      getSPVAnalysisRegionData(context, requiredDataForFilter, statusForRouting,
          isClearingApplyedFilter);
    } else if (type == 2) {
      getSPVAnalysisProjectData(context, requiredDataForFilter,
          statusForRouting, isClearingApplyedFilter);
    } else if (type == 3) {
      getSPVAnalysisProjectDeptTypeData(context, requiredDataForFilter,
          statusForRouting, isClearingApplyedFilter);
    } else if (type == 4) {
      log("Final data to get res $requiredDataForFilter");

      getSPVAnalysisProjectDeptTypeDeptData(context, requiredDataForFilter,
          statusForRouting, isClearingApplyedFilter);
    }
  }

  bool isFunctionalExp = false;
  reOpenMasterFilterScreen(context) {
    isFunctionalExp = false;
    CommanDialog.hideLoading(context);
    Navigator.pushNamed(context, "/open_search_filter");
  }

  clearFilterValues(context, status) {
    totalFunExpMin = 0;
    totalFunExpMax = 0;
    totalFunExpMinTotalFunExpMax = const RangeValues(0, 45);

    totalLocExpMin = 0;
    totalLocExpMax = 0;
    totalLocExpMinTotalLocExpMax = const RangeValues(0, 45);

    generalAgeMinMax = const RangeValues(18, 60);
    generalAgeMin = 18;
    generalAgeMax = 60;
    isAgeSelected = false;

    generalBalanceServiceMinMax = const RangeValues(0, 45);
    generalBalanceMin = 0;
    generalBalanceMax = 45;
    isGeneralBalanceSelected = false;

    pHPerMinMax = const RangeValues(0, 100);
    pHPerMin = 0;
    pHPerMax = 100;

    leaveHistoryCountMinMax = const RangeValues(0, 500);
    leaveHistoryCountMin = 0;
    leaveHistoryCountrMax = 500;

    masterGenderSelectedValue = "";
    keyPositionHoldingAsOnDate = false;
    keyPositionHoldedInPast = false;
    leaveHistorySelectedValue = "Leave Type";
    iPDSelectedValue = "Select Type";
    oPDSelectedValue = "Select Type";
    dobmin = 'Date of Birth';
    dobMax = 'Date of Birth';
    superannuationMin = 'DOS';
    superannuationMax = 'DOS';
    dojProjectMin = 'DOJ Project';
    dojProjectMax = 'DOJ Project';
    dOJDepartmentMin = 'DOJ Department';
    dOJDepartmentMax = 'DOJ Department';
    dOEGradeMin = 'DOE Grade';
    dOEGradeMax = 'DOE Grade';
    tranningStartDate = 'Start Date';
    tranningEndDate = 'End Date';
    ridValue = '';
    diagnosis.text = "";
    typeListID = '';

    masterDepartmentGroupFilterValues.clear();
    masterDepartmentSubGroupFilterValues.clear();
    masterDepartmentFilterValues.clear();
    masterWorkProfileValues.clear();
    masterDepartmentExpEmpGroupValue = "";
    masterRegionValues.clear();
    masterProjectValues.clear();
    masterCategoryValues.clear();

    masterDepartmentDepartmentGroupFilterValues.clear();
    masterDepartmentDepartmentSubGroupFilterValues.clear();
    masterDepartmentDepartmentFilterValues.clear();
    masterDepartmentWorkProfileValues.clear();
    masterStatesValues.clear();
    masterEmployeeGroupValues.clear();
    masterGradeValues.clear();
    masterSubstantiveGradeValues.clear();
    masterLavelValues.clear();

    masterAssociationsCommitteesValues.clear();
    masterAssociationsMemberValues.clear();
    masterAssociationsFacultyValues.clear();
    masterInterestAwardInterestValues.clear();
    masterInterestAwardAchievementValues.clear();
    masterEntryModeValues.clear();
    masterQualificationValues.clear();
    masterBranchValues.clear();
    masterInstituteValues.clear();
    masterAreaOfRecruitmentValues.clear();
    masterTrainingValues.clear();
    masterProjectCategoryValues.clear();
    masterCurrentProjectRegionValues.clear();
    masterCurrentProjectProjectValues.clear();
    masterCurrentProjectProjectLocationValues.clear();
    masterPHHearing = false;
    masterPHOrtho = false;
    masterPHVisual = false;

    applyMasterFilter(context, status);
  }

  // E market place -> Manage Job start

  Map jobDetailsData = {};
  List applyDetailsData = [];
  Future<void> viewJobDetails(context, id) async {
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/Job_Applicant_Details'));
    request.fields.addAll({'JobID': '$id', 'EmpID': '$empCode'});
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        CommanDialog.hideLoading(context);
        Map data = json.decode(
          await response.stream.bytesToString(),
        );
        if (data['code'] == 200) {
          jobDetailsData = data['data']['jobDetails'][0];
          applyDetailsData.clear();
          applyDetailsData = data['data']['applyDetails'];
          print("RESULT $jobDetailsData");
          Navigator.pushNamed(context, "/search_job_view_details");
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> withdrawApplication(context, id) async {
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiBaseUrl/Main/Job_Applied_Withdraw'),
    );
    request.fields.addAll({'JobID': '$id', 'EmpID': '$empCode'});
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        CommanDialog.hideLoading(context);
        Map data = json.decode(
          await response.stream.bytesToString(),
        );
        if (data['code'] == 200) {
          print(data);
          Navigator.pop(context);
          if (data['data'][0]['isWithdraw'] == 1) {
            CommanDialog.showErrorDialog(context,
                description: "Application is withdraw successfully");
          } else if (data['data'][0]['isWithdraw'] == -1) {
            CommanDialog.showErrorDialog(context,
                description: "You can not withdraw this Application");
          } else if (data['data'][0]['isWithdraw'] == -2) {
            CommanDialog.showErrorDialog(context,
                description: "You did not applied for  this Application");
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);
      CommanDialog.showErrorDialog(context, description: "$error");
    }
  }

  Map<String, String> eMarketPalceManageJob_Post_filter_value = {
    'SearchID': '',
    'SearchTitle': '',
    'Region': '0',
    'Project': '0',
    'Location': '0',
    'Department_Group': '0',
    'Department_SubGroup': '0',
    'Department': '0',
    'isKeyPosition': '-1',
    'SortBy': '',
    'CurrentPage': '1',
    'PagingSize': '20000'
  };

  Map eMarketPlaceManageJobSummaryData = {
    "tv": "",
    "ov": "",
    "cv": "",
    "okpv": ""
  };

  // Manage Job filters lists
  List mJKeyPositionList = [];
  List mJRegionList = [];
  List mJProjectList = [];
  List mJLocationList = [];
  List mJDepartmentGroupList = [];
  List mJDepartmentSubGroupList = [];
  List mJDepartmentList = [];

  List regionNewList = [];
  List projectNewList = [];
  List locationNewList = [];
  List departGroupNewList = [];
  List departSubGroupNewList = [];
  List departmentNewList = [];

  final items1 = ["All", 'Yes', 'No'];
  String selectedValue1 = '';
  String selectedRegionValue = '';
  String selectedProjectCatValue = '';
  String selectedLocationValue = '';
  String selectedDepartGroupValue = '';
  String selectedDepartSubGroupValue = '';
  String selectedDepartmentValue = '';
  TextEditingController byTitle = TextEditingController();

  List eMarketPalceManageJobDataList = [];
  List eMarketPalceManageJobDataSearch = [];
  Future<void> getEMarketPalceManageJobDataNew(
      context, data, status, routingStatus) async {
    statusForshowKeyPositionMonitoringDataOrProjectionData = false;
    // notifyListeners();
    eMarketPalceManageJobDataList.clear();
    eMarketPalceManageJobDataList.clear();

    if (isOfflineData) {
      print("Get Data from offline mode");
      setKeyPositionFilterForOfflineMode();
      List result = await dataBaseHelper.getManageJobListing('jobPost_Details');

      eMarketPlaceManageJobSummaryData["tv"] = '10';
      eMarketPlaceManageJobSummaryData["cv"] = '20';
      eMarketPlaceManageJobSummaryData["okpv"] = '5';
      eMarketPalceManageJobDataSearch.addAll(result);
      eMarketPalceManageJobDataList.addAll(result);

      print(eMarketPalceManageJobDataList[0]);

      if (status || routingStatus) {
        CommanDialog.hideLoading(context);
      }
      if (routingStatus) {
        Navigator.pushNamed(context, '/e_market_place_manage_job');
      }

      notifyListeners();
    } else {
      if (status || routingStatus) {
        CommanDialog.showLoading(context);
      }

      regionNewList.clear();
      locationNewList.clear();
      projectNewList.clear();
      departGroupNewList.clear();
      departSubGroupNewList.clear();
      departmentNewList.clear();

      mJKeyPositionList.clear();
      mJRegionList.clear();
      mJProjectList.clear();
      mJLocationList.clear();
      mJDepartmentGroupList.clear();
      mJDepartmentSubGroupList.clear();
      mJDepartmentList.clear();

      byTitle.text = '';
      selectedValue1 = '';
      selectedRegionValue = '';
      selectedProjectCatValue = '';
      selectedLocationValue = '';
      selectedDepartGroupValue = '';
      selectedDepartSubGroupValue = '';
      selectedDepartmentValue = '';

      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Job_Admin_Search'));
      request.fields.addAll(data);
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());
          if (data['code'] == 200) {
            eMarketPlaceManageJobSummaryData["tv"] = data['totalRecord'];
            eMarketPlaceManageJobSummaryData["cv"] = data['closeJob'];
            eMarketPlaceManageJobSummaryData["okpv"] = data['totalKeyPostion'];
            eMarketPalceManageJobDataSearch.addAll(data['data']);
            eMarketPalceManageJobDataList.addAll(data['data']);
            // print("eMarketResponse eMarketPalceManageJobDataList.length");
            if (status || routingStatus) {
              CommanDialog.hideLoading(context);
            }
            if (routingStatus) {
              Navigator.pushNamed(context, '/e_market_place_manage_job');
            }

            notifyListeners();
          } else {
            if (status || routingStatus) {
              CommanDialog.hideLoading(context);
            }
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        if (status || routingStatus) {
          CommanDialog.hideLoading(context);
        }
        print("Error $error");
      }
    }
  }

  Future<void> getEMarketPalceManageJobDataNew1(
      context, filterData, status) async {
    eMarketPalceManageJobDataList.clear();
    eMarketPalceManageJobDataSearch.clear();
    if (isOfflineData) {
      if (filterData['SearchID'] == "" &&
          filterData['SearchTitle'] == "" &&
          filterData['Region'] == "" &&
          filterData['Project'] == "" &&
          filterData['Location'] == "" &&
          filterData['Department_Group'] == "" &&
          filterData['Department_SubGroup'] == "" &&
          filterData['Department'] == "") {
        List result =
            await dataBaseHelper.getManageJobListing('jobPost_Details');
        eMarketPalceManageJobDataSearch.addAll(result);
        eMarketPalceManageJobDataList.addAll(result);
        notifyListeners();
      } else {
        List filteredData =
            await dataBaseHelper.getMangeJobOfflineDataAfterApplyingFilter(
                jobPost_Details, filterData);
        eMarketPalceManageJobDataSearch.addAll(filteredData);
        eMarketPalceManageJobDataList.addAll(filteredData);

        notifyListeners();
      }
    } else {
      CommanDialog.showLoading(context);
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Job_Admin_Search'));
      request.fields.addAll(filterData);
      request.headers.addAll(headers);

      try {
        http.StreamedResponse response = await request.send();
        print("RESULT $response");
        if (response.statusCode == 200) {
          CommanDialog.hideLoading(context);
          if (status) {
            CommanDialog.hideLoading(context);
          }

          Map data = json.decode(await response.stream.bytesToString());
          if (data['code'] == 200) {
            eMarketPlaceManageJobSummaryData["tv"] = data['totalRecord'];
            eMarketPlaceManageJobSummaryData["cv"] = data['closeJob'];
            eMarketPlaceManageJobSummaryData["okpv"] = data['totalKeyPostion'];
            eMarketPalceManageJobDataSearch.addAll(data['data']);
            eMarketPalceManageJobDataList.addAll(data['data']);
            print("APIRESPONSE1 $data");
            notifyListeners();
          } else {
            print("API RESPONSE $data");
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        print("Error $error");
      }
    }
  }

  // Job Search

  publishedJobsSearch(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = eMarketPalceManageJobDataSearch;
    } else {
      results = eMarketPalceManageJobDataSearch.where((user) {
        return user["title"]
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    print("resulr $results");
    eMarketPalceManageJobDataList = results;
    notifyListeners();
  }

  // View Details

  Map mJobDetailData = {};

  Future<void> getMjItemDetail(
      context, Map<String, String> requiedRequestData) async {
    mJobDetailData.clear();

    print("Required Data $requiedRequestData");

    if (isOfflineData) {
      print("Please get data from offline");
      List result = await dataBaseHelper.getMangeJobDetails(
          jobPost_Details, requiedRequestData['PositionID'], 'jobID');

      List projectExp = await dataBaseHelper.getMangeJobDetails(
          'jobPost_Project_Exp',
          requiedRequestData['PositionID'],
          'positionID');
      List jobPost_Role_Exp = await dataBaseHelper.getMangeJobDetails(
          'jobPost_Role_Exp', requiedRequestData['PositionID'], 'positionID');

      List entryModeExp = await dataBaseHelper.getMangeJobDetails(
          'jobPost_EntryMode_Exp',
          requiedRequestData['PositionID'],
          'positionID');

      List gradeExp = await dataBaseHelper.getMangeJobDetails(
          'jobPost_Grade_Exp', requiedRequestData['PositionID'], 'positionID');

      List departmentExp = await dataBaseHelper.getMangeJobDetails(
          'jobPost_Department_Exp',
          requiedRequestData['PositionID'],
          'positionID');
      mJobDetailData["jobDetails"] = result;
      mJobDetailData["projectExp"] = projectExp;
      mJobDetailData['roleExp'] = jobPost_Role_Exp;
      mJobDetailData['entryModeExp'] = entryModeExp;
      mJobDetailData['gradeExp'] = gradeExp;
      mJobDetailData['departmentExp'] = departmentExp;

      log("message  ${mJobDetailData['projectExp']}");

      Navigator.pushNamed(context, '/view_details_mj');
    } else {
      CommanDialog.showLoading(context);
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/JobPost_Details_All'));
      request.fields.addAll(requiedRequestData);
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response = await request.send();
        CommanDialog.hideLoading(context);
        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());

          if (data['code'] == 200) {
            mJobDetailData.addAll(data['data']);
            Navigator.pushNamed(context, '/view_details_mj');
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
        }
      } catch (error) {
        CommanDialog.hideLoading(context);
        print("Error $error");
      }
    }
  }

// E market place -> Manage Job end

// E market place -> Search Job Start

  final applied = ["All", 'Applied', 'Not Applied'];
  String appliedValue = '';

  Map<String, String> eMarketPalceSearch_job_value = {
    'SearchTitle': '',
    'Region': '0',
    'Project': '0',
    'Location': '0',
    'Department_Group': '0',
    'Department_SubGroup': '0',
    'Department': '0',
    'isKeyPosition': '-1',
    'SortBy': '',
    'CurrentPage': '1',
    'isJobApplied': '0'
  };

  String eMarketPlaceSearchJobSummaryData = "";
  dynamic totalApplicantCount = "";

  List eMarketPlaceSearchJobDataList = [];
  List eMarketPlaceSearchJobDataSearch = [];
  Future<void> getEMarketPlaceSearchJobDataNew(
      context, data, userID, status, routingStatus) async {
    statusForshowKeyPositionMonitoringDataOrProjectionData = false;
    notifyListeners();
    if (status || routingStatus) {
      CommanDialog.showLoading(context);
    }
    eMarketPlaceSearchJobDataList.clear();
    eMarketPlaceSearchJobDataSearch.clear(); //1

    regionNewList.clear();
    locationNewList.clear();
    projectNewList.clear();
    departGroupNewList.clear();
    departSubGroupNewList.clear();
    departmentNewList.clear();

    mJKeyPositionList.clear();
    mJRegionList.clear();
    mJProjectList.clear();
    mJLocationList.clear();
    mJDepartmentGroupList.clear();
    mJDepartmentSubGroupList.clear();
    mJDepartmentList.clear();
    appliedValue = '';
    byTitle.text = '';
    selectedValue1 = '';
    selectedRegionValue = '';
    selectedProjectCatValue = '';
    selectedLocationValue = '';
    selectedDepartGroupValue = '';
    selectedDepartSubGroupValue = '';
    selectedDepartmentValue = '';
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/Job_Applicant_Search'));
    request.fields.addAll({'EmpID': userID});
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          eMarketPlaceSearchJobSummaryData = data['totalRecord'];
          totalApplicantCount = data['totalApplicant'];
          eMarketPlaceSearchJobDataSearch.addAll(data['data']);
          eMarketPlaceSearchJobDataList.addAll(data['data']);
          log("Data ${data['data']}");
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          if (routingStatus) {
            Navigator.pushNamed(context, '/search_job_home_screen');
          }

          notifyListeners();
        } else {
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        if (status || routingStatus) {
          CommanDialog.hideLoading(context);
        }
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      if (status || routingStatus) {
        CommanDialog.hideLoading(context);
      }
      print("Error $error");
    }
  }

  Future<void> getEMarketPlaceSearchJobDataNew1(
      context, filterData, userId, status) async {
    CommanDialog.showLoading(context);
    eMarketPlaceSearchJobDataList.clear();
    eMarketPlaceSearchJobDataSearch.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/Job_Applicant_Search'));
    request.fields.addAll({'EmpID': userId});
    request.fields.addAll(filterData);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print("RESULT $response");
      if (response.statusCode == 200) {
        CommanDialog.hideLoading(context);
        if (status) {
          CommanDialog.hideLoading(context);
        }

        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          eMarketPlaceSearchJobSummaryData = data['totalRecord'];
          totalApplicantCount = data['totalApplicant'];
          eMarketPlaceSearchJobDataSearch.addAll(data['data']);
          eMarketPlaceSearchJobDataList.addAll(data['data']);
          print("APIRESPONSE1 $data");
          notifyListeners();
        } else {
          print("API RESPONSE $data");
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  publishedSearchJobsSearch(String enteredKeyword) {
    print("Search value  $eMarketPlaceSearchJobDataSearch");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = eMarketPlaceSearchJobDataSearch;
    } else {
      results = eMarketPlaceSearchJobDataSearch.where((user) {
        return user["title"].toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ) ||
            user["jobID"].toString().contains(
                  enteredKeyword,
                );
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    print("resulr $results");
    eMarketPlaceSearchJobDataList = results;
    notifyListeners();
  }

  // Apply for this vacancy

  Future<void> applyForThisVacancy(context, Map vacancyInfo) async {
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/Job_Applied_InsUpd'));
    request.headers.addAll(headers);
    request.fields.addAll({
      'ApplicantID': "${vacancyInfo['ApplicantID']}",
      'JobID': "${vacancyInfo['JobID']}",
      'EmpID': "${vacancyInfo['EmpID']}",
      'Document_Title': '${vacancyInfo['Document_Title']}',
      'DocumentPath': '${vacancyInfo['DocumentPath']}',
      'Expertise': '${vacancyInfo['Expertise']}',
      'Descriptions': '${vacancyInfo['Descriptions']}',
      "fileBytes": ""
    });
    try {
      http.StreamedResponse response = await request.send();
      CommanDialog.hideLoading(context);

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
          if (data['data'][0]['applicantID'] != -1) {
            CommanDialog.showErrorDialog(context,
                description: "You have applied for this applicatoin");
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

// E market place -> Search Job end

// Job Rotation start

  final jrSearchBy = ['Department Subgroup', 'Department'];

  RangeValues totalExpMinMaxJobRotation = const RangeValues(0, 0);
  double totalJrExpMin = 0;
  double totalJrExpMax = 0;

  updateTotalExpMinMaxJobRotation(RangeValues value) {
    totalExpMinMaxJobRotation = value;
    totalJrExpMin = value.start;
    totalJrExpMax = value.end;
    notifyListeners();
  }

  Map<String, String> jobRotation_value = {
    'SearchBy': 'DEPTGROUP',
    'Region': '0',
    'Project': '0',
    'Location': '0',
    'Department_Group': '0',
    'Department_SubGroup': '0',
    'Department': '0',
    'Level': '0',
    'TotalExpMin': '0',
    'TotalExpMax': '0'
  };

  List jobRotationDataList = [];
  List jobRotationDataListSearch = [];
  Future<void> getJobRotationDataList(
      context, data, status, routingStatus) async {
    notifyListeners();
    if (status || routingStatus) {
      CommanDialog.showLoading(context);
    }
    jobRotationDataList.clear();

    totalJrExpMin = 0;
    totalJrExpMax = 0;
    totalExpMinMaxJobRotation = const RangeValues(0, 0);
    regionNewList.clear();
    locationNewList.clear();
    projectNewList.clear();
    departGroupNewList.clear();
    departSubGroupNewList.clear();
    departmentNewList.clear();

    mJKeyPositionList.clear();
    mJRegionList.clear();
    mJProjectList.clear();
    mJLocationList.clear();
    mJDepartmentGroupList.clear();
    mJDepartmentSubGroupList.clear();
    mJDepartmentList.clear();
    appliedValue = '';
    byTitle.text = '';
    selectedValue1 = '';
    selectedRegionValue = '';
    selectedProjectCatValue = '';
    selectedLocationValue = '';
    selectedDepartGroupValue = '';
    selectedDepartSubGroupValue = '';
    selectedDepartmentValue = '';
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/JobRotation_Search_Post'));
    request.fields.addAll(data);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          jobRotationDataList.addAll(data['data']);
          jobRotationDataListSearch.addAll(data['data']);
          log("Data ${data['data']}");
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          if (routingStatus) {
            Navigator.pushNamed(context, '/job_rotation');
          }

          notifyListeners();
        } else {
          if (status || routingStatus) {
            CommanDialog.hideLoading(context);
          }
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        if (status || routingStatus) {
          CommanDialog.hideLoading(context);
        }
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      if (status || routingStatus) {
        CommanDialog.hideLoading(context);
      }
      print("Error $error");
    }
  }

  Future<void> getJobRotationDataList1(context, filterData, status) async {
    notifyListeners();
    CommanDialog.showLoading(context);
    jobRotationDataList.clear();
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/JobRotation_Search_Post'));
    request.fields.addAll(filterData);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print("RESULT $response");
      if (response.statusCode == 200) {
        CommanDialog.hideLoading(context);
        if (status) {
          CommanDialog.hideLoading(context);
        }

        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          jobRotationDataList.addAll(data['data']);
          jobRotationDataListSearch.addAll(data['data']);
          print("APIRESPONSE1 $data");
          notifyListeners();
        } else {
          print("API RESPONSE $data");
          CommanDialog.showErrorDialog(context, description: "$data");
        }
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  publishedJobRotationSearch(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = jobRotationDataListSearch;
    } else {
      results = jobRotationDataListSearch.where((user) {
        return user["firstName"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            user["location"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()) ||
            user["designation"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase());
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    print("resulr $results");
    jobRotationDataList = results;
    notifyListeners();
  }

// Job Rotation end

  /// OPen Files

  void commonMethodForNTPCSafetyOpenPDF(url) async {
    print("_url $url");
    try {
      final Uri urlTwitter = Uri.parse(url);
      await launchUrl(
        urlTwitter,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print("Error $e");
    }
  }

  Future<bool> isUserLogedIn() async {
    isDeviceInfo();
    final _storage = const FlutterSecureStorage();

    final readDta = await _storage.read(key: 'ntpctwo_isuser_login');

    if (readDta != null) {
      final userInfo = json.decode(readDta);
      empCode = userInfo['empCode'];
      accessToken = userInfo['accessToken'];
      userRole = userInfo['userRole'];
      empRegionID = userInfo['empRegionID'];
      empProjectType = userInfo['empProjectType'];
      isManasReportShow = userInfo['isManasReportShow'];

      return true;
    } else {
      return false;
    }
  }

  getIsInOfflineModeOrOnlineMode() async {
    final _storage = const FlutterSecureStorage();
    final getIsUserOfflineORNot =
        await _storage.read(key: 'isUserOfflineNTPCDelphi');
    print("getIsUserOfflineORNot $getIsUserOfflineORNot");
    if (getIsUserOfflineORNot != null) {
      Map data = json.decode(getIsUserOfflineORNot);
      if (data['isUserOffline']) {
        isOfflineData = true;
        notifyListeners();
        return true;
      } else {
        isOfflineData = false;
        notifyListeners();
        return false;
      }
    } else {
      isOfflineData = false;
      notifyListeners();
      return false;
    }
  }

  isUserDownloadedData() async {
    final _storage = const FlutterSecureStorage();
    final readDta = await _storage.read(key: 'dateOfLastDownloadedDataOffline');
    if (readDta != null) {
      dateOfLastDownloadedDataOffline = readDta;
      print("Yes Date avilable $dateOfLastDownloadedDataOffline");
      notifyListeners();
    }
  }

  updateOfflineDateWhileDownloadDataOffline(String date) {
    dateOfLastDownloadedDataOffline = date;
    notifyListeners();
  }

  //Offline

  DataBaseHelper dataBaseHelper = DataBaseHelper();

  insetFilterDataInTabls() {
    print("insetFilterDataInTabls calling");
    //Insert Departments Data
    List departmentsFilterTableData = [];
    for (int i = 0; i < departmentsF.length; i++) {
      Map<String, dynamic> depTableData = {
        "deptCode": departmentsF[i]['deptCode'],
        "deptName": departmentsF[i]['deptName'],
        "subDeptCode": departmentsF[i]['subDeptCode'],
        "groupDeptCode": departmentsF[i]['groupDeptCode']
      };
      departmentsFilterTableData.add(depTableData);
    }
    print(departmentsFilterTableData.length);
    dataBaseHelper.insertDepartments("departments", departmentsFilterTableData);

    // subDepartments Table Start
    List subDepartmentsFilterTableData = [];
    for (int i = 0; i < subDepartmentsF.length; i++) {
      Map<String, dynamic> depTableData = {
        "subDeptCode": subDepartmentsF[i]['subDeptCode'],
        "subDeptName": subDepartmentsF[i]['subDeptName'],
        "groupDeptCode": subDepartmentsF[i]['groupDeptCode'],
      };
      subDepartmentsFilterTableData.add(depTableData);
    }
    print(departmentsFilterTableData.length);
    dataBaseHelper.insertDepartments(
        "SubDepartments", subDepartmentsFilterTableData);

    // groupDepartments Table Start
    List groupDepartmentsFilterTableData = [];
    for (int i = 0; i < groupDepartmentsF.length; i++) {
      Map<String, dynamic> depTableData = {
        "groupDeptCode": groupDepartmentsF[i]['groupDeptCode'],
        "groupDeptName": groupDepartmentsF[i]['groupDeptName'],
      };
      groupDepartmentsFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments(
        "groupDepartments", groupDepartmentsFilterTableData);

    // region Table Start
    List regionFilterTableData = [];
    for (int i = 0; i < regionF.length; i++) {
      Map<String, dynamic> depTableData = {
        "regionCode": regionF[i]['regionCode'],
        "regionName": regionF[i]['regionName'],
      };
      regionFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments("Region", regionFilterTableData);

    // projectCategory Table Start
    List projectCategoryFilterTableData = [];
    for (int i = 0; i < projectCategoryF.length; i++) {
      Map<String, dynamic> depTableData = {
        "projectTypeID": projectCategoryF[i]['projectTypeID'],
        "projectType": projectCategoryF[i]['projectType'],
      };
      projectCategoryFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments(
        "ProjectCategory", projectCategoryFilterTableData);

    // project Table Start
    List projectFilterTableData = [];
    for (int i = 0; i < projectF.length; i++) {
      Map<String, dynamic> depTableData = {
        "pid": projectF[i]['pid'],
        "pCategory": projectF[i]['pCategory'],
        "regionID": projectF[i]['regionID'],
        "projectCategory": projectF[i]['projectCategory'],
      };
      projectFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments("Project", projectFilterTableData);

    // projectAreas Table Start
    List projectAreasFilterTableData = [];
    for (int i = 0; i < projectAreasF.length; i++) {
      Map<String, dynamic> depTableData = {
        "projectAreaID": projectAreasF[i]['projectAreaID'],
        "projectArea": projectAreasF[i]['projectArea'],
        "projectID": projectAreasF[i]['projectID'],
        "regionID": projectAreasF[i]['regionID'],
        "projectCategory": projectAreasF[i]['projectCategory'],
      };
      projectAreasFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments(
        "ProjectAreas", projectAreasFilterTableData);

    // e_EmpGrade Table Start
    List e_EmpGradeFilterTableData = [];

    log("eEmpGradeF $eEmpGradeF");
    for (int i = 0; i < eEmpGradeF.length; i++) {
      Map<String, dynamic> depTableData = {
        "levelCode": eEmpGradeF[i]['levelCode'],
        "levelName": eEmpGradeF[i]['levelName'],
        "empGrp_Code": eEmpGradeF[i]['empGrp_Code'],
      };
      e_EmpGradeFilterTableData.add(depTableData);
    }
    print("e_EmpGradeFilterTableData $e_EmpGradeFilterTableData");
    dataBaseHelper.insertDepartments("e_EmpGrade", e_EmpGradeFilterTableData);

    // empLevel_Designation Table Start
    List empLevel_DesignationFilterTableData = [];
    for (int i = 0; i < empLevelDesignationF.length; i++) {
      Map<String, dynamic> depTableData = {
        "id": empLevelDesignationF[i]['id'],
        "textVal": empLevelDesignationF[i]['textVal'],
        "levelCode": empLevelDesignationF[i]['levelCode'],
        "levelName": empLevelDesignationF[i]['levelName'],
        "empGrp_Code": empLevelDesignationF[i]['empGrp_Code']
      };
      empLevel_DesignationFilterTableData.add(depTableData);
    }
    dataBaseHelper.insertDepartments(
        "empLevel_Designation", empLevel_DesignationFilterTableData);

    List sPV_Dept_Type = [];
    for (int i = 0; i < spVDeptTypeF.length; i++) {
      Map<String, dynamic> spvTableData = {
        "id": spVDeptTypeF[i]['id'],
        "textVal": spVDeptTypeF[i]['textVal'],
        "dept_Group": spVDeptTypeF[i]['dept_Group'],
      };
      sPV_Dept_Type.add(spvTableData);
    }
    dataBaseHelper.insertDepartments("SPV_Dept_Type", sPV_Dept_Type);

    List spV_Dept = [];

    for (int i = 0; i < spVDeptF.length; i++) {
      Map<String, dynamic> spvDeptTableData = {
        "id": spVDeptF[i]['id'],
        "textVal": spVDeptF[i]['textVal'],
        "dept_Type": spVDeptF[i]['dept_Type'],
        "dept_Order": spVDeptF[i]['dept_Order'],
      };
      spV_Dept.add(spvDeptTableData);
    }
    dataBaseHelper.insertDepartments("spV_Dept", spV_Dept);
  }

  Future<void> getRequiredTableDataToStoreOffline(context) async {
    // dataBaseHelper.getTableDataToSee('tbl_spvdetails');
    // return;
    CommanDialog.showLoading(context);
    var headers = {'Authorization': 'Bearer $accessToken'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('$apiBaseUrl/Main/DataOfflineAll'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        if (data['code'] == 200) {
          // log("Key position data $result");
          // print("Length of data ${result.length}");
          //tbl_KeyPostions
          //departments
          //SubDepartments
          //groupDepartments
          //Region
          //ProjectCategory
          //Project
          //ProjectAreas
          //e_EmpGrade
          //empLevel_Designation
          //departmentExp
          //projectExp
          //roleExp
          //totalDetails
          //SPV_Dept_Type
          //spV_Dept
          //spvTotalDetails Table
          // SPV Details Table

          dataBaseHelper.insertDepartments(
              "tbl_KeyPostions", data['data']['positionDetail']);

          dataBaseHelper.insertDepartments(
              "departmentExp", data['data']['departmentExp']);

          dataBaseHelper.insertDepartments(
              "projectExp", data['data']['projectExp']);

          dataBaseHelper.insertDepartments("roleExp", data['data']['roleExp']);

          dataBaseHelper.insertDepartments(
              "tbl_spvtotal", data['data']['spvTotalDetails']);

          dataBaseHelper.insertDepartments(
              "tbl_spvdetails", data['data']['spvDetail']);

          //E-Market Palce Insert Offline data
          dataBaseHelper.insertDepartments(
              "jobPost_Department_Exp", data['data']['jobPost_Department_Exp']);

          dataBaseHelper.insertDepartments(
              "jobPost_Project_Exp", data['data']['jobPost_Project_Exp']);

          dataBaseHelper.insertDepartments(
              "jobPost_Role_Exp", data['data']['jobPost_Role_Exp']);

          dataBaseHelper.insertDepartments(
              "jobPost_Grade_Exp", data['data']['jobPost_Grade_Exp']);

          dataBaseHelper.insertDepartments(
              "jobPost_EntryMode_Exp", data['data']['jobPost_EntryMode_Exp']);

          // dataBaseHelper.insertDepartments(
          //     "jobPost_Applied_Emp", data['data']['jobPost_Applied_Emp']);

          dataBaseHelper.insertDepartments(
              "jobPost_Details", data['data']['jobPost_Details']);
          dataBaseHelper.insertDepartments(
              "employee_Details", data['data']['employee_Details']);
          dataBaseHelper.insertDepartments(
              "jobPost_Applied_Emp", data['data']['jobPost_Applied_Emp']);
          dataBaseHelper.insertDepartments(
              "roles_Menu", data['data']['roles_Menu']);
          CommanDialog.hideLoading(context);
          insetFilterDataInTabls();
        } else {
          CommanDialog.showErrorDialog(context, description: "$data");
        }

        print("API Send Media Respionse $accessToken");
      } else {
        CommanDialog.showErrorDialog(context,
            description: "${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  getKeyPositionDataOffine(
    context,
    requiredData,
    status,
    showProjectionStatusForSucessionPlanning,
  ) async {
    statusForshowKeyPositionMonitoringDataOrProjectionData = false;

    statusForshowKeyPositionMonitoringDataOrProjectionData = false;
    this.showProjectionStatusForSucessionPlanning =
        showProjectionStatusForSucessionPlanning;
    notifyListeners();
    CommanDialog.showLoading(context);
    keyPositionMonitoringData.clear();

    try {
      Map data = await dataBaseHelper.getDataBasedOnCondition(
        'tbl_KeyPostions',
        requiredData,
      );

      log("data $data");

      // Map data = json.decode(await response.stream.bytesToString());

      if (data['code'] == 200) {
        print("IN 200 ${data['totalVacantOneM']}");
        keyPositionMonitoringSummaryData["s"] = data['totalSanctioned'];
        keyPositionMonitoringSummaryData["p"] = data['totalPositioned'];
        // keyPositionMonitoringSummaryData["v"] = data[''];
        keyPositionMonitoringSummaryData["1mon"] = data['totalVacantOneM'];
        keyPositionMonitoringSummaryData["3mon"] = data['totalVacantThreeM'];
        keyPositionMonitoringSummaryData["6mon"] = data['totalVacantSixM'];
        keyPositionMonitoringData.addAll(data['data']);
        keyPositionMonitoringDataMain.addAll(data['data']);
        CommanDialog.hideLoading(context);

        if (status) {
          Navigator.pushNamed(context, '/key_position_monitoring');
          setKeyPositionFilterForOfflineMode();
        }

        notifyListeners();
      } else {
        CommanDialog.hideLoading(context);

        CommanDialog.showErrorDialog(context, description: "$data");
      }
    } catch (error) {
      CommanDialog.hideLoading(context);

      print("Error $error");
    }
  }

  setKeyPositionFilterForOfflineMode() async {
    print("Calling setKeyPositionFilterForOfflineMode");

    List groupDepFilterData =
        await dataBaseHelper.getTableData('groupDepartments');
    List subDepartments = await dataBaseHelper.getTableData('SubDepartments');
    List departments = await dataBaseHelper.getTableData('departments');
    List pCategory = await dataBaseHelper.getTableData('ProjectCategory');
    List locationd = await dataBaseHelper.getTableData('Project');
    List eEmpGradeData = await dataBaseHelper.getTableData('e_EmpGrade');
    List levela = await dataBaseHelper.getTableData('empLevel_Designation');

    deptGroup.clear();
    deptSubGroup.clear();
    deptSubGroupDummy.clear();
    dept.clear();
    deptDummy.clear();
    projectCategory.clear();
    projectCategoryDummy.clear();
    location.clear();
    locationDummy.clear();
    grade.clear();
    level.clear();
    levelDummy.clear();

    deptGroup = groupDepFilterData.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['groupDeptName']);
    }).toList();

    deptSubGroup = subDepartments.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
    }).toList();

    deptSubGroupDummy = subDepartments.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['subDeptName']);
    }).toList();

    dept = departments.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
    }).toList();

    deptDummy = departments.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['deptName']);
    }).toList();

    projectCategory = pCategory.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
    }).toList();

    projectCategoryDummy = pCategory.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
    }).toList();

    location = locationd.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();

    locationDummy = locationd.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();

    grade = eEmpGradeData.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['levelName']);
    }).toList();

    List levela1 = [];
    levela1.addAll(levela.where((value) => value['empGrp_Code'] == 'E'));

    level = levela1.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
    }).toList();

    levelDummy = levela1.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['textVal']);
    }).toList();
    notifyListeners();
  }

  switchBitweenOfflineAndOnline(value, context) async {
    bool isInternet = await checkInternetAvailableOrNot();

    if (!isInternet) {
      CommanDialog.showErrorDialog(context,
          description: "No Internet Connection");
    } else {
      isOfflineData = value;

      getUserProfile(context);

      Map updateRole = {
        "isUserOffline": isOfflineData,
      };
      final _storage = const FlutterSecureStorage();
      final userDataLocal = json.encode(updateRole);
      await _storage.write(
          key: 'isUserOfflineNTPCDelphi', value: userDataLocal);
      // Read value
      getHomeScreenModuleBasedOnUserRole(context);
      notifyListeners();
    }
  }

//SPV Analysis Offline Start
  setOfflineFilterForSPVAnalysis(context, type, idToGetData) async {
    if (type == 1) {
      getRegionDataOffline(context);
    }

    if (type == 2) {
      getProjectDataOffline(context, idToGetData);
    }

    if (type == 3) {
      getDeptTypeData(context, idToGetData);
    }
    if (type == 4) {
      getSPVDept(context, idToGetData);
    }

    //Get SPV Analysis Data offline

    List pCategory = await dataBaseHelper.getTableData('ProjectCategory');

    List locationd = await dataBaseHelper.getTableData('Project');

    List eEmpGradeData = await dataBaseHelper.getTableData('e_EmpGrade');

    List regionData = await dataBaseHelper.getTableData('Region');

    // SPV_Dept_Type // spV_Dept

    List spvDeptTypeData = await dataBaseHelper.getTableData('SPV_Dept_Type');
    List spvDeptData = await dataBaseHelper.getTableData('SPV_Dept');

    projectCategory.clear();
    projectCategoryDummy.clear();
    location.clear();
    locationDummy.clear();
    grade.clear();

    spVDeptTypeF.clear();
    spVDeptF.clear();

    spVDeptTypeF.addAll(spvDeptTypeData);
    spVDeptF.addAll(spvDeptData);

    masterRegionFilterData = regionData.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['regionName']);
    }).toList();

    projectCategory = pCategory.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
    }).toList();

    projectCategoryDummy = pCategory.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['projectType']);
    }).toList();

    location = locationd.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();

    locationDummy = locationd.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['pCategory']);
    }).toList();

    grade = eEmpGradeData.map((subjectdataa) {
      return MultiSelectItem(subjectdataa, subjectdataa['levelName']);
    }).toList();

    //Note Last 2 filter SPVDepType and SPVDep data did not set set that

    notifyListeners();
  }

  getRegionDataOffline(context) async {
    spvAnalysisRegionData.clear();
    spvAnalysisRegionDataMain.clear();
    List response =
        await dataBaseHelper.getSPVRegionOfflineData("tbl_spvdetails");
    spvAnalysisRegionData.addAll(response);
    spvAnalysisRegionDataMain.addAll(response);
    print(spvAnalysisRegionDataMain[0]);
    Navigator.pushNamed(context, '/spv_analysis_region_screen');
  }

  getProjectDataOffline(context, idToGetData) async {
    spvAnalysisProjectData.clear();
    spvAnalysisProjectDataMain.clear();
    List response = await dataBaseHelper.getSPVProjectOfflineData(
        "tbl_spvdetails", idToGetData);
    print("Respoinse $response");
    spvAnalysisProjectData.addAll(response);
    spvAnalysisProjectDataMain.addAll(response);
    Navigator.pushNamed(context, '/spv_analysis_project_screen');
  }

  getDeptTypeData(context, idToGetData) async {
    spvAnalysisProjectDeptTypeData.clear();
    spvAnalysisProjectDeptTypeDataMain.clear();
    List response = await dataBaseHelper.getSPVDeptTypeOfflineData(
        "tbl_spvdetails", idToGetData);
    print("Respoinse $response");
    spvAnalysisProjectDeptTypeData.addAll(response);
    spvAnalysisProjectDeptTypeDataMain.addAll(response);
    Navigator.pushNamed(context, '/spv_positions_project_dept_Type_search');
  }

  getSPVDept(context, idToGetData) async {
    spvAnalysisProjectDeptTypeDeptData.clear();
    spvAnalysisProjectDeptTypeDeptDataMain.clear();
    List response = await dataBaseHelper.getSPVDeptOfflineData(
        "tbl_spvdetails", idToGetData);
    print("Respoinse $response");
    spvAnalysisProjectDeptTypeDeptData.addAll(response);
    spvAnalysisProjectDeptTypeDeptDataMain.addAll(response);
    Navigator.pushNamed(context, '/spv_dept_type_dept_search');
  }
//SPV Analysis Offline End

  Future<bool> checkInternetAvailableOrNot() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected with Mobile");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected with Wifi");
      return true;
    } else {
      return false;
    }
  }

  List homeModuleList = [];

  Future<void> getHomeScreenModuleBasedOnUserRole(context) async {
    bool isUserOfflineOrOnline = await getIsInOfflineModeOrOnlineMode();

    print("isUserOffline $isUserOfflineOrOnline and user role $userRole");

    if (isUserOfflineOrOnline) {
      try {
        var result =
            await dataBaseHelper.getMenuOffline("roles_Menu", userRole);
        print("data result $result");
        homeModuleList.clear();
        for (int i = 0; i < result.length; i++) {
          if (i < 3) {
            print("pppppp");
            homeModuleList.add(result[i]);
          }
        }
        // homeModuleList.clear();
        // homeModuleList = result;
        print("result offline ${homeModuleList.length}");
        notifyListeners();
      } catch (error) {
        print("Error aa gyiii $error");
      }
      // homeModuleList = [
      //   {
      //     "roleID": 2,
      //     "menuID": 8,
      //     "menuName": "Key position Monitoring",
      //     "menuLevel": 1,
      //     "apiIcon": "assets/images/KeypositionIcon.png",
      //     "apiUrl": "KeyPositionMonitoring"
      //   },
      //   {
      //     "roleID": 2,
      //     "menuID": 9,
      //     "menuName": "SPV Analysis",
      //     "menuLevel": 1,
      //     "apiIcon": "assets/images/SPVAnalysisicon.png",
      //     "apiUrl": "SPVAnalysis"
      //   },
      //   {
      //     "roleID": 2,
      //     "menuID": 10,
      //     "menuName": "E-Market Place",
      //     "menuLevel": 2,
      //     "apiIcon": "assets/images/EMarketPlaceicon.png",
      //     "apiUrl": "EMarketPlace"
      //   },
      //   {
      //     "roleID": 2,
      //     "menuID": 11,
      //     "menuName": "Open Search",
      //     "menuLevel": 1,
      //     "apiIcon": "assets/images/OpenSearchicon.png",
      //     "apiUrl": "OpenSearch"
      //   },
      //   {
      //     "roleID": 1,
      //     "menuID": 31,
      //     "menuName": "Succession Planning",
      //     "menuLevel": 1,
      //     "apiIcon": "assets/images/SuccessionPlanningicon.png",
      //     "apiUrl": "SuccessionPlanning"
      //   },
      //   {
      //     "roleID": 1,
      //     "menuID": 32,
      //     "menuName": "Job Rotation",
      //     "menuLevel": 1,
      //     "apiIcon": "assets/images/JobRotationicon.png",
      //     "apiUrl": "JobRotation"
      //   },
      // ];
    } else {
      print("IN ELSEEE");
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Roles_Module_Menu'));
      request.fields.addAll({"RoleID": userRole});
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Map data = json.decode(await response.stream.bytesToString());
          if (data['code'] == 200) {
            homeModuleList.clear();
            homeModuleList = data['data'];
            getTotalEmpCount(context);
            getAvailableFilter(context);
            notifyListeners();
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
        }
      } catch (error) {
        CommanDialog.showErrorDialog(context, description: "${error}");
      }
    }
  }

  List homeModuleSubMenuList = [];
  Future<void> getHomeScreenSubModuleMenuBasedOnUserRole(context) async {
    if (isOfflineData) {
      print("Offline sectipon");
      List result = [
        {
          "menuID": 12,
          "menuName": "Manage Job",
          "menulink": "Emarket/JobList",
          "menuLevel": 3,
          "apiIcon": "assets/images/manage_job.png",
          "apiUrl": "ManageJob"
        },
        {
          "menuID": 13,
          "menuName": "Job Search",
          "menulink": "Emarket/JobApplicantList",
          "menuLevel": 3,
          "apiIcon": "assets/images/jobsearch.png",
          "apiUrl": "SearchJob"
        }
      ];
      homeModuleSubMenuList = result;
      print(json.encode(homeModuleSubMenuList));
      Navigator.pushNamed(context, '/e_market_place');
      notifyListeners();
    } else {
      Map dddd = {"RoleID": userRole, "MenuID": 10};
      print("SSSSS $dddd");
      var headers = {'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$apiBaseUrl/Main/Roles_Module_SubMenu'));
      request.fields.addAll({"RoleID": userRole, "MenuID": "10"});
      request.headers.addAll(headers);

      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Map data = json.decode(
            await response.stream.bytesToString(),
          );
          log("data $data");
          if (data['code'] == 200) {
            homeModuleSubMenuList = data['data'];
            print(json.encode(homeModuleSubMenuList));
            Navigator.pushNamed(context, '/e_market_place');
            notifyListeners();
          } else {
            CommanDialog.showErrorDialog(context, description: "$data");
          }
        } else {
          CommanDialog.showErrorDialog(context,
              description: "${response.reasonPhrase}");
          print(response.reasonPhrase);
        }
      } catch (error) {
        print("Error $error");
      }
    }
  }

  static bool iPadSize = false;
  Future<void> isDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.name != null) {
      if (info.name!.toLowerCase().contains("ipad")) {
        iPadSize = true;
      } else {
        iPadSize = false;
      }
    }

    print("Is Ipad $iPadSize");
  }
}
