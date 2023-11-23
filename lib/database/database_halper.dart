import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Tables which is not created yet for offline
//1: positionDetail
//2: employee_Details
//3: jobPost_Details

// total details
// key Positon Table
// departments Table
// subDepartments Table
//  groupDepartments Table
// region Table
// projectCategory Table
// project Table
// projectAreas Table
// e_EmpGrade Table
// empLevel_Designation Table
// departmentExp Table Start

// Key Position Table
const String keyPositionTable = 'tbl_KeyPostions';
const String positionID = "positionID";
const String title = "title";
const String positionType = "positionType";
const String deptGroupCode = "dept_Group_Code";
const String deptSubGroupCode = "dept_SubGroup_Code";
const String departmentCode = "department_Code";
const String region_Code = "region_Code";
const String projectCategoryCode = "projectCategory_Code";
const String projectCode = "project_Code";
const String locationCode = "location_Code";
const String gradeCode = "grade_Code";
const String designation = "designation";
const String totalPositioned = "totalSanctioned";
const String totalPosition = "totalPositioned";
const String roles = "roles";
const String descriptions = "descriptions";
const String requirements = "requirements";
const String skillSet = "skillSet";
const String qualifyGrade_Code = "qualifyGrade_Code";
const String qualifyDesignation = "qualifyDesignation";
const String qualifications_Code = "qualifications_Code";
const String branches_Code = "branches_Code";
const String ageMin = "ageMin";
const String ageMax = "ageMax";
const String noOfRegionMin = "noOfRegionMin";
const String noOfRegionMax = "noOfRegionMax";
const String noOfProjectMin = "noOfProjectMin";
const String noOfProjectMax = "noOfProjectMax";
const String region = "regionName";
const String project = "projectCategory";
const String location = "projectName";
const String departmentName = "departmentName";
const String subDepartmentName = "subDepartmentName";
const String departmentGroupName = "departmentGroupName";
const String gradeName = "gradeName";
const String levelNameKP = "levelName";
const String qualificationAll = "qualificationAll";
const String branchsAll = "branchsAll";
const String gradeAll = "gradeAll";
const String currentRoleType = "currentRoleType";
const String levelAll = "levelAll";

// const String projectName = "projectName";
// const String actionDate = "ActionDate";
// const String actionBy = "ActionBy";
// const String jobID = "JobID";
// const String positionFor = "PositionFor";
// const String keyRoleType = "KeyRoleType";
// const String orgUnit = "OrgUnit";
// Key Positon Table
//SPV Details Table

// departments Table Start
const String departmentTable = "departments";
const String deptCode = "deptCode";
const String deptName = "deptName";
const String subDeptCode = "subDeptCode";
const String groupDeptCode = "groupDeptCode";

// departments Table End

// subDepartments Table Start
const String subDepartmentsTable = "SubDepartments";
const String subDeptCodeSD = "subDeptCode";
const String subDeptNameSD = "subDeptName";
const String groupDeptCodeSD = "groupDeptCode";

// subDepartments Table End

// groupDepartments Table Start
const String groupDepartmentsTable = "groupDepartments";
const String groupDeptCodeGD = "groupDeptCode";
const String groupDeptNameGD = "groupDeptName";
// groupDepartments Table End

// region Table Start
const String regionTable = "Region";
const String regionCode = "regionCode";
const String regionName = "regionName";
// region Table End

// projectCategory Table Start
const String projectCategoryTable = "ProjectCategory";
const String projectTypeID = "projectTypeID";
const String projectType = "projectType";
// projectCategory Table End

// project Table Start
const String projectTable = "Project";
const String pid = "pid";
const String pCategory = "pCategory";
const String regionID = "regionID";
const String projectCategoryP = "projectCategory";
// project Table End

// projectAreas Table Start
const String projectAreasTable = "ProjectAreas";
const String projectAreaID = "projectAreaID";
const String projectArea = "projectArea";
const String projectID = "projectID";
const String regionIDPA = "regionID";
const String projectCategoryPA = "projectCategory";
// projectAreas Table End

// e_EmpGrade Table Start
const String e_EmpGradeTable = "e_EmpGrade";
const String levelCode = "levelCode";
const String levelName = "levelName";
const String empGrp_Code = "empGrp_Code";
// e_EmpGrade Table End

// empLevel_Designation Table Start
const String empLevelDesignationTable = "empLevel_Designation";
const String id = "id";
const String textVal = "textVal";
const String levelCodeELD = "levelCode";
const String levelNameELD = "levelName";
const String empGrp_CodeELD = "empGrp_Code";
// empLevel_Designation Table End

// departmentExp Table Start
const String departmentExpTableName = "departmentExp";
const String positionIDDE = "positionID";
const String deptGroupNameDE = "deptGroupName";
const String deptSubGroupNameDE = "deptSubGroupName";
const String deptNameDE = "deptName";
const String totalExpMinDE = "totalExpMin";
const String totalExpMaxDE = "totalExpMax";
// departmentExp Table End

// projectExp Table Start
const String projectExpTableName = "projectExp";
const String positionIDPE = "positionID";
const String projectIDPE = "projectID";
const String projectNamePE = "projectName";
const String totalExpPE = "totalExp";
// projectExp Table End

// roleExp Table Start
const String roleExpTableName = "roleExp";
const String positionIDRE = "positionID";
const String roleIDRE = "roleID";
const String roleNameRE = "roleName";
const String totalExpMinRE = "totalExpMin";
const String totalExpMaxRE = "totalExpMax";
// roleExp Table End

// total details Start
const String totalDetailsTableName = "totalDetails";
const String totalPositionT = "totalPosition";
const String totalPositionedT = "totalPositioned";
const String totalVacantOneM = "totalVacantOneM";
const String totalVacantThreeM = "totalVacantThreeM";
const String totalVacantSixM = "totalVacantSixM";
// total details End

//SPV Tables

// SPV_Dept_Type Table
const String spvDeptTypeTableName = "SPV_Dept_Type";
const String idSPV = "id";
const String textValSPV = "textVal";
const String dept_GroupSPV = "dept_Group";

// spV_Dept Table
const String spvDeptTableName = "SPV_Dept";
const String idD = "id";
const String textValD = "textVal";
const String dept_Type = "dept_Type";
const String deptOrder = "dept_Order";

//spvTotalDetails Table
const String spvTotalTable = "tbl_spvtotal";
const String totalRecordSVPDT = "totalRecord";
const String totalPositionSVPDT = "totalPosition";
const String totalOccupiedSVPDT = "totalOccupied";
const String totalVacantOneMSVPDT = "totalVacantOneM";
const String totalVacantThreeMSVPDT = "totalVacantThreeM";
const String totalVacantSixMSVPDT = "totalVacantSixM";

// SPV Details Table
const String spvDetailsTable = "tbl_spvdetails";
const String projectTypeSPVD = "projectType";
const String region_CodeSPVD = "region_Code";
const String regionNameSPVD = "regionName";
const String projectIDSPVD = "projectID";
const String projectNameSPVD = "projectName";
const String locationIDSPVD = "locationID";
const String projectAreaSPVD = "projectArea";
const String svp_Dept_Type_IDSPVD = "svp_Dept_Type_ID";
const String svp_Department_TypeSPVD = "svp_Department_Type";
const String svp_Department_IDSPVD = "svp_Department_ID";
const String svp_Department_NameSPVD = "svp_Department_Name";
const String totalSPVD = "total";
const String p_TotalSPVD = "p_Total";
const String t_TotalSPVD = "t_Total";

//E-Market Palce Offline Table structure

//jobPost_Applied_Emp tabls
String jobPost_Applied_Emp = "jobPost_Applied_Emp";
String jobIDJAE = "jobID";
String empNoJAE = "empNo";
String pernrJAE = "pernr";
String nameJAE = "name";
String gradeJAE = "grade";
String projectJAE = "project";
String locationJAE = "location";
String departmentJAE = "department";
String department_GroupJAE = "department_Group";
String designationJAE = "designation";
String entrymodeJAE = "entrymode";
String casteJAE = "caste";
String domicile_StateJAE = "domicile_State";
String genderJAE = "gender";
String prev_ProjJAE = "prev_Proj";
String ageJAE = "age";
String balanceJob = "balanceJob";
String totalExp = "totalExp";
String totalYearProjectJAE = "totalYearProject";
String dobJAE = "dob";
String doJ_NTPCJAE = "doJ_NTPC";
String doE_GradeJAE = "doE_Grade";
String doE_ProjectJAE = "doE_Project";
String retirementDateJAE = "retirementDate";
String doE_DeptJAE = "doE_Dept";
String alertMsgJAE = "alertMsg";
String imgPath = "imgPath";
String imgRealPathJAE = "imgRealPath";
String applicantIDJAE = "applicantID";
String isShortlistJAE = "isShortlist";
String isMarkSelectedJAE = "isMarkSelected";
String docsPathJAE = "docsPath";
String docsTitleJAE = "docsTitle";
String expertiseJAE = "expertise";
String descriptionsJAE = "descriptions";
String keyPositionJAE = "keyPosition";
String isEligibleEmpJAE = "isEligibleEmp";
String locationExpJAE = "locationExp";
String functionExpJAE = "functionExp";
String function_ExpJAE = "function_Exp";
String department_ExpJAE = "department_Exp";
String workarea_ExpJAE = "workarea_Exp";
String spouseIDJAE = "spouseID";
String suposeDataJAE = "suposeData";
String isLongLeaveJAE = "isLongLeave";

//jobPost_EntryMode_Exp
const String jobPostEntryModeExpTable = "jobPost_EntryMode_Exp";
const String positionIDEME = "positionID";
const String entryModeID = "entryModeID";
const String entryMode = "entryMode";
const String experienceType = "experienceType";
const String experienceTypeVar = "experienceTypeVar";

//jobPost_Grade_Exp
const String jobPost_Grade_ExpTable = "jobPost_Grade_Exp";
const String positionIDGE = 'positionID';
const String gradeID = 'gradeID';
const String gradeNameGE = 'gradeName';
const String substantiveGradeID = 'substantiveGradeID';
const String substantiveGrade = 'substantiveGrade';
const String totalExpMin = 'totalExpMin';
const String totalExpMax = 'totalExpMax';

//jobPost_Role_Exp
const String jobPostRoleExpTable = "jobPost_Role_Exp";
const String positionIDJRE = "positionID";
const String roleID = "roleID";
const String roleName = "roleName";
const String totalExpMinJRE = "totalExpMin";
const String totalExpMaxJRE = "totalExpMax";

//jobPost_Project_Exp
const String jobPostProjectExp = "jobPost_Project_Exp";
const String positionIDJPP = "positionID";
const String regionIDJPP = "regionID";
const String regionNameJPP = "regionName";
const String projectIDJPP = "projectID";
const String projectNameJPP = "projectName";
const String totalExpMinJPP = "totalExpMin";
const String totalExpMaxJPP = "totalExpMax";
const String experienceTypeJPP = "experienceType";
const String experienceTypeVarJPP = "experienceTypeVar";

//jobPost_Department_Exp
const String jobPostDepartmentExp = "jobPost_Department_Exp";
const String positionIDJPD = "positionID";
const String deptGroupIDJPD = "deptGroupID";
const String deptGroupNameJPD = "deptGroupName";
const String deptSubGroupIDJPD = "deptSubGroupID";
const String deptSubGroupNameJPD = "deptSubGroupName";
const String departmentIDJPD = "departmentID";
const String deptNameJPD = "deptName";
const String totalExpMinJPD = "totalExpMin";
const String totalExpMaxJPD = "totalExpMax";
const String sexperienceType = "experienceType";
const String experienceTypeVarJPD = "experienceTypeVar";

//jobPost_Details
const String jobPost_Details = "jobPost_Details";
const String jobIDJPD = "jobID";
const String titleJPD = "title";
const String vacanciesJPD = "vacancies";
const String startDateJPD = "startDate";
const String endDateJPD = "endDate";
const String jobStatusJPD = "jobStatus";
const String documentExtJPD = "documentExt";
const String documentPathJPD = "documentPath";
const String jobModeJPD = "jobMode";
const String mode_HODJPD = "mode_HOD";
const String mode_HOPJPD = "mode_HOP";
const String descriptionsJPD = "descriptions";
const String regionIDKPD = "regionID";
const String projectIDKPD = "projectID";
const String locationIDKPD = "locationID";
const String regionJPD = "region";
const String projectJPD = "project";
const String locationJPD = "location";
const String dept_GroupJPD = "dept_Group";
const String dept_SUbGroupJPD = "dept_SUbGroup";
const String departmentJPD = "department";
const String gradeJPD = "grade";
const String column1JPD = "column1";
const String qualifyDesignationJPD = "qualifyDesignation";
const String substansiveGradeJPD = "substansiveGrade";
const String isKeyPositionJPD = "isKeyPosition";
const String keyPositionJPD = "keyPosition";
const String keyLocationJPD = "keyLocation";
const String keyDepartmentJPD = "keyDepartment";
const String keyRoleTypeJPD = "keyRoleType";
const String funExp_Dept_GroupJPD = "funExp_Dept_Group";
const String funExp_Dept_SubGroupJPD = "funExp_Dept_SubGroup";
const String funExp_DepartmentJPD = "funExp_Department";
const String funExpMinJPD = "funExpMin";
const String funExpMaxJPD = "funExpMax";
const String region_LocExpMinJPD = "region_LocExpMin";
const String region_LocExpMaxJPD = "region_LocExpMax";
const String project_LocExpMinJPD = "project_LocExpMin";
const String project_LocExpMaxv = "project_LocExpMax";
const String qualificationJPD = "qualification";
const String branchsJPD = "branchs";
const String postedByJPD = "postedBy";
const String postedDateJPD = "postedDate";
const String document_TitleJPD = "document_Title";
const String ageMinJPD = "ageMin";
const String ageMaxJPD = "ageMax";
const String isEditJPD = "isEdit";
const String currentProjExpJPD = "currentProjExp";
const String regionNameJJPD = "regionName";
const String projectNameJJPD = "projectName";
const String locationNameJPD = "locationName";
const String departmentNameJPD = "departmentName";
const String dept_GroupID = "dept_GroupID";
const String projectCategoryName = "projectCategoryName";
const String subDepartmentNameJPD = "subDepartmentName";
const String departmentGroupNameJPD = "departmentGroupName";
const String departmentNameEJPD = "departmentNameE";
const String subDepartmentNameEJPD = "subDepartmentNameE";
const String departmentGroupNameEJPD = "departmentGroupNameE";
const String qualificationAllJPD = "qualificationAll";
const String branchsAllJPD = "branchsAll";
const String gradeAllJPD = "gradeAll";
const String totalApplicant = "totalApplicant";
const String dept_SUbGroupID = "dept_SUbGroupID";
const String departmentID = "departmentID";
const String subDepartment = "subDepartment";
const String departmentGroup = "departmentGroup";
const String deptNameJD = "deptName";
const String subDeptName = "subDeptName";
const String groupDeptName = "groupDeptName";

//employee_Details Table
const String employee_Details = "employee_Details";
const String empNo = "empNo";
const String pernr = "pernr";
const String firstName = "firstName";
const String grade = "grade";
const String substanciveGrade = "substanciveGrade";
const String projectED = "project";
const String locationED = "location";
const String department = "department";
const String designationED = "designation";
const String dob = "dob";
const String doJ_NTPC = "doJ_NTPC";
const String doE_Project = "doE_Project";
const String doE_Project1 = "doE_Project1";
const String promotionDate = "promotionDate";
const String retirementDate = "retirementDate";
const String caste = "caste";
const String gender = "gender";
const String entryModeED = "entryMode";
const String prev_Proj = "prev_Proj";
const String empl_Group = "empl_Group";
const String domicile_State = "domicile_State";
const String regionED = "region";
const String department_Group = "department_Group";
const String mobile = "mobile";
const String email = "email";
const String ph = "ph";
const String pH_Per = "pH_Per";
const String areaOfRect = "areaOfRect";
const String fun_Exp = "fun_Exp";
const String location_Exp = "location_Exp";
const String department_Exp = "department_Exp";
const String workarea_Exp = "workarea_Exp";
const String spouseID = "spouseID";
const String healthCheckUp = "healthCheckUp";
const String subLocation_Exp = "subLocation_Exp";
const String holdKeyPositionName = "holdKeyPositionName";

const String recruitmentArea = "recruitmentArea";
const String doE_Grade = "doE_Grade";
const String keyPosition = "keyPosition";
const String supose = "supose";
const String supose_EmpNo = "supose_EmpNo";
const String keyPositionPast = "keyPositionPast";
const String lastYearLeaveStatus = "lastYearLeaveStatus";
const String isVigilance = "isVigilance";

//Role Menu
const String rolesMenu = "roles_Menu";
const String roleIDRM = "roleID";
const String menuID = "menuID";
const String menuName = "menuName";
const String menuLevel = "menuLevel";
const String apiIcon = "apiIcon";
const String apiUrl = "apiUrl";
const String parentMenuID = "parentMenuID";

class DataBaseHelper {
  static const _databasename = "ntpc2.0.db";
  static const _databaseversion = 1;
  static Database? _database;

  // create a database  instance variable
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = join(await getDatabasesPath(), _databasename);
    print("DataBase path  $path");
    var database = await openDatabase(path, version: _databaseversion,
        onCreate: (db, version) async {
      await db.execute(
        '''
          CREATE TABLE $keyPositionTable(
          $positionID INTEGER,
          $title TEXT,
          $positionType TEXT,
          $deptGroupCode INTEGER,
          $deptSubGroupCode INTEGER ,
          $departmentCode INTEGER,
          $region_Code INTEGER,
          $regionCode INTEGER,
          $projectCategoryCode INTEGER,
          $projectCode INTEGER,
          $locationCode TEXT,
          $gradeCode TEXT,
          $designation TEXT,
          $totalPosition INTEGER,
          $totalPositioned INTEGER,
          $roles TEXT,
          $descriptions TEXT,
          $requirements TEXT,
          $skillSet TEXT,
          $qualifyGrade_Code TEXT,
          $qualifyDesignation TEXT,
          $qualifications_Code TEXT,
          $branches_Code TEXT,
          $ageMin INTEGER,
          $ageMax INTEGER,
          $noOfRegionMin INTEGER,
          $noOfRegionMax INTEGER,
          $noOfProjectMin INTEGER,
          $noOfProjectMax INTEGER,
          $region TEXT,
          $project TEXT,
          $location TEXT,
          $departmentName TEXT,
          $subDepartmentName TEXT,
          $departmentGroupName TEXT,
          $gradeName TEXT,
          $levelNameKP TEXT,
          $qualificationAll TEXT,
          $branchsAll TEXT,
          $gradeAll TEXT,
          $currentRoleType TEXT,
          $levelAll TEXT
                    )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $departmentTable(
            $deptCode INTEGER,
            $deptName TEXT,
            $subDeptCode INTEGER,
            $groupDeptCode INTEGER
               
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $subDepartmentsTable(
            $subDeptCodeSD INTEGER,
            $subDeptNameSD TEXT,
            $groupDeptCodeSD INTEGER
           
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $groupDepartmentsTable(
           
            $groupDeptCodeGD INTEGER,
            $groupDeptNameGD TEXT
       
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $regionTable(
            
            $regionCode INTEGER,
            $regionName TEXT
       
            
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $projectCategoryTable(
            $projectTypeID INTEGER,
            $projectType TEXT
       
            
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $projectTable(
            $pid INTEGER,
            $pCategory TEXT,
            $regionID INTEGER,
            $projectCategoryP TEXT

          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $projectAreasTable(
           
            $projectAreaID INTEGER,
            $projectArea TEXT,
            $projectID INTEGER,
            $regionIDPA INTEGER,
            $projectCategoryPA INTEGER
       
            
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $e_EmpGradeTable(
            $levelCode INTEGER,
            $levelName TEXT,
            $empGrp_Code INTEGER
            
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $empLevelDesignationTable(
            $id INTEGER,
            $textVal TEXT,
            $levelCodeELD INTEGER,
            $levelNameELD TEXT,
            $empGrp_CodeELD INTEGER
             
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $departmentExpTableName(
           $positionIDDE INTEGER,
           $deptGroupNameDE TEXT,
           $deptSubGroupNameDE TEXT,
           $deptNameDE TEXT,
           $totalExpMinDE INTEGER,
           $totalExpMaxDE INTEGER
                      )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $projectExpTableName(
          $positionIDPE INTEGER,
          $projectIDPE INTEGER,
          $projectNamePE TEXT,
          $totalExpPE TEXT
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $roleExpTableName(
          $positionIDRE INTEGER,
          $roleIDRE TEXT,
          $roleNameRE TEXT,
          $totalExpMinRE INTEGER,
          $totalExpMaxRE INTEGER
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $totalDetailsTableName(
          $totalPositionT INTEGER,
          $totalPositionedT INTEGER,
          $totalVacantOneM INTEGER,
          $totalVacantThreeM INTEGER,
          $totalVacantSixM INTEGER
            
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $spvDeptTypeTableName(
          $idSPV INTEGER,
          $textValSPV TEXT,
          $dept_GroupSPV INTEGER
           
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $spvDeptTableName(
          $idD INTEGER,
          $textValD TEXT,
          $dept_Type INTEGER,
          $deptOrder TEXT
           
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $spvTotalTable(
           $totalRecordSVPDT INTEGER,
           $totalPositionSVPDT INTEGER,
           $totalOccupiedSVPDT INTEGER,
           $totalVacantOneMSVPDT INTEGER,
           $totalVacantThreeMSVPDT INTEGER,
           $totalVacantSixMSVPDT INTEGER
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $spvDetailsTable(
           $projectTypeSPVD TEXT,
           $region_CodeSPVD TEXT,
           $regionNameSPVD TEXT,
           $projectIDSPVD TEXT,
           $projectNameSPVD TEXT,
           $locationIDSPVD TEXT,
           $projectAreaSPVD TEXT,
           $svp_Dept_Type_IDSPVD INTEGER,
           $svp_Department_TypeSPVD TEXT,
           $svp_Department_IDSPVD INTEGER,
           $svp_Department_NameSPVD TEXT,
           $totalSPVD INTEGER,
           $p_TotalSPVD INTEGER,
           $t_TotalSPVD INTEGER
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPostDepartmentExp(
          $positionIDJPD INTEGER,
          $deptGroupIDJPD INTEGER,
          $deptGroupNameJPD TEXT,
          $deptSubGroupIDJPD INTEGER,
          $deptSubGroupNameJPD TEXT,
          $departmentIDJPD INTEGER,
          $deptNameJPD TEXT,
          $totalExpMinJPD INTEGER,
          $totalExpMaxJPD INTEGER,
          $sexperienceType INTEGER,
          $experienceTypeVarJPD TEXT
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPostProjectExp(
             $positionIDJPP INTEGER,
             $regionIDJPP INTEGER,
             $regionNameJPP TEXT,
             $projectIDJPP INTEGER,
             $projectNameJPP TEXT,
             $totalExpMinJPP INTEGER,
             $totalExpMaxJPP INTEGER,
             $experienceTypeJPP INTEGER,
             $experienceTypeVarJPP TEXT
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPostRoleExpTable(
            $positionIDJRE INTEGER,
            $roleID TEXT,
            $roleName TEXT,
            $totalExpMinJRE INTEGER,
            $totalExpMaxJRE INTEGER
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPost_Grade_ExpTable(
            $positionIDGE INTEGER,
            $gradeID TEXT,
            $gradeNameGE TEXT,
            $substantiveGradeID TEXT,
            $substantiveGrade TEXT,
            $totalExpMin INTEGER,
            $totalExpMax INTEGER
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPostEntryModeExpTable(
            $positionIDEME INTEGER,
            $entryModeID TEXT,
            $entryMode TEXT,
            $experienceType INTEGER,
            $experienceTypeVar TEXT

          )
          ''',
      );
      // await db.execute(
      //   '''
      //     CREATE TABLE $jobPostAppliedEmp(
      //     $jPAEPositionID INTEGER,
      //     $jPAEEntryModeID TEXT,
      //     $jPAEEntryMode TEXT,
      //     $jPAEExperienceType INTEGER,
      //     $jPAEExperienceTypeVar TEXT

      //     )
      //     ''',
      // );

      await db.execute(
        '''
          CREATE TABLE $jobPost_Details(
            $jobIDJPD INTEGER,
            $titleJPD TEXT,
            $vacanciesJPD INTEGER,
            $startDateJPD TEXT,
            $endDateJPD TEXT,
            $jobStatusJPD TEXT,
            $documentExtJPD TEXT,
            $documentPathJPD TEXT,
            $jobModeJPD TEXT,
            $mode_HODJPD INTEGER,
            $mode_HOPJPD INTEGER,
            $descriptionsJPD TEXT,
            $regionJPD INTEGER,
            $projectJPD INTEGER,
            $locationJPD INTEGER,
            $dept_GroupJPD INTEGER,
            $dept_SUbGroupJPD INTEGER,
            $departmentJPD INTEGER,
            $gradeJPD TEXT,
            $column1JPD TEXT,
            $qualifyDesignationJPD TEXT,
            $substansiveGradeJPD TEXT,
            $isKeyPositionJPD TEXT,
            $keyPositionJPD TEXT,
            $keyLocationJPD INTEGER,
            $keyDepartmentJPD TEXT,
            $keyRoleTypeJPD TEXT,
            $funExp_Dept_GroupJPD INTEGER,
            $funExp_Dept_SubGroupJPD INTEGER,
            $funExp_DepartmentJPD INTEGER,
            $funExpMinJPD INTEGER,
            $funExpMaxJPD INTEGER,
            $region_LocExpMinJPD INTEGER,
            $region_LocExpMaxJPD INTEGER,
            $project_LocExpMinJPD INTEGER,
            $project_LocExpMaxv INTEGER,
            $qualificationJPD TEXT,
            $branchsJPD TEXT,
            $postedByJPD INTEGER,
            $postedDateJPD TEXT,
            $document_TitleJPD TEXT,
            $ageMinJPD INTEGER,
            $ageMaxJPD INTEGER,
            $isEditJPD INTEGER,
            $currentProjExpJPD INTEGER,
            $regionNameJJPD TEXT,
            $projectNameJJPD TEXT,
            $projectCategoryName TEXT,
            $locationNameJPD TEXT,
            $departmentNameJPD TEXT,
            $subDepartmentNameJPD TEXT,
            $departmentGroupNameJPD TEXT,
            $departmentNameEJPD TEXT,
            $subDepartmentNameEJPD TEXT,
            $departmentGroupNameEJPD TEXT,
            $qualificationAllJPD TEXT,
            $branchsAllJPD TEXT,
            $gradeAllJPD TEXT,
            $regionIDKPD INTEGER,
            $projectIDKPD INTEGER,
            $locationIDKPD INTEGER,
            $totalApplicant INTEGER,
            $dept_GroupID INTEGER,
            $dept_SUbGroupID INTEGER,
            $departmentID INTEGER,
            $subDepartment TEXT,
            $departmentGroup TEXT,
            $deptNameJD TEXT,
            $subDeptName TEXT,
            $groupDeptName TEXT
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $employee_Details(
               $empNo INTEGER,
               $pernr TEXT,
               $firstName TEXT,
               $grade TEXT,
               $substanciveGrade TEXT,
               $projectED TEXT,
               $locationED TEXT,
               $department TEXT,
               $designationED TEXT,
               $dob TEXT,
               $doJ_NTPC TEXT,
               $doE_Project TEXT,
               $doE_Project1 TEXT,
               $promotionDate TEXT,
               $retirementDate TEXT,
               $caste TEXT,
               $gender TEXT,
               $entryModeED TEXT,
               $prev_Proj TEXT,
               $empl_Group TEXT,
               $domicile_State TEXT,
               $regionED TEXT,
               $department_Group TEXT,
               $mobile TEXT,
               $email TEXT,
               $ph TEXT,
               $pH_Per TEXT,
               $areaOfRect TEXT,
               $fun_Exp TEXT,
               $location_Exp TEXT,
               $department_Exp TEXT,
               $workarea_Exp TEXT,
               $spouseID TEXT,
               $healthCheckUp TEXT,
               $subLocation_Exp TEXT,
               $holdKeyPositionName TEXT,
               $recruitmentArea TEXT,
               $doE_Grade TEXT,
               $keyPosition TEXT,
               $supose TEXT,
               $supose_EmpNo TEXT,
               $keyPositionPast TEXT,
               $lastYearLeaveStatus TEXT,
               $isVigilance TEXT
          )
          ''',
      );

      await db.execute(
        '''
          CREATE TABLE $jobPost_Applied_Emp(
              $jobIDJAE INTEGER,
              $empNoJAE INTEGER,
              $pernrJAE TEXT,
              $nameJAE TEXT,
              $gradeJAE TEXT,
              $projectJAE TEXT,
              $locationJAE TEXT,
              $departmentJAE TEXT,
              $department_GroupJAE TEXT,
              $designationJAE TEXT,
              $entrymodeJAE TEXT,
              $casteJAE TEXT,
              $domicile_StateJAE TEXT,
              $genderJAE TEXT,
              $prev_ProjJAE TEXT,
              $ageJAE INTEGER,
              $balanceJob INTEGER,
              $totalExp INTEGER,
              $totalYearProjectJAE INTEGER,
              $dobJAE TEXT,
              $doJ_NTPCJAE TEXT,
              $doE_GradeJAE TEXT,
              $doE_ProjectJAE TEXT,
              $retirementDateJAE TEXT,
              $doE_DeptJAE TEXT,
              $alertMsgJAE TEXT,
              $imgPath TEXT,
              $imgRealPathJAE TEXT,
              $applicantIDJAE INTEGER,
              $isShortlistJAE TEXT,
              $isMarkSelectedJAE TEXT,
              $docsPathJAE TEXT,
              $docsTitleJAE TEXT,
              $expertiseJAE TEXT,
              $descriptionsJAE TEXT,
              $keyPositionJAE TEXT,
              $isEligibleEmpJAE TEXT,
              $locationExpJAE TEXT,
              $functionExpJAE TEXT,
              $function_ExpJAE TEXT,
              $department_ExpJAE TEXT,
              $workarea_ExpJAE TEXT,
              $spouseIDJAE TEXT,
              $suposeDataJAE TEXT,
              $isLongLeaveJAE INTEGER
          )
          ''',
      );
      await db.execute(
        '''
          CREATE TABLE $rolesMenu(
          $roleIDRM INTEGER,
          $menuID INTEGER,
          $menuName TEXT,
          $menuLevel INTEGER,
          $apiIcon TEXT,
          $apiUrl TEXT,
          $parentMenuID INTEGER
          )
          ''',
      );
    });

    print("DataBase path  $path");
    return database;
  }

  Future<void> insertDepartments(String tableName, dynamic data) async {
    var db = await database;
    await db.execute("delete from " + tableName);
    var batch = db.batch();
    try {
      print("Inserting Table Data $tableName");
      for (int i = 0; i < data.length; i++) {
        // batch.insert(tableName, data[i].toJson());//Use this if you created model for data
        batch.insert(tableName,
            data[i]); //Use this if you did not created model for data
      }
      batch.commit();
    } catch (error) {
      print("Error to crate table $error");
    }
  }

  // Get Table data start
  getTableData(tableName) async {
    var db = await database;
    try {
      final result = await db.query("$tableName");

      return result;
      // print("$tableName $result");
      // for (int i = 0; i < result.length; i++) {
      //   print('users Table Data1 : ${result[i]} $i');
      // }
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getManageJobListing(tableName) async {
    var db = await database;
    try {
      final result = await db.query("$tableName");

      return result;
      // print("$tableName $result");
      // for (int i = 0; i < result.length; i++) {
      //   print('users Table Data1 : ${result[i]} $i');
      // }
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getSPVRegionOfflineData(tableName) async {
    var db = await database;
    String queryToGetData =
        "SELECT regionName,region_Code, sum (total) as total, sum (p_total) as p_Total, sum(t_total) as t_Total from tbl_spvdetails WHERE region_Code >0";

//     List regionCode = [1, 2, 3, 9, 8];

//     String regCode_S = "";

//     for (int i = 0; i < regionCode.length; i++) {
//       if (i == 0) {
//         regCode_S += " AND (region_Code = ${regionCode[i]}";
//       } else {
//         regCode_S += " OR region_Code = ${regionCode[i]}";
//       }
//     }

//     if (regCode_S != "") {
//       regCode_S += " )";
//     }

//     // By Location ID

//     List locationCode = [1, 2, 3, 9, 2004];

//     String location_S = "";

//     for (int i = 0; i < locationCode.length; i++) {
//       if (i == 0) {
//         location_S += " AND (projectID = ${locationCode[i]}";
//       } else {
//         location_S += " OR projectID = ${locationCode[i]}";
//       }
//     }

//     if (location_S != "") {
//       location_S += " )";
//     }

// //By SPV DEPT TYPE

//     String spvDeptType = "1";
//     String spvDeptType_S = "";
//     if (spvDeptType != "") {
//       spvDeptType_S += " AND svp_Dept_Type_ID= $spvDeptType";
//     }

//     queryToGetData = queryToGetData + regCode_S + location_S + spvDeptType_S;

    queryToGetData = queryToGetData + " group by regionName,region_Code";

    try {
      List result = await db.rawQuery("$queryToGetData");

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getSPVProjectOfflineData(tableName, getDataByregionID) async {
    print(regionID);
    var db = await database;
    try {
      List result = await db.rawQuery(
        "SELECT projectName,projectID,regionName, sum (total) as total, sum (p_total) as p_Total, sum(t_total) as t_Total from tbl_spvdetails  WHERE region_Code = $getDataByregionID group by projectName",
      );

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  dynamic holdValueToGetSPVDept = "";
  getSPVDeptTypeOfflineData(tableName, getDataByprojectID) async {
    holdValueToGetSPVDept = getDataByprojectID;
    var db = await database;
    try {
      List result = await db.rawQuery(
        "SELECT svp_Department_Type,svp_Dept_Type_ID, sum (total) as total, sum (p_total) as p_Total, sum(t_total) as t_Total from tbl_spvdetails  WHERE projectID = $getDataByprojectID group by svp_Department_Type",
      );

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getSPVDeptOfflineData(
    tableName,
    getDataByDeptTypeID,
  ) async {
    var db = await database;
    try {
      List result = await db.rawQuery(
        "SELECT svp_Department_Name,svp_Department_ID, sum (total) as total, sum (p_total) as p_Total, sum(t_total) as t_Total from tbl_spvdetails  WHERE svp_Dept_Type_ID = $getDataByDeptTypeID AND projectID =$holdValueToGetSPVDept group by svp_Department_Name",
      );
      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getTableDataToSee(tableName) async {
    var db = await database;
    try {
      final result = await db.query("$tableName");

      print("$tableName $result");
      for (int i = 0; i < result.length; i++) {
        print('users Table Data1 : ${result[i]} $i');
      }
    } catch (error) {
      print("Error to Get table $error");
    }
  }
  // Get table data end

  //Get data base on condition

  getDataBasedOnCondition(String tableName, requiredFilterData) async {
    final db = await database;

    try {
      print("Required Filter Data $requiredFilterData");
      List maps = await db.query("$tableName"); //all data 20

      print("Map data ${maps}");

      if (requiredFilterData['SearchTitle'] != "") {
        maps = maps
            .where((element) =>
                element['title'].toLowerCase().contains(title.toLowerCase()))
            .toList();
      }

      if (requiredFilterData['PositionType'] != "") {
        print(maps.length);
        maps = maps
            .where(
              (element) =>
                  element['positionType'] == requiredFilterData['PositionType'],
            )
            .toList();
      }

      List deptGroup = [];

      for (int i = 0; i < requiredFilterData['DepartmentGroup'].length; i++) {
        deptGroup = maps
            .where(
              (element) =>
                  element['dept_Group_Code'] ==
                  requiredFilterData['DepartmentGroup'][i],
            )
            .toList();
      }

      if (deptGroup.isNotEmpty) {
        maps.clear();
        maps.addAll(deptGroup);
      }

      List deptSubGroup = [];

      for (int i = 0;
          i < requiredFilterData['DepartmentSubGroup'].length;
          i++) {
        deptSubGroup = maps
            .where(
              (element) =>
                  element['dept_SubGroup_Code'] ==
                  requiredFilterData['DepartmentSubGroup'][i],
            )
            .toList();
      }

      if (deptSubGroup.isNotEmpty) {
        maps.clear();
        maps.addAll(deptSubGroup);
      }

      List dept = [];
      for (int i = 0; i < requiredFilterData['Department'].length; i++) {
        dept = maps
            .where(
              (element) =>
                  element['department_Code'] ==
                  requiredFilterData['Department'][i],
            )
            .toList();
      }

      if (dept.isNotEmpty) {
        maps.clear();
        maps.addAll(dept);
      }

      List projectCategory = [];
      for (int i = 0; i < requiredFilterData['ProjectCategory'].length; i++) {
        projectCategory = maps
            .where(
              (element) =>
                  element['projectCategory_Code'] ==
                  requiredFilterData['ProjectCategory'][i],
            )
            .toList();
      }

      if (projectCategory.isNotEmpty) {
        maps.clear();
        maps.addAll(projectCategory);
      }

      List project = [];
      for (int i = 0; i < requiredFilterData['Project'].length; i++) {
        project = maps
            .where(
              (element) =>
                  element['project_Code'] == requiredFilterData['Project'][i],
            )
            .toList();
      }

      if (project.isNotEmpty) {
        maps.clear();
        maps.addAll(project);
      }

      List grade = [];
      for (int i = 0; i < requiredFilterData['Grade'].length; i++) {
        grade = maps
            .where(
              (element) =>
                  element['grade_Code'].toString() ==
                  requiredFilterData['Grade'][i].toString(),
            )
            .toList();
      }

      if (grade.isNotEmpty) {
        maps.clear();
        maps.addAll(grade);
      }

      List vacentStatusData = [];
      if (requiredFilterData['VacentStatus'] == "1") {
        List dummyData = List.generate(
            maps.length, (index) => Map.from(maps[index]),
            growable: true);
        for (int i = 0; i < dummyData.length; i++) {
          if (maps[i]['totalSanctioned'] - dummyData[i]['totalPositioned'] <
              0) {
            vacentStatusData.add(dummyData[i]);
            print(dummyData[i]);
          }
        }
      }

      if (requiredFilterData['VacentStatus'] == "2") {
        List dummyData = List.generate(
            maps.length, (index) => Map.from(maps[index]),
            growable: true);
        for (int i = 0; i < dummyData.length; i++) {
          if (maps[i]['totalSanctioned'] - dummyData[i]['totalPositioned'] >
              0) {
            vacentStatusData.add(dummyData[i]);
            print(dummyData[i]);
          }
        }
      }

      if (vacentStatusData.isNotEmpty) {
        maps.clear();
        maps = vacentStatusData;
      }

      // List level = [];
      // for (int i = 0; i < requiredFilterData['Level'].length; i++) {
      //   level = maps
      //       .where(
      //         (element) =>
      //             element['grade_Code'].toString() ==
      //             requiredFilterData['Level'][i].toString(),
      //       )
      //       .toList();
      // }

      // if (level.isNotEmpty) {
      //   maps.clear();
      //   maps.addAll(level);
      // }

      print("Map Length ${maps.length}");
      if (maps.isEmpty) {
        print("isEmpty");
        Map response = {
          "code": 200,
          "status": "Ok",
          "totalRecord": "1123",
          "totalSanctioned": "1141",
          "totalPositioned": "929",
          "totalVacantOneM": "18",
          "totalVacantThreeM": "49",
          "totalVacantSixM": "79",
          "data": maps
        };
        return response;
      } else {
        print("isNot empty");
        Map response = {
          "code": 200,
          "status": "Ok",
          "totalRecord": "1123",
          "totalSanctioned": "1141",
          "totalPositioned": "929",
          "totalVacantOneM": "18",
          "totalVacantThreeM": "49",
          "totalVacantSixM": "79",
          "data": maps
        };
        return response;
      }
    } catch (error) {
      print("Error $error");
    }

    // if (title != "") {
    //   final List<Map<String, dynamic>> maps = await db.query(
    //     tableName,
    //     where: 'title = ?',
    //     // Pass the Dog's id as a whereArg to prevent SQL injection.
    //     whereArgs: [title],
    //   );
    // }

    // if (maps.isEmpty) {
    //   print("No Data found with  $title");
    //   return 0;
    // } else {
    //   print("Data found with ID $maps");

    //   return maps;
    // }
  }

  getKeyPositionDetails(tableName, positionID) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",

        where: 'positionID = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [positionID],
      );

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getMangeJobDetails(tableName, jobID, fieldName) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",

        where: '$fieldName = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [jobID],
      );

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getMangeJobOfflineDataAfterApplyingFilter(tableName, filterData) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",
        where:
            "jobID = ? OR title = ? OR regionID = ? OR projectID = ? OR locationID = ? OR dept_GroupID = ? OR dept_SUbGroupID = ? OR departmentID = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [
          filterData['SearchID'],
          filterData['SearchTitle'],
          filterData['Region'],
          filterData['Project'],
          filterData['Location'],
          filterData['Department_Group'],
          filterData['Department_SubGroup'],
          filterData['Department'],
        ],
      );

      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getUserProfileOffline(tableName, employeeId) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",
        where: 'empNo = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [employeeId],
      );
      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getApplicantDataOffline(tableName, id) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",
        where: 'jobID = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }

  getMenuOffline(tableName, id) async {
    var db = await database;
    try {
      final result = await db.query(
        "$tableName",
        where: 'roleID = ? AND parentMenuID = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id, 3],
      );
      return result;
    } catch (error) {
      print("Error to Get table $error");
    }
  }
}
