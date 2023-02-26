import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/number_formate.dart';

class PoleInstallationSummeryComponent extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // PISummeryC.getPoleInstallationSummery();
    // PISummeryC.getTotalSiteSummaryPercentages();

// Get progress Color
//..............
    String getColor(double value) {
      if (value < 50) {
        return '#FF7373';
      } else if (value < 75) {
        return '#55ADFE';
      } else {
        return '#00D8A0';
      }
    }

    PISummeryC.getGeographySummary();
    return Obx(
      () => Container(
        // padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RenderSvg(
                        path: 'site_operation_icon',
                        height: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      KText(
                        text: 'Site Installation Summary',
                        fontSize: 16,
                        bold: true,
                      ),
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
                ],
              ),
            ),

            //  Site Installation
            SizedBox(
              height: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (PISummeryC.poleInstallationSummeryModel.value != null)
                    Builder(builder: (context) {
                      final item =
                          PISummeryC.poleInstallationSummeryModel.value;

                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 10, top: 15, bottom: 10, left: 16),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            width: Get.width / 1.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: KText(
                                    text: 'Site Installation',
                                    fontSize: 16,
                                    bold: true,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Column(
                                  children: item!.totalSummary!
                                      .map(
                                        (e) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Target Sites',
                                              color: hexToColor('#80939D'),
                                              bold: true,
                                            ),
                                            KText(
                                              text: formateNumber(
                                                  value: int.parse(
                                                      e.targetSites!)),
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                Column(
                                  children: item.workStatus!
                                      .map(
                                        (e) => Column(
                                          children: [
                                            Divider(
                                              color: Colors.black26,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(text: '${e.status}'),
                                                KText(
                                                  text: formateNumber(
                                                      value:
                                                          int.parse(e.count!)),
                                                  bold: true,
                                                  fontSize: 15,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                Column(
                                  children: item.totalSummary!
                                      .map((e) => Column(
                                            children: [
                                              Divider(
                                                color: Colors.black26,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text: 'Completed Today'),
                                                  KText(
                                                    text: formateNumber(
                                                        value: int.parse(
                                                            e.completedToday!)),
                                                    bold: true,
                                                    fontSize: 15,
                                                  )
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.black26,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'Total Completed',
                                                    bold: true,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                    text: formateNumber(
                                                      value: int.parse(
                                                          e.totalCompleted!),
                                                    ),
                                                    bold: true,
                                                    fontSize: 15,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // double.parse(
                                    //             '${PISummeryC.getTotalSiteSummaryPercentages()}') <=
                                    //         1.00
                                    //     ?
                                    Expanded(
                                      flex: 9,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        child: LinearPercentIndicator(
                                          percent: double.parse(
                                                  '${PISummeryC.getTotalSiteSummaryPercentages()}') /
                                              100,
                                          barRadius: Radius.circular(10),
                                          animation: true,
                                          lineHeight: 8.0,
                                          animationDuration: 5000,
                                          progressColor: hexToColor(
                                            getColor(double.parse(
                                                    '${PISummeryC.getTotalSiteSummaryPercentages()}') *
                                                100),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // : Expanded(
                                    //     flex: 9,
                                    //     child: Padding(
                                    //       padding: EdgeInsets.symmetric(
                                    //         horizontal: 0,
                                    //         vertical: 0,
                                    //       ),
                                    //       child: LinearPercentIndicator(
                                    //         percent: 1.00,
                                    //         barRadius: Radius.circular(10),
                                    //         animation: true,
                                    //         lineHeight: 8.0,
                                    //         animationDuration: 5000,
                                    //         progressColor:
                                    //             Colors.green.shade400,
                                    //       ),
                                    //     ),
                                    //   ),
                                    Expanded(
                                      flex: 2,
                                      child: KText(
                                        text:
                                            '${PISummeryC.getTotalSiteSummaryPercentages()} %',
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  //Geography Summary of Site Installation
                  if (PISummeryC.geographySummeryModel.value != null)
                    Builder(builder: (context) {
                      final item = PISummeryC.geographySummeryModel.value;

                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 10, top: 15, bottom: 10, left: 16),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            width: Get.width / 1.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: KText(
                                    text:
                                        'Geography Summary of Site Installation',
                                    fontSize: 16,
                                    bold: true,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                if (item!.headerSummaries != null)
                                  Column(
                                    children: item.headerSummaries!
                                        .map(
                                          (e) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Target Sites',
                                                color: hexToColor('#80939D'),
                                                bold: true,
                                              ),
                                              KText(
                                                text: formateNumber(
                                                  value: e.targetGeographies!,
                                                ),
                                                bold: true,
                                                fontSize: 15,
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                if (item.statusSummaries != null)
                                  Column(
                                    children: item.statusSummaries!
                                        .map(
                                          (e) => Column(
                                            children: [
                                              Divider(
                                                color: Colors.black26,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(text: '${e.status}'),
                                                  KText(
                                                    text: formateNumber(
                                                        value: e.count!),
                                                    bold: true,
                                                    fontSize: 15,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                if (item.headerSummaries != null)
                                  Column(
                                    children: item.headerSummaries!
                                        .map((e) => Column(
                                              children: [
                                                Divider(
                                                  color: Colors.black26,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text:
                                                            'Completed Today'),
                                                    KText(
                                                      text: formateNumber(
                                                          value: e
                                                              .completedToday!),
                                                      bold: true,
                                                      fontSize: 15,
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  color: Colors.black26,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Total Completed',
                                                      bold: true,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    KText(
                                                      text: formateNumber(
                                                        value:
                                                            e.totalCompleted!,
                                                      ),
                                                      bold: true,
                                                      fontSize: 15,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                if (item.headerSummaries != null)
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                if (item.headerSummaries != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // double.parse(
                                      //             '${PISummeryC.getGeographySummaryPercentages()}') <=
                                      //         1.00
                                      //     ?
                                      Expanded(
                                        flex: 9,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 0,
                                            vertical: 0,
                                          ),
                                          child: LinearPercentIndicator(
                                            percent: double.parse(
                                                    '${PISummeryC.getGeographySummaryPercentages()}') /
                                                100,
                                            barRadius: Radius.circular(10),
                                            animation: true,
                                            lineHeight: 8.0,
                                            animationDuration: 5000,
                                            progressColor: hexToColor(
                                              getColor(double.parse(
                                                      '${PISummeryC.getGeographySummaryPercentages()}') *
                                                  100),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // : Expanded(
                                      //     flex: 9,
                                      //     child: Padding(
                                      //       padding: EdgeInsets.symmetric(
                                      //         horizontal: 0,
                                      //         vertical: 0,
                                      //       ),
                                      //       child: LinearPercentIndicator(
                                      //         percent: 1.00,
                                      //         barRadius:
                                      //             Radius.circular(10),
                                      //         animation: true,
                                      //         lineHeight: 8.0,
                                      //         animationDuration: 5000,
                                      //         progressColor:
                                      //             Colors.green.shade400,
                                      //       ),
                                      //     ),
                                      //   ),

                                      Expanded(
                                        flex: 2,
                                        child: KText(
                                          text:
                                              '${PISummeryC.getGeographySummaryPercentages()} %',
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       right: 10, top: 15, bottom: 10, left: 4),
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 10,
                  //       vertical: 15,
                  //     ),
                  //     width: Get.width - 80,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           blurRadius: 10.0,
                  //           color: Colors.black12,
                  //         )
                  //       ],
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: KText(
                  //             text: 'Geography Summary of Site Installation',
                  //             fontSize: 16,
                  //             bold: true,
                  //             maxLines: 2,
                  //             textOverflow: TextOverflow.visible,
                  //           ),
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: 'Target Sites'),
                  //             KText(
                  //               text: '35,000',
                  //               bold: true,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: 'WIP'),
                  //             KText(
                  //               text: '2,000',
                  //               bold: true,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: 'Aborted'),
                  //             KText(
                  //               text: '0',
                  //               bold: true,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: 'Completed Today'),
                  //             KText(
                  //               text: '100',
                  //               bold: true,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: 'Total Completed'),
                  //             KText(
                  //               text: '10,000',
                  //               bold: true,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Expanded(
                  //               flex: 9,
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(
                  //                   horizontal: 0,
                  //                   vertical: 0,
                  //                 ),
                  //                 child: LinearPercentIndicator(
                  //                   percent: 0.9,
                  //                   barRadius: Radius.circular(10),
                  //                   animation: true,
                  //                   lineHeight: 8.0,
                  //                   animationDuration: 5000,
                  //                   progressColor: hexToColor('#55ADFE'),
                  //                 ),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               flex: 2,
                  //               child: KText(
                  //                 text: '0.90 %',
                  //                 fontSize: 12,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
