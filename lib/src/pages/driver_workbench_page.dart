import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:workforce/src/pages/confirm_transport_page.dart';
import 'package:workforce/src/pages/start_journey_page.dart';
import 'package:workforce/src/pages/unload_materials_vehicle_page.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

import '../models/workbench_model.dart';

class DriverWorkbenchPage extends StatelessWidget with Base {
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    // await Future.delayed(Duration(seconds: 1));
    driverWorkbenchC.getDriverOrdersForWorkbench();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    driverWorkbenchC.getDriverOrdersForWorkbench();
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      backgroundColor: hexToColor('#EEF0F6'),
      body: Obx(
        () => SmartRefresher(
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 12, top: 3, bottom: 3),
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
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          back();
                        },
                      ),
                      KText(
                        text: 'Driver Workbench',
                        fontSize: 16,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                driverWorkbenchC.driverWorkbenchOrder.isEmpty
                    ? driverWorkbenchC.isLoading.value
                        ? SizedBox(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : SizedBox(
                            height: Get.height / 1.5,
                            child: Center(child: KText(text: 'No data found')),
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: driverWorkbenchC.driverWorkbenchOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              driverWorkbenchC.driverWorkbenchOrder[index];

                          // Confirm Vehicle Rediness
                          if (item.statusCode == '07' ||
                              item.statusCode == '08') {
                            return DriverWorkbenchMethod(
                              status: 'For Confirmation',
                              item: item,
                              onTap: () {
                                // kLog('${item.transportOrderNo}');
                                push(
                                  ConfirmTransportOrderReadinessByDriverPage(
                                    transportOrderNo:
                                        '${item.transportOrderNo}',
                                    isFromNotification: true,
                                  ),
                                );
                              },
                              title: 'Confirm Vehicle Readiness',
                              statusColor: hexToColor('#48A7FF'),
                            );
                          }
                          // if (item.statusCode == '09' ||
                          //     item.statusCode == '10') {
                          //   return DriverWorkbenchMethod(
                          //     status: '${item.status}',
                          //     item: item,
                          //     onTap: () {
                          //      // kLog('${item.transportOrderNo}');
                          //         push(
                          //           ConfirmTransportOrderReadinessByDriverPage(
                          //             transportOrderNo: '${item.transportOrderNo}',
                          //             isFromNotification: true,
                          //           ),
                          //         );
                          //     },
                          //     title: 'Confirm Vehicle Readiness',
                          //     statusColor: hexToColor('#FCA949'),
                          //   );
                          // }
                          if (item.statusCode == '11' ||
                              item.statusCode == '12') {
                            return DriverWorkbenchMethod(
                              status: 'For Starting',
                              item: item,
                              onTap: () {
                                // kLog('${item.transportOrderNo}');
                                push(
                                  StartJourneyPage(
                                    transportOrderNo:
                                        '${item.transportOrderNo}',
                                    isFromNotification: true,
                                  ),
                                );
                              },
                              title: 'Start Journey',
                              statusColor: hexToColor('#48A7FF'),
                            );
                          }

                          if (item.statusCode == '13' ||
                              item.statusCode == '14') {
                            return DriverWorkbenchMethod(
                              status: 'For Delivery',
                              item: item,
                              onTap: () {
                                // kLog('${item.transportOrderNo}');
                                push(
                                  UnloadMaterialsVehicle(
                                    transportOrderNo:
                                        '${item.transportOrderNo}',
                                    isFromNotification: true,
                                  ),
                                );
                              },
                              title: 'Drop Materials',
                              statusColor: hexToColor('#FCA949'),
                            );
                          }

                          return SizedBox();
                        },
                      ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack DriverWorkbenchMethod({
    required WorkbenchModel item,
    required void Function()? onTap,
    required String title,
    required String status,
    required Color statusColor,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 18, top: 18, left: 12, right: 12),
          padding: EdgeInsets.all(12),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Transport Order',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      KText(
                        bold: true,
                        text: '${item.transportOrderNo}',
                        color: hexToColor('#515D64'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Order Date',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (item.transportOrderDate != null)
                        KText(
                          bold: true,
                          text: formatDate(date: item.transportOrderDate!),
                          color: hexToColor('#515D64'),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Ordering Party',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          maxLines: 3,
                          text: item.orderingAgencyName != null
                              ? '${item.orderingAgencyName}'
                              : '',
                          color: hexToColor('#515D64'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Receiving Party',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: KText(
                              maxLines: 3,
                              text: item.receiverAgencyName != null
                                  ? '${item.receiverAgencyName}'
                                  : '',
                              color: hexToColor('#515D64'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Ordering Person',
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: KText(
                                maxLines: 3,
                                text: item.orderingAgencyName != null
                                    ? '${item.orderingAgencyName}'
                                    : ''),
                          ),
                          // SizedBox(
                          //   width: 12,
                          // ),
                          // RenderImg(
                          //   path: 'icon_avatar.png',
                          //   width: 30,
                          //   height: 30,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (item.receiverFullname != null)
                Divider(
                  thickness: 1,
                ),
              if (item.receiverFullname != null)
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Receiving Person',
                          color: hexToColor('#80939D'),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              KText(
                                  text: item.receiverFullname != null
                                      ? '${item.receiverFullname} '
                                      : ''),
                              SizedBox(
                                width: 12,
                              ),
                              RenderImg(
                                path: 'icon_avatar.png',
                                width: 30,
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Project',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: KText(
                          maxLines: 3,
                          text: item.projectName != null
                              ? '${item.projectName}'
                              : '',
                          color: hexToColor('#515D64'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Source',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: KText(
                              text: item.sourceLocName != null
                                  ? '${item.sourceLocName}'
                                  : '',
                              color: hexToColor('#515D64'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Destination',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: KText(
                              text: item.destinationLocName != null
                                  ? '${item.destinationLocName}'
                                  : '',
                              color: hexToColor('#515D64'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'ETD',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.latestEtd != null)
                          KText(
                            text: formatDate(date: '${item.latestEtd}'),
                            color: hexToColor('#515D64'),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Travel Path',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 300,
                        child: KText(
                          text: '',
                          // text: '${item.travelPathName}',
                          color: hexToColor('#515D64'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  GestureDetector(
                    // onTap: () {
                    //  // kLog('${item.transportOrderNo}');
                    //   push(InspectMaterialsToTransportPage(
                    //     transportOrderNo: '${item.transportOrderNo}',
                    //     isFromNotification: true,
                    //   ));
                    // },
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: KText(
                        text: title,
                        color: Colors.white,
                        bold: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        driverWorkbenchC.expendITem(item.id!);
                      },
                      child: Row(
                        children: [
                          KText(
                            text: 'BOQ',
                            bold: true,
                            color: Colors.black,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              driverWorkbenchC.expendITem(item.id!);
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hexToColor('#FFA133'),
                              ),
                              child: Icon(
                                item.expended == false
                                    ? Icons.arrow_downward_outlined
                                    : Icons.arrow_upward_outlined,
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  RenderSvg(
                    path: 'icon_top_bar_left_menu',
                    color: hexToColor('#9BA9B3'),
                  )
                ],
              ),
              SizedBox(height: 8),
              Divider(
                thickness: 1,
              ),
              if (item.expended! && item.workbebchLodingDTO != null)
                //  if (item.expended! && item.orderlines != null)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          RenderSvg(path: 'icon_5'),
                          SizedBox(
                            width: 12,
                          ),
                          KText(
                            text: 'Materials List',
                            fontSize: 16,
                            bold: true,
                            color: hexToColor('#41525A'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DottedLine(dashColor: hexToColor('#80939D')),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      itemCount: item.workbebchLodingDTO!.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        final i = item.workbebchLodingDTO![index];
                        return GestureDetector(
                          //  onTap: () => createTrasnportOrderC.exapndItem(item),
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            //width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1.5, color: hexToColor('#DBECFB')),
                            ),

                            child: Column(
                              children: [
                                Container(
                                  //width: Get.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(12),
                                      // border: Border.all(),
                                      color: hexToColor('#DBECFB')),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: KText(
                                          text: i.productName != null
                                              ? '${i.productName}'
                                              : '',
                                          // text: '${i.dropLocName}',
                                          bold: true,
                                          color: hexToColor('#41525A'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Product Code',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'Drop Location',
                                            color: hexToColor('#80939D'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: KText(
                                              text: i.productCode != null
                                                  ? '${i.productCode}'
                                                  : '',
                                              color: hexToColor('#515D64'),
                                            ),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            flex: 5,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: KText(
                                                text: i.dropLocName != null
                                                    ? '${i.dropLocName}'
                                                    : '',
                                                color: hexToColor('#515D64'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: hexToColor('#DBECFB'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(9),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Quantity',
                                                color: hexToColor('#80939D'),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: i.baseUomQuantity != null
                                                    ? '${i.baseUomQuantity} '
                                                    : '',
                                                color: hexToColor('#515D64'),
                                              ),
                                              KText(
                                                text: i.baseUom != null
                                                    ? '${i.baseUom}'
                                                    : '',
                                                color: hexToColor('#515D64'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
            ],
          ),
        ),
        Positioned(
          right: 30,
          top: 4,
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
            child: KText(
              text: status,
              color: Colors.white,
              fontSize: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }
}
