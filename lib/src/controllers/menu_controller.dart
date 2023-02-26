import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/sidebar.dart';
import 'package:workforce/src/models/sidebar_children.dart';
import 'package:workforce/src/pages/add_driver_agency_page.dart';
import 'package:workforce/src/pages/add_vehicle_to_agency_page.dart';
import 'package:workforce/src/pages/advance_application_workbench_page.dart';
import 'package:workforce/src/pages/attendance_page.dart';

import 'package:workforce/src/pages/change_request_workbench_page.dart';
import 'package:workforce/src/pages/expense_reimbursement_workbench_page.dart';
import 'package:workforce/src/pages/home_page.dart';
import 'package:workforce/src/pages/inspection_workbench_destination_page.dart';
import 'package:workforce/src/pages/link_inspection_result_page.dart';
import 'package:workforce/src/pages/link_work_status_page.dart';
import 'package:workforce/src/pages/loan_application_workbench_page.dart';
import 'package:workforce/src/pages/maintain_test_type_page.dart';
import 'package:workforce/src/pages/project_progress_dashboard_page.dart';
import 'package:workforce/src/pages/settingspage/logistics_policy_settings_page.dart';
import 'package:workforce/src/pages/settingspage/network_management_settings_page.dart';
import 'package:workforce/src/pages/settingspage/project_management_settings_page.dart';
import 'package:workforce/src/pages/site_completion_page.dart';
import 'package:workforce/src/pages/site_completion_status_page.dart';

import 'package:workforce/src/pages/site_inspection_page.dart';
import 'package:workforce/src/pages/travel_request_workbench_page.dart';
import '../config/app_theme.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../models/right_side_bar_model.dart';
import '../pages/logistics_workbench_page.dart';
import '../pages/my_geography_workbench_for_equipment_inspector_page.dart';
import '../pages/my_geography_workbench_for_network_inspector_page.dart';
import '../pages/my_geography_workbench_for_equipment_installer_page.dart';
import '../pages/my_geography_workbench_for_network_installer_page.dart';
import '../pages/my_geography_workbench_for_site_inspector_page.dart';
import '../pages/my_geography_workbench_for_site_installer_page.dart';
import '../pages/network_topology_page.dart';
import '../pages/project_planning_board_page.dart';
import '../pages/receiving_workbench_page.dart';
import '../pages/create_vehicle_page.dart';
import '../pages/driver_workbench_page.dart';
import '../pages/inspection_workbench_page.dart';
import '../pages/post_my_task_progress.dart';
import '../pages/record_test_result_create_page.dart';
import '../pages/register_as_driver_page.dart';
import '../pages/request_site_relocation_page.dart';
import '../pages/site_locations_page.dart';
import '../pages/transport_dashboard_transport_agency_page.dart';
import '../pages/transportation_workbench_page.dart';
import '../pages/warehouse_workbench_page.dart';

class MenuController extends GetxController {
  final globalKey = GlobalKey<ScaffoldState>();

  final leftSidebar = [
    // Sidebar(
    //   svgPath: 'personal_data_icon',
    //   title: 'My Personal Data',
    //   children: [
    //     // SidebarChildren(
    //     //   title: 'Update My Profile',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Validate My Identity',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Enroll My Biometrics',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Authorize the Use of My data',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Change My Password',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Register My Vehicle',
    //     // ),
    //     // SidebarChildren(
    //     //   title: 'Register as a Driver',
    //     // ),
    //   ],
    // ),

    Sidebar(
      title: 'Manage Agency',
      svgPath: 'manage_agency',
      children: [
        // SidebarChildren(
        //   title: 'Register My Agency',
        // ),
        // SidebarChildren(
        //   title: 'Register Agency Vehicle',
        // ),
        SidebarChildren(
          title: 'Add Driver to Agency',
        ),
        SidebarChildren(
          title: 'Add Vehicle to Agency',
        ),
        // SidebarChildren(
        //   title: 'Maintain Test Type',
        // ),
        // SidebarChildren(
        //   title: 'Maintain Business Locations',
        // ),
        // SidebarChildren(
        //   title: 'Manage Agency Team',
        // ),
        // SidebarChildren(
        //   title: 'Agency Team Locations',
        // ),
        // SidebarChildren(
        //   title: 'My Team Locations',
        // ),
        SidebarChildren(
          title: 'Post My Attendance',
        ),
      ],
    ),
    // Sidebar(
    //   title: 'User Feedback',
    //   svgPath: 'user_feedback',
    //   children: [
    //     SidebarChildren(
    //       title: 'UI FeedBack',
    //     ),
    //     SidebarChildren(
    //       title: 'User Complaints',
    //     ),
    //   ],
    // ),
    // Sidebar(
    //   svgPath: 'app_settings',
    //   title: 'App Settings',
    //   children: [
    //     SidebarChildren(
    //       title: 'App Settings',
    //     ),
    //     SidebarChildren(
    //       title: 'Update App Configurations',
    //     ),
    //   ],
    // ),
  ];

  final rightSidebar = [
    RightSidebar(
        svgPath: 'icon_project_management',
        title: 'Project Management',
        rightSidebarofSideBar: [
          RightSidebarofSideBar(
            subTitle: 'Reporting and Analysis',
            subSvgPath: 'icon_reporting_and_analysis',
            subChildren: [
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Dashboard',
              // ),

              //            case 'Network Topology for Geography':
              // back();
              // return push(NetworkTopologyPage());
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Network Topology for Geography',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Project Progress Report',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Project Sites',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Site Completion Report',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Conduct Project Test',
              // ),

              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Plan with RASCI',
              // ),
            ],
          ),
          RightSidebarofSideBar(
            subTitle: 'Data Entry and Processing',
            subSvgPath: 'icon_dataentry_and_processing',
            subChildren: [
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Change Request',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Site Installation',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Site Inspection',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Network Installation',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Network Inspection',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Equipment Installation',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'My Geography for Equipment Inspection',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Post Project Progress',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Post Site Work Progress',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Post Site Inspection Result',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Escalate Challanges',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Assess Project Risks',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Conduct Project Test',
              ),
            ],
          ),
          RightSidebarofSideBar(
            subTitle: 'Setup and Configuration',
            subSvgPath: 'icon_setup_configure',
            subChildren: [
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Project Planning Board',
              ),

              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Activity Planning Board',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Geographies',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Partners',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Project Test Types',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Test Approvers',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Project Testers',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Setup Project Sites',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Assess Project Risks',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Project Mgt. Settings',
              ),
            ],
          ),
        ]),
    RightSidebar(
        svgPath: 'icn_logistic_operation',
        title: 'Logistic Operation',
        rightSidebarofSideBar: [
          RightSidebarofSideBar(
            subTitle: 'Reporting and Analysis',
            subSvgPath: 'icon_reporting_and_analysis',
            subChildren: [
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Transportation Dashboard',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Vehicle Fleet Dashboard',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Drivers Dashboard',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Transportation Map',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Transportation Order History',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Transportation Summary',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Transportation Routes on Map',
              // ),
            ],
          ),
          RightSidebarofSideBar(
            subTitle: 'Data Entry and Processing',
            subSvgPath: 'icon_dataentry_and_processing',
            subChildren: [
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Place Transportation Orders',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Assign Vehicles and Drivers',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Inspect Materials before Loading',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Load Materials to Vehicle',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Deliver Materials',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Inspect Delivered Materials',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Receive Delivered Materials',
              ),
            ],
          ),
          RightSidebarofSideBar(
            subTitle: 'Setup and Configuration',
            subSvgPath: 'icon_setup_configure',
            subChildren: [
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Register Driver',
              ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Register Vehicle',
              ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Define Travel Routes',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Define Transportation Tariff Plan',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Define Known Locations',
              // ),
              // RightSidebarChildrenofChildern(
              //   subTitleofTitle: 'Define Agency Warehouses',
              // ),
              RightSidebarChildrenofChildern(
                subTitleofTitle: 'Logistic Settings',
              ),
            ],
          ),
        ]),
    RightSidebar(
      svgPath: 'icon_network_management',
      title: 'Network Management',
      rightSidebarofSideBar: [
        RightSidebarofSideBar(
          subTitle: 'Reporting and Analysis',
          subSvgPath: 'icon_reporting_and_analysis',
          subChildren: [
            RightSidebarChildrenofChildern(
              subTitleofTitle: 'Network Topology for Geography',
            ),
            // RightSidebarChildrenofChildern(
            //   subTitleofTitle: 'Full Network Topology',
            // ),
            // RightSidebarChildrenofChildern(
            //   subTitleofTitle: 'Equipment Status in Geography',
            // ),
            // RightSidebarChildrenofChildern(
            //   subTitleofTitle: 'Trouble Ticket Dashboard',
            // ),
          ],
        ),
        // RightSidebarofSideBar(
        //   subTitle: 'Data Entry and Processing',
        //   subSvgPath: 'icon_dataentry_and_processing',
        //   subChildren: [
        //     RightSidebarChildrenofChildern(
        //       subTitleofTitle: 'Install Network Links',
        //     ),
        //     RightSidebarChildrenofChildern(
        //       subTitleofTitle: 'Install Network Equipments',
        //     ),
        //     RightSidebarChildrenofChildern(
        //       subTitleofTitle: 'Trouble Tickets Board',
        //     ),
        //   ],
        // ),

        RightSidebarofSideBar(
          subTitle: 'Data Entry and Processing',
          subSvgPath: 'icon_dataentry_and_processing',
          subChildren: [
            RightSidebarChildrenofChildern(
              subTitleofTitle: 'Post Link Work Progress',
            ),
            RightSidebarChildrenofChildern(
              subTitleofTitle: 'Post Link Inspection Result',
            ),
          ],
        ),
        RightSidebarofSideBar(
          subTitle: 'Setup and Configuration',
          subSvgPath: 'icon_setup_configure',
          subChildren: [
            // RightSidebarChildrenofChildern(
            //   subTitleofTitle: 'Network Link Design Board',
            // ),
            // RightSidebarChildrenofChildern(
            //   subTitleofTitle: 'Equipment Configurations',
            // ),
            RightSidebarChildrenofChildern(
              subTitleofTitle: 'NMS Settings',
            ),
          ],
        ),
      ],
    ),

    // RightSidebar(
    //     svgPath: 'icon_construction',
    //     title: 'Construction',
    //     rightSidebarofSideBar: [
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //     ]),
    // RightSidebar(
    //     svgPath: 'icon_payment',
    //     title: 'Payment',
    //     rightSidebarofSideBar: [
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //       RightSidebarofSideBar(
    //         subTitle: 'Demo Content',
    //         subChildren: [
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //           RightSidebarChildrenofChildern(
    //             subTitleofTitle: 'Demo Content',
    //           ),
    //         ],
    //       ),
    //     ]),
  ];

  final currentIndex = RxInt(1);

  set setCurrentIndex(String item) => currentIndex.value = getMenuIndex(item);

  Widget getCurrentPage() {
    switch (currentIndex.value) {
      case 0:
        return HomePage();
      case 1:
        return HomePage();

      // case 2:
      //   return ;

      default:
        return Container(
          height: 1000,
          color: Colors.white,
          width: Get.width,
        );
    }
    // switch (currentIndex.value) {
    //   case 0:
    //     return MapPage();
    //   case 1:
    //     return ListViewTaskPage();
    //   case 2:
    //     return HomePage();
    //   case 3:
    //     return ConversationListPage();
    //   case 4:
    //     return Container(
    //       height: 1000,
    //       color: Colors.white,
    //       width: Get.width,
    //     );
    //   default:
    //     return Container(
    //       height: 1000,
    //       color: Colors.white,
    //       width: Get.width,
    //     );
    // }
  }

  final bottomMenus = [
    'bottom_1.svg',
    // 'bottom_2.svg',
    'bottom_3.svg',
    // 'bottom_4.svg',
    'bottom_5.svg'
  ];

//   // 3-12-2022..........................................................

//   final currentIndex = RxInt(2);

//   set setCurrentIndex(String item) => currentIndex.value = getMenuIndex(item);

//   Widget getCurrentPage() {
//     switch (currentIndex.value) {
//       case 0:
//         return MapPage();
//       case 1:
//         return ListViewTaskPage();
//       case 2:
//         return HomePage();
//       case 3:
//         return ConversationListPage();
//       case 4:
//         return Container(
//           height: 1000,
//           color: Colors.white,
//           width: Get.width,
//         );
//       default:
//         return Container(
//           height: 1000,
//           color: Colors.white,
//           width: Get.width,
//         );
//     }
//   }

//   final bottomMenus = [
//     'bottom_1.svg',
//     'bottom_2.svg',
//     'icon_bottom_navigation_dashboard.svg',
//     'bottom_4.svg',
//     'bottom_5.svg'
//   ];

// //...............................................................

  final appbarMenus = [
    // 'top_1.svg',
    'top_2.svg',
    // 'top_3.svg',
    // 'top_4.svg',
    'top_5.svg'
  ];

  int getMenuIndex(String item) {
    return bottomMenus.indexOf(item);
  }

//left
  void pushMenuleft(String title) {
    switch (title) {
      case 'Add Vehicle to Agency':
        back();
        return push(AddVehicleToAgencyPage());

      case 'Add Driver to Agency':
        back();
        return push(AddDriverToAgencyPage());
      case 'Post My Attendance':
        back();
        return push(AttendancePage());
      case 'Maintain Test Type':
        back();
        return push(MaintainTestTypePage());

      // case '':
      //   back();
      //   return push();

      default:
        {
          Get.snackbar(
            'Attention!!',
            'Development in progress',
            colorText: AppTheme.black,
            backgroundColor: AppTheme.appHomePageColor,
            snackPosition: SnackPosition.BOTTOM,
            dismissDirection: DismissDirection.horizontal,
            maxWidth: 190,
          );
          //statements;
        }
    }
  }

//right
  void pushMenu(String title) {
    switch (title) {
      case 'Place Transportation Orders':
        back();
        return push(TransportationWorkbenchPage());

      case 'Project Sites':
        back();
        return push(SiteLocationsPage());
      case 'Site Completion Report':
        back();
        return push(SiteCompletionStatusPage());
      case 'Assign Vehicles and Drivers':
        back();
        return push(LogisticWorkbenchPage());

      case 'Inspect Materials before Loading':
        back();
        return push(InspectionWorkbenchPage());

      case 'Load Materials to Vehicle':
        back();
        return push(WareHouseWorkbenchPage());

      case 'Deliver Materials':
        back();
        return push(DriverWorkbenchPage());

      case 'Inspect Delivered Materials':
        back();
        return push(InspectionWorkbenchDestinationPage());

      case 'Receive Delivered Materials':
        back();
        return push(ReceivingWorkbenchPage());

      case 'Post Project Progress':
        back();
        return push(PostMyTaskProgress());

      case 'My Geography for Site Installation':
        back();
        return push(MyGeographyForSiteInstaller());

      case 'My Geography for Site Inspection':
        back();
        return push(MyGeographyForSiteInspector());

      case 'My Geography for Network Installation':
        back();
        return push(MyGeographyForNetworkInstaller());

      case 'My Geography for Network Inspection':
        back();
        return push(MyGeographyForNetworkInspector());

      case 'My Geography for Equipment Installation':
        back();
        return push(MyGeographyForEquipmentInstaller());

      case 'My Geography for Equipment Inspection':
        back();
        return push(MyGeographyForEquipmentInspector());

      // case 'Project Dashboard':
      //   back();
      //   return push(ProjectDashboardPage());

      case 'Transportation Dashboard':
        back();
        return push(TransportationDashboardTransportAgencyPage());

      case 'Register Vehicle':
        back();
        return push(CreateVehiclePage());

      case 'Register Driver':
        back();
        return push(RegisterAsDriverPage());
      case 'Project Planning Board':
        back();
        return push(ProjectPlanningBoardPage());
      // case 'Change Request Workbench':
      //   back();
      //   return push(ProjectActivityGroupBoardPage());

      case 'Project Progress Report':
        back();
        return push(ProjectProgressDashboardPage());

      case 'Network Topology for Geography':
        back();
        return push(NetworkTopologyPage());
      case 'Setup Project Sites':
        back();
        return push(RequestSiteRelocationPage());
      // case 'Maintain Test Type':
      //   back();
      //   return push(MaintainTestTypePage());
      // case '':
      //   back();
      //   return push();
      case 'Post Site Work Progress':
        back();
        return push(SiteCompletionPage());
      case 'Post Site Inspection Result':
        back();
        return push(SiteInspectionPage());
      case 'Change Request':
        back();
        return push(ChangeRequestWorkbenchPage());

      case 'Conduct Project Test':
        back();
        return push(RecordTestResultCreatePage());
      case 'Project Test Types':
        back();
        return push(MaintainTestTypePage());
      case 'Post Link Work Progress':
        back();
        return push(LinkWorkStatusPage());
      case 'Post Link Inspection Result':
        back();
        return push(LinkInspectionPage());
      case 'Project Mgt. Settings':
        back();
        return push(ProjectManagementSettingsPage());
      case 'Logistic Settings':
        back();
        return push(LogisticsPolicySettingsPage());
      case 'NMS Settings':
        back();
        return push(NetworkManagementSettingsPage());
      default:
        {
          Get.snackbar('Attention!!', 'Development in progress',
              colorText: AppTheme.black,
              backgroundColor: AppTheme.appHomePageColor,
              snackPosition: SnackPosition.BOTTOM,
              maxWidth: 190,
              duration: Duration(seconds: 3));
          //statements;
        }
    }
  }
}

//

searchLocationBottomSheet() async {
  try {
    await Get.bottomSheet(
      ignoreSafeArea: true,

      isScrollControlled: true,
      persistent: false,
      isDismissible: true,

      // Obx(
      //   () =>
      SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: 320,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  back();
                  push(LoanApplicationWorkbenchPage());
                },
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: SizedBox(
                    height: 30,
                    width: 60,
                    child: RenderSvg(
                      path: 'icon_demo',
                    ),
                  ),
                  title:
                      KText(text: 'Apply for Loan', bold: true, fontSize: 15),
                  trailing: KText(text: ''),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  back();
                  push(AdvanceApplicationWorkbenchPage());
                },
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: SizedBox(
                    height: 30,
                    width: 60,
                    child: RenderSvg(
                      path: 'icon_demo',
                    ),
                  ),
                  title: KText(
                      text: 'Apply for Advance', bold: true, fontSize: 15),
                  trailing: KText(text: ''),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  back();
                  push(ExpenseReimbursementWorkbenchPage());
                },
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: SizedBox(
                    height: 30,
                    width: 60,
                    child: RenderSvg(
                      path: 'icon_demo',
                    ),
                  ),
                  title: KText(
                      text: 'Expense Reimbursement', bold: true, fontSize: 15),
                  trailing: KText(text: ''),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  back();
                  push(TravelRequestWorkbenchPage());
                },
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: SizedBox(
                    height: 30,
                    width: 60,
                    child: RenderSvg(
                      path: 'icon_demo',
                    ),
                  ),
                  title:
                      KText(text: 'Travel Request', bold: true, fontSize: 15),
                  trailing: KText(text: ''),
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
      // ),

      //backgroundColor: Colors.white,
      elevation: 0,
    ).then((value) {
      // search.value = '';
      // locations.clear();

      // isLoadding.value = false;
      //// kLog('closed');
    });
  } catch (e) {
    print(e);
  }
}
