import 'package:flutter/material.dart';

import '../components/k_appbar.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../widgets/title_bar.dart';

class PostMyTaskProgress2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleBar(title: 'Task Details'),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: hexToColor('#EEF0F6'),
              ),
              padding: EdgeInsets.only(left: 15, right: 15),
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                children: [
                  KText(
                    text: 'BTCLHaor-BaorProject',
                    fontSize: 13,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: RenderSvg(
                      path: 'icon_forward',
                      height: 18,
                      width: 18,
                    ),
                  ),
                  KText(
                    text: 'Pole',
                    fontSize: 13,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: RenderSvg(
                      path: 'icon_forward',
                      height: 18,
                      width: 18,
                    ),
                  ),
                  KText(
                    text: 'Pole Delivery',
                    fontSize: 13,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text:
                        'Guidance needed for pole delivery by truck from\n jessore to Tangail',
                    fontSize: 14,
                    color: AppTheme.oColor1,
                    bold: true,
                  ),
                  Divider(
                    thickness: 1,
                    color: hexToColor('#D9D9D9'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                                color: hexToColor('#49CDAB'),
                              ),
                              child: Center(
                                child: KText(
                                  text: 'Consulted',
                                  color: hexToColor('#FFFFFF'),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                KText(
                                  text: 'Task ID :',
                                  fontSize: 13,
                                ),
                                KText(
                                  text: ' 3201578',
                                  fontSize: 13,
                                  bold: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: KText(
                                text: 'Task Status',
                                fontSize: 13,
                              ),
                            ),
                            Spacer(),
                            KText(
                              text: 'Progress',
                              fontSize: 13,
                            ),
                            Spacer(),
                            KText(
                              text: 'Remaning',
                              fontSize: 13,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  color: hexToColor('#FFA133'),
                                ),
                              ),
                              child: Center(
                                child: KText(
                                  text: 'Accepted',
                                  color: hexToColor('#FFA133'),
                                  fontSize: 13,
                                  bold: true,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 22,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: hexToColor('#00D8A0')),
                              ),
                              child: Center(
                                child: KText(
                                  text: '0%',
                                  color: hexToColor('#00D8A0'),
                                  fontSize: 13,
                                  bold: true,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 22,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: hexToColor('#FF3C3C')),
                              ),
                              child: Center(
                                child: KText(
                                  text: '3 Days',
                                  bold: true,
                                  color: hexToColor('#FF3C3C'),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        margin: EdgeInsets.only(right: 5, top: 5),
                        decoration: BoxDecoration(
                          color: Color(0xffF5F5FA),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Color.fromARGB(255, 230, 230, 233),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffF5F5FA).withOpacity(0.6),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                '${Constants.imgPath}/bill.jpg',
                                width: 37,
                                height: 37,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Assigned by',
                            fontSize: 13,
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: 'Md.Sazzad Hossain ',
                            fontSize: 14,
                            color: hexToColor('#515D64'),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: KText(
                              text: 'Created on',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                          ),
                          KText(
                            text: '04 Sep 2022',
                            fontSize: 14,
                            color: hexToColor('#515D64'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Quantity',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: '2 Advices',
                              fontSize: 14,
                              color: hexToColor('#515D64'),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            KText(
                              text: 'Remaining. Qty.',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: '2 Advices',
                              fontSize: 14,
                              color: hexToColor('#515D64'),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Delivery Date',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: '07 Sep 2022',
                              fontSize: 14,
                              color: hexToColor('#515D64'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  KText(
                    text: 'Description',
                    fontSize: 14,
                    color: hexToColor('#515D64'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  KText(
                    text:
                        '600 pieces concrete poles, weight 20 ton, length 20 feet. Delivery from Jessore to Durgapur, Kalihati,\n Tangail.',
                    fontSize: 14,
                    color: hexToColor('#515D64'),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 34,
                      width: 116,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: hexToColor('#449EF1')),
                      child: Center(
                        child: KText(
                          text: 'Start Task',
                          fontSize: 16,
                          color: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 15),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 1,
            //         width: 80,
            //         color: hexToColor('#D9D9D9'),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       KText(
            //         text: 'Task Progress History',
            //         fontSize: 16,
            //         color: hexToColor('#41525A'),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         height: 1,
            //         width: 80,
            //         color: hexToColor('#D9D9D9'),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding:   EdgeInsets.only(left: 15),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       CircleAvatar(
            //         backgroundColor: hexToColor('#84BEF3'),
            //         radius: 15,
            //         child: Center(
            //           child: KText(
            //             text: '1',
            //             fontSize: 14,
            //             color: hexToColor('#FFFFFF'),
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           KText(
            //             text: '04 Sep 2022',
            //             fontSize: 14,
            //             color: hexToColor('#515D64'),
            //           ),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           KText(
            //             text: '12:30 PM ',
            //             fontSize: 14,
            //             color: hexToColor('#515D64'),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         width: 70,
            //       ),
            //       Column(
            //         //crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 6),
            //             child: KText(
            //               text: 'Task Status',
            //               fontSize: 13,
            //               color: hexToColor('#80939D'),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           Container(
            //             height: 25,
            //             width: 90,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(8)),
            //               border: Border.all(
            //                 color: hexToColor('#FFA133'),
            //               ),
            //             ),
            //             child: Center(
            //               child: KText(
            //                 text: 'Accepted',
            //                 color: hexToColor('#FFA133'),
            //                 fontSize: 13,
            //                 bold: true,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
