import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/widgets/title_bar.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';

class TransportationDashboardPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(MainPage());
        return Future(
          () => true,
        );
      },
      child: Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleBar(title: 'Transportation Dashboard'),
              SizedBox(
                height: 22,
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.offAll(MainPage());
                            },
                            child: RenderSvg(path: 'icon_bill')),
                        SizedBox(
                          width: 12,
                        ),
                        KText(
                          text: 'Transportation Orders I Placed',
                          fontSize: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(
                      thickness: .5,
                      color: hexToColor('#80939D'),
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => uiC.isExpanded.toggle(),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: uiC.isExpanded.value ? 200 : 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(
                                        color: hexToColor('#DBECFB'),
                                        width: 1)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(),
                                        color: hexToColor('#DBECFB'),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            uiC.isExpanded.value
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          KText(
                                            text: 'Transport Order No.',
                                            bold: true,
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'A21345D6',
                                            bold: true,
                                            fontSize: 14,
                                          ),
                                          // Icon(
                                          //   SvgPicture.asset('${Constants.svgPath}/Vector2.svg'),
                                          //   color: hexToColor('#FF8A00'),
                                          // ),

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
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Serial Number'),
                                          Text('Weight'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    uiC.isExpanded.value
                                        ? Column(
                                            children: [
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('-'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('-'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: hexToColor(
                                                                        '#DBECFB'))),
                                                            child: Center(
                                                                child:
                                                                    Text('-'))),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 1,
                                              width: 50,
                                              color: hexToColor('#DBECFB')),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                              height: 1,
                                              width: 60,
                                              color: hexToColor('#DBECFB')),
                                          SizedBox(
                                            width: 120,
                                          ),
                                          Container(
                                              height: 1,
                                              width: 50,
                                              color: hexToColor('#DBECFB'))
                                        ],
                                      ),
                                    ),
                                    Divider(color: hexToColor('#DBECFB')),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Quantity'),
                                          Text('450 PCs'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => uiC.isExpanded.toggle(),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: uiC.isExpanded.value ? 200 : 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: hexToColor('#DBECFB'), width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(),
                                        color: hexToColor('#98F2DB'),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            uiC.isExpanded.value
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          KText(
                                            text: 'Transport Order No.',
                                            bold: true,
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'A21345D6',
                                            bold: true,
                                            fontSize: 14,
                                          ),
                                          // Icon(
                                          //   SvgPicture.asset('${Constants.svgPath}/Vector2.svg'),
                                          //   color: hexToColor('#FF8A00'),
                                          // ),

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
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Serial Number'),
                                          Text('Weight'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    uiC.isExpanded.value
                                        ? Column(
                                            children: [
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('-'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('-'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
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
                                                        Text('26345634'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: hexToColor(
                                                                        '#DBECFB'))),
                                                            child: Center(
                                                                child:
                                                                    Text('-'))),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text('21741273'),
                                                      ],
                                                    ),
                                                    Text('155 Kg'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 1,
                                              width: 50,
                                              color: hexToColor('#DBECFB')),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Container(
                                              height: 1,
                                              width: 60,
                                              color: hexToColor('#DBECFB')),
                                          SizedBox(
                                            width: 120,
                                          ),
                                          Container(
                                              height: 1,
                                              width: 50,
                                              color: hexToColor('#DBECFB'))
                                        ],
                                      ),
                                    ),
                                    Divider(color: hexToColor('#DBECFB')),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Quantity'),
                                          Text('450 PCs'),
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//  Column(
//                               children: [
//                                 Padding(
//                                   padding:   EdgeInsets.only(
//                                       left: 10, right: 10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('26345634'),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Container(
//                                               height: 20,
//                                               width: 20,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   border: Border.all(
//                                                       color: hexToColor(
//                                                           '#DBECFB'))),
//                                               child: Center(child: Text('-'))),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text('21741273'),
//                                         ],
//                                       ),
//                                       Text('155 Kg'),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                       Padding(
//                         padding:   EdgeInsets.only(left: 10),
//                         child: Row(
//                           children: [
//                             Container(
//                                 height: 1,
//                                 width: 50,
//                                 color: hexToColor('#DBECFB')),
//                             SizedBox(
//                               width: 50,
//                             ),
//                             Container(
//                                 height: 1,
//                                 width: 60,
//                                 color: hexToColor('#DBECFB')),
//                             SizedBox(
//                               width: 120,
//                             ),
//                             Container(
//                                 height: 1,
//                                 width: 50,
//                                 color: hexToColor('#DBECFB'))
//                           ],
//                         ),
//                       ),
//                       Divider(color: hexToColor('#DBECFB')),
//                       Padding(
//                         padding:   EdgeInsets.only(left: 10, right: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Quantity'),
//                             Text('450 PCs'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )