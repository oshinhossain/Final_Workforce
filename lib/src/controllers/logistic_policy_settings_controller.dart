import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/enums/enums.dart';

class LogisticPolicySettingsController extends GetxController with ApiService {
  //logistics setting
  final restrictDriversAgencyPool = RxBool(false);
  final restrictVehiclesAgencyPool = RxBool(false);

  final applyInspectorsource = RxBool(false);
  final applyVehicleReadiness = RxBool(false);
  final applyRecipientReadiness = RxBool(false);
  final applyVehicleStart = RxBool(false);
  final applyMaterialsDrop = RxBool(false);
  final applyInspectionDestination = RxBool(false);
  final applyGeography = RxBool(false);

  // final applyGeographywiseBudget = RxBool(false);
  // final applyMaterialsDropLocation = RxBool(false);
  // final applyGeographywiseDropLocation = RxBool(false);
  // final applyInspectionDestinationDropLocation = RxBool(false);

  final approvalAuthoritytransportOrder1 = RxBool(false);
  final approvalAuthoritytransportOrder2 = RxBool(false);
  final approvalAuthoritytransportOrder3 = RxBool(false);

  final enforcement = Rx<Enforcement>(Enforcement.defaultControls);

  final firstApproverAuthority =
      Rx<FirstApproverAuthority>(FirstApproverAuthority.reportingManager);

  final secondApproverAuthority =
      Rx<SecondApproverAuthority>(SecondApproverAuthority.unitManager);

  final thirdApproverAuthority =
      Rx<ThirdApproverAuthority>(ThirdApproverAuthority.agencyController);

  //
  final selected = RxString('');
  final firstApprover = RxList([
    'Reporting Manager',
    'Location Manager',
    'Unit Manager',
    'Agency Manager',
    'Geography Matrix'
  ]);
  final secondApprover = RxList([
    'Location Manager',
    'Unit Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller'
  ]);
  final thirdApprover = RxList([
    'Location Manager',
    'Unit Manager',
    'Agency Manager',
    'Geography Matrix',
    'Agency Controller'
  ]);

// project Management setting

}
