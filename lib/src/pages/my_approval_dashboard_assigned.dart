import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';

import '../components/k_appbar.dart';
import '../config/app_theme.dart';

import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../widgets/title_bar.dart';

class MyApprovalDashboard extends StatefulWidget with Base {
  @override
  State<MyApprovalDashboard> createState() => _MyApprovalDashboard();
}

class _MyApprovalDashboard extends State<MyApprovalDashboard>
    with SingleTickerProviderStateMixin, Base {
  TextEditingController nameController = TextEditingController();

  TabController? _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBar(title: 'My Activity Dashboard'),
          Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(5)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: AppTheme.appbarColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Container(
                    // width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: .0001,
                            blurRadius: 1,
                          )
                        ],
                        color: AppTheme.appbarColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: TabBar(
                      physics: BouncingScrollPhysics(),
                      controller: _tabController,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))),
                      labelColor: AppTheme.color4,
                      unselectedLabelColor: AppTheme.black,
                      tabs: [
                        Tab(
                          text: 'Approval Requests',
                        ),
                        Tab(
                          text: 'My Requests',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ApprovalRequests(),
              MyRequests(),
            ]),
          ),
        ],
      ),
    );
  }
}

class ApprovalRequests extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                RenderSvg(path: 'trucklogo'),
                // SvgPicture.asset('${Constants.svgPath}/icon_bill.svg'),
                SizedBox(
                  width: 5,
                ),

                KText(
                  text: 'TO Approval Requests',
                  bold: false,
                  fontSize: 14,
                  color: hexToColor('#41525A'),
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: hexToColor('#FFECD6'),
                  ),
                  child: Center(
                    child: KText(
                      text: '03',
                      color: hexToColor('#FFA133'),
                      bold: true,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DottedLine(
              lineThickness: 0.1,
              dashColor: Colors.black,
            ),
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 200,
                  margin: EdgeInsets.only(top: 12),
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border:
                          Border.all(color: hexToColor('#DBECFB'), width: 1)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'Transport Order ',
                                  bold: true,
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),

                                KText(
                                  text: 'S2SD83SD8 ',
                                  bold: true,
                                  fontSize: 13,
                                  color: hexToColor('#515D64'),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                // Icon(
                                //   uiC.isExpanded.value
                                //       ? EvaIcons.arrowIosUpwardOutline
                                //       : EvaIcons.arrowIosDownwardOutline,
                                //   color: hexToColor('#80939D'),
                                // ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: KText(
                                    text: 'Date ',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ),

                                KText(
                                  text: '01 Sep 2022',
                                  bold: true,
                                  fontSize: 13,
                                  color: hexToColor('#515D64'),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                // Icon(
                                //   uiC.isExpanded.value
                                //       ? EvaIcons.arrowIosUpwardOutline
                                //       : EvaIcons.arrowIosDownwardOutline,
                                //   color: hexToColor('#80939D'),
                                // ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 50, top: 10),
                                ),
                                Icon(
                                  uiC.isExpanded.value
                                      ? EvaIcons.arrowIosUpwardOutline
                                      : EvaIcons.arrowIosDownwardOutline,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: hexToColor('#DBECFB'),
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Row(
                          children: [
                            KText(
                              text: 'Transport Order ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            Spacer(),
                            KText(
                              text: 'Arif Hossain ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            Container(
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
                          ],
                        ),
                      ),
                      Divider(
                        color: hexToColor('#DBECFB'),
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 34,
                              width: 116,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: hexToColor('#FF9191')),
                              child: Center(
                                child: KText(
                                  text: 'Reject',
                                  fontSize: 16,
                                  color: Colors.white,
                                  bold: true,
                                ),
                              ),
                            ),
                            Container(
                              height: 34,
                              width: 116,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: hexToColor('#49CDAB')),
                              child: Center(
                                child: KText(
                                  text: 'Approve',
                                  fontSize: 16,
                                  color: Colors.white,
                                  bold: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                RenderSvg(path: 'trucklogo'),
                // SvgPicture.asset('${Constants.svgPath}/icon_bill.svg'),
                SizedBox(
                  width: 5,
                ),

                KText(
                  text: 'Test Approval Requests',
                  bold: false,
                  fontSize: 14,
                  color: hexToColor('#41525A'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DottedLine(
              lineThickness: 0.1,
              dashColor: Colors.black,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 12),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: hexToColor('#DBECFB'), width: 1)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Transport Order ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),

                            KText(
                              text: 'S2SD83SD8 ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#515D64'),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            // Icon(
                            //   uiC.isExpanded.value
                            //       ? EvaIcons.arrowIosUpwardOutline
                            //       : EvaIcons.arrowIosDownwardOutline,
                            //   color: hexToColor('#80939D'),
                            // ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: KText(
                                text: 'Date ',
                                bold: true,
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                            ),

                            KText(
                              text: '01 Sep 2022',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#515D64'),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            // Icon(
                            //   uiC.isExpanded.value
                            //       ? EvaIcons.arrowIosUpwardOutline
                            //       : EvaIcons.arrowIosDownwardOutline,
                            //   color: hexToColor('#80939D'),
                            // ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50, top: 10),
                            ),
                            Icon(
                              uiC.isExpanded.value
                                  ? EvaIcons.arrowIosUpwardOutline
                                  : EvaIcons.arrowIosDownwardOutline,
                              color: hexToColor('#80939D'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: hexToColor('#DBECFB'),
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      children: [
                        KText(
                          text: 'Assigned to ',
                          bold: true,
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Spacer(),
                        KText(
                          text: 'Arafat Kabir',
                          bold: true,
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                  Divider(
                    color: hexToColor('#DBECFB'),
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 34,
                          width: 116,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: hexToColor('#FF9191')),
                          child: Center(
                            child: KText(
                              text: 'Reject',
                              fontSize: 16,
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                        Container(
                          height: 34,
                          width: 116,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: hexToColor('#49CDAB')),
                          child: Center(
                            child: KText(
                              text: 'Approve',
                              fontSize: 16,
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 12),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: hexToColor('#DBECFB'), width: 1)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Transport Order ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),

                            KText(
                              text: 'S2SD83SD8 ',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#515D64'),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            // Icon(
                            //   uiC.isExpanded.value
                            //       ? EvaIcons.arrowIosUpwardOutline
                            //       : EvaIcons.arrowIosDownwardOutline,
                            //   color: hexToColor('#80939D'),
                            // ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: KText(
                                text: 'Date ',
                                bold: true,
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                            ),

                            KText(
                              text: '01 Sep 2022',
                              bold: true,
                              fontSize: 13,
                              color: hexToColor('#515D64'),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            // Icon(
                            //   uiC.isExpanded.value
                            //       ? EvaIcons.arrowIosUpwardOutline
                            //       : EvaIcons.arrowIosDownwardOutline,
                            //   color: hexToColor('#80939D'),
                            // ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 50, top: 10),
                            ),
                            Icon(
                              uiC.isExpanded.value
                                  ? EvaIcons.arrowIosUpwardOutline
                                  : EvaIcons.arrowIosDownwardOutline,
                              color: hexToColor('#80939D'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: hexToColor('#DBECFB'),
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      children: [
                        KText(
                          text: 'Assigned to ',
                          bold: true,
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Spacer(),
                        KText(
                          text: 'Nusrat Jahan',
                          bold: true,
                          fontSize: 13,
                          color: hexToColor('#80939D'),
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                  Divider(
                    color: hexToColor('#DBECFB'),
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 34,
                          width: 116,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: hexToColor('#FF9191')),
                          child: Center(
                            child: KText(
                              text: 'Reject',
                              fontSize: 16,
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                        Container(
                          height: 34,
                          width: 116,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: hexToColor('#49CDAB')),
                          child: Center(
                            child: KText(
                              text: 'Approve',
                              fontSize: 16,
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
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

class MyRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
