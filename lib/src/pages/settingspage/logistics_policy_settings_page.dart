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

// ignore: camel_case_types

class LogisticsPolicySettingsPage extends StatefulWidget {
  @override
  State<LogisticsPolicySettingsPage> createState() =>
      _LogisticsPolicySettingsPageState();
}

class _LogisticsPolicySettingsPageState
    extends State<LogisticsPolicySettingsPage> with Base {
  final restrictDriversKey = GlobalKey<State<Tooltip>>();
  final restrictVehiclesKey = GlobalKey<State<Tooltip>>();

  final applyInspectorSourceKey = GlobalKey<State<Tooltip>>();
  final applyVehicleKey = GlobalKey<State<Tooltip>>();
  final applyRecipientKey = GlobalKey<State<Tooltip>>();
  final applyVehicleStartKey = GlobalKey<State<Tooltip>>();
  final applyMaterialsDropKey = GlobalKey<State<Tooltip>>();
  final applyInspectorDestinationKey = GlobalKey<State<Tooltip>>();
  final applyGeographyKey = GlobalKey<State<Tooltip>>();

  final approveKey1 = GlobalKey<State<Tooltip>>();
  final approveKey2 = GlobalKey<State<Tooltip>>();
  final approveKey3 = GlobalKey<State<Tooltip>>();

//  String? gender;

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
                    text: 'Logistics Policy Settings',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  kCheckBox(
                      'Restrict Drivers to Agency Pool',
                      restrictDriversKey,
                      logisticPolicySettingsC.restrictDriversAgencyPool),
                  kCheckBox(
                      'Restrict Vehicles to Agency Pool',
                      restrictVehiclesKey,
                      logisticPolicySettingsC.restrictVehiclesAgencyPool),
                ],
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
                      child: KText(
                        text: ' Transportation Order controls  ',
                        fontSize: 14,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        kCheckBox(
                            'Apply Inspector at Source',
                            applyInspectorSourceKey,
                            logisticPolicySettingsC.applyInspectorsource),
                        kCheckBox('Apply Vehicle Readiness', applyVehicleKey,
                            logisticPolicySettingsC.applyVehicleReadiness),
                        kCheckBox(
                            'Apply Recipient Readiness',
                            applyRecipientKey,
                            logisticPolicySettingsC.applyRecipientReadiness),
                        kCheckBox(
                            'Apply Vehicle Starting by Driver',
                            applyVehicleStartKey,
                            logisticPolicySettingsC.applyVehicleStart),
                        kCheckBox(
                            'Apply Materials Dropping by Driver',
                            applyMaterialsDropKey,
                            logisticPolicySettingsC.applyMaterialsDrop),
                        kCheckBox(
                            'Apply Inspection at Destination',
                            applyInspectorDestinationKey,
                            logisticPolicySettingsC.applyInspectionDestination),
                        kCheckBox(
                            'Apply Geography at Destination',
                            applyGeographyKey,
                            logisticPolicySettingsC.applyGeography),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Enforcement: : ',
                                fontSize: 14,
                                bold: true,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    logisticPolicySettingsC.enforcement.value =
                                        Enforcement.defaultControls;
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: Radio(
                                          value: Enforcement.defaultControls,
                                          groupValue: logisticPolicySettingsC
                                              .enforcement.value,
                                          // activeColor: Colors.green,
                                          onChanged: logisticPolicySettingsC
                                              .enforcement,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
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
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    logisticPolicySettingsC.enforcement.value =
                                        Enforcement.mandatoryControls;
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: Radio(
                                          value: Enforcement.mandatoryControls,
                                          groupValue: logisticPolicySettingsC
                                              .enforcement.value,
                                          // activeColor: Colors.green,
                                          onChanged: logisticPolicySettingsC
                                              .enforcement,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
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
                                height: 15,
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
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -10,
                      left: 14,
                      child: Container(
                        child: KText(
                          text: ' Approval Authority for Transport Order  ',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            kCheckBox(
                                '1st Approver',
                                approveKey1,
                                logisticPolicySettingsC
                                    .approvalAuthoritytransportOrder1),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          logisticPolicySettingsC
                                                  .firstApproverAuthority
                                                  .value =
                                              FirstApproverAuthority
                                                  .reportingManager;
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value: FirstApproverAuthority
                                                    .reportingManager,
                                                groupValue:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority,
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
                                          logisticPolicySettingsC
                                                  .firstApproverAuthority
                                                  .value =
                                              FirstApproverAuthority
                                                  .agencyManager;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value: FirstApproverAuthority
                                                    .agencyManager,
                                                groupValue:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority
                                                        .value,
                                                onChanged:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority,
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
                                          logisticPolicySettingsC
                                                  .firstApproverAuthority
                                                  .value =
                                              FirstApproverAuthority
                                                  .geographymatrix;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value: FirstApproverAuthority
                                                    .geographymatrix,
                                                groupValue:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority,
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
                                          logisticPolicySettingsC
                                                  .firstApproverAuthority
                                                  .value =
                                              FirstApproverAuthority
                                                  .unitManager;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value: FirstApproverAuthority
                                                    .unitManager,
                                                groupValue:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority,
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
                                          logisticPolicySettingsC
                                                  .firstApproverAuthority
                                                  .value =
                                              FirstApproverAuthority
                                                  .agencyController;
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: Radio(
                                                value: FirstApproverAuthority
                                                    .agencyController,
                                                groupValue:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority
                                                        .value,
                                                // activeColor: Colors.green,
                                                onChanged:
                                                    logisticPolicySettingsC
                                                        .firstApproverAuthority,
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
                        kCheckBox(
                            '2nd Approver',
                            approveKey2,
                            logisticPolicySettingsC
                                .approvalAuthoritytransportOrder2),
                        // SizedBox(
                        //   height: 10,
                        // ),
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
                                      logisticPolicySettingsC
                                              .secondApproverAuthority.value =
                                          SecondApproverAuthority
                                              .locationmanager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondApproverAuthority
                                                .locationmanager,
                                            groupValue: logisticPolicySettingsC
                                                .secondApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .secondApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Location Manager',
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
                                      logisticPolicySettingsC
                                              .secondApproverAuthority.value =
                                          SecondApproverAuthority.agencyManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondApproverAuthority
                                                .agencyManager,
                                            groupValue: logisticPolicySettingsC
                                                .secondApproverAuthority.value,
                                            onChanged: logisticPolicySettingsC
                                                .secondApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .secondApproverAuthority.value =
                                          SecondApproverAuthority
                                              .geographyMatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondApproverAuthority
                                                .geographyMatrix,
                                            groupValue: logisticPolicySettingsC
                                                .secondApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .secondApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .secondApproverAuthority.value =
                                          SecondApproverAuthority.unitManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondApproverAuthority
                                                .unitManager,
                                            groupValue: logisticPolicySettingsC
                                                .secondApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .secondApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .secondApproverAuthority.value =
                                          SecondApproverAuthority
                                              .agencyController;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: SecondApproverAuthority
                                                .agencyController,
                                            groupValue: logisticPolicySettingsC
                                                .secondApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .secondApproverAuthority,
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
                            '3rd Approver',
                            approveKey3,
                            logisticPolicySettingsC
                                .approvalAuthoritytransportOrder3),
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
                                      logisticPolicySettingsC
                                              .thirdApproverAuthority.value =
                                          ThirdApproverAuthority
                                              .locationmanager;
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdApproverAuthority
                                                .locationmanager,
                                            groupValue: logisticPolicySettingsC
                                                .thirdApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .thirdApproverAuthority,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: 'Location Manager',
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
                                      logisticPolicySettingsC
                                              .thirdApproverAuthority.value =
                                          ThirdApproverAuthority.agencyManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdApproverAuthority
                                                .agencyManager,
                                            groupValue: logisticPolicySettingsC
                                                .thirdApproverAuthority.value,
                                            onChanged: logisticPolicySettingsC
                                                .thirdApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .thirdApproverAuthority.value =
                                          ThirdApproverAuthority
                                              .geographyMatrix;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdApproverAuthority
                                                .geographyMatrix,
                                            groupValue: logisticPolicySettingsC
                                                .thirdApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .thirdApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .thirdApproverAuthority.value =
                                          ThirdApproverAuthority.unitManager;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdApproverAuthority
                                                .unitManager,
                                            groupValue: logisticPolicySettingsC
                                                .thirdApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .thirdApproverAuthority,
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
                                      logisticPolicySettingsC
                                              .thirdApproverAuthority.value =
                                          ThirdApproverAuthority
                                              .agencyController;
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15.0,
                                          height: 15.0,
                                          child: Radio(
                                            value: ThirdApproverAuthority
                                                .agencyController,
                                            groupValue: logisticPolicySettingsC
                                                .thirdApproverAuthority.value,
                                            // activeColor: Colors.green,
                                            onChanged: logisticPolicySettingsC
                                                .thirdApproverAuthority,
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

  // Widget singleDropLocation() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                     activeColor: hexToColor('#84BEF3'),
  //                     value: createTrasnportOrderC.isSingleDropLocation.value,
  //                     onChanged: (bool? value) =>
  //                         createTrasnportOrderC.isSingleDropLocation.toggle()),
  //               ),
  //             ),
  //             KText(
  //               text: 'Single Drop Location (Unloading Point)',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 2,
  //             ),
  //             KText(
  //               text: '*',
  //               color: Colors.redAccent,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),

  //             Container(
  //               padding: EdgeInsets.all(0),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   createTrasnportOrderC.allLocationBottomSheet(
  //                     locationPoint: LocationPoint.unloading,
  //                     title: 'Single drop location',
  //                   );
  //                   // .searchLocationBottomsheet('Single drop location');
  //                 },
  //                 // child: SvgPicture.asset(
  //                 //   '${Constants.svgPath}/icon_search_elements.svg',
  //                 //   color: hexToColor('#66A1D9'),
  //                 //   width: 20,
  //                 // ),
  //                 child: RenderSvg(
  //                   path: 'icon_search_elements',
  //                   width: 26,
  //                   color: hexToColor('#66A1D9'),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 8,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: createTrasnportOrderC.getDropLocationName() == null
  //                   ? 'Select drop location'
  //                   : createTrasnportOrderC.getDropLocationName(),
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: 'ETD (Estimated Time of Delivery)',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 2,
  //             ),
  //             KText(
  //               text: '*',
  //               color: Colors.redAccent,
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(0),
  //               child: IconButton(
  //                 onPressed: () async {
  //                   DateTime? pickedDate = await showDatePicker(
  //                     context: Get.context!,
  //                     initialDate: DateTime.now(),
  //                     firstDate: DateTime(1950),
  //                     //DateTime.now() - not to allow to choose before today.
  //                     lastDate: DateTime.now().add(Duration(days: 1095)),
  //                   );
  //                   if (pickedDate != null) {
  //                     String formattedDate =
  //                         DateFormat('yyyy-MM-dd').format(pickedDate);
  //                     createTrasnportOrderC.etd.value = formattedDate;
  //                   } else {}
  //                 },
  //                 icon: Icon(
  //                   Icons.calendar_month_outlined,
  //                   color: AppTheme.primaryColor,
  //                   size: 18,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: createTrasnportOrderC.etd.value.isEmpty
  //                   ? 'Select ETD'
  //                   : createTrasnportOrderC.etd.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget travelPath() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                     activeColor: hexToColor('#84BEF3'),
  //                     value: createTrasnportOrderC.isPrescribeTravelPath.value,
  //                     onChanged: (bool? value) =>
  //                         createTrasnportOrderC.isPrescribeTravelPath.toggle()),
  //               ),
  //             ),
  //             KText(
  //               text: 'Prescribe Travel Path',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),

  //             Container(
  //               padding: EdgeInsets.all(0),
  //               child: GestureDetector(
  //                 onTap: () {},
  //                 // child: SvgPicture.asset(
  //                 //   '${Constants.svgPath}/icon_search_elements.svg',
  //                 //   color: hexToColor('#66A1D9'),
  //                 //   width: 20,
  //                 // ),
  //                 child: RenderSvg(
  //                   path: 'icon_search_elements',
  //                   width: 26,
  //                   color: hexToColor('#66A1D9'),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: KText(
  //                 text: createTrasnportOrderC.prescribeTravelPath.value.isEmpty
  //                     ? 'select travel path'
  //                     : createTrasnportOrderC.prescribeTravelPath.value,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget singleRecivingPerson() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               // child: SizedBox(
  //               //   height: 20,
  //               //   width: 20,
  //               //   child: Checkbox(
  //               //     activeColor: hexToColor('#84BEF3'),
  //               //     value: logisticsettingC.isSingleRecivingParty.value,
  //               //     onChanged: (bool? _) =>
  //               //         logisticsettingC.isSingleRecivingParty.toggle(),
  //               //   ),
  //               // ),
  //             ),
  //             KText(
  //               text: 'Single Receiving Person',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),

  //             Container(
  //               padding: EdgeInsets.all(0),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   createTrasnportOrderC
  //                       .searchUserBottomsheet('Single Receiving Party');
  //                 },
  //                 // child: SvgPicture.asset(
  //                 //   '${Constants.svgPath}/icon_search_elements.svg',
  //                 //   color: hexToColor('#66A1D9'),
  //                 //   width: 20,
  //                 // ),
  //                 child: RenderSvg(
  //                   path: 'icon_search_elements',
  //                   width: 26,
  //                   color: hexToColor('#66A1D9'),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 10),
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffF5F5FA),
  //                   borderRadius: BorderRadius.circular(50),
  //                   border: Border.all(
  //                     color: Color.fromARGB(255, 220, 220, 233),
  //                     style: BorderStyle.solid,
  //                     width: 2,
  //                   ),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Color(0xffF5F5FA).withOpacity(0.6),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: Container(
  //                   height: 38,
  //                   width: 38,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(1.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child: RenderImg(
  //                         path: 'icon_avatar.png',
  //                         width: 37,
  //                         height: 37,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: createTrasnportOrderC.singleReciverPartyName.value.isEmpty
  //                   ? 'select single receving party'
  //                   : createTrasnportOrderC.singleReciverPartyName.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(
                fontFamily: 'Manrope Regular',
                color: AppTheme.textColor,
                fontSize: 13),
          ),
        ],
      ),
    );
  }
}
