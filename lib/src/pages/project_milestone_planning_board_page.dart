import 'package:get/get.dart';
import 'package:workforce/src/pages/project_planning_creat_milestone_page.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class ProjectMilestonePlanningBoardPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppbar(),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      backgroundColor: hexToColor('#EEF0F6'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              height: 55,
              width: Get.width,
              // margin: EdgeInsets.symmetric(vertical: .5),

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
                  SizedBox(
                    width: 8,
                  ),
                  KText(
                    text: 'Project Milestone Planning Board',
                    fontSize: 16,
                    color: hexToColor('#41525A'),
                    bold: true,
                  ),
                  Spacer(),
                  Container(
                    height: 30,
                    width: 30,

                    //  padding: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: hexToColor('#FFF4E8'),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(width: 1, color: hexToColor('#FFA133'))),
                    child: Center(
                      child: KText(
                        text: '03',
                        bold: true,
                        color: hexToColor('#FFA133'),
                      ),
                    ),
                  ),
                  SizedBox()
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  // final item1 = projectPlanningBoardC.projectCountGet(
                  //     projectPlanningBoardC
                  //         .projectPlanningBoard[index]!.id!);

                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Container(
                        width: 360,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          border: Border.all(color: AppTheme.nBorderC1),
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
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Milestone ID',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  Icon(Icons.more_vert_outlined)
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Milestone ID',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  KText(
                                    text: '01',
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Weight Percentage',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  KText(
                                    text: '20',
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Deadline',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  KText(
                                    text: '06 Sep 2022',
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Description',
                                    fontSize: 13,
                                    bold: true,
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text:
                                        'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
                                    fontSize: 13,
                                    maxLines: 2,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(ProjectPlanningCreatMilestonePage());
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
