import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../helpers/hex_color.dart';
import '../helpers/route.dart';

class CreateRiskPage extends StatefulWidget {
  @override
  State<CreateRiskPage> createState() => _CreateRiskPageState();
}

class _CreateRiskPageState extends State<CreateRiskPage> with Base {
  @override
  void initState() {
    createTrasnportOrderC.getProjectName();
    super.initState();
  }

  @override
  void dispose() {
    createTrasnportOrderC.resetData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    projectDashboardCreateC.getActivityName();
    projectDashboardCreateC.getProjectName();
    projectDashboardCreateC.getBucketName();
    return Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
        body: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    height: 55,
                    width: Get.width,
                    // margin: EdgeInsets.symmetric(vertical: .5),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: Colors.black12,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => back(),
                          child: RenderSvg(
                            path: 'cross_icon',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        KText(
                          text: '             Create Risk',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        SizedBox(
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: hexToColor('#CFD7DD'),
                      border: Border.all(color: AppTheme.nBorderC1),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          color: hexToColor('#EEF0F6'),
                        )
                      ],
                    ),
                    height: 60,
                    width: Get.width,
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(text: 'Project Name:'),
                          SizedBox(
                            width: 8,
                          ),
                          KText(
                            text: 'BTCL Haor-Baor Project',
                            bold: true,
                            fontSize: 14,
                          ),
                        ]),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: 'Bucket',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  projectDashboardCreateC
                                      .openProjectNameDialog();
                                },
                                child: RenderSvg(
                                  path: 'dropdown',
                                  height: 10,
                                  width: 10,
                                ),
                              )
                            ],
                          ),

                          KText(
                            text: projectDashboardCreateC
                                    .projectName.value.isEmpty
                                ? ''
                                : projectDashboardCreateC.projectName.value,
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: 'Activity Group',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                              GestureDetector(
                                // onTap: () {
                                //   projectDashboardCreateC.openProjectNameDialog();
                                // },
                                child: RenderSvg(
                                  path: 'dropdown',
                                  height: 10,
                                  width: 10,
                                ),
                              )
                            ],
                          ),
                          KText(
                            text: projectDashboardCreateC
                                    .projectName.value.isEmpty
                                ? ''
                                : projectDashboardCreateC.projectName.value,
                          ),

                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),

                          // SizedBox(
                          //   width: 2,
                          // ),

                          // TextFormField(
                          //   onChanged: projectDashboardCreateC.projectName,
                          //   decoration: InputDecoration(
                          //     labelText: '01',
                          //     labelStyle: TextStyle(
                          //         color: hexToColor('#D9D9D9'), fontSize: 14),
                          //   ),
                          // ),

                          SizedBox(
                            height: 10,
                          ),
                          KText(
                            text: 'Activity',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole Erection',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),

                          // Obx(
                          //   () => KText(
                          //     text: projectDashboardCreateC.bucketName.value.isEmpty
                          //         ? ''
                          //         : projectDashboardCreateC.bucketName.value,
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),

                          KText(
                            text: 'Risk Title',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole Damage After Election',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),

                          KText(
                              text: 'Risk Description',
                              color: AppTheme.nTextLightC,
                              fontSize: 14),

                          TextFormField(
                            initialValue:
                                projectDashboardCreateC.description.value == ''
                                    ? ''
                                    : projectDashboardCreateC.description.value,
                            onChanged: projectDashboardCreateC.description,
                            decoration: InputDecoration(
                              labelText: 'Write advice here',
                              labelStyle: TextStyle(
                                  color: hexToColor('#D9D9D9'), fontSize: 14),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          KText(
                            text: 'Impact',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole Erection',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),
                          KText(
                            text: 'Likelihood',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Medium',
                                fontSize: 14,
                                color: hexToColor('#80939D'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),
                          KText(
                              text: 'Mitigation Plan',
                              color: AppTheme.nTextLightC,
                              fontSize: 14),

                          TextFormField(
                            initialValue:
                                projectDashboardCreateC.description.value == ''
                                    ? ''
                                    : projectDashboardCreateC.description.value,
                            onChanged: projectDashboardCreateC.description,
                            decoration: InputDecoration(
                              labelText: 'Write details here',
                              labelStyle: TextStyle(
                                  color: hexToColor('#D9D9D9'), fontSize: 14),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                width: 116,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: hexToColor('#9BA9B3')),
                                child: Center(
                                  child: KText(
                                    text: 'Cancel',
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  projectDashboardCreateC
                                      .postCreateProjectActivityAdd();
                                  // print(
                                  //     '..........................................................................');
                                  // print('dhjwhqd');
                                },
                                child: Container(
                                  height: 34,
                                  width: 116,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: hexToColor('#449EF1')),
                                  child: Center(
                                    child: KText(
                                      text: 'Create',
                                      fontSize: 16,
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
}
