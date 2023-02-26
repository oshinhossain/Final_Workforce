import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/transportation_dashboard_page.dart';

import '../helpers/hex_color.dart';
import '../pages/transport_dashboard_transport_agency_page.dart';
import '../pages/transportation_workbench_page.dart';

class TransportOrdersComponent extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    transportationC.getTransportationOrders();
    return Obx(
      () => transportationC.transportationOrders.isEmpty
          ? Center(
              child: Loading(),
            )
          : Column(
              children: [
                // SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              RenderSvg(path: 'car'),
                              SizedBox(width: 8),
                              KText(
                                text:
                                    'Transportation (${transportationC.transportationOrders.length})',
                                bold: true,
                                fontSize: 16,
                              ),
                            ],
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              push(TransportationWorkbenchPage());
                            },
                            child: Icon(EvaIcons.plusSquare),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              push(TransportationDashboardPage());
                            },
                            child: InkWell(
                              onTap: () {
                                push(
                                    TransportationDashboardTransportAgencyPage());
                              },
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Dashboard',
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: hexToColor('#80939D'),
                                    size: 15,
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 520,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: transportationC.transportationOrders.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item =
                            transportationC.transportationOrders[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 12, right: 12, left: 8),
                          child: Column(
                            children: [
                              Container(
                                width: 340,
                                height: 440,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.black12,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        color: hexToColor('#D2E4F3'),
                                      ),
                                      child: KText(
                                        text: item.productName != null
                                            ? '${item.productName}'
                                            : '',
                                        bold: true,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Code:',
                                                      fontSize: 13,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        children: [
                                                          KText(
                                                            text: item.productFullcode !=
                                                                    null
                                                                ? '${item.productFullcode}'
                                                                : '',
                                                            bold: true,
                                                            fontSize: 13,
                                                            maxLines: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    KText(
                                                      text: 'Uom: ',
                                                      fontSize: 13,
                                                    ),
                                                    KText(
                                                      text: item.baseUom != null
                                                          ? '${item.baseUom}'
                                                          : '',
                                                      bold: true,
                                                      fontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'Agency Name',
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text:
                                                            '${item.orderingAgencyName}',
                                                        //  text: '${item.orderedToday}',
                                                        color: AppTheme.nTextC,
                                                        bold: true,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Project Name',
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 5,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: KText(
                                                    text: item.projectName !=
                                                            null
                                                        ? '${item.projectName}'
                                                        : '',
                                                    color: AppTheme.nTextC,
                                                    bold: true,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Ordered Today',
                                              ),
                                              KText(
                                                text: item.orderedToday != null
                                                    ? '${item.orderedToday}'
                                                    : '',
                                                bold: true,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Delivered Today',
                                              ),
                                              KText(
                                                text: item.deliveredToday !=
                                                        null
                                                    ? '${item.deliveredToday}'
                                                    : '',
                                                bold: true,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'Total Ordered',
                                                fontSize: 13,
                                              ),
                                              Spacer(),
                                              KText(
                                                text: item.totalOrdered != null
                                                    ? '${item.totalOrdered}'
                                                    : '',
                                                //  text: '${item.orderedToday}',
                                                color: AppTheme.nTextC,
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Total Delivered',
                                              ),
                                              KText(
                                                text: item.totalDelivered !=
                                                        null
                                                    ? '${item.totalDelivered}'
                                                    : '',
                                                color: AppTheme.nTextC,
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Total Pending',
                                              ),
                                              KText(
                                                text: item.totalPending != null
                                                    ? '${item.totalPending}'
                                                    : '',
                                                bold: true,
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
