import 'package:get/get.dart';
import 'package:workforce/src/helpers/global_helper.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class ActivityDetailsPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    networkTopologyC.getProjectName();
    projectProgressDashboardC.projectGet();

    List<Widget> pages = [
      //Bucket
      Obx(
        () => projectProgressDashboardC.bucketNameList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: projectProgressDashboardC.bucketNameList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      width: Get.width,
                      // width: 360,
                      // height: 410,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        //  border: Border.all(color: AppTheme.nBorderC1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: KText(
                                        text: projectProgressDashboardC
                                            .bucketNameList[index].bucketName,
                                        fontSize: 16,
                                        bold: true,
                                        color: hexToColor('#515D64'),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    KText(
                                      text: 'Assigned to',
                                      color: hexToColor('#80939D'),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: KText(
                                              text: projectProgressDashboardC
                                                          .bucketNameList[index]
                                                          .fullname !=
                                                      null
                                                  ? projectProgressDashboardC
                                                      .bucketNameList[index]
                                                      .fullname
                                                  : '',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        RenderImg(
                                          path: 'icon_avatar.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                KText(
                                  text: 'Output Target ',
                                  color: hexToColor('#80939D'),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: KText(
                                      maxLines: 2,
                                      text: projectProgressDashboardC
                                                  .bucketNameList[index]
                                                  .outputTarget !=
                                              null
                                          // ignore: prefer_interpolation_to_compose_strings
                                          ? projectProgressDashboardC
                                                  .bucketNameList[index]
                                                  .outputTarget
                                                  .toString() +
                                              ' '
                                          : '',
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: KText(
                                    maxLines: 2,
                                    text: projectProgressDashboardC
                                                .bucketNameList[index]
                                                .outputDescr !=
                                            null
                                        ? projectProgressDashboardC
                                            .bucketNameList[index].outputDescr
                                        : '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    KText(
                                      text: 'Actual Progress ',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: KText(
                                          maxLines: 2,
                                          text: projectProgressDashboardC
                                                      .bucketNameList[index]
                                                      .outputProgress !=
                                                  null
                                              ? '${(double.parse(projectProgressDashboardC.bucketNameList[index].outputProgress.toString()) * 100).toStringAsFixed(2)} %'
                                              : '',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // KText(
                                //   text:
                                //       '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(0)}%',
                                //   fontSize: 13,
                                //   bold: true,
                                //   color: hexToColor('#515D64'),
                                // ),
                                SizedBox(
                                  height: 10,
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
                  );
                },
              )
            : SizedBox(
                height: 400,
                child: Center(
                  child: KText(text: 'No Data Found'),
                ),
              ),
      ),
      //Act. Group
      Obx(
        () => projectProgressDashboardC.activityGroupList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: projectProgressDashboardC.activityGroupList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      width: Get.width,
                      // width: 360,
                      // height: 410,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        //  border: Border.all(color: AppTheme.nBorderC1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: KText(
                                        text:
                                            '${projectProgressDashboardC.activityGroupList[index].bucketName!} > ${projectProgressDashboardC.activityGroupList[index].groupName!}',
                                        fontSize: 16,
                                        bold: true,
                                        color: hexToColor('#515D64'),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    KText(
                                      text: 'Assigned to',
                                      color: hexToColor('#80939D'),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: KText(
                                              text: projectProgressDashboardC
                                                          .activityGroupList[
                                                              index]
                                                          .assignedFullname !=
                                                      null
                                                  ? projectProgressDashboardC
                                                      .activityGroupList[index]
                                                      .assignedFullname
                                                  : '',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        RenderImg(
                                          path: 'icon_avatar.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                KText(
                                  text: 'Output Target ',
                                  color: hexToColor('#80939D'),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: KText(
                                      maxLines: 2,
                                      text: projectProgressDashboardC
                                                  .activityGroupList[index]
                                                  .outputTarget !=
                                              null
                                          ? '${projectProgressDashboardC.activityGroupList[index].outputTarget} ${projectProgressDashboardC.activityGroupList[index].outputDescr}'
                                          : 'NA',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 5),
                          //   child: Row(
                          //     children: [
                          //       KText(
                          //         text: 'Projected Progress ',
                          //         color: hexToColor('#80939D'),
                          //       ),
                          //       Expanded(
                          //         flex: 7,
                          //         child: Align(
                          //           alignment: Alignment.centerRight,
                          //           child: KText(
                          //             maxLines: 2,
                          //             text: '',
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   thickness: 1,
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    KText(
                                      text: 'Actual Progress ',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: KText(
                                            maxLines: 2,
                                            text: projectProgressDashboardC
                                                        .activityGroupList[
                                                            index]
                                                        .outputProgress !=
                                                    null
                                                ? '${(double.parse(projectProgressDashboardC.activityGroupList[index].outputProgress.toString()) * 100).toStringAsFixed(2)} %'
                                                : ''),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 5),
                          //   child: Row(
                          //     children: [
                          //       KText(
                          //         text: 'Target Completion date',
                          //         color: hexToColor('#80939D'),
                          //       ),
                          //       Spacer(),
                          //       KText(
                          //         text: 'Remaining Time',
                          //         color: hexToColor('#80939D'),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 5),
                          //   child: Row(
                          //     children: [
                          //       KText(
                          //         text: '06 Sep 2022',
                          //         color: hexToColor('#515D64'),
                          //         fontSize: 15,
                          //       ),
                          //       Spacer(),
                          //       KText(
                          //         text: '16 days',
                          //         color: hexToColor('#515D64'),
                          //         fontSize: 15,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : SizedBox(
                height: 400,
                child: Center(
                  child: KText(text: 'No Data Found'),
                ),
              ),
      ),
      //Activity
      Obx(
        () => projectProgressDashboardC.activityList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: projectProgressDashboardC.activityList.length,
                itemBuilder: (context, index) {
                  // ignore: unused_local_variable
                  final item = projectProgressDashboardC.activityList[index];
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      width: Get.width,
                      // width: 360,
                      // height: 410,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        //  border: Border.all(color: AppTheme.nBorderC1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    KText(
                                      text: 'Assigned to',
                                      color: hexToColor('#80939D'),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: KText(
                                              text: projectProgressDashboardC
                                                          .activityList[index]
                                                          .fullname !=
                                                      null
                                                  ? projectProgressDashboardC
                                                      .activityList[index]
                                                      .fullname
                                                  : '',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        RenderImg(
                                          path: 'icon_avatar.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: KText(
                                        text:
                                            '${projectProgressDashboardC.activityList[index].bucketName!} > ${projectProgressDashboardC.activityList[index].activityName!} > ${projectProgressDashboardC.activityList[index].groupName!}',
                                        fontSize: 15,
                                        bold: true,
                                        color: hexToColor('#515D64'),
                                        maxLines: 3,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Divider(
                            thickness: 1,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                KText(
                                  text: 'Output Target ',
                                  color: hexToColor('#80939D'),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: KText(
                                      maxLines: 2,
                                      text: projectProgressDashboardC
                                                  .activityList[index]
                                                  .outputTarget !=
                                              null
                                          ? '${projectProgressDashboardC.activityList[index].outputTarget} ${projectProgressDashboardC.activityList[index].outputDescr}'
                                          : '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    KText(
                                      text: 'Actual Progress ',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: KText(
                                          maxLines: 2,
                                          text: projectProgressDashboardC
                                                      .activityList[index]
                                                      .outputProgress !=
                                                  null
                                              ? '${(double.parse(projectProgressDashboardC.activityList[index].outputProgress.toString()) * 100).toStringAsFixed(2)} %'
                                              : '',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                KText(
                                  text: 'Target Completion Date',
                                  color: hexToColor('#80939D'),
                                ),
                                // Spacer(),
                                // KText(
                                //   text: 'Remaining Time',
                                //   color: hexToColor('#80939D'),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                KText(
                                  text: formatDate(
                                      date: projectProgressDashboardC
                                          .activityList[index]
                                          .scheduledEndDate!),
                                  color: hexToColor('#515D64'),
                                  fontSize: 15,
                                ),
                                // Spacer(),
                                // KText(
                                //   text: '16 days',
                                //   color: hexToColor('#515D64'),
                                //   fontSize: 15,
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Divider(
                          //   thickness: 1,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 5),
                          //   child: Row(
                          //     children: [
                          //       KText(
                          //         text: 'Remaining Time',
                          //         color: hexToColor('#80939D'),
                          //       ),
                          //       Spacer(),
                          //       KText(
                          //         text: '14 days',
                          //         color: hexToColor('#80939D'),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Divider(
                          //   thickness: 1,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 15, vertical: 5),
                          //   child: Row(
                          //     children: [
                          //       KText(
                          //         text: '06 Sep 2022',
                          //         color: hexToColor('#515D64'),
                          //         fontSize: 15,
                          //       ),
                          //       Spacer(),
                          //       KText(
                          //         text: '16 days',
                          //         color: hexToColor('#515D64'),
                          //         fontSize: 15,
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : SizedBox(
                height: 400,
                child: Center(
                  child: KText(text: 'No Data Found'),
                ),
              ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppbar(),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      backgroundColor: hexToColor('#FFFFFF'),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: RenderSvg(
                        path: 'icon_back',
                        width: 13.0,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    KText(
                      text: 'Activity Details',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: hexToColor('#CFD7DD'),

              //     // border: Border.all(color: AppTheme.nBorderC1),
              //     border: Border(
              //       bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
              //       top: BorderSide(width: 1.5, color: Colors.grey.shade300),
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 10.0,
              //         color: hexToColor('#EEF0F6'),
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 3),
              //       if (networkTopologyC.projectNameList.isNotEmpty)
              //         Container(
              //           margin: EdgeInsets.symmetric(horizontal: 12.0),
              //           child: CustomTextFieldWithDropdown(
              //             suffix: DropdownButton(
              //               value: networkTopologyC
              //                   .selectedProject.value!.projectName,
              //               underline: Container(),
              //               icon: Icon(
              //                 Icons.keyboard_arrow_down,
              //                 color: hexToColor('#80939D'),
              //               ),
              //               items: networkTopologyC.projectNameList.map((item) {
              //                 return DropdownMenuItem(
              //                   onTap: () {
              //                     networkTopologyC.selectedProject.value = item;
              //                   },
              //                   value: item.projectName,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(
              //                       right: 35,
              //                     ),
              //                     child: SizedBox(
              //                       width: Get.width / 1.3,
              //                       child: KText(
              //                         text: item.projectName,
              //                         fontSize: 13,
              //                         maxLines: 2,
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               }).toList(),
              //               onChanged: (item) {
              //                // kLog(projectProgressDashboardC
              //                     .projectPlanningBoard[
              //                         projectProgressDashboardC
              //                             .projectPlanningBoard
              //                             .indexWhere((element) =>
              //                                 element!.projectName == item)]!
              //                     .id);
              //                 projectProgressDashboardC.changeIndex.value =
              //                     projectProgressDashboardC.projectPlanningBoard
              //                         .indexWhere((element) =>
              //                             element!.projectName == item);
              //                 projectProgressDashboardC.getBucketName();
              //                 projectProgressDashboardC.getActivityName();
              //                 projectProgressDashboardC.getActivity();
              //               },
              //             ),
              //           ),
              //         ),
              //     ],
              //   ),
              // ),

              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  border: Border.all(color: AppTheme.nBorderC1),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: hexToColor('#EEF0F6'),
                    )
                  ],
                ),
                height: 160,
                width: Get.width,
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        KText(
                          text: 'Output Target',
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Spacer(),
                        KText(
                          text: 'Progress',
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        KText(
                          text: projectProgressDashboardC
                                  .projectPlanningBoard.isNotEmpty
                              ? '${projectProgressDashboardC.projectPlanningBoard[projectProgressDashboardC.changeIndex.value]!.outputTarget}'
                              : '',
                          fontSize: 13,
                          color: hexToColor('#515D64'),
                        ),
                        KText(
                          text: projectProgressDashboardC
                                  .projectPlanningBoard.isNotEmpty
                              ? projectProgressDashboardC
                                          .projectPlanningBoard[
                                              projectProgressDashboardC
                                                  .changeIndex.value]!
                                          .outputDescr !=
                                      null
                                  ? projectProgressDashboardC
                                      .projectPlanningBoard[
                                          projectProgressDashboardC
                                              .changeIndex.value]!
                                      .outputDescr
                                  : ''
                              : '',
                          fontSize: 13,
                          color: hexToColor('#515D64'),
                        ),
                        Spacer(),
                        KText(
                          text: projectProgressDashboardC
                                  .projectPlanningBoard.isNotEmpty
                              ? '${(double.parse(projectProgressDashboardC.projectPlanningBoard[projectProgressDashboardC.changeIndex.value]!.outputProgress.toString()) * 100).toStringAsFixed(2)} %'
                              : '',
                          fontSize: 13,
                          color: hexToColor('#515D64'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        KText(
                          text: 'Output Target',
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Spacer(),
                        KText(
                          text: 'Progress',
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              pages[projectProgressDashboardC.changeTab.value],

              // ListView.builder(
              //   shrinkWrap: true,
              //   primary: false,
              //   itemCount: 10,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: EdgeInsets.all(15),
              //       child: Container(
              //         width: Get.width,
              //         // width: 360,
              //         // height: 410,
              //         decoration: BoxDecoration(
              //           color: AppTheme.white,
              //           //  border: Border.all(color: AppTheme.nBorderC1),
              //           borderRadius: BorderRadius.circular(12),
              //           boxShadow: [
              //             BoxShadow(
              //               blurRadius: 10.0,
              //               color: Colors.black12,
              //             )
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.all(15),
              //               child: Column(
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Expanded(
              //                         flex: 20,
              //                         child: KText(
              //                           text: 'Pole Supply',
              //                           fontSize: 16,
              //                           bold: true,
              //                           color: hexToColor('#515D64'),
              //                           maxLines: 2,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 10,
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Divider(
              //               thickness: 1,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   Column(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       KText(
              //                         text: 'Assigned to',
              //                         color: hexToColor('#80939D'),
              //                       ),
              //                     ],
              //                   ),
              //                   Spacer(),
              //                   Expanded(
              //                     flex: 5,
              //                     child: Padding(
              //                       padding: EdgeInsets.all(5),
              //                       child: Row(
              //                         children: [
              //                           Expanded(
              //                             child: Align(
              //                               alignment: Alignment.centerRight,
              //                               child: KText(text: 'Ahsan Habib'),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width: 12,
              //                           ),
              //                           RenderImg(
              //                             path: 'icon_avatar.png',
              //                             width: 30,
              //                             height: 30,
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Divider(
              //               thickness: 1,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   KText(
              //                     text: 'Output Target ',
              //                     color: hexToColor('#80939D'),
              //                   ),
              //                   Expanded(
              //                     flex: 7,
              //                     child: Align(
              //                       alignment: Alignment.centerRight,
              //                       child: KText(
              //                         maxLines: 2,
              //                         text: '36000',
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Divider(
              //               thickness: 1,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   KText(
              //                     text: 'Projected Progress ',
              //                     color: hexToColor('#80939D'),
              //                   ),
              //                   Expanded(
              //                     flex: 7,
              //                     child: Align(
              //                       alignment: Alignment.centerRight,
              //                       child: KText(
              //                         maxLines: 2,
              //                         text: '7,000 Pole',
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Divider(
              //               thickness: 1,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   KText(
              //                     text: 'Actual Progress ',
              //                     color: hexToColor('#80939D'),
              //                   ),
              //                   Expanded(
              //                     flex: 7,
              //                     child: Align(
              //                       alignment: Alignment.centerRight,
              //                       child: KText(
              //                         maxLines: 2,
              //                         text: '6000',
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Divider(
              //               thickness: 1,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   KText(
              //                     text: 'Target Completion date',
              //                     color: hexToColor('#80939D'),
              //                   ),
              //                   Spacer(),
              //                   KText(
              //                     text: 'Remaining Time',
              //                     color: hexToColor('#80939D'),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 5),
              //               child: Row(
              //                 children: [
              //                   KText(
              //                     text: '06 Sep 2022',
              //                     color: hexToColor('#515D64'),
              //                     fontSize: 15,
              //                   ),
              //                   Spacer(),
              //                   KText(
              //                     text: '16 days',
              //                     color: hexToColor('#515D64'),
              //                     fontSize: 15,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: 15,
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
