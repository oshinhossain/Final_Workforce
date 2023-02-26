import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../../helpers/hex_color.dart';
import '../../helpers/route.dart';

class ProjectManagementSettingsPage extends StatefulWidget {
  @override
  State<ProjectManagementSettingsPage> createState() =>
      _ProjectManagementSettingsPageState();
}

class _ProjectManagementSettingsPageState
    extends State<ProjectManagementSettingsPage> with Base {
  final materialkey1 = GlobalKey<State<Tooltip>>();
  final materialkey2 = GlobalKey<State<Tooltip>>();
  final materialkey3 = GlobalKey<State<Tooltip>>();
  final materialkey4 = GlobalKey<State<Tooltip>>();
  final projectKey1 = GlobalKey<State<Tooltip>>();
  final projectKey2 = GlobalKey<State<Tooltip>>();
  final projectKey3 = GlobalKey<State<Tooltip>>();
  final testKey1 = GlobalKey<State<Tooltip>>();
  final testKey2 = GlobalKey<State<Tooltip>>();
  final testKey3 = GlobalKey<State<Tooltip>>();
  final projectSiteKey1 = GlobalKey<State<Tooltip>>();
  final projectSiteKey2 = GlobalKey<State<Tooltip>>();
  final projectSiteKey3 = GlobalKey<State<Tooltip>>();

  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Container(),
        ],
        flexibleSpace: KAppbar(),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[2],
              //  boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 5.0, offset: Offset(0.0, 0.55))],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: hexToColor('#9BA9B3'),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Center(
                  child: KText(
                    text: 'Project Management Settings',
                    bold: true,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              //   height: 50,
              //   width: Get.width,
              //   // margin: EdgeInsets.symmetric(vertical: .5),

              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border(
              //       bottom: BorderSide(width: 2, color: Colors.grey.shade300),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       GestureDetector(
              //         onTap: () => back(),
              //         child: RenderSvg(
              //           path: 'icon_back',
              //           width: 13.0,
              //         ),
              //       ),
              //       KText(
              //         text: 'Project Management Settings',
              //         fontSize: 16,
              //         color: hexToColor('#41525A'),
              //         bold: true,
              //       ),
              //       SizedBox()
              //     ],
              //   ),
              // ),

              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -10,
                      left: 14,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: KText(
                          text: 'Materials Requisition Controls',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        kCheckBox('Apply Geography wise Budget', materialkey1,
                            projectmanagementsettingC.applyGeographywiseBudget),
                        kCheckBox(
                            'Apply Materials Drop Location',
                            materialkey2,
                            projectmanagementsettingC
                                .applyMaterialsDropLocation),
                        kCheckBox(
                            'Apply Geography wise Drop Location\n Restriction (Matrix)',
                            materialkey3,
                            projectmanagementsettingC
                                .applyGeographywiseDropLocation),
                        kCheckBox(
                            'Apply Inspection at Destination \n Drop Location',
                            materialkey4,
                            projectmanagementsettingC
                                .applyInspectionDestinationDropLocation),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              KText(
                                text: 'Enforcement: : ',
                                fontSize: 14,
                                bold: true,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    projectmanagementsettingC
                                            .projectenforcement.value =
                                        EnforcementProject.defaultControls;
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: Radio(
                                          value: EnforcementProject
                                              .defaultControls,
                                          groupValue: projectmanagementsettingC
                                              .projectenforcement.value,
                                          // activeColor: Colors.green,
                                          onChanged: projectmanagementsettingC
                                              .projectenforcement,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      KText(
                                        text: 'Default Controls',
                                        fontSize: 14.0,
                                        color: AppTheme.textColorlight,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    projectmanagementsettingC
                                            .projectenforcement.value =
                                        EnforcementProject.mandatoryControls;
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: Radio(
                                          value: EnforcementProject
                                              .mandatoryControls,
                                          groupValue: projectmanagementsettingC
                                              .projectenforcement.value,
                                          // activeColor: Colors.green,
                                          onChanged: projectmanagementsettingC
                                              .projectenforcement,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      KText(
                                        text: 'Mandatory Controls',
                                        fontSize: 14.0,
                                        color: AppTheme.textColorlight,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -10,
                      left: 14,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: KText(
                          text: 'Project Approval Authority',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        kCheckBox('1st Approver', projectKey1,
                            projectmanagementsettingC.projectApprovalAuthority),
                        SizedBox(
                          height: 5,
                        ),
                        //  1st Approver
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstProjectApproverAuthority
                                              .value =
                                          FirstProjectApproverAuthority
                                              .reportingManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: FirstProjectApproverAuthority
                                                .reportingManager,
                                            groupValue: projectmanagementsettingC
                                                .firstProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Reporting Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstProjectApproverAuthority
                                              .value =
                                          FirstProjectApproverAuthority
                                              .agencyManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: FirstProjectApproverAuthority
                                                .agencyManager,
                                            groupValue: projectmanagementsettingC
                                                .firstProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstProjectApproverAuthority
                                              .value =
                                          FirstProjectApproverAuthority
                                              .unitManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: FirstProjectApproverAuthority
                                                .unitManager,
                                            groupValue: projectmanagementsettingC
                                                .firstProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Unit Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstProjectApproverAuthority
                                              .value =
                                          FirstProjectApproverAuthority
                                              .agencyController;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: FirstProjectApproverAuthority
                                                .agencyController,
                                            groupValue: projectmanagementsettingC
                                                .firstProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox(
                            '2nd Approver',
                            projectKey2,
                            projectmanagementsettingC
                                .projectApprovalAuthority2),
                        //  2nd Approver
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondProjectApproverAuthority
                                              .value =
                                          SecondProjectApproverAuthority
                                              .unitManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectApproverAuthority
                                                    .unitManager,
                                            groupValue: projectmanagementsettingC
                                                .secondProjectApproverAuthority
                                                .value,
                                            onChanged: projectmanagementsettingC
                                                .secondProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Unit Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondProjectApproverAuthority
                                              .value =
                                          SecondProjectApproverAuthority
                                              .agencyController;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectApproverAuthority
                                                    .agencyController,
                                            groupValue: projectmanagementsettingC
                                                .secondProjectApproverAuthority
                                                .value,
                                            onChanged: projectmanagementsettingC
                                                .secondProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondProjectApproverAuthority
                                              .value =
                                          SecondProjectApproverAuthority
                                              .agencyManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectApproverAuthority
                                                    .agencyManager,
                                            groupValue: projectmanagementsettingC
                                                .secondProjectApproverAuthority
                                                .value,
                                            onChanged: projectmanagementsettingC
                                                .secondProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox(
                            '3rd Approver',
                            projectKey3,
                            projectmanagementsettingC
                                .projectApprovalAuthority3),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdProjectApproverAuthority
                                              .value =
                                          ThirdProjectApproverAuthority
                                              .locationmanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdProjectApproverAuthority
                                                .locationmanager,
                                            groupValue: projectmanagementsettingC
                                                .thirdProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Unit Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdProjectApproverAuthority
                                              .value =
                                          ThirdProjectApproverAuthority
                                              .agencyManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdProjectApproverAuthority
                                                .agencyManager,
                                            groupValue: projectmanagementsettingC
                                                .thirdProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdProjectApproverAuthority
                                              .value =
                                          ThirdProjectApproverAuthority
                                              .unitManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdProjectApproverAuthority
                                                .unitManager,
                                            groupValue: projectmanagementsettingC
                                                .thirdProjectApproverAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdProjectApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -7,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: KText(
                          text: 'Test Approval Authority',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            kCheckBox('1st Approver', testKey1,
                                projectmanagementsettingC.testAuthority),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          projectmanagementsettingC
                                                  .firstTestApprovalAuthority
                                                  .value =
                                              FirstTestApprovalAuthority
                                                  .projectManager;
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value:
                                                    FirstTestApprovalAuthority
                                                        .projectManager,
                                                groupValue:
                                                    projectmanagementsettingC
                                                        .firstTestApprovalAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged: projectmanagementsettingC
                                                    .firstTestApprovalAuthority,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            KText(
                                              text: 'Project Manager',
                                              fontSize: 14.0,
                                              color: AppTheme.textColorlight,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          projectmanagementsettingC
                                                  .firstTestApprovalAuthority
                                                  .value =
                                              FirstTestApprovalAuthority
                                                  .geographymatrix;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value:
                                                    FirstTestApprovalAuthority
                                                        .geographymatrix,
                                                groupValue:
                                                    projectmanagementsettingC
                                                        .firstTestApprovalAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged: projectmanagementsettingC
                                                    .firstTestApprovalAuthority,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            KText(
                                              text: 'Geography Matrix',
                                              fontSize: 14.0,
                                              color: AppTheme.textColorlight,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          projectmanagementsettingC
                                                  .firstTestApprovalAuthority
                                                  .value =
                                              FirstTestApprovalAuthority
                                                  .agencymanager;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value:
                                                    FirstTestApprovalAuthority
                                                        .agencymanager,
                                                groupValue:
                                                    projectmanagementsettingC
                                                        .firstTestApprovalAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged: projectmanagementsettingC
                                                    .firstTestApprovalAuthority,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            KText(
                                              text: 'Agency Manager',
                                              fontSize: 14.0,
                                              color: AppTheme.textColorlight,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          projectmanagementsettingC
                                                  .firstTestApprovalAuthority
                                                  .value =
                                              FirstTestApprovalAuthority
                                                  .agencycontroller;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value:
                                                    FirstTestApprovalAuthority
                                                        .agencycontroller,
                                                groupValue:
                                                    projectmanagementsettingC
                                                        .firstTestApprovalAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged: projectmanagementsettingC
                                                    .firstTestApprovalAuthority,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            KText(
                                              text: 'Agency Controller',
                                              fontSize: 14.0,
                                              color: AppTheme.textColorlight,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox('2nd Approver', testKey2,
                            projectmanagementsettingC.testAuthority2),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondTestApprovalAuthority
                                              .value =
                                          SecondTestApprovalAuthority
                                              .projectManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondTestApprovalAuthority
                                                .projectManager,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .secondTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Project Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondTestApprovalAuthority
                                              .value =
                                          SecondTestApprovalAuthority
                                              .geographymatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondTestApprovalAuthority
                                                .geographymatrix,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .secondTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Geography Matrix',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondTestApprovalAuthority
                                              .value =
                                          SecondTestApprovalAuthority
                                              .agencymanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondTestApprovalAuthority
                                                .agencymanager,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .secondTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondTestApprovalAuthority
                                              .value =
                                          SecondTestApprovalAuthority
                                              .agencycontroller;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondTestApprovalAuthority
                                                .agencycontroller,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .secondTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox('3rd Approver', testKey3,
                            projectmanagementsettingC.testAuthority3),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdTestApprovalAuthority
                                              .value =
                                          ThirdTestApprovalAuthority
                                              .projectManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdTestApprovalAuthority
                                                .projectManager,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .thirdTestApprovalAuthority
                                                    .value,
                                            onChanged: projectmanagementsettingC
                                                .thirdTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Project Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdTestApprovalAuthority
                                              .value =
                                          ThirdTestApprovalAuthority
                                              .geographymatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdTestApprovalAuthority
                                                .geographymatrix,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .thirdTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Geography Matrix',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdTestApprovalAuthority
                                              .value =
                                          ThirdTestApprovalAuthority
                                              .agencymanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdTestApprovalAuthority
                                                .agencymanager,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .thirdTestApprovalAuthority
                                                    .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdTestApprovalAuthority
                                              .value =
                                          ThirdTestApprovalAuthority
                                              .agencycontroller;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdTestApprovalAuthority
                                                .agencycontroller,
                                            groupValue:
                                                projectmanagementsettingC
                                                    .thirdTestApprovalAuthority
                                                    .value,
                                            onChanged: projectmanagementsettingC
                                                .thirdTestApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -7,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: KText(
                          text: 'Project Site Relocation Approval Authority',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        kCheckBox('1st Approver', projectSiteKey1,
                            projectmanagementsettingC.projectSiteAuthority1),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstprojectsiteRelocationApprovalAuthority
                                              .value =
                                          FirstProjectSiteRelocationApprovalAuthority
                                              .projectManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                FirstProjectSiteRelocationApprovalAuthority
                                                    .projectManager,
                                            groupValue: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Project Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstprojectsiteRelocationApprovalAuthority
                                              .value =
                                          FirstProjectSiteRelocationApprovalAuthority
                                              .geographymatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                FirstProjectSiteRelocationApprovalAuthority
                                                    .geographymatrix,
                                            groupValue: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Geography Matrix',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstprojectsiteRelocationApprovalAuthority
                                              .value =
                                          FirstProjectSiteRelocationApprovalAuthority
                                              .agencymanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                FirstProjectSiteRelocationApprovalAuthority
                                                    .agencymanager,
                                            groupValue: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .firstprojectsiteRelocationApprovalAuthority
                                              .value =
                                          FirstProjectSiteRelocationApprovalAuthority
                                              .agencycontroller;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                FirstProjectSiteRelocationApprovalAuthority
                                                    .agencycontroller,
                                            groupValue: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .firstprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox('2nd Approver', projectSiteKey2,
                            projectmanagementsettingC.projectSiteAuthority2),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondprojectsiteRelocationApprovalAuthority
                                              .value =
                                          SecondProjectSiteRelocationApprovalAuthority
                                              .projectManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectSiteRelocationApprovalAuthority
                                                    .projectManager,
                                            groupValue: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Project Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondprojectsiteRelocationApprovalAuthority
                                              .value =
                                          SecondProjectSiteRelocationApprovalAuthority
                                              .geographymatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectSiteRelocationApprovalAuthority
                                                    .geographymatrix,
                                            groupValue: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Geography Matrix',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondprojectsiteRelocationApprovalAuthority
                                              .value =
                                          SecondProjectSiteRelocationApprovalAuthority
                                              .agencymanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectSiteRelocationApprovalAuthority
                                                    .agencymanager,
                                            groupValue: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .secondprojectsiteRelocationApprovalAuthority
                                              .value =
                                          SecondProjectSiteRelocationApprovalAuthority
                                              .agencycontroller;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                SecondProjectSiteRelocationApprovalAuthority
                                                    .agencycontroller,
                                            groupValue: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .secondprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        kCheckBox('3rd Approver', projectSiteKey3,
                            projectmanagementsettingC.projectSiteAuthority3),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdprojectsiteRelocationApprovalAuthority
                                              .value =
                                          ThirdProjectSiteRelocationApprovalAuthority
                                              .projectManager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                ThirdProjectSiteRelocationApprovalAuthority
                                                    .projectManager,
                                            groupValue: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Project Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdprojectsiteRelocationApprovalAuthority
                                              .value =
                                          ThirdProjectSiteRelocationApprovalAuthority
                                              .geographymatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                ThirdProjectSiteRelocationApprovalAuthority
                                                    .geographymatrix,
                                            groupValue: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Geography Matrix',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdprojectsiteRelocationApprovalAuthority
                                              .value =
                                          ThirdProjectSiteRelocationApprovalAuthority
                                              .agencymanager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                ThirdProjectSiteRelocationApprovalAuthority
                                                    .agencymanager,
                                            groupValue: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Manager',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      projectmanagementsettingC
                                              .thirdprojectsiteRelocationApprovalAuthority
                                              .value =
                                          ThirdProjectSiteRelocationApprovalAuthority
                                              .agencycontroller;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value:
                                                ThirdProjectSiteRelocationApprovalAuthority
                                                    .agencycontroller,
                                            groupValue: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority
                                                .value,
                                            // activeColor: Colors.green,
                                            onChanged: projectmanagementsettingC
                                                .thirdprojectsiteRelocationApprovalAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Agency Controller',
                                          fontSize: 14.0,
                                          color: AppTheme.textColorlight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        // height: 40,
        width: Get.width,
        // margin: EdgeInsets.symmetric(vertical: .5),

        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Global.confirmDialog(onConfirmed: () {
                  // kLog('done');
                  back();
                });
                // if (createTrasnportOrderC.transportOrderDate.isNotEmpty) {
                //   push(CreateTransportLineItemsPage());
                // }

                // print('dd');

                // showTopSnackBar(
                //   context,
                //   CustomSnackBar.success(
                //     message: "Submitted",
                //   ),
                // );
              },
              child: Obx(
                () => Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#007BEC').withOpacity(
                        createTrasnportOrderC.transportOrderDate.isEmpty
                            ? .5
                            : 1),
                  ),
                  child: Center(
                    child: KText(
                      text: 'Save',
                      color: Colors.white,
                      bold: true,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget kCheckBox(String title, GlobalKey key, RxBool v) {
    return GestureDetector(
      onTap: () {
        v.toggle();
      },
      child: Row(
        children: [
          Checkbox(
            // visualDensity: VisualDensity(
            //     horizontal: VisualDensity.minimumDensity,
            //     vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: v.value,
            onChanged: (x) {
              v.toggle();
            },
            activeColor: hexToColor('#84BEF3'),
          ),
          // SizedBox(
          //   width: 12,
          // ),
          KText(
            text: title,
            fontSize: 14,
          ),
          Tooltip(
            key: key,
            triggerMode: TooltipTriggerMode.longPress,
            message: 'Lorem Ipsum is simply dummy text',
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.appbarColor,
                border: Border.all(
                    width: 1.5, color: AppTheme.textColor.withOpacity(.1))),
            // padding: EdgeInsets.all(10),
            textStyle: TextStyle(
                fontFamily: 'Manrope Regular',
                color: AppTheme.textColor,
                fontSize: 13),
            // child: IconButton(
            //   visualDensity: VisualDensity(
            //       horizontal: VisualDensity.minimumDensity,
            //       vertical: VisualDensity.minimumDensity),
            //   onPressed: () {
            //     final dynamic tooltip = key.currentState!;
            //     tooltip?.ensureTooltipVisible();
            //   },
            //   icon: Icon(Icons.info_outline),
            //   color: Colors.grey,
            // ),
          ),
        ],
      ),
    );
  }
}
