import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../helpers/hex_color.dart';
import '../helpers/render_svg.dart';
import 'chart_component.dart';
import 'k_appbar.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MapDialog extends StatefulWidget {
  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  final partnerAgency = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: SizedBox(
        height: 200,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: KText(text: 'Show Dialog'),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.tealAccent,
                textStyle: TextStyle(
                  fontSize: 18,
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: Size(120, 50),
              ),
              onPressed: () {
                Get.defaultDialog(
                    contentPadding: EdgeInsets.zero,
                    title: 'District-1 / Upazila-1 / Union-1',
                    titleStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    content: SizedBox(
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: hexToColor('#BBDAEA'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SvgPicture.asset(
                                  //   'images/chat/icon_back.svg',
                                  //   height: 30.0,
                                  //   width: 30.0,
                                  //   allowDrawingOutsideViewBox: true,

                                  //   //color: Color(0xff007BEC),
                                  // ),

                                  RenderSvg(
                                    path: 'button_add',
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          KText(
                                            text: 'All Time',
                                            fontSize: 13,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          RenderSvg(
                                            path: 'Variant8',
                                            height: 13.0,
                                            width: 13.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // SvgPicture.asset(
                                  //   'images/chat/icon_forward.svg',
                                  //   height: 30.0,
                                  //   width: 30.0,
                                  //   allowDrawingOutsideViewBox: true,

                                  //   //color: Color(0xff007BEC),
                                  // ),

                                  RenderSvg(
                                    path: 'button_explore',
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                height: 200,
                                width: 200,
                                child: ChartComponent(),
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      color: hexToColor('#007BEC'),
                                      padding: EdgeInsets.all(4),
                                      // foregroundDecoration: BoxDecoration(
                                      //   color: hexToColor('#007BEC'),
                                      //   borderRadius: BorderRadius.all(
                                      //     Radius.circular(8),
                                      //   ),
                                      // ),
                                      child: KText(
                                        text: '100%',
                                        bold: true,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  KText(
                                    text: 'In Progress ',
                                    fontSize: 12,
                                    color: AppTheme.textColor,
                                  ),
                                  KText(
                                    text: '340',
                                    fontSize: 14,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      color: hexToColor('#FF3C3C'),
                                      padding: EdgeInsets.all(4),
                                      // foregroundDecoration: BoxDecoration(
                                      //   color: hexToColor('#007BEC'),
                                      //   borderRadius: BorderRadius.all(
                                      //     Radius.circular(8),
                                      //   ),
                                      // ),
                                      child: KText(
                                        text: '10%',
                                        bold: true,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  KText(
                                    text: 'In Danger ',
                                    fontSize: 12,
                                    color: AppTheme.textColor,
                                  ),
                                  KText(
                                    text: '340',
                                    fontSize: 13,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      color: hexToColor('#00D8A0'),
                                      padding: EdgeInsets.all(4),
                                      // foregroundDecoration: BoxDecoration(
                                      //   color: hexToColor('#007BEC'),
                                      //   borderRadius: BorderRadius.all(
                                      //     Radius.circular(8),
                                      //   ),
                                      // ),
                                      child: KText(
                                        text: '100%',
                                        bold: true,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  KText(
                                    text: 'In Progress ',
                                    fontSize: 12,
                                    color: AppTheme.textColor,
                                  ),
                                  KText(
                                    text: '340',
                                    fontSize: 14,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      color: hexToColor('#FFA133'),
                                      padding: EdgeInsets.all(4),
                                      // foregroundDecoration: BoxDecoration(
                                      //   color: hexToColor('#007BEC'),
                                      //   borderRadius: BorderRadius.all(
                                      //     Radius.circular(8),
                                      //   ),
                                      // ),
                                      child: KText(
                                        text: '10%',
                                        bold: true,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  KText(
                                    text: 'In Danger ',
                                    fontSize: 12,
                                    color: AppTheme.textColor,
                                  ),
                                  KText(
                                    text: '340',
                                    fontSize: 13,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Partner Agency',
                                    fontSize: 15,
                                    bold: true,
                                    color: AppTheme.textColor,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                height: 100,
                                width: Get.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 250,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 230, 230, 233),
                                              style: BorderStyle.solid,
                                              width: 2,
                                            ),
                                          ),
                                          child: Card(
                                            margin: EdgeInsets.only(right: 12),
                                            shadowColor: Colors.black,
                                            elevation: .3,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // SizedBox(
                                                  //   height: 120,
                                                  // ),

                                                  Row(
                                                    children: [
                                                      ClipOval(
                                                        child:
                                                            SizedBox.fromSize(
                                                          size: Size.fromRadius(
                                                              30),
                                                          // Image radius
                                                          child: Image.asset(
                                                            '${Constants.imgPath}/placeholder.jpg',
                                                            fit: BoxFit.cover,
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            KText(
                                                              bold: true,
                                                              text:
                                                                  'Bangladesh Machine ',
                                                              fontSize: 16,
                                                            ),
                                                            KText(
                                                              bold: true,
                                                              text:
                                                                  'Tools Factory (BMTF)',
                                                              fontSize: 16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // // SmoothPageIndicator(
                              // //   controller: partnerAgency,
                              // //   count: 3,
                              // //   effect: WormEffect(
                              // //     activeDotColor: hexToColor('#FFA133'),
                              // //     dotHeight: 10,
                              // //     dotColor: hexToColor('#BAC2CE'),
                              // //     dotWidth: 10,
                              // //   ),
                              // // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: hexToColor('#FFA133')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: hexToColor('#DED6D6')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: hexToColor('#DED6D6')),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Divider(
                                height: 1,
                                color: hexToColor('#BAC2CE'),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    '${Constants.svgPath}/icon_card_messages.svg',
                                    height: 16.0,
                                    width: 18.0,
                                    allowDrawingOutsideViewBox: true,
                                    color: Color(0xff9BA9B3),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  KText(
                                    text: '4',
                                    fontSize: 17,
                                    color: hexToColor('#515D64'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    '${Constants.svgPath}/icon_chat_attach.svg',
                                    height: 16.0,
                                    width: 18.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  KText(
                                    text: '2',
                                    fontSize: 17,
                                    color: hexToColor('#515D64'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    '${Constants.svgPath}/icon_card_escalation.svg',
                                    height: 16.0,
                                    width: 18.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  KText(
                                    text: '2',
                                    fontSize: 17,
                                    color: hexToColor('#515D64'),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    '${Constants.svgPath}/icon_add_user.svg',
                                    height: 30.0,
                                    width: 30.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 33,
                                        width: 33,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF5F5FA),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 230, 230, 233),
                                            style: BorderStyle.solid,
                                            width: 0.2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffF5F5FA)
                                                  .withOpacity(0.6),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          height: 29,
                                          width: 29,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(
                                                '${Constants.imgPath}/bill.jpg',
                                                width: 29,
                                                height: 29,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 15,
                                        top: 0,
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF5F5FA),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 230, 230, 233),
                                              style: BorderStyle.solid,
                                              width: 0.2,
                                            ),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Color(0xffF5F5FA).withOpacity(0.6),
                                            //     spreadRadius: 5,
                                            //     blurRadius: 7,
                                            //     offset: Offset(
                                            //         0, 3), // changes position of shadow
                                            //   ),
                                            // ],
                                          ),
                                          child: Container(
                                            height: 29,
                                            width: 29,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(1.5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.asset(
                                                  '${Constants.imgPath}/bill.jpg',
                                                  width: 29,
                                                  height: 29,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 32,
                                        top: 0,
                                        child: Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: hexToColor('#F5F5FA'),

                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 230, 230, 233),
                                              style: BorderStyle.solid,
                                              width: 0.2,
                                            ),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Color(0xffF5F5FA).withOpacity(0.6),
                                            //     spreadRadius: 5,
                                            //     blurRadius: 7,
                                            //     offset: Offset(
                                            //         0, 3), // changes position of shadow
                                            //   ),
                                            // ],
                                          ),
                                          child: Container(
                                            height: 29,
                                            width: 29,
                                            decoration: BoxDecoration(
                                              color: Color(0xffEEF0F6),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Center(
                                              child: KText(
                                                text: '+25',
                                                fontSize: 12,
                                                color: hexToColor('#FF3C3C'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 35,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    middleTextStyle: TextStyle(color: Colors.black),
                    radius: 5);
              },
            ),
          ],
        ),
      ),
    );
  }
}
