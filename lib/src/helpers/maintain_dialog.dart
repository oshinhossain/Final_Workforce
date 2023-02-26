import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/test_criterias_model.dart';
import '../config/app_theme.dart';
import '../controllers/maintain_test_type_controller.dart';
import '../models/criteria_group_get_model.dart';
import '../models/maintain_test_type_mode.dart';
import '../models/scenario_groupdata_get_model.dart';
import 'hex_color.dart';
import 'k_text.dart';

class MaintainDialog with Base {
  MaintainDialog._();
  //show error dialog

  static void editTestCriteriaInputDialog({
    required String title,
    required String labelText,
    required MaintainTestTypeController controller,
    required MaintainTest item,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: title,
                      bold: true,
                      fontSize: 18,
                    ),
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: '${item.projectName!} > ${item.testTypeName!}',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Type Code:',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.testTypeCode,
                          initialValue: '${item.testTypeCode}',
                          decoration: InputDecoration(
                            hintText: 'Project code will be here',
                            // labelText: 'Project code will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Test Type Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.testTypeName,
                          initialValue: '${item.testTypeName}',
                          decoration: InputDecoration(
                            hintText: 'Test Type Name will be here',

                            // labelText: 'Test Type Name will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            //
                            InkWell(
                              onTap: () {
                                back();
                                //     controller.updateData(id: ,projectCode: ,projectId: ,projectName: );
                                if (controller.maintainTestTypeList.every(
                                    (element) =>
                                        element.testTypeName!.toLowerCase() !=
                                        controller.testTypeName
                                            .toLowerCase())) {
                                  controller.updateData(
                                      projectId: item.projectId!,
                                      projectCode: item.projectCode!,
                                      id: item.id!,
                                      projectName: item.projectName!);
                                } else {
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'Already Exist',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));

                                  //  offAll(ProjectDashboardv1());

                                }
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

                            // GestureDetector(
                            //   onTap: () {
                            //     controller.updateData(
                            //       id: item.id!,
                            //       projectId: item.projectId!,
                            //       projectName: item.projectName!,
                            //       projectCode: item.projectCode!,
                            //     );
                            //     if (controller.maintainTestTypeList.every(
                            //         (element) =>
                            //             element.testTypeName!.toLowerCase() !=
                            //             controller.testTypeName
                            //                 .toLowerCase())) {
                            //       controller.maintainCreateTestType();
                            //     } else {
                            //       Get.defaultDialog(
                            //           barrierDismissible: false,
                            //           onWillPop: () {
                            //             return Future.value(false);
                            //           },
                            //           backgroundColor: Colors.white,
                            //           title: '',
                            //           content: Container(
                            //             alignment: Alignment.center,
                            //             height: 200,
                            //             width: Get.width,
                            //             child: Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.center,
                            //               children: [
                            //                 Icon(
                            //                   Icons.close,
                            //                   color: Colors.red.withOpacity(.8),
                            //                   size: 60,
                            //                 ),
                            //                 SizedBox(
                            //                   height: 22,
                            //                 ),
                            //                 Center(
                            //                   child: KText(
                            //                     text: 'same Group name',
                            //                     maxLines: 3,
                            //                     fontSize: 14,
                            //                     bold: false,
                            //                     color: AppTheme.textColor,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   height: 22,
                            //                 ),
                            //                 SizedBox(
                            //                   width: Get.width / 2,
                            //                   child: TextButton(
                            //                     onPressed: () {
                            //                       Get.back();
                            //                     },
                            //                     style: ButtonStyle(
                            //                         backgroundColor:
                            //                             MaterialStateProperty
                            //                                 .all(AppTheme
                            //                                     .primaryColor)),
                            //                     child: KText(
                            //                       text: 'OK',
                            //                       bold: true,
                            //                       color: Colors.white,
                            //                     ),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ));
                            //       //  offAll(ProjectDashboardv1());

                            //     }
                            //   },
                            //   child: Container(
                            //     height: 34,
                            //     width: 116,
                            //     decoration: BoxDecoration(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(8)),
                            //         color: hexToColor('#449EF1')),
                            //     child: Center(
                            //       child: KText(
                            //         text: 'Create',
                            //         fontSize: 16,
                            //         color: Colors.white,
                            //         bold: true,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),

                    // OTPInput(),
                    // NewPasswordInput(),
                    // ConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void creatTestTypeDialog({
    required String title,
    required String labelText,
    required String pName,
    required String tName,
    required MaintainTestTypeController controller,
    // required MaintainTestTypeController controller,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: KText(
                    text: '$pName ',
                    color: hexToColor('#80939D'),
                    fontSize: 13,
                    maxLines: 3,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //   KText(
                        //   text: 'Project Name',
                        //   color: hexToColor('#80939D'),
                        //   fontSize: 13,
                        // ),
                        KText(
                          text: 'Type Code:',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),

                        TextFormField(
                          onChanged: controller.testTypeCode,
                          decoration: InputDecoration(
                            //   labelText: 'Test Type code will be here',
                            hintText: 'Test Type code will be here',

                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Test Type Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.testTypeName,
                          decoration: InputDecoration(
                            //labelText: 'Test Type Name will be here',
                            hintText: 'Test Type Name will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            //
                            GestureDetector(
                              onTap: () {
                                if (controller.maintainTestTypeList.every(
                                    (element) =>
                                        element.testTypeName!.toLowerCase() !=
                                        controller.testTypeName
                                            .toLowerCase())) {
                                  controller.maintainCreateTestType();
                                } else {
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'same Group name',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());

                                }
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
                      ],
                    ),

                    // OTPInput(),
                    // NewPasswordInput(),
                    // ConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //creat Criteria Group

  static void createCriteriaGroupInputDialog({
    required String projectId,
    required String id,
    required String title,
    required String labelText,
    required String pName,
    // required String tName,
    required MaintainTestTypeController controller,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      //     text: '${item.projectName!} > ${item.testTypeName!}',
                      text: pName,
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Group Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.groupCode,
                          decoration: InputDecoration(
                            // labelText: 'Project group code will be here',
                            hintText: 'Project group code will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KText(
                            text: 'Criteria Group Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.groupName,
                          decoration: InputDecoration(
                            // labelText: 'Project group name will be here',
                            hintText: 'Criteria group name will be here',

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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                print(
                                    'group code ${controller.groupCode.value} group name ${controller.groupName.value}');

                                if (controller.criteriaGroupList.every(
                                    (element) =>
                                        element.groupName!.toLowerCase() !=
                                        controller.groupName.value
                                            .toLowerCase())) {
                                  // ignore: unrelated_type_equality_checks
                                  if (controller.groupCode != '' &&
                                      // ignore: unrelated_type_equality_checks
                                      controller.groupName != '') {
                                    controller.postCreateCriteriaGroup(
                                        projectId, id);
                                  } else {
                                    Get.defaultDialog(
                                        barrierDismissible: false,
                                        onWillPop: () {
                                          return Future.value(false);
                                        },
                                        backgroundColor: Colors.white,
                                        title: '',
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: Get.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color:
                                                    Colors.red.withOpacity(.8),
                                                size: 60,
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              Center(
                                                child: KText(
                                                  text:
                                                      'Input Group Name && Group Code',
                                                  maxLines: 3,
                                                  fontSize: 14,
                                                  bold: false,
                                                  color: AppTheme.textColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: Get.width / 2,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppTheme
                                                                  .primaryColor)),
                                                  child: KText(
                                                    text: 'OK',
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                    //  offAll(ProjectDashboardv1());
                                  }
                                } else {
                                  back();
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'Same Group Name',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());

                                }

                                // controller.getCreateCriteriaGroup(
                                //     projectId, id);
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
                                    text: 'create',
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // OTPInput(),
                    // NewPasswordInput(),
                    // ConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void editCriteriaGroupInputDialog({
    required String title,
    required String labelText,
    required MaintainTestTypeController controller,
    required String pName,
    required String grouptypeName,
    required CriteriaGroupGet item,
    // required String tName,
    // required String tName,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: '$pName > ${item.groupName!}',

                      // text: '$pName > $groupName',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Group Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.groupCode,
                          initialValue:
                              item.groupCode != '' ? '${item.groupCode}' : '',
                          decoration: InputDecoration(
                            hintText: 'Project name will be here',
                            // labelText: 'Project name will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Group Type Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.groupName,
                          initialValue: '${item.groupName}',
                          decoration: InputDecoration(
                            //  labelText: 'Group Name will be here',
                            hintText: 'Group Name will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),

                            //  onTap: () {
                            //     controller.criteriaGroupUpdate(
                            //       testTypeId: item.testTypeId!,
                            //       id: item.id!,
                            //       projectId: item.projectId!,

                            //       projectName: item.projectName!,
                            //       projectCode: item.projectCode!,
                            //       //  item: ,
                            //     );
                            //     Get.back();
                            //   },

                            GestureDetector(
                              onTap: () {
                                // controller.criteriaGroupUpdate(
                                //   testTypeId: item.testTypeId!,
                                //   id: item.id!,
                                //   projectId: item.projectId!,
                                //   projectName: item.projectName!,
                                //   projectCode: item.projectCode!,
                                // );

                                if (controller.criteriaGroupList.every(
                                    (element) =>
                                        element.testTypeName!.toLowerCase() !=
                                        controller.testTypeName
                                            .toLowerCase())) {
                                  controller.criteriaGroupUpdate(
                                    testTypeId: item.testTypeId!,
                                    id: item.id!,
                                    projectId: item.projectId!,
                                    projectName: item.projectName!,
                                    projectCode: item.projectCode!,
                                  );
                                } else {
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'Already Exist',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());
                                }
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Test Criteria
  static void createTestCriteriaInputDialog({
    required String id,
    required String title,
    required String labelText,
    required String pName,
    required String groupName,
    required MaintainTestTypeController controller,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: pName,
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Criteria Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.criterionCode,
                          decoration: InputDecoration(
                            hintText: 'Criteria code will be here',
                            // labelText: 'Criteria code will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KText(
                            text: 'Test Criteria  Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.criterionName,
                          decoration: InputDecoration(
                            hintText: 'Criteria name will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                          text: 'Expected Value:',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.expectedResult,
                          decoration: InputDecoration(
                            hintText: 'Expected Value will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // kLog(id);

                                if (controller.testcriteriaGroupList.every(
                                    (element) =>
                                        element.criterionName!.toLowerCase() !=
                                        controller.criterionName.value
                                            .toLowerCase())) {
                                  // ignore: unrelated_type_equality_checks
                                  if (controller.criterionName != '' &&
                                      // ignore: unrelated_type_equality_checks
                                      controller.criterionCode != '' &&
                                      // ignore: unrelated_type_equality_checks
                                      controller.expectedResult != '') {
                                    controller.postTestCriteria(
                                      id,
                                    );
                                  } else {
                                    Get.defaultDialog(
                                        barrierDismissible: false,
                                        onWillPop: () {
                                          return Future.value(false);
                                        },
                                        backgroundColor: Colors.white,
                                        title: '',
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: Get.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color:
                                                    Colors.red.withOpacity(.8),
                                                size: 60,
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              Center(
                                                child: KText(
                                                  text:
                                                      'Input Criteria Name && Criteria Code && Expected Value',
                                                  maxLines: 3,
                                                  fontSize: 14,
                                                  bold: false,
                                                  color: AppTheme.textColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: Get.width / 2,
                                                child: TextButton(
                                                  onPressed: () {
                                                    back();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor),
                                                  ),
                                                  child: KText(
                                                    text: 'OK',
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                  }
                                } else {
                                  back();
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'same Test Criteria name',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());

                                }
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
                      ],
                    ),

                    // OTPInput(),
                    // NewPasswordInput(),
                    // ConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void edittestCriteria({
    required String title,
    required String labelText,
    required MaintainTestTypeController controller,
    required String pName,
    required String grouptypeName,
    required TestCriteriasGet item,
    // required String tName,
    // required String tName,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          //physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: '$pName > $grouptypeName',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Criteria Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.criterionCode,
                          initialValue: item.criterionCode != ''
                              ? '${item.criterionCode}'
                              : '',
                          decoration: InputDecoration(
                            hintText: 'Criteria name will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Criteria Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.criterionName,
                          initialValue: '${item.criterionName}',
                          decoration: InputDecoration(
                            hintText: 'Criteria Name will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Expected Value:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.expectedResult,
                          initialValue: '${item.expectedResult}',
                          decoration: InputDecoration(
                            hintText: 'Expected Result will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                if (controller.testcriteriaGroupList.every(
                                    (element) =>
                                        element.testTypeName!.toLowerCase() !=
                                        controller.testTypeName
                                            .toLowerCase())) {
                                  controller.testCriteriaUpdate(
                                    testTypeId: item.testTypeId!,
                                    id: item.id!,
                                    projectId: item.projectId!,
                                    projectName: item.projectName!,
                                    projectCode: item.projectCode!,
                                  );
                                } else {
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'Already Exist',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());

                                }
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Scenario

  static void createScenarioInputDialog({
    required String id,
    required String title,
    required String labelText,
    required String pName,
    // required String tName,
    required MaintainTestTypeController controller,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 50,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: pName,
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Scenario Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.scenarioCode,
                          decoration: InputDecoration(
                            hintText: 'Scenario code will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KText(
                            text: 'Scenario Group Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.scenarioName,
                          decoration: InputDecoration(
                            hintText: 'Scenario group name will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                // kLog(id);
                                if (controller.scenarioGroupList.every(
                                    (element) =>
                                        element.scenarioName!.toLowerCase() !=
                                        controller.scenarioName
                                            .toLowerCase())) {
                                  // ignore: unrelated_type_equality_checks
                                  if (controller.scenarioCode != '' &&
                                      // ignore: unrelated_type_equality_checks
                                      controller.scenarioName != '') {
                                    controller.postScenario(
                                      id,
                                    );
                                  } else {
                                    back();
                                    Get.defaultDialog(
                                        barrierDismissible: false,
                                        onWillPop: () {
                                          return Future.value(false);
                                        },
                                        backgroundColor: Colors.white,
                                        title: '',
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: Get.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color:
                                                    Colors.red.withOpacity(.8),
                                                size: 60,
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              Center(
                                                child: KText(
                                                  text:
                                                      'Write Scenario Code and Scenario Name',
                                                  maxLines: 3,
                                                  fontSize: 14,
                                                  bold: false,
                                                  color: AppTheme.textColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                              SizedBox(
                                                width: Get.width / 2,
                                                child: TextButton(
                                                  onPressed: () async {
                                                    // push(DefineTestAcceptancecriteriaPage(
                                                    //   id: id,
                                                    //   pName: projectName.value,
                                                    //   tName: testTypeCode.value,
                                                    // ));

                                                    Get.back();
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppTheme
                                                                  .primaryColor)),
                                                  child: KText(
                                                    text: 'OK',
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                  }
                                } else {
                                  back();
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'Same Scenario Name',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () async {
                                                  // push(DefineTestAcceptancecriteriaPage(
                                                  //   id: id,
                                                  //   pName: projectName.value,
                                                  //   tName: testTypeCode.value,
                                                  // ));

                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                }
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
                      ],
                    ),

                    // OTPInput(),
                    // NewPasswordInput(),
                    // ConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void editScenarioGroupInputDialog({
    required String title,
    required String labelText,
    required MaintainTestTypeController controller,
    required String pName,
    required String grouptypeName,
    required String scenarioName,
    required ScenarioGroupGet item,
    // required String tName,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: title,
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                color: hexToColor('#EEF0F6'),
                height: 70,
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: KText(
                      text: '$pName >  ${item.testTypeName!}',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Scenario Code',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          onChanged: controller.scenarioCode,
                          initialValue: item.scenarioCode != ''
                              ? '${item.scenarioCode}'
                              : 'aaa',
                          decoration: InputDecoration(
                            hintText: 'Scenario  code will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        KText(
                            text: 'Scenario Type Name:',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        TextFormField(
                          onChanged: controller.scenarioName,
                          initialValue: '${item.scenarioName}',
                          decoration: InputDecoration(
                            hintText: 'Scenario  Type Name will be here',
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
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            //
                            //   onTap: () {
                            //     controller.scenarioGroupUpdate(
                            //       testTypeId: item.testTypeId!,
                            //       id: item.id!,
                            //       projectId: item.projectId!,

                            //       projectName: item.projectName!,
                            //       projectCode: item.projectCode!,
                            //       //  item: ,
                            //     );
                            //     Get.back();
                            GestureDetector(
                              onTap: () {
                                if (controller.scenarioGroupList.every(
                                    (element) =>
                                        element.testTypeName!.toLowerCase() !=
                                        controller.testTypeName
                                            .toLowerCase())) {
                                  controller.scenarioGroupUpdate(
                                    testTypeId: item.testTypeId!,
                                    id: item.id!,
                                    projectId: item.projectId!,
                                    projectName: item.projectName!,
                                    projectCode: item.projectCode!,
                                  );
                                } else {
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      backgroundColor: Colors.white,
                                      title: '',
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red.withOpacity(.8),
                                              size: 60,
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            Center(
                                              child: KText(
                                                text: 'same Group name',
                                                maxLines: 3,
                                                fontSize: 14,
                                                bold: false,
                                                color: AppTheme.textColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 22,
                                            ),
                                            SizedBox(
                                              width: Get.width / 2,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppTheme
                                                                .primaryColor)),
                                                child: KText(
                                                  text: 'OK',
                                                  bold: true,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                  //  offAll(ProjectDashboardv1());

                                }
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
                            // GestureDetector(
                            //   onTap: () {
                            //     controller.scenarioGroupUpdate(
                            //       testTypeId: item.testTypeId!,
                            //       id: item.id!,
                            //       projectId: item.projectId!,

                            //       projectName: item.projectName!,
                            //       projectCode: item.projectCode!,
                            //       //  item: ,
                            //     );
                            //     Get.back();
                            //   },
                            //   child: Container(
                            //     height: 34,
                            //     width: 116,
                            //     decoration: BoxDecoration(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(8)),
                            //         color: hexToColor('#449EF1')),
                            //     child: Center(
                            //       child: KText(
                            //         text: 'create',
                            //         fontSize: 16,
                            //         color: Colors.white,
                            //         bold: true,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
