import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/calendar_component%20.dart';

import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../helpers/hex_color.dart';
import '../helpers/render_svg.dart';

class ListViewTaskPage extends StatelessWidget with Base {
  final String? activitie = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.grey.shade300),
              ),
            ),
            height: 53,
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(
                //   'images/chat/icon_back.svg',
                //   height: 30.0,
                //   width: 30.0,
                //   allowDrawingOutsideViewBox: true,

                //   //color: Color(0xff007BEC),
                // ),

                RenderSvg(
                  path: 'icon_back',
                  height: 30.0,
                  width: 30.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: 'August',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    KText(
                      text: '2022',
                      fontSize: 12,
                      color: hexToColor('#80939D'),
                      bold: true,
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
                  path: 'icon_forward',
                  height: 30.0,
                  width: 30.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Radio(
                      visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      value: 'activities',
                      groupValue: activitie,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 70,
                    child: KText(
                      text: 'Activities',
                      fontSize: 14,
                      bold: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  SizedBox(
                    width: 15,
                    child: Radio(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => hexToColor('#80939D')),
                      visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 70,
                    child: KText(
                      text: 'Tasks',
                      fontSize: 14,
                      bold: true,
                    ),
                  ),
                  Spacer(),

                  // SvgPicture.asset(
                  //   '${Constants.svgPath}/icon_list_view.svg',
                  //   height: 20.0,
                  //   width: 20.0,
                  //   allowDrawingOutsideViewBox: true,
                  //   color: Color(0xff9BA9B3),
                  // ),
                  RenderSvg(
                    path: 'icon_list_view',
                    height: 20.0,
                    width: 20.0,
                    color: hexToColor('#9BA9B3'),
                    //allowDrawingOutsideViewBox: true,
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  // SvgPicture.asset(
                  //   'images/Dashboard_icons/icon_calendar_view.svg',
                  //   height: 16.0,
                  //   width: 18.0,
                  //   allowDrawingOutsideViewBox: true,
                  // ),
                  // SvgPicture.asset(
                  //   '${Constants.svgPath}/icon_calendar_view.svg',
                  //   height: 16.0,
                  //   width: 18.0,
                  //   allowDrawingOutsideViewBox: true,
                  // ),

                  RenderSvg(
                    path: 'icon_calendar_view',
                    height: 16.0,
                    width: 18.0,
                    //allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
            ),
          ),
          CalendarComponent(),
        ],
      ),
    );
  }
}
