import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../helpers/hex_color.dart';
import '../models/calendarModel.dart';

class CalendarComponent extends StatelessWidget with Base {
  final calendars = [
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      0,
      4,
      9,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      5,
      7,
      1,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      8,
      5,
      9,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      3,
      1,
      5,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      8,
      2,
      5,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      3,
      1,
      5,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
    Calendar(
      'Task Name One',
      '02 Aug 2022 -',
      '09 Aug 2022',
      3,
      1,
      5,
      [
        'images/bill.jpeg',
        'images/stevejobs.jpeg',
        'images/bill.jpeg',
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: calendars.length,
      itemBuilder: (BuildContext context, int index) {
        final item = calendars[index];
        return Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 3,
          ),
          width: Get.width,
          height: 107,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color.fromARGB(255, 230, 230, 233),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: 13,
                  height: 103,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: hexToColor('#00C290'),
                  ),
                ),
              ),
              Expanded(
                flex: 90,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: '${item.title}',
                        fontSize: 16,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                              '${Constants.svgPath}/icon_card_calendar.svg',
                              height: 16.0,
                              width: 18.0,
                              allowDrawingOutsideViewBox: true,
                              color: hexToColor('#9BA9B3')),
                          SizedBox(
                            width: 6,
                          ),
                          KText(
                            text: '${item.startTimer} ${item.endTimer}',
                            fontSize: 13,
                            color: hexToColor('#515D64'),
                          ),
                        ],
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
                            color: hexToColor('#9BA9B3'),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          KText(
                            text: '${item.comments}',
                            fontSize: 16,
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
                            text: '${item.attachments}',
                            fontSize: 16,
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
                            text: '${item.flag}',
                            fontSize: 16,
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
                                  color: hexToColor('#F5F5FA'),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 230, 230, 233),
                                    style: BorderStyle.solid,
                                    width: 0.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: hexToColor('#F5F5FA')
                                          .withOpacity(0.6),

                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: 29,
                                  width: 29,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        '${Constants.imgPath}/bill.jpeg',
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
                                    color: hexToColor('#F5F5FA'),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 230, 230, 233),
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
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(1.5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          '${Constants.imgPath}/bill.jpeg',
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

                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 230, 230, 233),
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
                                      color: hexToColor('#EEF0F6'),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                        child: KText(
                                      text: '+25',
                                      color: Colors.red,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 35,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
