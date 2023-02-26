import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/chart_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/post_my_task_progress.dart';

class TaskProgressComponent extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // taskProgressC.getTaskProgress();
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  '${Constants.svgPath}/icon_task_solid.svg',
                ),
                SizedBox(
                  width: 8,
                ),
                KText(
                  text: 'Tasks',
                  fontSize: 16,
                  bold: true,
                ),
                SizedBox(
                  width: 12,
                ),
                SvgPicture.asset(
                  '${Constants.svgPath}/icon_task_status-1.svg',
                ),
                Spacer(),
                InkWell(
                  onTap: (() {
                    push(PostMyTaskProgress());
                  }),
                  child: KText(
                    text: 'Progress',
                    fontSize: 15,
                    // bold: true,
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                InkWell(
                    onTap: (() {
                      push(PostMyTaskProgress());
                    }),
                    child: Icon(EvaIcons.plusSquare)),
              ],
            ),
            SizedBox(height: 8),
            DottedLine(
              lineThickness: 1,
              dashLength: 1.5,
              dashGapLength: 2,
              dashColor: hexToColor(
                '#80939D',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ChartComponent(),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children:
                        taskProgressC.taskProgressDashbordHome.map((element) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Container(
                                child: FittedBox(
                                  child: KText(
                                      bold: true,
                                      color: Colors.white,
                                      text:
                                          '${((element!.count! / taskProgressC.total.value) * 100).toStringAsFixed(2)} %'),
                                ),
                                alignment: Alignment.center,
                                width: 40,
                                color: element.status == 'Accepted'
                                    ? hexToColor('#786e04')
                                    : element.status == 'Started'
                                        ? hexToColor('#FFA133')
                                        : element.status == 'WIP'
                                            ? hexToColor('#08E8DE')
                                            : element.status == 'Aborted'
                                                ? hexToColor('#FF3C3C')
                                                : element.status == 'Restarted'
                                                    ? hexToColor('#6666FF')
                                                    : element.status ==
                                                            'Completed'
                                                        ? hexToColor('#00D8A0')
                                                        : hexToColor('#000000'),
                                padding: EdgeInsets.all(4),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  KText(
                                    text: taskProgressC
                                            .taskProgressDashbordHome.isNotEmpty
                                        ? element.status
                                        : '',
                                    fontSize: 12,
                                    color: AppTheme.textColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: taskProgressC
                                            .taskProgressDashbordHome.isNotEmpty
                                        ? element.count.toString()
                                        : '',
                                    fontSize: 12,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),

                                  // KText(
                                  //   text: taskProgressC.taskProgressDashbordHome
                                  //               .value !=
                                  //           null
                                  //       ? taskProgressC.taskProgressDashbordHome
                                  //           .value!.totalSupports
                                  //           .toString()
                                  //       : '',
                                  //   fontSize: 11,
                                  //   color: AppTheme.textColor,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    // Row(
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: 40,
                    //         color: hexToColor('#00D8A0'),
                    //         padding: EdgeInsets.all(4),
                    //         // foregroundDecoration: BoxDecoration(
                    //         //   color: hexToColor('#007BEC'),
                    //         //   borderRadius: BorderRadius.all(
                    //         //     Radius.circular(8),
                    //         //   ),
                    //         // ),
                    //         // child: KText(
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? taskProgressC.taskProgressDashbordHome
                    //         //           .value!.completedSupportsPct
                    //         //           .toString()
                    //         //       : '',
                    //         //   bold: true,
                    //         //   fontSize: 11,
                    //         //   color: Colors.white,
                    //         // ),
                    //         // child: KText(
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? '${taskProgressC.taskProgressDashbordHome.value!.completedSupportsPct.toString()}%'
                    //         //       : '',
                    //         //   bold: true,
                    //         //   fontSize: 11,
                    //         //   color: Colors.white,
                    //         // ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 7,
                    //     ),
                    //     // Expanded(
                    //     //   child: KText(
                    //     //     text: 'Completed 340',
                    //     //     fontSize: 12,
                    //     //     color: AppTheme.textColor,
                    //     //   ),
                    //     // ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'Started '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? taskProgressC.taskProgressDashbordHome
                    //           //           .value!.completedSupports
                    //           //           .toString()
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // Row(
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: 40,
                    //         color: hexToColor('#FF3C3C'),
                    //         padding: EdgeInsets.all(4),
                    //         // foregroundDecoration: BoxDecoration(
                    //         //   color: hexToColor('#007BEC'),
                    //         //   borderRadius: BorderRadius.all(
                    //         //     Radius.circular(8),
                    //         //   ),
                    //         // ),
                    //         // child: KText(
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? '${taskProgressC.taskProgressDashbordHome.value!.pendingSupportsPct.toString()}'
                    //         //       : '',
                    //         //   fontSize: 11,
                    //         //   color: AppTheme.textColor,
                    //         // ),

                    //         // child: KText(
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? '${taskProgressC.taskProgressDashbordHome.value!.pendingSupportsPct.toString()}%'
                    //         //       : '',
                    //         //   bold: true,
                    //         //   fontSize: 11,
                    //         //   color: Colors.white,
                    //         // ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 7,
                    //     ),
                    //     // Expanded(
                    //     //   child: KText(
                    //     //     text: 'Pending 340',
                    //     //     fontSize: 12,
                    //     //     color: AppTheme.textColor,
                    //     //   ),
                    //     // ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'Aborted '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? taskProgressC.taskProgressDashbordHome
                    //           //           .value!.pendingSupports
                    //           //           .toString()
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 7,
                    //     ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'Restarted '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? taskProgressC.taskProgressDashbordHome
                    //           //           .value!.pendingSupports
                    //           //           .toString()
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 7,
                    //     ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'Completed '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? taskProgressC.taskProgressDashbordHome
                    //           //           .value!.pendingSupports
                    //           //           .toString()
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),

                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'WIP '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? taskProgressC.taskProgressDashbordHome
                    //           //           .value!.pendingSupports
                    //           //           .toString()
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // Row(
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(8),
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: 40,
                    //         color: hexToColor('#86A4B5'),
                    //         padding: EdgeInsets.all(4),
                    //         // foregroundDecoration: BoxDecoration(
                    //         //   color: hexToColor('#007BEC'),
                    //         //   borderRadius: BorderRadius.all(
                    //         //     Radius.circular(8),
                    //         //   ),
                    //         // ),
                    //         // child: KText(
                    //         //   // text: '37%',
                    //         //   // bold: true,
                    //         //   // fontSize: 12,
                    //         //   // color: Colors.white,
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? taskProgressC.taskProgressDashbordHome
                    //         //           .value!.notStartedSupportsPct
                    //         //           .toString()
                    //         //       : '',
                    //         //   bold: true,
                    //         //   fontSize: 11,
                    //         //   color: Colors.white,
                    //         // ),
                    //         // child: KText(
                    //         //   text: taskProgressC
                    //         //               .taskProgressDashbordHome.value !=
                    //         //           null
                    //         //       ? '${taskProgressC.taskProgressDashbordHome.value!.notStartedSupportsPct.toString()}%'
                    //         //       : '',
                    //         //   bold: true,
                    //         //   fontSize: 11,
                    //         //   color: Colors.white,
                    //         // ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 7,
                    //     ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           KText(
                    //             text: taskProgressC.taskProgressDashbordHome
                    //                         .value !=
                    //                     null
                    //                 ? 'Not Started '
                    //                 : '',
                    //             fontSize: 12,
                    //             color: AppTheme.textColor,
                    //           ),
                    //           // KText(
                    //           //   text: taskProgressC.taskProgressDashbordHome
                    //           //               .value !=
                    //           //           null
                    //           //       ? '${taskProgressC.taskProgressDashbordHome.value!.pendingSupports.toString()}'
                    //           //       : '',
                    //           //   fontSize: 11,
                    //           //   color: AppTheme.textColor,
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                )
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     SvgPicture.asset(
            //       '${Constants.svgPath}/manage_agency.svg',
            //       width: 25,
            //     ),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     KText(
            //       text: 'Parties ',
            //       fontSize: 17,
            //       bold: true,
            //     ),
            //     KText(
            //       text: '(105)',
            //       fontSize: 17,
            //       // bold: true,
            //     ),
            //     SizedBox(
            //       width: 12,
            //     ),
            //     // SvgPicture.asset(
            //     //   '${Constants.svgPath}/icon_task_status-1.svg',
            //     //   width: 15,
            //     // ),
            //     Spacer(),
            //     KText(
            //       text: 'Dashboard',
            //       fontSize: 17,
            //       // bold: true,
            //     ),
            //     SizedBox(
            //       width: 12,
            //     ),
            //     Icon(EvaIcons.arrowIosForward),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
