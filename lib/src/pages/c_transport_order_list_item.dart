import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/create_transport_order_preview.dart';

import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';

class CTransportOrderListItem extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: SizedBox(
        //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        height: Get.height,
        //width: Get.width,
        child: ListView(
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
            SizedBox(
              height: Get.height - 170,
              //width: Get.width,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 47,
                    width: Get.width,
                    color: hexToColor('#ffffff'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                                text: '1245',
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
                                text: '253,265',
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
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () => materialC.isExpanded.toggle(),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 12,
                            ),
                            height: materialC.isExpanded.value ? 325 : 142,
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
                                      Icon(
                                        materialC.isExpanded.value
                                            ? EvaIcons.arrowIosUpwardOutline
                                            : EvaIcons.arrowIosDownwardOutline,
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text: 'Item Name 01',
                                        bold: true,
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                        '${Constants.svgPath}/icon_copy.svg',
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        '${Constants.svgPath}/icon_delete.svg',
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
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
                                                text: 'Code ',
                                                fontSize: 13,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SvgPicture.asset(
                                                '${Constants.svgPath}/icon_search_elements.svg',
                                                width: 25,
                                                color: hexToColor('#66A1D9'),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 0,
                                            ),
                                            child: KText(
                                              text: 'A213456',
                                              color: hexToColor('#515D64'),
                                              fontSize: 14,
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
                                                text: 'Drop Location ',
                                                fontSize: 13,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SvgPicture.asset(
                                                '${Constants.svgPath}/icon_search_elements.svg',
                                                width: 25,
                                                color: hexToColor('#66A1D9'),
                                              ),
                                            ],
                                          ),
                                          true
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 0,
                                                  ),
                                                  child: KText(
                                                    text: 'Location 01',
                                                    color:
                                                        hexToColor('#515D64'),
                                                    fontSize: 14,
                                                  ),
                                                )
                                              // ignore: dead_code
                                              : Container(
                                                  margin: EdgeInsets.all(0),
                                                  padding: EdgeInsets.all(0),
                                                )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                true
                                    ? Column(
                                        children: [
                                          Divider(color: hexToColor('#DBECFB')),
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
                                                Text('50 Km'),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      isDense: true,
                                                      hintText: '649',
                                                      labelStyle: TextStyle(
                                                          color: hexToColor(
                                                              '#FF0000')),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: hexToColor(
                                                                '#DBECFB')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                KText(
                                                  text: 'Pcs',
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      isDense: true,
                                                      hintText: '649',
                                                      labelStyle: TextStyle(
                                                          color: hexToColor(
                                                              '#FF0000')),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: hexToColor(
                                                                '#DBECFB')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                KText(
                                                  text: 'Kg',
                                                  fontSize: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(color: hexToColor('#DBECFB')),
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
                                                      color:
                                                          hexToColor('#41525A'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                KText(
                                                  text: 'BDT  95,000',
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
                                    // ignore: dead_code
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
                                                      text: 'A213456',
                                                      color:
                                                          hexToColor('#515D64'),
                                                      fontSize: 14,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                KText(
                                                  text: 'Location 01',
                                                  color: hexToColor('#515D64'),
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
                                materialC.isExpanded.value
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
                                                      text: 'Goods Receiver ',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SvgPicture.asset(
                                                      '${Constants.svgPath}/icon_search_elements.svg',
                                                      width: 25,
                                                      color:
                                                          hexToColor('#66A1D9'),
                                                    ),
                                                  ],
                                                ),
                                                KText(
                                                  text: 'Abdul Karim',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Goods Inspector ',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SvgPicture.asset(
                                                      '${Constants.svgPath}/icon_search_elements.svg',
                                                      width: 25,
                                                      color:
                                                          hexToColor('#66A1D9'),
                                                    ),
                                                  ],
                                                ),
                                                KText(
                                                  text: 'Tamal Sarkar',
                                                  fontSize: 15,
                                                  color: hexToColor('#515D64'),
                                                ),
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
                                              text: '450 PCs',
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
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

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                push(CreateTransportOrderPreview());
                // print('dd');

                // showTopSnackBar(
                //
                //   context,
                //   CustomSnackBar.success(
                //     message:
                //     'Previewed',
                //   ),
                // );

                // Get.snackbar(
                //   'Status',
                //   'Previewed',
                //   colorText: AppTheme.black,
                //   backgroundColor: AppTheme.appHomePageColor,
                //   snackPosition: SnackPosition.BOTTOM,
                // );
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: hexToColor('#007BEC'),
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
    );
  }
}
