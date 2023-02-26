import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/enums/enums.dart';

class ProjectManagementSettingsController extends GetxController
    with ApiService {
  //logistics setting

  //project management setting

  final applyGeographywiseBudget = RxBool(false);
  final applyMaterialsDropLocation = RxBool(false);
  final applyGeographywiseDropLocation = RxBool(false);
  final applyInspectionDestinationDropLocation = RxBool(false);

  // final enforcement = RxBool(false);
// project Management setting

  final projectApprovalAuthority = RxBool(false);
  final projectApprovalAuthority2 = RxBool(false);
  final projectApprovalAuthority3 = RxBool(false);
  final testAuthority = RxBool(false);
  final testAuthority2 = RxBool(false);
  final testAuthority3 = RxBool(false);
  final projectSiteAuthority1 = RxBool(false);
  final projectSiteAuthority2 = RxBool(false);
  final projectSiteAuthority3 = RxBool(false);

  final projectenforcement =
      Rx<EnforcementProject>(EnforcementProject.defaultControls);

  final firstProjectApproverAuthority = Rx<FirstProjectApproverAuthority>(
      FirstProjectApproverAuthority.reportingManager);

  final secondProjectApproverAuthority = Rx<SecondProjectApproverAuthority>(
      SecondProjectApproverAuthority.unitManager);

  final thirdProjectApproverAuthority = Rx<ThirdProjectApproverAuthority>(
      ThirdProjectApproverAuthority.agencyController);

  //
  final firstApproverProject = RxList([
    'Reporting Manager',
    'Unit Manager',
    'Agency Manager',
    'Agency Controller',
  ]);
  final secondApproverProject = RxList([
    'Unit Manager',
    'Agency Manager',
    'Agency Controller',
  ]);
  final thirdApproverProject = RxList([
    'Unit Manager',
    'Agency Manager',
    'Agency Controller',
  ]);

  //Test Approval Authority
  final firstTestApprovalAuthority = Rx<FirstTestApprovalAuthority>(
      FirstTestApprovalAuthority.geographymatrix);

  final secondTestApprovalAuthority = Rx<SecondTestApprovalAuthority>(
      SecondTestApprovalAuthority.projectManager);

  final thirdTestApprovalAuthority =
      Rx<ThirdTestApprovalAuthority>(ThirdTestApprovalAuthority.projectManager);

  final firstTestApproval = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);
  final secondTestApproval = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);
  final thirdTestApproval = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);

//project site Relocation Approval Authority

  final firstprojectsiteRelocationApprovalAuthority =
      Rx<FirstProjectSiteRelocationApprovalAuthority>(
          FirstProjectSiteRelocationApprovalAuthority.geographymatrix);

  final secondprojectsiteRelocationApprovalAuthority =
      Rx<SecondProjectSiteRelocationApprovalAuthority>(
          SecondProjectSiteRelocationApprovalAuthority.projectManager);

  final thirdprojectsiteRelocationApprovalAuthority =
      Rx<ThirdProjectSiteRelocationApprovalAuthority>(
          ThirdProjectSiteRelocationApprovalAuthority.agencycontroller);

  final firstProjectSiteRelocation = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);
  final secondProjectSiteRelocation = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);
  final thirdProjectSiteRelocation = RxList([
    'Project Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller',
  ]);
}
