import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/global_helper.dart';
import '../helpers/loading.dart';
import '../helpers/render_img.dart';

class ProjectDashboardPage extends StatefulWidget with Base {
  @override
  // ignore: library_private_types_in_public_api
  _ProjectDashboardPageState createState() => _ProjectDashboardPageState();
}

class _ProjectDashboardPageState extends State<ProjectDashboardPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    projectDashbordOperationalC.getProjectDashbordMyTasksSupport();
    projectDashbordOperationalC.getProjectDashbordMaterialsRequisition();
    projectDashbordOperationalC.getProjectDashbordMyProjectList();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController!.index;
        });
      }
    });

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: hexToColor('#9BA9B3'),
              )),
          title: KText(
            text: 'Project Dashboard',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: hexToColor('#EEF0F6'),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                        child: _tabBar,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Icon(Icons.settings),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Operational(),
            Reporting(),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            color: Colors.amber,
            fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: _activeIndex == 0
              ? BorderRadius.only(topLeft: Radius.circular(5.0))
              : _activeIndex == 1
                  ? BorderRadius.only(topRight: Radius.circular(5.0))
                  : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'Operational'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Reporting')),
          // Icon(Icons.settings)
        ],
      );
}

class Operational extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'Subtract'),
                            SizedBox(width: 8),
                            KText(
                              text:
                                  'My Project (${projectDashbordOperationalC.projectDashbordMyProjectList.length})',
                              bold: true,
                              fontSize: 18,
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            //  push(ProjectDashboardCreateProjectPage());
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: hexToColor('#FFA133'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DottedLine(
                      lineThickness: 1,
                      dashColor: hexToColor(
                        '#80939D',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              // margin: EdgeInsets.only(left: 12),
              height: 140,
              child: Obx(() => projectDashbordOperationalC
                      .projectDashbordMyProjectList.isEmpty
                  ? projectDashbordOperationalC.isLoading.value
                      ? SizedBox(
                          height: Get.height / 1.5,
                          child: Center(
                            child: Loading(),
                          ))
                      : SizedBox(
                          height: Get.height / 1.5,
                          child: Center(child: KText(text: 'No data found')),
                        )
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: projectDashbordOperationalC
                          .projectDashbordMyProjectList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = projectDashbordOperationalC
                            .projectDashbordMyProjectList[index];
                        return SizedBox(
                          width: 330,
                          child: Card(
                            margin: EdgeInsets.only(right: 12),
                            shadowColor: Colors.black,
                            elevation: .3,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 120,
                                  // ),

                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipOval(
                                            child: SizedBox.fromSize(
                                              size: Size.fromRadius(26),
                                              // Image radius
                                              child: RenderImg(
                                                path: 'service_icon.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50.0,
                                            width: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      hexToColor('#00D8A0')),
                                              strokeWidth: 5,
                                              value: .75,
                                            ),
                                          )
                                          // CircularProgressIndicator(
                                          //   valueColor: AlwaysStoppedAnimation<Color>(
                                          //       Colors.orange),
                                          //   strokeWidth: 3,
                                          //   value: .75,
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: KText(
                                        bold: true,
                                        text: item!.projectName,
                                        fontSize: 16,
                                      )),
                                      // Container(
                                      //   padding: EdgeInsets.all(4),
                                      //   decoration: BoxDecoration(
                                      //     color: hexToColor('#FF9191'),
                                      //     borderRadius: BorderRadius.circular(8),
                                      //   ),
                                      //   child: KText(
                                      //     text: 'High Priority',
                                      //     bold: true,
                                      //     color: Colors.white,
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 30,
                                      )
                                    ],
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: KText(
                                      text: item.outputProgress.toString(),
                                      fontSize: 14,
                                      bold: true,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // projectDashbordOperationalC
                                          //     .getProjectDashbordMyProjectList();
                                        },
                                        child: SvgPicture.asset(
                                          '${Constants.svgPath}/icon_card_messages.svg',
                                          height: 16.0,
                                          width: 18.0,
                                          allowDrawingOutsideViewBox: true,
                                          color: hexToColor('#9BA9B3'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      KText(
                                        text: '',
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
                                        text: '',
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
                                        text: '',
                                        fontSize: 16,
                                        color: hexToColor('#515D64'),
                                      ),
                                      Spacer(),
                                      RenderSvg(
                                        path: 'icon_add_user',
                                        width: 35,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 35,
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
                                              height: 35,
                                              width: 35,
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
                                                    'assets/img/bill.jpeg',
                                                    height: 35,
                                                    width: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 15,
                                            top: 0,
                                            child: Container(
                                              height: 35,
                                              width: 35,
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
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(1.5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.asset(
                                                      'assets/img/bill.jpeg',
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 30,
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
                                                height: 32,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffEEF0F6),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  '+25',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          RenderSvg(path: 'Subtract'),
                          SizedBox(width: 8),
                          KText(
                            // 'My Project (${projectDashbordOperationalC.projectDashbordMyProjectList.length})',

                            text:
                                'My Activities (${projectDashbordOperationalC.projectDashbordMyActivityList.length})',
                            bold: true,
                            fontSize: 18,
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          //  push(ProjectDashboardCreatActivityPage());
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: hexToColor('#FFA133'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DottedLine(
                    lineThickness: 1,
                    dashColor: hexToColor(
                      '#80939D',
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 10, right: 15, top: 15, bottom: 5),
                height: 240,
                child: MyActivities()),
            MyTask(),
            MaterialsRequisition(),
          ],
        ),
      ),
    );
  }
}

class MyActivities extends StatefulWidget {
  @override
  State<MyActivities> createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  // ignore: unused_field
  final int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {});
      }
    });
//update
    return Column(
      children: [
        PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: Material(
            borderRadius: BorderRadius.circular(5),
            color: hexToColor('#EEF0F6'),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: hexToColor('#EEF0F6'),
                borderRadius: BorderRadius.circular(5),
              ),
              child: _tabBar,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 130,
          child: TabBarView(
            controller: _tabController,
            children: [
              assignedtome(),
              independentactivity(),
            ],
          ),
        ),
      ],
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            color: Colors.amber,
            fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // _activeIndex == 0
          //     ? BorderRadius.only(topLeft: Radius.circular(5.0))
          //     : _activeIndex == 1
          //         ? BorderRadius.only(topRight: Radius.circular(5.0))
          //         : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Tab(text: 'Assigned to Me')),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Tab(text: 'Independent Activity')),
          // Icon(Icons.settings)
        ],
      );

  Widget assignedtome() {
    projectDashbordOperationalC.getProjectDashbordMyActivities();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.zero,
          // padding: EdgeInsets.all(12),
          // margin: EdgeInsets.only(left: 12),
          height: 130,
          width: Get.width,
          // Obx(
          //       () => projectDashbordOperationalC
          //                   .projectdashbordMyProjectCheck.value ==
          //               true
          //           ? Center(
          //               child: Loading(),
          //             )
          //           : projectDashbordOperationalC
          //                   .projectDashbordMyProjectList.isNotEmpty
          //               ? ListView.builder(
          child: Obx(() => projectDashbordOperationalC
                  .projectDashbordMyActivityList.isEmpty
              ? projectDashbordOperationalC.isLoading.value
                  ? SizedBox(
                      height: Get.height / 1.5,
                      child: Center(
                        child: Loading(),
                      ),
                    )
                  : SizedBox(
                      height: Get.height / 1.5,
                      child: Center(child: KText(text: 'No data found')),
                    )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: projectDashbordOperationalC
                      .projectDashbordMyActivityList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = projectDashbordOperationalC
                        .projectDashbordMyActivityList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Container(
                        height: 100,
                        width: 320,
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
                                      Expanded(
                                        flex: 2,
                                        child: KText(
                                            text: item!.projectName != null
                                                ? '${item.projectName}'
                                                : ''),
                                      ),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),
                                      // RenderSvg(
                                      //   path: 'icon_forward',
                                      //   height: 12,
                                      // ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: KText(
                                            text: item.bucketName != null
                                                ? ' > ${item.bucketName} '
                                                : ''),
                                      ),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),
                                      // RenderSvg(
                                      //   path: 'icon_forward',
                                      //   height: 12,
                                      // ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        flex: 6,
                                        child: KText(
                                          text: item.groupName != null
                                              ? ' > ${item.groupName}'
                                              : '',
                                          bold: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                          text: 'Delivery Date',
                                          color: AppTheme.nTextLightC,
                                          fontSize: 14),
                                      Spacer(),
                                      if (item.scheduledEndDate != null)
                                        KText(
                                          text: formatDate(
                                              date: item.scheduledEndDate!),
                                          color: AppTheme.nTextC,
                                          fontSize: 14,
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  DottedLine(dashColor: hexToColor('#80939D')),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      KText(
                                          text: 'Assign to',
                                          color: AppTheme.nTextLightC,
                                          fontSize: 14),
                                      Spacer(),
                                      Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: KText(
                                              text: item.fullname != null
                                                  ? '${item.fullname} '
                                                  : '',
                                              color: AppTheme.nTextC,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
        ),
      ],
    );

    //
  }

  Widget independentactivity() {
    return SizedBox(
      height: 120,
      child: Text(''),
    );
  }
}

class MyTask extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  RenderSvg(path: 'Subtract'),
                  SizedBox(width: 8),
                  KText(
                    text:
                        'My Tasks (${projectDashbordOperationalC.projectDashbordMyTaskList.length})',
                    bold: true,
                    fontSize: 19,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // push(ProjectDashboardCreatTaskPage());
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: hexToColor('#FFA133'),
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              DottedLine(
                lineThickness: 1,
                dashColor: hexToColor(
                  '#80939D',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    // padding: EdgeInsets.all(12),
                    // margin: EdgeInsets.only(left: 12),
                    height: 330,
                    width: Get.width,
                    child: Obx(
                      () => projectDashbordOperationalC
                              .projectDashbordMyTaskList.isEmpty
                          ? projectDashbordOperationalC.isLoading.value
                              ? SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                    child: Loading(),
                                  ),
                                )
                              : SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                      child: KText(text: 'No data found')),
                                )
                          : ListView.builder(
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: projectDashbordOperationalC
                                  .projectDashbordMyTaskList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = projectDashbordOperationalC
                                    .projectDashbordMyTaskList[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 15,
                                      ),
                                      child: Container(
                                        width: 300,
                                        height: 310,
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
                                                        text: 'Consulted',
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
                                                        text: item!.id,
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
                                                text: item.supportName,
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
                                                        text: item.outputTarget
                                                            .toString(),
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
                                                        maxLines: 2,
                                                        text: item.outputDescr,
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
                                                  text: item.outputDescr,
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
                                                          item.scheduledEndDate,
                                                      color: AppTheme.nTextC,
                                                      fontSize: 14),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text: item
                                                              .ownerFullname,
                                                          color:
                                                              AppTheme.nTextC,
                                                          fontSize: 14),
                                                      // ClipRRect(
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(50),
                                                      //     child: RenderImg(
                                                      //       path: 'man-1.png',
                                                      //       height: 32,
                                                      //       width: 32,
                                                      //     )),
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
                            ),
                    ),
                  ),
                ],
              ),

              // Row(
              //   children: [
              //     RenderSvg(path: 'icon_task_solid'),
              //     SizedBox(width: 8),
              //     KText(
              //       text: 'Materials Requisition(2)',
              //       bold: true,
              //       fontSize: 19,
              //     ),
              //     Spacer(),
              //     InkWell(
              //       onTap: () {
              //         push(CreateMaterialRequisitionPage());
              //       },
              //       child: Container(
              //         height: 35,
              //         width: 35,
              //         decoration: BoxDecoration(
              //             color: hexToColor('#FFA133'),
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Icon(
              //           Icons.add,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // DottedLine(
              //   lineThickness: 1,
              //   dashColor: hexToColor(
              //     '#80939D',
              //   ),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(top: 12),
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(12)),
              //         border:
              //             Border.all(color: hexToColor('#DBECFB'), width: 1),
              //       ),
              //       child: Column(
              //         children: [
              //           Container(
              //             width: Get.width,
              //             height: 40,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(8),
              //                 topRight: Radius.circular(8),
              //               ),
              //               // border: Border.all(),
              //               color: hexToColor('#E1FFF7'),
              //             ),
              //             child: Row(
              //               children: [
              //                 SizedBox(
              //                   width: 12,
              //                 ),
              //                 KText(
              //                   text: 'MR # A22100501,01 Nov 2022',
              //                   bold: true,
              //                   fontSize: 13,
              //                 ),
              //                 Spacer(),
              //                 Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(8)),
              //                     color: AppTheme.nColor4,
              //                   ),
              //                   height: 30,
              //                   width: 100,
              //                   child: Center(
              //                     child: KText(
              //                       text: 'Approved',
              //                       fontSize: 14,
              //                       //  bold: true,
              //                       color: AppTheme.white,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 12,
              //                 )
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 12,
              //           ),

              //           // KText(
              //           //                                       text:
              //           //                                           'Duis aute irure dolor in reprehenderit in\n voluptate velit esse cillum dolore eu fugiat.',
              //           //                                       color: AppTheme.nTextC,
              //           //                                       fontSize: 14),
              //           //                                   SizedBox(
              //           //                                     height: 5,
              //           //                                   ),
              //           //                                   Divider(
              //           //                                     thickness: .5,
              //           //                                     color: AppTheme.nBorderC1,
              //           //                                   ),

              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'Delivery Location',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 KText(
              //                     text: 'Jhikargacha, Jessore',
              //                     color: hexToColor('#41525A'),
              //                     fontSize: 15),
              //               ],
              //             ),
              //           ),
              //           Divider(
              //             thickness: .5,
              //             color: AppTheme.nBorderC1,
              //           ),
              //           SizedBox(
              //             height: 5,
              //           ),

              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'Project',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 KText(
              //                     text: 'Pole Supply',
              //                     color: hexToColor('#41525A'),
              //                     fontSize: 15),
              //               ],
              //             ),
              //           ),
              //           Divider(
              //             thickness: .5,
              //             color: AppTheme.nBorderC1,
              //           ),
              //           SizedBox(
              //             height: 5,
              //           ),

              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'No. of Materilas Requested',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 Row(
              //                   children: [
              //                     KText(
              //                         text: '350',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     KText(
              //                         text: 'Pcs',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'No. of Materilas Approved',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 Row(
              //                   children: [
              //                     KText(
              //                         text: '200',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     KText(
              //                         text: 'Pcs',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 5,
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'No. of Materilas Received',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 Row(
              //                   children: [
              //                     KText(
              //                         text: '150',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     KText(
              //                         text: 'Pcs',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Divider(
              //             thickness: .5,
              //             color: AppTheme.nBorderC1,
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 KText(
              //                     text: 'Remaining Materials',
              //                     color: hexToColor('#80939D'),
              //                     fontSize: 14),
              //                 Row(
              //                   children: [
              //                     KText(
              //                         text: '00',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     KText(
              //                         text: 'Pcs',
              //                         color: hexToColor('#41525A'),
              //                         fontSize: 15),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),

              //           Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Container(
              //                 height: 34,
              //                 width: 150,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: Color.fromARGB(255, 230, 230, 233),
              //                     style: BorderStyle.solid,
              //                     width: 1,
              //                   ),
              //                 ),
              //                 child: Center(
              //                   child: KText(
              //                     text: 'Transport Orders',
              //                     fontSize: 16,
              //                     color: hexToColor('#4195E3'),
              //                     bold: true,
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Container(
              //                 height: 34,
              //                 width: 150,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(5),
              //                   border: Border.all(
              //                     color: Color.fromARGB(255, 230, 230, 233),
              //                     style: BorderStyle.solid,
              //                     width: 1,
              //                   ),
              //                 ),
              //                 child: Center(
              //                   child: KText(
              //                     text: 'Material List',
              //                     fontSize: 16,
              //                     color: hexToColor('#4195E3'),
              //                     bold: true,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // // Column(
              // //   mainAxisAlignment: MainAxisAlignment.start,
              // //   crossAxisAlignment: CrossAxisAlignment.start,
              // //   children: [
              // //     Container(
              // //       margin: EdgeInsets.only(top: 12),
              // //       width: double.infinity,
              // //       decoration: BoxDecoration(
              // //         borderRadius: BorderRadius.all(Radius.circular(12)),
              // //         border:
              // //             Border.all(color: hexToColor('#DBECFB'), width: 1),
              // //       ),
              // //       child: Column(
              // //         children: [
              // //           Container(
              // //             width: Get.width,
              // //             height: 40,
              // //             decoration: BoxDecoration(
              // //               borderRadius: BorderRadius.only(
              // //                 topLeft: Radius.circular(8),
              // //                 topRight: Radius.circular(8),
              // //               ),
              // //               // border: Border.all(),
              // //               color: hexToColor('#E1FFF7'),
              // //             ),
              // //             child: Row(
              // //               children: [
              // //                 SizedBox(
              // //                   width: 12,
              // //                 ),
              // //                 KText(
              // //                   text: 'MR # A22100501,01 Nov 2022',
              // //                   bold: true,
              // //                   fontSize: 13,
              // //                 ),
              // //                 Spacer(),
              // //                 Container(
              // //                   decoration: BoxDecoration(
              // //                     borderRadius:
              // //                         BorderRadius.all(Radius.circular(8)),
              // //                     color: hexToColor('#84BEF3'),
              // //                   ),
              // //                   height: 30,
              // //                   width: 100,
              // //                   child: Center(
              // //                     child: KText(
              // //                       text: 'Pending',
              // //                       fontSize: 14,
              // //                       //  bold: true,
              // //                       color: AppTheme.white,
              // //                     ),
              // //                   ),
              // //                 ),
              // //                 SizedBox(
              // //                   width: 12,
              // //                 )
              // //               ],
              // //             ),
              // //           ),
              // //           SizedBox(
              // //             height: 12,
              // //           ),

              // //           // KText(
              // //           //                                       text:
              // //           //                                           'Duis aute irure dolor in reprehenderit in\n voluptate velit esse cillum dolore eu fugiat.',
              // //           //                                       color: AppTheme.nTextC,
              // //           //                                       fontSize: 14),
              // //           //                                   SizedBox(
              // //           //                                     height: 5,
              // //           //                                   ),
              // //           //                                   Divider(
              // //           //                                     thickness: .5,
              // //           //                                     color: AppTheme.nBorderC1,
              // //           //                                   ),

              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'Delivery Location',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 KText(
              // //                     text: 'Jhikargacha, Jessore',
              // //                     color: hexToColor('#41525A'),
              // //                     fontSize: 15),
              // //               ],
              // //             ),
              // //           ),
              // //           Divider(
              // //             thickness: .5,
              // //             color: AppTheme.nBorderC1,
              // //           ),
              // //           SizedBox(
              // //             height: 5,
              // //           ),

              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'Project',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 KText(
              // //                     text: 'Pole Supply',
              // //                     color: hexToColor('#41525A'),
              // //                     fontSize: 15),
              // //               ],
              // //             ),
              // //           ),
              // //           Divider(
              // //             thickness: .5,
              // //             color: AppTheme.nBorderC1,
              // //           ),
              // //           SizedBox(
              // //             height: 5,
              // //           ),

              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'No. of Materilas Requested',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 Row(
              // //                   children: [
              // //                     KText(
              // //                         text: '350',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                     SizedBox(
              // //                       width: 5,
              // //                     ),
              // //                     KText(
              // //                         text: 'Pcs',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                   ],
              // //                 ),
              // //               ],
              // //             ),
              // //           ),
              // //           SizedBox(
              // //             height: 5,
              // //           ),
              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'No. of Materilas Approved',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 Row(
              // //                   children: [
              // //                     KText(
              // //                         text: '200',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                     SizedBox(
              // //                       width: 5,
              // //                     ),
              // //                     KText(
              // //                         text: 'Pcs',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                   ],
              // //                 ),
              // //               ],
              // //             ),
              // //           ),
              // //           SizedBox(
              // //             height: 5,
              // //           ),
              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'No. of Materilas Received',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 Row(
              // //                   children: [
              // //                     KText(
              // //                         text: '150',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                     SizedBox(
              // //                       width: 5,
              // //                     ),
              // //                     KText(
              // //                         text: 'Pcs',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                   ],
              // //                 ),
              // //               ],
              // //             ),
              // //           ),
              // //           Divider(
              // //             thickness: .5,
              // //             color: AppTheme.nBorderC1,
              // //           ),
              // //           Padding(
              // //             padding: EdgeInsets.only(left: 10, right: 10),
              // //             child: Row(
              // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //               children: [
              // //                 KText(
              // //                     text: 'Remaining Materials',
              // //                     color: hexToColor('#80939D'),
              // //                     fontSize: 14),
              // //                 Row(
              // //                   children: [
              // //                     KText(
              // //                         text: '50',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                     SizedBox(
              // //                       width: 5,
              // //                     ),
              // //                     KText(
              // //                         text: 'Pcs',
              // //                         color: hexToColor('#41525A'),
              // //                         fontSize: 15),
              // //                   ],
              // //                 ),
              // //               ],
              // //             ),
              // //           ),
              // //           SizedBox(
              // //             height: 20,
              // //           ),

              // //           Row(
              // //             crossAxisAlignment: CrossAxisAlignment.center,
              // //             mainAxisAlignment: MainAxisAlignment.center,
              // //             children: [
              // //               Container(
              // //                 height: 34,
              // //                 width: 150,
              // //                 decoration: BoxDecoration(
              // //                   border: Border.all(
              // //                     color: Color.fromARGB(255, 230, 230, 233),
              // //                     style: BorderStyle.solid,
              // //                     width: 1,
              // //                   ),
              // //                 ),
              // //                 child: Center(
              // //                   child: KText(
              // //                     text: 'Transport Orders',
              // //                     fontSize: 16,
              // //                     color: hexToColor('#4195E3'),
              // //                     bold: true,
              // //                   ),
              // //                 ),
              // //               ),
              // //               SizedBox(
              // //                 width: 10,
              // //               ),
              // //               Container(
              // //                 height: 34,
              // //                 width: 150,
              // //                 decoration: BoxDecoration(
              // //                   borderRadius: BorderRadius.circular(5),
              // //                   border: Border.all(
              // //                     color: Color.fromARGB(255, 230, 230, 233),
              // //                     style: BorderStyle.solid,
              // //                     width: 1,
              // //                   ),
              // //                 ),
              // //                 child: Center(
              // //                   child: KText(
              // //                     text: 'Material List',
              // //                     fontSize: 16,
              // //                     color: hexToColor('#4195E3'),
              // //                     bold: true,
              // //                   ),
              // //                 ),
              // //               ),
              // //             ],
              // //           ),
              // //           SizedBox(
              // //             height: 20,
              // //           ),
              // //         ],
              // //       ),
              // //     ),
              // //   ],
              // // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: [
              //     RenderSvg(path: 'icon_pointer'),
              //     SizedBox(width: 8),
              //     KText(
              //       text: 'Assigned Work Areas (Geographies)',
              //       bold: true,
              //       fontSize: 17,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // DottedLine(
              //   lineThickness: 1,
              //   dashColor: hexToColor(
              //     '#80939D',
              //   ),
              // ),
              // SizedBox(
              //   height: 19,
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.check_box,
              //       color: hexToColor('#84BEF3'),
              //     ),
              //     SizedBox(width: 8),
              //     KText(
              //       text: 'Include Completed Geographies',
              //       fontSize: 15,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 19,
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.zero,
              //       // padding: EdgeInsets.all(12),
              //       // margin: EdgeInsets.only(left: 12),
              //       height: 130,
              //       width: Get.width,
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         primary: false,
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 10,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Padding(
              //             padding: EdgeInsets.only(
              //               right: 15,
              //             ),
              //             child: Container(
              //               height: 120,
              //               width: 320,
              //               decoration: BoxDecoration(
              //                 // borderRadius: BorderRadius.all(Radius.circular(5)),
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(5)),
              //                 border: Border.all(
              //                     width: 1, color: hexToColor('#C0F9EA')),
              //                 //  color: AppTheme.nColor3,
              //               ),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     height: 40,
              //                     width: double.infinity,
              //                     // color: hexToColor('#FFE9CF'),
              //                     decoration: BoxDecoration(
              //                       // borderRadius: BorderRadius.all(Radius.circular(5)),
              //                       borderRadius: BorderRadius.only(
              //                           topLeft: Radius.circular(5),
              //                           topRight: Radius.circular(5)),
              //                       color: hexToColor('#E1FFF7'),
              //                     ),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             SizedBox(
              //                               width: 7,
              //                             ),
              //                             KText(text: 'BTCL Wifi Project'),
              //                             Spacer(),
              //                             Padding(
              //                               padding: const EdgeInsets.only(
              //                                   right: 10),
              //                               child: Container(
              //                                 decoration: BoxDecoration(
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(8)),
              //                                   color: hexToColor('#49CDAB'),
              //                                 ),
              //                                 height: 30,
              //                                 width: 100,
              //                                 child: Center(
              //                                   child: KText(
              //                                     text: 'Completed',
              //                                     fontSize: 14,
              //                                     //  bold: true,
              //                                     color: AppTheme.white,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                         left: 10, top: 10, right: 10),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           children: [
              //                             KText(
              //                               text: 'Jessore',
              //                               fontSize: 15,
              //                             ),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             RenderSvg(
              //                               path: 'icon_forward',
              //                               height: 12,
              //                             ),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             KText(
              //                               text: 'Jhik',
              //                               fontSize: 15,
              //                             ),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             RenderSvg(
              //                               path: 'icon_forward',
              //                               height: 12,
              //                             ),
              //                             SizedBox(
              //                               width: 5,
              //                             ),
              //                             KText(
              //                               text: ' Ganganandapur ',
              //                               fontSize: 15,
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 8,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             KText(
              //                                 text: 'No. of Sites',
              //                                 color: hexToColor('#41525A'),
              //                                 fontSize: 14),
              //                             Spacer(),
              //                             Row(
              //                               children: [
              //                                 KText(
              //                                     text: '15',
              //                                     color: hexToColor('#41525A'),
              //                                     fontSize: 14),
              //                               ],
              //                             )
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 8,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             KText(
              //                                 text: 'No. of Completed Sites',
              //                                 color: hexToColor('#41525A'),
              //                                 fontSize: 14),
              //                             Spacer(),
              //                             Row(
              //                               children: [
              //                                 KText(
              //                                     text: '10',
              //                                     color: hexToColor('#41525A'),
              //                                     fontSize: 14),
              //                               ],
              //                             )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 100,
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class MaterialsRequisition extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    //  projectDashbordOperationalC.getProjectDashbordMaterialsRequisition();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  RenderSvg(path: 'icon_task_solid'),
                  SizedBox(width: 8),
                  KText(
                    text:
                        'Materials Requisition(${projectDashbordOperationalC.projectDashbordMaterialsRequisitionList.length})',
                    bold: true,
                    fontSize: 19,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      //   push(CreateMaterialRequisitionPage());
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: hexToColor('#FFA133'),
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              DottedLine(
                lineThickness: 1,
                dashColor: hexToColor(
                  '#80939D',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    // padding: EdgeInsets.all(12),
                    // margin: EdgeInsets.only(left: 12),
                    height: 400,
                    width: Get.width,
                    child: Obx(
                      () => projectDashbordOperationalC
                              .projectDashbordMaterialsRequisitionList.isEmpty
                          ? projectDashbordOperationalC.isLoading.value
                              ? SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                    child: Loading(),
                                  ))
                              : SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                      child: KText(text: 'No data found')),
                                )
                          : ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: projectDashbordOperationalC
                                  .projectDashbordMaterialsRequisitionList
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = projectDashbordOperationalC
                                        .projectDashbordMaterialsRequisitionList[
                                    index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        height: 350,
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
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                // border: Border.all(),
                                                color: hexToColor('#E1FFF7'),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  KText(
                                                    text:
                                                        'MR # A22100501,01 Nov 2022',
                                                    bold: true,
                                                    fontSize: 13,
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      color:
                                                          hexToColor('#84BEF3'),
                                                    ),
                                                    height: 30,
                                                    width: 100,
                                                    child: Center(
                                                      child: KText(
                                                        text: item!.status,
                                                        fontSize: 14,
                                                        //  bold: true,
                                                        color: AppTheme.white,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),

                                            // KText(
                                            //                                       text:
                                            //                                           'Duis aute irure dolor in reprehenderit in\n voluptate velit esse cillum dolore eu fugiat.',
                                            //                                       color: AppTheme.nTextC,
                                            //                                       fontSize: 14),
                                            //                                   SizedBox(
                                            //                                     height: 5,
                                            //                                   ),
                                            //                                   Divider(
                                            //                                     thickness: .5,
                                            //                                     color: AppTheme.nBorderC1,
                                            //                                   ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text: 'Delivery Location',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  KText(
                                                      text:
                                                          item.deliveryLocation,
                                                      color:
                                                          hexToColor('#41525A'),
                                                      fontSize: 15),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: .5,
                                              color: AppTheme.nBorderC1,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text: 'Project',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  KText(
                                                      text: item.project,
                                                      color:
                                                          hexToColor('#41525A'),
                                                      fontSize: 15),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: .5,
                                              color: AppTheme.nBorderC1,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text:
                                                          'No. of Materilas Requested',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text: item
                                                              .noOfMaterialsRequested
                                                              .toString(),
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      KText(
                                                          text: 'Pcs',
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text:
                                                          'No. of Materilas Approved',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text: item
                                                              .noOfMaterialsApproved
                                                              .toString(),
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      KText(
                                                          text: 'Pcs',
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text:
                                                          'No. of Materilas Received',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text: item
                                                              .noOfMaterialsReceived
                                                              .toString(),
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      KText(
                                                          text: 'Pcs',
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: .5,
                                              color: AppTheme.nBorderC1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                      text:
                                                          'Remaining Materials',
                                                      color:
                                                          hexToColor('#80939D'),
                                                      fontSize: 14),
                                                  Row(
                                                    children: [
                                                      KText(
                                                          text: item
                                                              .remainingMaterials
                                                              .toString(),
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      KText(
                                                          text: 'Pcs',
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          fontSize: 15),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 34,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 230, 230, 233),
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: KText(
                                                      text: 'Transport Orders',
                                                      fontSize: 16,
                                                      color:
                                                          hexToColor('#4195E3'),
                                                      bold: true,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 34,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 230, 230, 233),
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: KText(
                                                      text: 'Material List',
                                                      fontSize: 16,
                                                      color:
                                                          hexToColor('#4195E3'),
                                                      bold: true,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  RenderSvg(path: 'icon_pointer'),
                  SizedBox(width: 8),
                  KText(
                    text: 'Assigned Work Areas (Geographies)',
                    bold: true,
                    fontSize: 17,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DottedLine(
                lineThickness: 1,
                dashColor: hexToColor(
                  '#80939D',
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_box,
                    color: hexToColor('#84BEF3'),
                  ),
                  SizedBox(width: 8),
                  KText(
                    text: 'Include Completed Geographies',
                    fontSize: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 19,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    // padding: EdgeInsets.all(12),
                    // margin: EdgeInsets.only(left: 12),
                    height: 130,
                    width: Get.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Container(
                            height: 120,
                            width: 320,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  width: 1, color: hexToColor('#C0F9EA')),
                              //  color: AppTheme.nColor3,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  // color: hexToColor('#FFE9CF'),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: hexToColor('#E1FFF7'),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 7,
                                          ),
                                          KText(text: 'BTCL Wifi Project'),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: hexToColor('#49CDAB'),
                                              ),
                                              height: 30,
                                              width: 100,
                                              child: Center(
                                                child: KText(
                                                  text: 'Completed',
                                                  fontSize: 14,
                                                  //  bold: true,
                                                  color: AppTheme.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Jessore',
                                            fontSize: 15,
                                          ),
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
                                            text: 'Jhik',
                                            fontSize: 15,
                                          ),
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
                                            text: ' Ganganandapur ',
                                            fontSize: 15,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'No. of Sites',
                                              color: hexToColor('#41525A'),
                                              fontSize: 14),
                                          Spacer(),
                                          Row(
                                            children: [
                                              KText(
                                                  text: '15',
                                                  color: hexToColor('#41525A'),
                                                  fontSize: 14),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'No. of Completed Sites',
                                              color: hexToColor('#41525A'),
                                              fontSize: 14),
                                          Spacer(),
                                          Row(
                                            children: [
                                              KText(
                                                  text: '10',
                                                  color: hexToColor('#41525A'),
                                                  fontSize: 14),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Reporting extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool searchIcon;
  final bool avatar;
  final bool hasCheckbox;
  final String? srchText;
  final Color? color;

  const TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = true,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    this.color,
    this.srchText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isActive = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.hasCheckbox)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                  ),
                ),
              ),
            KText(
              text: widget.title,
              color: hexToColor('#80939D'),
              fontSize: 13,
            ),
            SizedBox(
              width: 3,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            widget.avatar
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 40,
                      width: 40,
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
                              '${Constants.imgPath}/bill.jpeg',
                              width: 37,
                              height: 37,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            KText(
              text: widget.srchText,
              fontSize: 15,
              color: widget.color != null ? widget.color : AppTheme.textColor,
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
