import 'package:get/get.dart';
import 'package:workforce/src/controllers/app_version_controller.dart';
import 'package:workforce/src/controllers/apply_for_advance_controller.dart';
import 'package:workforce/src/controllers/apply_for_loan_controller.dart';
import 'package:workforce/src/controllers/area_search_controller.dart';
import 'package:workforce/src/controllers/attendance_controller.dart';
import 'package:workforce/src/controllers/auth_controller.dart';
import 'package:workforce/src/controllers/confirm_material_receipt_controller.dart';
import 'package:workforce/src/controllers/content_controller.dart';
import 'package:workforce/src/controllers/create_materials_requisition_controller.dart';
import 'package:workforce/src/controllers/create_transport_controller.dart';
import 'package:workforce/src/controllers/expense_reimbursement_workbench_controller.dart';
import 'package:workforce/src/controllers/link_inspection_controller.dart';
import 'package:workforce/src/controllers/link_work_status_controller.dart';
import 'package:workforce/src/controllers/location_controller.dart';
import 'package:workforce/src/controllers/logistics_workbench_controller.dart';
import 'package:workforce/src/controllers/material_delivery_location_planing_controller.dart';
import 'package:workforce/src/controllers/inspect_materials_controller.dart';
import 'package:workforce/src/controllers/driver_search_controller.dart';
import 'package:workforce/src/controllers/load_materials_to_vehicle_controller.dart';
import 'package:workforce/src/controllers/map_view_controller.dart';
import 'package:workforce/src/controllers/material_controller.dart';
import 'package:workforce/src/controllers/materials_budgeting_workbench_controller.dart';
import 'package:workforce/src/controllers/menu_controller.dart';
import 'package:workforce/src/controllers/post_my_task_controller.dart';
import 'package:workforce/src/controllers/project%20_planning_board_controller.dart';
import 'package:workforce/src/controllers/site_completion_controller.dart';
import 'package:workforce/src/controllers/site_completion_status_controller.dart';
import 'package:workforce/src/controllers/site_inspection_controller.dart';
import 'package:workforce/src/controllers/task_detail_controller.dart';
import 'package:workforce/src/controllers/transpotation_history_controller.dart';
import 'package:workforce/src/controllers/travel_path_controller.dart';
import 'package:workforce/src/controllers/ui_controller.dart';
import 'package:workforce/src/controllers/unload_materials_controller.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/controllers/warehouse_workbench_controller.dart';
import 'package:workforce/src/pages/call/call_controller.dart';
import '../controllers/agencyController.dart';
import '../controllers/assing_geographie_project_controller.dart';
import '../controllers/change_request_controller.dart';
import '../controllers/geography_workbanch_controller.dart';
import '../controllers/maintain_test_type_controller.dart';
import '../controllers/network_link_installation_summery_controller.dart';
import '../controllers/network_topology_controller.dart';
import '../controllers/inspection_workbench_destination_controller.dart';
import '../controllers/pole_installation_summery_controller.dart';
import '../controllers/project _planing_board_dropdown_controller.dart';
import '../controllers/project_activity_group_board_controller.dart';
import '../controllers/project_progress_dashboard_controller.dart';
import '../controllers/receiving_workbench_controller.dart';
import '../controllers/confirm_recipient_readiness_controller.dart';
import '../controllers/create_vehicle_controller.dart';
import 'package:workforce/src/controllers/home_dashbord_task_progress_controller.dart';
import '../controllers/driver_workbench_controller.dart';
import '../controllers/inspection_workbench_controller.dart';
import '../controllers/my_activity_dashboad_create_activity_controller.dart';
import '../controllers/my_activity_dashboard_controller.dart';
import '../controllers/my_approval_dashboard_controller.dart';
import '../controllers/project_dashboard_operational_controller.dart';
import '../controllers/project_dashbord_home_controller.dart';
import '../controllers/project_management_settings_controller.dart';
import '../controllers/push_notifications_controller.dart';
import '../controllers/record_test_result_controller.dart';
import '../controllers/register_as_driver_controller.dart';
import '../controllers/request_site_location_controller.dart';
import '../controllers/logistic_policy_settings_controller.dart';
import '../controllers/request_site_relocation_controller.dart';
import '../controllers/site_locations_controller.dart';
import '../controllers/confirm_transport_readiness_controller.dart';
import '../controllers/inspect_materials_at_drop_location_controller.dart';
import '../controllers/project_dashboard_create_controller.dart';
import '../controllers/start_journey_controller.dart';
import '../controllers/assign_vehicle_driver_controller.dart';
import '../controllers/transportation_controller.dart';
import '../controllers/transportation_workbench_controller.dart';
import '../controllers/travel_request_workbench_controller.dart';
import '../controllers/user_location_trace_controller.dart';
import '../controllers/vehicle_and_driver_controller.dart';
import '../controllers/vehicle_on_the_map_controller.dart';
import '../controllers/transportation_dashboard_controller.dart';
import '../controllers/transport_order_controller.dart';
import '../pages/call/socket_service.dart';

class Base {
  final locationC = Get.put(LocationController());
  final userLocationTraceC = Get.put(UserLocationTraceController());
  final contentC = Get.put(ContentController());
  final authC = Get.put(AuthController());
  final userC = Get.put(UserController());
  final menuC = Get.put(MenuController());
  final mapViewC = Get.put(MapViewController());
  final materialC = Get.put(MaterialController());
  final attendanceC = Get.put(AttendanceController());
  final uiC = Get.put(UiController());
  final createTrasnportOrderC = Get.put(CreateTransportController());
  final loadMaterialsToVehicleC = Get.put(LoadMaterialsToVehicleController());
  final inspectMaterialsC = Get.put(InspectMaterialsController());
  final confirmTransportReadinessC =
      Get.put(ConfirmTransportReadinessController());
  final confirmRecipientReadinessC =
      Get.put(ConfirmRecipientReadinessController());
  final inspectMaterialsDropLocationC =
      Get.put(InspectMaterialsAtDropLocationController());
  final callC = Get.put(CallController());

  // final confirmTransportReadinessC =
  //     Get.put(ConfirmTransportReadinessController());
  // final confirmRecipientReadinessC =
  //     Get.put(ConfirmRecipientReadinessController());
  // final inspectMaterialsDropLocationC =
  //     Get.put(InspectMaterialsAtDropLocationController());

  // nahid
  final confirmMaterialReceiptC = Get.put(ConfirmMaterialReceiptController());
  final travelPathC = Get.put(TravelPathController());
  final vehicleOnTheMapC = Get.put(VehicleOnTheMapController());
  final myActivityDashboardC = Get.put(MyAcitivityDashboardController());
  final myActivityDashboardCreateActivityC =
      Get.put(MyActivityDashboardCreateActivityController());
  final inspectWorkbenchC = Get.put(InspectionWorkbenchController());
  final driverWorkbenchC = Get.put(DriverWorkbenchController());
  final inspectionWorkbenchDestinationC =
      Get.put(InspectionWorkbenchDestinationController());
  final transportationC = Get.put(TransportationController());
  final versionC = Get.put(VersionController());
  final changeRequestC = Get.put(ChangeRequestController());

  final assignVehicleAndDriverC = Get.put(AssignVehicleDriverController());
  final projectProgressDashboardC =
      Get.put(ProjectProgressDashboardController());
  final projectActivityGroupBoardC =
      Get.put(ProjectActivityGroupBoardController());

  final driverSearchC = Get.put(DriverSearchController());
  final unloadMaterialsC = Get.put(UnloadMaterialsController());
  final createMaterialReqC = Get.put(CreateMaterialsRequisitionController());
  final createMaterialC = Get.put(CreateMaterialsRequisitionController());

  final notificationsC = Get.put(PushNotificationsController());

  final startJourneyDriverConfirmC = Get.put(StartJourneyController());
  final postTaskC = Get.put(PostMyTaskController());
  final taskDetailC = Get.put(TaskDetailController());
  final projectDashboardCreateC = Get.put(ProjectDashboardCreateController());
  final transportationDashboardC = Get.put(TransportationDashboardController());

  final transportOrderC = Get.put(TransportOrderController());
  final siteLocationsC = Get.put(SiteLocationsController());
  final areaSearchC = Get.put(AreaSearchController());
  final networkTopologyC = Get.put(NetworkTopologyController());
  final requestSiteRelocationC = Get.put(RequestSiteRelocationController());
  final requestSiteLocationsC = Get.put(RequestSiteLocationsController());
  final registerAsDriverC = Get.put(RegisterAsDriverController());
  final createVehicleC = Get.put(CreateVehicleController());
  final projectDashbordC = Get.put(ProjectDashbordController());

  final projectDashbordOperationalC =
      Get.put(ProjectDashbordOparationalController());

  final taskProgressC = Get.put(TaskProgressController());

  final agencyC = Get.put(AgencyController());
  final vehicleAndDriverC = Get.put(VehicleAndDriverController());

  final transotationHistoryC = Get.put(TranspotationHistoryController());
  final deliveryLocPlaningC =
      Get.put(MaterialsDeliveryLocationPlanningController());

  final transportationWorkbenchC = Get.put(TransportationWorkbenchController());
  final warehouseWorkbenchC = Get.put(WarehouseWorkbenchController());
  final myApprovalDashboardC = Get.put(MyApprovalDashboardController());

  final logisticsWorkbenchC = Get.put(LogisticsWorkbenchController());

  final confirmmaterialrecevingWorkbenchC =
      Get.put(ReceivingWorkbenchController());

  final materialBudgetWorkbenchC =
      Get.put(MaterialBudgetingWorkbenchController());

  // final defineGoodDeliveryLocC = Get.put(DefineGoodsDeliveryLocationGeographyController());

  final logisticPolicySettingsC = Get.put(LogisticPolicySettingsController());

  final projectmanagementsettingC =
      Get.put(ProjectManagementSettingsController());

  //project planning controller

  final projectPlanningBoardC = Get.put(ProjectPlanningBoardController());
  final projectPlanningBoardDropDownC =
      Get.put(ProjectPlanningBoardDropDownController());

  //maintain test type
  final maintainTestTypeCreateC = Get.put(MaintainTestTypeController());

  final siteCompletionC = Get.put(SiteCompletionController());
  final siteCompletionStatusC = Get.put(SiteCompletionStausController());
  final linkStatusC = Get.put(LinkWorkStatusController());
  final linkInspectionC = Get.put(LinkInspectionController());
  final recordTestResultC = Get.put(RecordTestResultController());
  final siteInspectionC = Get.put(SiteInspectionController());
  final PISummeryC = Get.put(PoleInstallationSummeryController());
  final NLISummeryC = Get.put(NetworkLinkInstallationSummeryController());
  final assignGeographiesProjectC =
      Get.put(AssignGeographiesProjectController());
  final geographyWorkBanchC = Get.put(GeographyWorkBanchController());
  final loanC = Get.put(ApplyForLoanController());
  final advanceC = Get.put(ApplyForAdvanceController());
  final expenseRWC = Get.put(ExpenseReimbursementWorkbenchController());
  final travelRWC = Get.put(TravelRequestWorkbenchController());

  final socketS = Get.put(SocketService());
}
