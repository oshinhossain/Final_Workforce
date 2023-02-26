import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/pages/create_risk_page.dart';

import '../helpers/hex_color.dart';
import '../helpers/route.dart';

class AssessProjectRiskPage extends StatefulWidget {
  @override
  State<AssessProjectRiskPage> createState() => _AssessProjectRiskPageState();
}

class _AssessProjectRiskPageState extends State<AssessProjectRiskPage>
    with Base {
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
                    text: 'Assess Project Risks',
                    fontSize: 16,
                    color: hexToColor('#41525A'),
                    bold: true,
                  ),
                  SizedBox()
                ],
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // Get.offAll(MainPage());
                          },
                          child: RenderSvg(path: 'icon_complaints')),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Risks',
                        fontSize: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 18, top: 18, left: 12, right: 12),
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
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: KText(
                                          bold: true,
                                          text: '101',
                                          color: hexToColor('#41525A'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: KText(
                                              textOverflow:
                                                  TextOverflow.visible,
                                              fontSize: 16,
                                              text:
                                                  'Pole Damage During Transportation')),
                                      Spacer(),
                                      Icon(Icons.more_vert_outlined),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Task',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Scope Bucket ',
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
                                            text: 'Activity 1 ',
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
                                            text: 'Activity 1',
                                            fontSize: 14,
                                            maxLines: 2,
                                            color: hexToColor('#515D64'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Risk Description',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text:
                                            'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
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
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Row(
                                    children: [
                                      KText(
                                        text: 'Impact',
                                        color: hexToColor('#80939D'),
                                      ),
                                      Spacer(),
                                      KText(
                                        text: 'High',
                                        color: hexToColor('#515D64'),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Row(
                                    children: [
                                      KText(
                                        text: 'Likelihood',
                                        color: hexToColor('#80939D'),
                                      ),
                                      Spacer(),
                                      KText(
                                        text: 'Medium',
                                        color: hexToColor('#515D64'),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Mitigation Plan',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text:
                                            'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
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
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Mitigation Date',
                                            color: hexToColor('#80939D'),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              KText(text: '06 Sep 2022'),
                                              SizedBox(
                                                width: 12,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 30,
                              top: 4,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: KText(
                                  text: 'Pending',
                                  color: hexToColor('#007BEC'),
                                  fontSize: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: hexToColor('#DBECFB'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(CreateRiskPage());
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
