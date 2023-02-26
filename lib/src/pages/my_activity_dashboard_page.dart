import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../helpers/hex_color.dart';
import '../helpers/loading.dart';
import '../widgets/title_bar.dart';
import 'my_acivity_dashboard_create_task_page.dart';
import 'my_activity_dashboard_create_activity_page.dart';

class MyActivityDashBoardPage extends StatefulWidget with Base {
  @override
  State<MyActivityDashBoardPage> createState() =>
      _MyActivityDashBoardPageState();
}

class _MyActivityDashBoardPageState extends State<MyActivityDashBoardPage>
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
    myActivityDashboardC.getMyActivitydashboard();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
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
                      labelColor: AppTheme.nTabTextUC,
                      unselectedLabelColor: AppTheme.black,
                      tabs: [
                        Tab(
                          text: 'Assigned to Me',
                        ),
                        Tab(
                          text: 'Assigned by Me',
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
              AssignToMe(),
              assignedByMe(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget assignedByMe() {
    return Stack(
      children: [
        SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 120,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: AppTheme.nColor3),
                  //  color: AppTheme.nColor3,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      width: double.infinity,
                      // color: hexToColor('#FFE9CF'),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: hexToColor('#FFE9CF'),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Icon(EvaIcons.arrowIosDownwardOutline),
                              SizedBox(
                                width: 7,
                              ),
                              KText(text: 'BTCL Haor-Ba...'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(text: 'OFC'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(
                                text: ' OFC Supply ',
                                bold: true,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Spacer(),
                              // InkWell(
                              //     onTap: () {
                              //       showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return createActivityAlartDialog();
                              //         },
                              //       );
                              //     },
                              //     child: RenderSvg(path: 'icon_add_box')),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Delivery Date',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              KText(
                                text: '06 Sep 2022',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppTheme.nBorderC1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Assign to',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              Row(
                                children: [
                                  KText(
                                      text: 'Tanvir Ahmed ',
                                      color: AppTheme.nTextC,
                                      fontSize: 14),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: RenderImg(
                                        path: 'man-1.png',
                                        height: 32,
                                        width: 32,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 300,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: AppTheme.nColor3),
                  //  color: AppTheme.nColor3,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      width: double.infinity,
                      // color: hexToColor('#FFE9CF'),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: hexToColor('#FFE9CF'),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Icon(EvaIcons.arrowIosDownwardOutline),
                              SizedBox(
                                width: 7,
                              ),
                              KText(text: 'BTCL Haor-Ba...'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(text: 'OFC'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(
                                text: ' OFC Supply ',
                                bold: true,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Delivery Date',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              KText(
                                text: '06 Sep 2022',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppTheme.nBorderC1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Output Quantity',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              KText(
                                text: 'Unit of Measure',
                                color: AppTheme.nTextLightC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: '1 ',
                                    color: AppTheme.nTextC,
                                    fontSize: 14,
                                  ),
                                  Container(
                                      height: 1,
                                      width: 100,
                                      color: AppTheme.nBorderC1,
                                      child: Divider(
                                        thickness: .5,
                                        color: AppTheme.nBorderC1,
                                      )),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  KText(
                                    text: 'Work',
                                    color: AppTheme.nTextC,
                                    fontSize: 14,
                                  ),
                                  Container(
                                      height: 1,
                                      width: 100,
                                      color: AppTheme.nBorderC1,
                                      child: Divider(
                                        thickness: .5,
                                        color: AppTheme.nBorderC1,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          KText(
                              text: 'Description',
                              color: AppTheme.nTextLightC,
                              fontSize: 14),
                          SizedBox(
                            height: 10,
                          ),
                          KText(
                              text:
                                  'Duis aute irure dolor in reprehenderit in\nvoluptate velit esse cillum dolore eu fugiat.',
                              color: AppTheme.nTextC,
                              fontSize: 14),
                          Divider(
                            thickness: 1,
                            color: AppTheme.nBorderC1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Assign to',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              Row(
                                children: [
                                  KText(
                                      text: 'Tanvir Ahmed ',
                                      color: AppTheme.nTextC,
                                      fontSize: 14),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: RenderImg(
                                        path: 'man-1.png',
                                        height: 32,
                                        width: 32,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 120,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1, color: AppTheme.nColor3),
                  //  color: AppTheme.nColor3,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      width: double.infinity,
                      // color: hexToColor('#FFE9CF'),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: hexToColor('#FFE9CF'),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Icon(EvaIcons.arrowIosDownwardOutline),
                              SizedBox(
                                width: 7,
                              ),
                              KText(text: 'BTCL Haor-Ba...'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(text: 'OFC'),
                              SizedBox(
                                width: 5,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              KText(
                                text: ' OFC Supply ',
                                bold: true,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Delivery Date',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              KText(
                                text: '06 Sep 2022',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppTheme.nBorderC1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                  text: 'Assign to',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              Row(
                                children: [
                                  KText(
                                      text: 'Tanvir Ahmed ',
                                      color: AppTheme.nTextC,
                                      fontSize: 14),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: RenderImg(
                                        path: 'man-1.png',
                                        height: 32,
                                        width: 32,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
        Positioned(
          bottom: 10,
          right: 18,
          child: FloatingActionButton(
            onPressed: () {
              push(MyActivityDashboardCreatActivityPage());
            },
            // ignore: sort_child_properties_last
            child: Icon(Icons.add),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: hexToColor('#FFFFFF'))),
          ),
        ),
      ],
    );
  }
}

class AssignToMe extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Obx(
            () => Container(
              // height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(width: 1, color: AppTheme.nColor3),
                //  color: AppTheme.nColor3,
              ),
              child: Column(
                children: [
                  Container(
                    height: 34,
                    width: double.infinity,
                    // color: hexToColor('#FFE9CF'),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: hexToColor('#FFE9CF'),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    myActivityDashboardC.isExpanded.toggle();
                                  },
                                  child: myActivityDashboardC.isExpanded.value
                                      ? Icon(EvaIcons.arrowIosUpwardOutline)
                                      : Icon(EvaIcons.arrowIosDownwardOutline),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                KText(text: 'BTCL Haor-Ba...'),
                                SizedBox(
                                  width: 5,
                                ),
                                RenderSvg(
                                  path: 'icon_forward',
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                KText(text: 'Pole'),
                                SizedBox(
                                  width: 5,
                                ),
                                RenderSvg(
                                  path: 'icon_forward',
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Pole Construction',
                                  bold: true,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    push(MyActivityDashboardCreatTaskPage());
                                  },
                                  child: RenderSvg(path: 'icon_add_box')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  myActivityDashboardC.isExpanded.value
                      ? myActivityDashboardC.myActivityDashboardModel.isEmpty
                          ? Center(
                              child: Loading(),
                            )
                          : ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: myActivityDashboardC
                                  .myActivityDashboardModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = myActivityDashboardC
                                    .myActivityDashboardModel[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(
                                        10,
                                      ),
                                      child: Container(
                                        width: Get.width,
                                        // height: 320,
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          border: Border.all(
                                              color: AppTheme.nBorderC1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              color: Colors.black12,
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      color: AppTheme.nColor4,
                                                    ),
                                                    height: 30,
                                                    width: 100,
                                                    child: Center(
                                                      child: KText(
                                                        text:
                                                            '${item!.supportType}',
                                                        fontSize: 14,
                                                        //  bold: true,
                                                        color: AppTheme.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  KText(
                                                      text: 'ID ',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                      fontSize: 14),
                                                  Flexible(
                                                    child: KText(
                                                        text: '${item.id}',
                                                        color: AppTheme.nTextC,
                                                        bold: true,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              KText(
                                                text: '${item.supportName}',
                                                fontSize: 18,
                                                color: AppTheme.nTextC,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text: 'Output Quantity',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                      fontSize: 14),
                                                  Spacer(),
                                                  KText(
                                                    text: 'Unit of Measure',
                                                    color: AppTheme.nTextLightC,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      KText(
                                                        text:
                                                            '${item.outputTarget}',
                                                        color: AppTheme.nTextC,
                                                        fontSize: 14,
                                                      ),
                                                      Container(
                                                          height: 1,
                                                          width: 100,
                                                          color: AppTheme
                                                              .nBorderC1,
                                                          child: Divider(
                                                            thickness: .5,
                                                            color: AppTheme
                                                                .nBorderC1,
                                                          )),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      KText(
                                                        text:
                                                            '${item.supportDescr}',
                                                        color: AppTheme.nTextC,
                                                        fontSize: 14,
                                                      ),
                                                      Container(
                                                          height: 1,
                                                          width: 100,
                                                          color: AppTheme
                                                              .nBorderC1,
                                                          child: Divider(
                                                            thickness: .5,
                                                            color: AppTheme
                                                                .nBorderC1,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              KText(
                                                  text: 'Description',
                                                  color: AppTheme.nTextLightC,
                                                  fontSize: 14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              KText(
                                                  text: '${item.outputDescr}',
                                                  color: AppTheme.nTextC,
                                                  fontSize: 14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Divider(
                                                thickness: .5,
                                                color: AppTheme.nBorderC1,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text: 'Delivery Date',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                      fontSize: 14),
                                                  Spacer(),
                                                  KText(
                                                    text: 'Assigned to',
                                                    color: AppTheme.nTextLightC,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text:
                                                          '${item.scheduledEndDate}',
                                                      color: AppTheme.nTextC,
                                                      fontSize: 14),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text:
                                                              '${item.ownerFullname}',
                                                          color:
                                                              AppTheme.nTextC,
                                                          fontSize: 14),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              KText(
                                  text: 'Delivery Date',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14),
                              Spacer(),
                              KText(
                                text: '06 Sep 2022',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
