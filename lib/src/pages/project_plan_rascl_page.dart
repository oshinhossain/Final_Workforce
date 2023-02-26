import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/render_img.dart';
import '../helpers/route.dart';

class ProjectPlanRasclPage extends StatefulWidget {
  @override
  State<ProjectPlanRasclPage> createState() => _ProjectPlanRasclPageState();
}

class _ProjectPlanRasclPageState extends State<ProjectPlanRasclPage> with Base {
  @override
  void initState() {
    createTrasnportOrderC.getProjectName();
    super.initState();
  }

  @override
  void dispose() {
    createTrasnportOrderC.resetData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: Get.width,
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: RenderSvg(
                        path: 'icon_back',
                        width: 13.0,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    KText(
                      text: 'Project Plan with RASCI',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: hexToColor('#CFD7DD'),
                border: Border.all(color: AppTheme.nBorderC1),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: hexToColor('#EEF0F6'),
                  )
                ],
              ),
              height: 50,
              width: Get.width,
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                KText(text: 'Project:'),
                SizedBox(
                  width: 8,
                ),
                KText(
                  text: 'BTCL Haor-Baor Project',
                  bold: true,
                  fontSize: 14,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: RenderSvg(
                    path: 'icon_search_elements',
                    height: 30,
                    width: 30,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 8),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 18, top: 18, left: 12, right: 12),
                        // padding: EdgeInsets.all(12),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12, top: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Row(
                                      children: [
                                        KText(
                                          text: 'Pole Supply',
                                          fontSize: 14,
                                          maxLines: 2,
                                          color: hexToColor('#515D64'),
                                        ),
                                        RenderSvg(
                                          path: 'icon_forward',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        KText(
                                          text: 'Pole Construction',
                                          fontSize: 14,
                                          maxLines: 2,
                                          color: hexToColor('#515D64'),
                                        ),
                                        RenderSvg(
                                          path: 'icon_forward',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        KText(
                                          textOverflow: TextOverflow.visible,
                                          text: 'Pole ',
                                          fontSize: 14,
                                          maxLines: 2,
                                          color: hexToColor('#515D64'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Row(
                                children: [
                                  RenderImg(
                                    path: 'icon_avatar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: 'Rafiq Ahmed',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    padding: EdgeInsets.all(6),
                                    child: Center(
                                      child: KText(
                                        text: 'Responsible',
                                        color: hexToColor('#F9F9F9'),
                                        fontSize: 12,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: hexToColor('#F9B667'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'who is responsible for carrying out the entrusted task',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Row(
                                children: [
                                  RenderImg(
                                    path: 'icon_avatar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: 'Ashraful Jubayer',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    padding: EdgeInsets.all(6),
                                    child: Center(
                                      child: KText(
                                        text: 'Responsible',
                                        color: hexToColor('#F9F9F9'),
                                        fontSize: 12,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: hexToColor('#75B7F3'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Approver or responsible for the whole task and who is responsible for what has been done?',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Row(
                                children: [
                                  RenderImg(
                                    path: 'icon_avatar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: 'Nusrat Jahan',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    padding: EdgeInsets.all(6),
                                    child: Center(
                                      child: KText(
                                        text: 'Support',
                                        color: hexToColor('#F9F9F9'),
                                        fontSize: 12,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: hexToColor('#FF9191'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'who support during the implementation of the activity / process / service',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Row(
                                children: [
                                  RenderImg(
                                    path: 'icon_avatar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: 'Imam Hasan',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return PlanningBoardDialog();
                                          });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      padding: EdgeInsets.all(6),
                                      child: Center(
                                        child: KText(
                                          text: 'Consulted',
                                          color: hexToColor('#F9F9F9'),
                                          fontSize: 12,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: hexToColor('#49CDAB'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'who can provide valuable advice or consultation for the task',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Row(
                                children: [
                                  RenderImg(
                                    path: 'icon_avatar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  KText(
                                    text: 'Jobayerul Hasan',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    padding: EdgeInsets.all(6),
                                    child: Center(
                                      child: KText(
                                        text: 'Informed',
                                        color: hexToColor('#F9F9F9'),
                                        fontSize: 12,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: hexToColor('#8BB2D6'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'who should be informed about the task progress or the decisions in the task',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanningBoardDialog extends StatelessWidget with Base {
  // final title;
  // PlanningBoardDialog(this.title);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    textOverflow: TextOverflow.visible,
                    text: 'pole Supply>PoleConstruction>Pole',
                    bold: true,
                    fontSize: 13,
                    maxLines: 3,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    textOverflow: TextOverflow.visible,
                    text: 'Guidance needed for pole delivery by truck from Jessore to Tangail ',
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
                                borderRadius: BorderRadius.all(Radius.circular(9)),
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
                                borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: hexToColor('#00D8A0')),
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
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: hexToColor('#FF3C3C')),
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
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                            textOverflow: TextOverflow.visible,
                            text: 'Imam Hasan',
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
                  GestureDetector(
                    onDoubleTap: (() {
                      back();
                    }),
                    child: Center(
                      child: Container(
                        height: 34,
                        width: 116,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: hexToColor('#9BA9B3')),
                        child: Center(
                          child: KText(
                            text: 'Close',
                            fontSize: 16,
                            color: Colors.white,
                            bold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
