import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/controllers/create_transport_controller.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/create_transport_order_preview.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';

class CreateTransportLineItemsPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    createMaterialC.isLoading.value = false;
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Obx(
        () => ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              height: 50,
              width: Get.width,
              // margin: EdgeInsets.symmetric(vertical: .5),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => back(),
                    child: RenderSvg(
                      path: 'icon_back',
                      width: 13.0,
                    ),
                  ),
                  KText(
                    text: 'Create Transport Order Line Items',
                    fontSize: 16,
                    color: hexToColor('#41525A'),
                    bold: true,
                  ),
                  SizedBox()
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 12),
                  // height: 47,
                  width: Get.width,
                  color: hexToColor('#ffffff'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          createTrasnportOrderC.addTransportLineItem();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: hexToColor('#FFA133'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Total Quantity',
                              fontSize: 14,
                            ),
                            KText(
                              text:
                                  '${createTrasnportOrderC.getTotalQuantity()}',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Gross Transportation Fee',
                              fontSize: 14,
                            ),
                            KText(
                              text: 'BDT 0',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                createTrasnportOrderC.transportOrderLines.isEmpty
                    ? Divider()
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                            createTrasnportOrderC.transportOrderLines.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              createTrasnportOrderC.transportOrderLines[index];
                          return GestureDetector(
                            // onTap: () => createTrasnportOrderC.exapndItem(item),
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 12,
                              ),
                              height: item.expended! ? 325 : 142,
                              //width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1.5, color: hexToColor('#DBECFB')),
                              ),

                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        createTrasnportOrderC.exapndItem(item),
                                    child: Container(
                                      //width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(12),
                                          // border: Border.all(),
                                          color: hexToColor('#DBECFB')),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 12),
                                          Icon(
                                            item.expended!
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: KText(
                                              text: item.productName,
                                              bold: true,
                                            ),
                                          ),
                                          Spacer(),
                                          SvgPicture.asset(
                                            '${Constants.svgPath}/icon_copy.svg',
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          GestureDetector(
                                            onTap: () => createTrasnportOrderC
                                                .deleteItem(item),
                                            child: SvgPicture.asset(
                                              '${Constants.svgPath}/icon_delete.svg',
                                              width: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  KText(
                                                    text: 'Code',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#515D64'),
                                                  ),

                                                  // SvgPicture.asset(
                                                  //   '${Constants.svgPath}/icon_search_elements.svg',
                                                  //   width: 25,
                                                  //   color: hexToColor('#66A1D9'),
                                                  // ),
                                                ],
                                              ),
                                              item.expended!
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 0,
                                                      ),
                                                      child: KText(
                                                        text:
                                                            '${item.productFullcode}',
                                                        color: hexToColor(
                                                            '#515D64'),
                                                        fontSize: 13,
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  KText(
                                                    text: 'Drop Location ',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#515D64'),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (createTrasnportOrderC
                                                          .isSingleDropLocation
                                                          .isTrue) {
                                                        Get.snackbar(
                                                            'Attention',
                                                            'Single drop location enabled',
                                                            backgroundColor:
                                                                AppTheme
                                                                    .appbarColor,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM);
                                                      } else {
                                                        createTrasnportOrderC
                                                            .searchOrderLineDropLocation(
                                                                item);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      '${Constants.svgPath}/icon_search_elements.svg',
                                                      width: 25,
                                                      color:
                                                          hexToColor('#66A1D9'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              item.expended!
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 0,
                                                      ),
                                                      child: KText(
                                                        text: createTrasnportOrderC
                                                                .isSingleDropLocation
                                                                .isTrue
                                                            ? createTrasnportOrderC
                                                                    .getDropLocationName() ??
                                                                'Drop Location'
                                                            : '',
                                                        color: hexToColor(
                                                            '#515D64'),
                                                        fontSize: 14,
                                                      ),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.all(0),
                                                      padding:
                                                          EdgeInsets.all(0),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  item.expended!
                                      ? Column(
                                          children: [
                                            Divider(
                                                color: hexToColor('#DBECFB')),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      KText(text: 'Distance'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  KText(
                                                    text:
                                                        '${item.distance ?? '0.0'} Km',
                                                    bold: true,
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //     left: 10,
                                            //     right: 10,
                                            //     top: 10,
                                            //   ),
                                            //   child: Row(
                                            //     children: [
                                            //       Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .spaceBetween,
                                            //         children: [
                                            //           KText(text: 'Quantity'),
                                            //           SizedBox(
                                            //             width: 10,
                                            //           ),
                                            //         ],
                                            //       ),
                                            //       Spacer(),
                                            //       SizedBox(
                                            //         width: 70,
                                            //         child: TextField(
                                            //           decoration:
                                            //               InputDecoration(
                                            //             contentPadding:
                                            //                 EdgeInsets.all(0),
                                            //             isDense: true,
                                            //             hintText: '649',
                                            //             labelStyle: TextStyle(
                                            //                 color: hexToColor(
                                            //                     '#FF0000')),
                                            //             enabledBorder:
                                            //                 UnderlineInputBorder(
                                            //               borderSide: BorderSide(
                                            //                   color: hexToColor(
                                            //                       '#DBECFB')),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       KText(
                                            //         text: 'Pcs',
                                            //         fontSize: 14,
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(text: 'Quantity'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  SizedBox(
                                                    width: 70,
                                                    child: TextFormField(
                                                      // inputFormatters: <
                                                      //     TextInputFormatter>[
                                                      //   FilteringTextInputFormatter
                                                      //       .digitsOnly
                                                      // ],
                                                      initialValue:
                                                          '${item.quantity == 0 ? '' : item.quantity}',
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (v) {
                                                        if (v.isNotEmpty) {
                                                          createTrasnportOrderC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType.pcs,
                                                            num.parse(v),
                                                          );
                                                        } else {
                                                          createTrasnportOrderC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType.pcs,
                                                            0.0,
                                                          );
                                                        }
                                                      },
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Manrope Regular',
                                                        fontSize: 12,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0),
                                                        isDense: true,
                                                        hintText: '0.0',
                                                        labelStyle: TextStyle(
                                                          color: hexToColor(
                                                              '#FF0000'),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: hexToColor(
                                                                '#DBECFB'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  KText(
                                                    text: item.baseUom != null
                                                        ? ' ${item.baseUom}'
                                                        : '',
                                                    fontSize: 14,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(text: 'Weight'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  SizedBox(
                                                    width: 70,
                                                    child: TextFormField(
                                                      // inputFormatters: <
                                                      //     TextInputFormatter>[
                                                      //   FilteringTextInputFormatter
                                                      //       .allow(RegExp(
                                                      //           r'^(0|[1-9]{0,4})(\.\d{0,2})?$'))
                                                      // ],
                                                      initialValue:
                                                          '${item.weight == 0 ? '' : item.weight}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Manrope Regular',
                                                        fontSize: 12,
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (v) {
                                                        if (v.isNotEmpty) {
                                                          createTrasnportOrderC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType.kg,
                                                            num.parse(v),
                                                          );
                                                        } else {
                                                          createTrasnportOrderC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType.kg,
                                                            0.0,
                                                          );
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0),
                                                        isDense: true,
                                                        hintText: '0.0',
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: hexToColor(
                                                                  '#DBECFB')),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  KText(
                                                    text: ' Kg',
                                                    fontSize: 14,
                                                  )
                                                ],
                                              ),
                                            ),
                                            // KText(text: '${item.weight}'),
                                            Divider(
                                                color: hexToColor('#DBECFB')),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      KText(
                                                        text:
                                                            'Transportation Fee',
                                                        fontSize: 14,
                                                        color: hexToColor(
                                                            '#41525A'),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  KText(
                                                    text:
                                                        'BDT  ${item.transportationFee}',
                                                    fontSize: 14,
                                                    bold: true,
                                                    color: hexToColor(
                                                      '#41525A',
                                                    ),
                                                  ),
                                                  // KText(
                                                  //   text: 'Kg',
                                                  //   fontSize: 14,
                                                  // )
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 16,
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //         EdgeInsets.only(left: 10, right: 10),
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.spaceBetween,
                                            //     children: [
                                            //       Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment.spaceBetween,
                                            //         children: [
                                            //           Text('26345634'),
                                            //           SizedBox(
                                            //             width: 10,
                                            //           ),
                                            //           Text('-'),
                                            //           SizedBox(
                                            //             width: 10,
                                            //           ),
                                            //           Text('21741273'),
                                            //         ],
                                            //       ),
                                            //       Text('5 Kg'),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      KText(
                                                        text:
                                                            '${item.productCode}',
                                                        color: hexToColor(
                                                            '#515D64'),
                                                        fontSize: 13,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  KText(
                                                    text: createTrasnportOrderC
                                                            .isSingleDropLocation
                                                            .isTrue
                                                        ? createTrasnportOrderC
                                                                .getDropLocationName() ??
                                                            'Drop Location'
                                                        : '',
                                                    color:
                                                        hexToColor('#515D64'),
                                                    fontSize: 14,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        // Container(
                                        //     height: 1, width: 50, color: hexToColor('#DBECFB')),
                                        // SizedBox(
                                        //   width: 50,
                                        // ),
                                        // Container(
                                        //     height: 1, width: 60, color: hexToColor('#DBECFB')),
                                        // SizedBox(
                                        //   width: 120,
                                        // ),
                                        // Container(
                                        //     height: 1, width: 50, color: hexToColor('#DBECFB'))
                                      ],
                                    ),
                                  ),
                                  Divider(color: hexToColor('#DBECFB')),
                                  item.expended!
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Goods Receiver',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      GestureDetector(
                                                        // onTap: () {
                                                        //   createTrasnportOrderC
                                                        //       .searchUserForDropLineITem(
                                                        //     item,
                                                        //     'receiver',
                                                        //   );
                                                        // },
                                                        onTap: () {
                                                          if (createTrasnportOrderC
                                                              .isSingleRecivingPerson
                                                              .isTrue) {
                                                            Get.snackbar(
                                                                'Attention',
                                                                'Single reciving person enabled',
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .appbarColor,
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM);
                                                          } else {
                                                            createTrasnportOrderC
                                                                .searchOrderLineDropLocation(
                                                                    item);
                                                          }
                                                        },
                                                        child: SvgPicture.asset(
                                                          '${Constants.svgPath}/icon_search_elements.svg',
                                                          width: 25,
                                                          color: hexToColor(
                                                              '#66A1D9'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 160,
                                                    child: KText(
                                                      text: createTrasnportOrderC
                                                              .isSingleRecivingPerson
                                                              .isTrue
                                                          ? createTrasnportOrderC
                                                                  .getSingleRecivingPerson() ??
                                                              'Goods Receiver'
                                                          : '',
                                                      color:
                                                          hexToColor('#515D64'),
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Goods Inspector',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      GestureDetector(
                                                        // onTap: () {
                                                        //   createTrasnportOrderC
                                                        //       .searchUserForDropLineITem(
                                                        //     item,
                                                        //     'inspector',
                                                        //   );
                                                        // },
                                                        onTap: () {
                                                          if (createTrasnportOrderC
                                                              .isSinglegoodsInspector
                                                              .isTrue) {
                                                            Get.snackbar(
                                                                'Attention',
                                                                'Single goods inspector enabled',
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .appbarColor,
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM);
                                                          } else {
                                                            createTrasnportOrderC
                                                                .searchOrderLineDropLocation(
                                                                    item);
                                                          }
                                                        },
                                                        child: SvgPicture.asset(
                                                          '${Constants.svgPath}/icon_search_elements.svg',
                                                          width: 25,
                                                          color: hexToColor(
                                                              '#66A1D9'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 133,
                                                    child: KText(
                                                      text: createTrasnportOrderC
                                                              .isSingleDropLocation
                                                              .isTrue
                                                          ? createTrasnportOrderC
                                                                  .getSingleGoodsInspectorAtDropLocation() ??
                                                              'Goods Inspector'
                                                          : '',
                                                      color:
                                                          hexToColor('#515D64'),
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Quantity',
                                              ),
                                              KText(
                                                text: '${item.quantity} PCs',
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            //   height: 40,
            //   width: Get.width,
            //   // margin: EdgeInsets.symmetric(vertical: .5),

            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //   ),

            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           push(CTransportOrderPreview());
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 100,
            //           child: Center(
            //             child: KText(
            //               text: 'Preview',
            //               color: Colors.white,
            //               bold: true,
            //             ),
            //           ),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(6),
            //             color: hexToColor('#007BEC'),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
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

        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: createTrasnportOrderC.transportOrderLines.isNotEmpty &&
                        createTrasnportOrderC.validateTransportOrderLines()
                    ? () {
                        push(CreateTransportOrderPreview());
                        // if (createTrasnportOrderC.transportOrderLines.isNotEmpty) {
                        //   push(CreateTransportOrderPreview());
                        // }

                        // print('dd');

                        // showTopSnackBar(
                        //
                        //   context,
                        //   CustomSnackBar.success(
                        //     message:
                        //     'Previewed',
                        //   ),
                        // );
                      }
                    : () {
                        Get.snackbar(
                          'Status',
                          'Enter the Item Quantity',
                          colorText: AppTheme.black,
                          backgroundColor: AppTheme.appHomePageColor,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#007BEC').withOpacity(
                        createTrasnportOrderC.transportOrderLines.isNotEmpty &&
                                createTrasnportOrderC
                                    .validateTransportOrderLines()
                            ? 1
                            : .5),
                  ),
                  child: Center(
                    child: KText(
                      text: 'Preview',
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
