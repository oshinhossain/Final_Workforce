import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/location_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import 'create_transport_order_page.dart';

class TransportationWorkbenchPage extends StatelessWidget with Base {
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    // await Future.delayed(Duration(seconds: 1));
    transportationWorkbenchC.getTransportOrdersForWorkbench();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';

    transportationWorkbenchC.getTransportOrdersForWorkbench();
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: BorderSide(
              color: hexToColor('#FFFFFF'),
            ),
          ),
          onPressed: () {
            push(CreateTransportOrderPage());
          },
          child: RenderSvg(
            path: 'floating-button-Chat-user-add',
          )),
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
                        text: 'Transportation Workbench',
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
                transportationWorkbenchC.workbenchTransportOrders.isEmpty
                    ? transportationWorkbenchC.isLoading.value
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
                        itemCount: transportationWorkbenchC
                            .workbenchTransportOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = transportationWorkbenchC
                              .workbenchTransportOrders[index];

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 18, top: 18, left: 12, right: 12),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Transport Order',
                                              color: hexToColor('#80939D'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            KText(
                                              text: '${item.transportOrderNo}',
                                              color: hexToColor('#515D64'),
                                              bold: true,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        if (item.transportOrderDate != null)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Order Date',
                                                color: hexToColor('#80939D'),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // KText(
                                              //   text: formatDate(
                                              //       date: item.transportOrderDate!),
                                              //   color: hexToColor('#515D64'),
                                              // ),
                                              KText(
                                                text: formatDate(
                                                    date: item
                                                        .transportOrderDate!),
                                                // text: item.transportOrderDate!,
                                                color: hexToColor('#515D64'),
                                                bold: true,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: SizedBox(
                                              width: 70,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: KText(
                                                  text:
                                                      item.receiverAgencyName ??
                                                          'Not found',
                                                  color: hexToColor('#515D64'),
                                                ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Ordering Party',
                                              color: hexToColor('#80939D'),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: KText(
                                                          text:
                                                              '${item.orderingAgencyName}',
                                                        ),
                                                      ),
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
                                                )
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Receiving Person',
                                                color: hexToColor('#80939D'),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: KText(
                                                              text:
                                                                  '${item.receiverFullname}'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      item.receiverUsername !=
                                                              null
                                                          ? Container(
                                                              height: 38,
                                                              width: 38,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          2.0,
                                                                    ),
                                                                  ]),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                child: Image
                                                                    .network(
                                                                  '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.receiverUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              backgroundColor:
                                                                  AppTheme
                                                                      .color4,
                                                              radius: 45,
                                                              child: RenderSvg(
                                                                  path:
                                                                      'avatar_placeholder'),
                                                            ),

                                                      // RenderImg(
                                                      //   path: 'icon_avatar.png',
                                                      //   width: 30,
                                                      //   height: 30,
                                                      // ),
                                                    ],
                                                  )
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: KText(
                                                text: '${item.sourceLocName}',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: KText(
                                                text:
                                                    '${item.destinationLocName}',
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
                                    if (item.latestEtd != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    text: 'ETD',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // KText(
                                                    //   text: formatDate(
                                                    //       date: '${item.latestEtd}'),
                                                    //   color: hexToColor('#515D64'),
                                                    // ),
                                                    KText(
                                                      text: formatDate(
                                                          date:
                                                              item.latestEtd!),
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                        ],
                                      ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                //  text: '${item.travelPathName}',

                                                text: '',
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
                                    if (item.remarks != null)
                                      Column(
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
                                                    text: 'Remarks',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    child: KText(
                                                      maxLines: 3,
                                                      text: '${item.remarks}',
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: item.statusCode == '02'
                                              ? null
                                              : () {
                                                  transportationWorkbenchC
                                                      .submitForApproval(item);
                                                },
                                          child: Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: AppTheme.primaryColor
                                                  .withOpacity(
                                                      item.statusCode == '02'
                                                          ? .5
                                                          : 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: item.isLoading
                                                ? Loading(
                                                    color: Colors.white,
                                                  )
                                                : KText(
                                                    text: 'Submit for Approval',
                                                    color: Colors.white,
                                                    bold: true,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            transportationWorkbenchC
                                                .expendITem(item.id!);
                                          },
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'BOQ',
                                                bold: true,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  transportationWorkbenchC
                                                      .expendITem(item.id!);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: hexToColor(
                                                          '#FFA133')),
                                                  child: Icon(
                                                    item.expended == false
                                                        ? Icons
                                                            .arrow_downward_outlined
                                                        : Icons
                                                            .arrow_upward_outlined,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                              // Transform.rotate(
                                              //   angle: -180,
                                              //   child: RenderSvg(
                                              //     path: 'top_icon',
                                              //     width: 25,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        RenderSvg(
                                          path: 'icon_top_bar_left_menu',
                                          color: hexToColor('#9BA9B3'),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    if (item.expended!)
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
                                                  text: 'Material List',
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
                                          DottedLine(
                                              dashColor: hexToColor('#80939D')),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          ListView.builder(
                                            itemCount: item.orderlines!.length,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final i = item.orderlines![index];
                                              return GestureDetector(
                                                // onTap: () => createTrasnportOrderC.exapndItem(item),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  //width: Get.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: hexToColor(
                                                            '#DBECFB')),
                                                  ),

                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        //width: Get.width,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                // borderRadius: BorderRadius.circular(12),
                                                                // border: Border.all(),
                                                                color: hexToColor(
                                                                    '#DBECFB')),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            KText(
                                                              text:
                                                                  '${i.productName}',
                                                              bold: true,
                                                              color: hexToColor(
                                                                  '#41525A'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          'Code ',
                                                                      color: hexToColor(
                                                                          '#80939D'),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          'Drop Location',
                                                                      color: hexToColor(
                                                                          '#80939D'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          '${i.productFullcode}',
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          '${i.dropLocName}',
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                        color: hexToColor(
                                                            '#DBECFB'),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(9),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          'Quantity',
                                                                      color: hexToColor(
                                                                          '#80939D'),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        KText(
                                                                          text:
                                                                              '${i.baseUomQuantity} ',
                                                                          color:
                                                                              hexToColor('#515D64'),
                                                                        ),
                                                                        KText(
                                                                          text: i.baseUom != null
                                                                              ? '${i.baseUom}'
                                                                              : '',
                                                                          color:
                                                                              hexToColor('#515D64'),
                                                                        ),
                                                                      ],
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
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, bottom: 5, top: 5),
                                    child: KText(
                                      text: '${item.status}',
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: hexToColor('#84BEF3'),
                                    ),
                                  )),
                            ],
                          );
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
}
