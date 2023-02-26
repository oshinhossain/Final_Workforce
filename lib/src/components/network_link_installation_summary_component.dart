import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/number_formate.dart';
import '../helpers/render_svg.dart';

class NetworkLinkInstallationSummaryComponent extends StatelessWidget
    with Base {
  String getColor(double value) {
    if (value < 50) {
      return '#FF7373';
    } else if (value < 75) {
      return '#55ADFE';
    } else {
      return '#00D8A0';
    }
  }

  @override
  Widget build(BuildContext context) {
    NLISummeryC.getGeographySummary();
    return Obx(
      () => Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RenderSvg(path: 'ofc'),
                      SizedBox(
                        width: 8,
                      ),
                      KText(
                        text: 'Network Link Installation Summary',
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
            SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //  Network Link Installation: Core wise Summary
                  if (NLISummeryC.networkLinkInstallationSummeryModel.value !=
                      null)
                    Builder(builder: (context) {
                      final item =
                          NLISummeryC.networkLinkInstallationSummeryModel.value;
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
                                        'Network Link Installation:\nCore wise Summary',
                                    fontSize: 16,
                                    bold: true,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Row(
                                  children: [
                                    KText(
                                      text: 'Total Target',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item!.totalCoreSummary!
                                                  .totalTarget !=
                                              null
                                          ? item.totalCoreSummary!.totalTarget
                                              ?.toStringAsFixed(2)
                                          : '0',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    KText(
                                      text: ' Km',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                                if (item
                                    .totalCoreSummary!.coreSummary!.isNotEmpty)
                                  Column(
                                    children: item
                                        .totalCoreSummary!.coreSummary!
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
                                                        text: '${e.core}-Core'),
                                                    KText(
                                                      text:
                                                          '${e.lengthkm!.toStringAsFixed(2)} Km',
                                                      bold: true,
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
                                  children: [
                                    KText(
                                      text: 'Total Installed',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.totalCoreSummary!
                                                  .totalInstalled !=
                                              null
                                          ? item
                                              .totalCoreSummary!.totalInstalled
                                              ?.toStringAsFixed(2)
                                          : '0',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    KText(
                                      text: ' Km',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    // SizedBox(
                                    //   width: 10,
                                    // )
                                  ],
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // double.parse(
                                    //             '${NLISummeryC.getTotalCore()}') <=
                                    //         1.01
                                    //     ?
                                    Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        child: LinearPercentIndicator(
                                          percent: double.parse(
                                                  '${NLISummeryC.getTotalCore()}') /
                                              100,
                                          barRadius: Radius.circular(10),
                                          animation: true,
                                          lineHeight: 8.0,
                                          animationDuration: 5000,
                                          progressColor: hexToColor(
                                            getColor(double.parse(
                                                '${NLISummeryC.getTotalCore()}')),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // : Expanded(
                                    //     flex: 10,
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
                                        text: '${NLISummeryC.getTotalCore()} %',
                                        fontSize: 12,
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
                  //Network Link Installation: Today’s Summary
                  if (NLISummeryC.networkLinkInstallationSummeryModel.value !=
                      null)
                    Builder(builder: (context) {
                      final item =
                          NLISummeryC.networkLinkInstallationSummeryModel.value;
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
                                        'Network Link Installation: Today’s Summary',
                                    fontSize: 16,
                                    bold: true,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Row(
                                  children: [
                                    KText(
                                      text: 'Total Target',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item!.dailyCoreSummary!
                                                  .totalTarget !=
                                              null
                                          ? item.dailyCoreSummary!.totalTarget
                                              ?.toStringAsFixed(2)
                                          : '0',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    KText(
                                      text: ' Km',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                                if (item
                                    .dailyCoreSummary!.coreSummary!.isNotEmpty)
                                  Column(
                                    children: item
                                        .dailyCoreSummary!.coreSummary!
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
                                                        text: '${e.core}-Core'),
                                                    KText(
                                                      text: e.lengthkm != null
                                                          ? '${e.lengthkm!.toStringAsFixed(2)} Km'
                                                          : '0 Km',
                                                      bold: true,
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
                                  children: [
                                    KText(
                                      text: 'Total Installed',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.dailyCoreSummary!
                                                  .totalInstalled !=
                                              null
                                          ? item
                                              .dailyCoreSummary!.totalInstalled
                                              ?.toStringAsFixed(2)
                                          : '0',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    KText(
                                      text: ' Km',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    // SizedBox(
                                    //   width: 10,
                                    // )
                                  ],
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // double.parse(
                                    //             '${NLISummeryC.getDailyTotalCore()}') <=
                                    //         1.01
                                    //     ?
                                    Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        child: LinearPercentIndicator(
                                          percent: double.parse(
                                                  '${NLISummeryC.getDailyTotalCore()}') /
                                              100,
                                          barRadius: Radius.circular(10),
                                          animation: true,
                                          lineHeight: 8.0,
                                          animationDuration: 5000,
                                          progressColor: hexToColor(
                                            getColor(double.parse(
                                                '${NLISummeryC.getDailyTotalCore()}')),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // : Expanded(
                                    //     flex: 10,
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
                                    //         progressColor: Colors.green,
                                    //       ),
                                    //     ),
                                    //   ),
                                    Expanded(
                                      flex: 2,
                                      child: KText(
                                        text:
                                            '${NLISummeryC.getDailyTotalCore()} %',
                                        fontSize: 12,
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
                  //Geography Summary of Network Link Installation
                  if (NLISummeryC.geographySummeryModel.value != null)
                    Builder(builder: (context) {
                      final item = NLISummeryC.geographySummeryModel.value;

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
                                        'Geography Summary of Network Link Installation',
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
                                      //             '${NLISummeryC.getGeographySummaryPercentages()}') <=
                                      //         1.01
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
                                                    '${NLISummeryC.getGeographySummaryPercentages()}') /
                                                100,
                                            barRadius: Radius.circular(10),
                                            animation: true,
                                            lineHeight: 8.0,
                                            animationDuration: 5000,
                                            progressColor: hexToColor(
                                              getColor(double.parse(
                                                      '${NLISummeryC.getGeographySummaryPercentages()}') *
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
                                      //         percent: double.parse(
                                      //                 '${NLISummeryC.getGeographySummaryPercentages()}') /
                                      //             100,
                                      //         barRadius:
                                      //             Radius.circular(10),
                                      //         animation: true,
                                      //         lineHeight: 8.0,
                                      //         animationDuration: 5000,
                                      //         progressColor: hexToColor(
                                      //           getColor(double.parse(
                                      //                   '${NLISummeryC.getGeographySummaryPercentages()}') *
                                      //               100),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      Expanded(
                                        flex: 2,
                                        child: KText(
                                          text:
                                              '${NLISummeryC.getGeographySummaryPercentages()} %',
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
                  //--design--//
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(right: 10, top: 15, bottom: 10, left: 4),
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
                  //             text:
                  //                 'Network Link Installation: Core wise Summary',
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
                  //             KText(
                  //               text: 'Total Target',
                  //               bold: true,
                  //               fontSize: 14,
                  //             ),
                  //             KText(
                  //               text: '11,000 Km',
                  //               bold: true,
                  //               fontSize: 14,
                  //             )
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Colors.black26,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             KText(text: '4-Core'),
                  //             KText(
                  //               text: '60 Km',
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
                  //             KText(text: '8-Core'),
                  //             KText(
                  //               text: '20 Km',
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
                  //             KText(text: '12-Core'),
                  //             KText(
                  //               text: '10 Km',
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
                  //             KText(text: '24-Core'),
                  //             KText(
                  //               text: '10 Km',
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
                  //             KText(text: 'Other Cores'),
                  //             KText(
                  //               text: '0 Km',
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
                  //             KText(
                  //               text: 'Total Installed',
                  //               bold: true,
                  //               fontSize: 14,
                  //             ),
                  //             KText(
                  //               text: '100 Km',
                  //               bold: true,
                  //               fontSize: 14,
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
                  //                   vertical: 5,
                  //                 ),
                  //                 child: LinearPercentIndicator(
                  //                   percent: 0.4,
                  //                   barRadius: Radius.circular(10),
                  //                   animation: true,
                  //                   lineHeight: 8.0,
                  //                   animationDuration: 5000,
                  //                   progressColor: hexToColor('#FFA133'),
                  //                 ),
                  //               ),
                  //             ),
                  //             Expanded(
                  //               flex: 2,
                  //               child: KText(
                  //                 text: '0.40 %',
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
