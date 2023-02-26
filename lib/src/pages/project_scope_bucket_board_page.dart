import 'package:flutter/material.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:get/get.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/project_planning_creat_bucket_page.dart';

class ProjectScopeBucketBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: KAppbar(),
        bottom: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: AppBar(
              title: KText(
                text: 'Project Milestone Planning Board',
                bold: true,
                fontSize: 16,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: back,
              ),
              actions: [
                Container(
                  height: 10,
                  width: 30,
                  margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
                  //  padding: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      color: hexToColor('#FFF4E8'),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(width: 1, color: hexToColor('#FFA133'))),
                  child: Center(
                    child: KText(
                      text: '03',
                      color: hexToColor('#FFA133'),
                    ),
                  ),
                )
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 47,
              width: Get.width,
              padding: EdgeInsets.only(left: 15),
              color: hexToColor('#EEF0F6'),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(text: 'Project Name'),
                    KText(
                      text: 'BTCL Haor-Baor Project',
                      fontSize: 14,
                    ),
                  ]),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 15,
                                      child: KText(
                                        text: 'Milestone Name 1',
                                        bold: true,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Icon(Icons.more_vert_outlined))
                                  ],
                                ),
                              ),
                              Divider(
                                color: hexToColor('#515D64'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Milestone ID',
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: '01')
                                  ],
                                ),
                              ),
                              Divider(
                                color: hexToColor('#515D64'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Weight Percentage',
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: '20')
                                  ],
                                ),
                              ),
                              Divider(
                                color: hexToColor('#515D64'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Deadline',
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: '06 Sep 2022')
                                  ],
                                ),
                              ),
                              Divider(
                                color: hexToColor('#515D64'),
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
                              Divider(
                                color: hexToColor('#515D64'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      hexToColor('#C1FFEF'),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        hexToColor('#DDFFF6'),
                                                    radius: 21,
                                                    child: KText(
                                                      text: 'B',
                                                      fontSize: 16,
                                                      bold: true,
                                                      color:
                                                          hexToColor('#09CD9A'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: 30,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        hexToColor('#09CD9A'),
                                                    radius: 10,
                                                    child: KText(
                                                      text: '3',
                                                      fontSize: 14,
                                                      bold: true,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      hexToColor('#FFF8B9'),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        hexToColor('#FFFCE1'),
                                                    radius: 21,
                                                    child: KText(
                                                      text: 'G',
                                                      fontSize: 16,
                                                      bold: true,
                                                      color:
                                                          hexToColor('#E2BE02'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 30,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      hexToColor('#E2BE02'),
                                                  radius: 10,
                                                  child: KText(
                                                    text: '6',
                                                    fontSize: 14,
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      hexToColor('#CFE8FF'),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        hexToColor('#E7F3FF'),
                                                    radius: 21,
                                                    child: KText(
                                                      text: 'A',
                                                      fontSize: 16,
                                                      bold: true,
                                                      color:
                                                          hexToColor('#007BEC'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 30,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      hexToColor('#007BEC'),
                                                  radius: 10,
                                                  child: KText(
                                                    text: '27',
                                                    fontSize: 14,
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      hexToColor('#FFE9CF'),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        hexToColor('#FFF4E8'),
                                                    radius: 21,
                                                    child: KText(
                                                      text: 'T',
                                                      fontSize: 16,
                                                      bold: true,
                                                      color:
                                                          hexToColor('#FFA133'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 30,
                                                child: Container(
                                                  width: 28,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        hexToColor('#FFA133'),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  // backgroundColor: hexToColor('#FFA133'),
                                                  // radius: 10,
                                                  child: KText(
                                                    text: '112',
                                                    fontSize: 14,
                                                    bold: true,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: RenderSvg(
                                        path: 'info',
                                        height: 45,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(ProjectPlanningCreatBucketPage());
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
