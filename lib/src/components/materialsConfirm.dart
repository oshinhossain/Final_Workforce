import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../helpers/render_svg.dart';

class MaterialsConfirm extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // var evaIcons = EvaIcons;
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Obx(
          () => GestureDetector(
            onTap: () => materialC.isExpanded.toggle(),
            child: Container(
              margin: EdgeInsets.only(
                top: 12,
                left: 10,
                right: 10,
              ),
              height: materialC.isExpanded.value ? 315 : 135,
              //width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1.5, color: hexToColor('#DBECFB'))
                  // border: Border.all(
                  //   color: hexToColor('#FFFFFF'),
                  //   style: BorderStyle.solid,
                  //   width: 1,
                  // ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color(0xffF5F5FA).withOpacity(0.4),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 2), // changes position of shadow
                  //   ),
                  // ],
                  ),
              child: Column(
                children: [
                  Container(
                    //width: Get.width,
                    height: 40,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                KText(
                                  text: 'Code ',
                                  fontSize: 13,
                                  color: hexToColor('#515D64'),
                                ),
                              ],
                            ),
                            materialC.isExpanded.value
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                    ),
                                    child: KText(
                                      text: 'A213456',
                                      color: hexToColor('#515D64'),
                                      fontSize: 14,
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.all(0),
                                  )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                KText(
                                  text: 'Drop Location ',
                                  fontSize: 13,
                                  color: hexToColor('#515D64'),
                                ),
                              ],
                            ),
                            materialC.isExpanded.value
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                    ),
                                    child: KText(
                                      text: 'Location 01',
                                      color: hexToColor('#515D64'),
                                      fontSize: 14,
                                    ),
                                  )
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
                  materialC.isExpanded.value
                      ? Column(
                          children: [
                            Divider(color: hexToColor('#DBECFB')),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Distance'),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Quantity'),
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
                                        contentPadding: EdgeInsets.all(0),
                                        isDense: true,
                                        hintText: '649',
                                        labelStyle: TextStyle(
                                            color: hexToColor('#FF0000')),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: hexToColor('#DBECFB')),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Weight'),
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
                                        contentPadding: EdgeInsets.all(0),
                                        isDense: true,
                                        hintText: '649',
                                        labelStyle: TextStyle(
                                            color: hexToColor('#FF0000')),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: hexToColor('#DBECFB')),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Transportation Fee',
                                        fontSize: 14,
                                        color: hexToColor('#41525A'),
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
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'A213456',
                                        color: hexToColor('#515D64'),
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
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'Goods Receiver ',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      RenderSvg(
                                        path: 'icon_search_elements',
                                        width: 25,
                                        color: hexToColor('#66A1D9'),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'Goods Inspector ',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      RenderSvg(
                                        path: 'icon_search_elements',
                                        width: 25,
                                        color: hexToColor('#66A1D9'),
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
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Quantity'),
                              Text('450 PCs'),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
