import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../components/check_box.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import '../controllers/location_controller.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../components/user_avatar.dart';

class MyApprovalDashboardPage extends StatefulWidget with Base {
  @override
  State<MyApprovalDashboardPage> createState() =>
      _MyApprovalDashboardPageState();
}

class _MyApprovalDashboardPageState extends State<MyApprovalDashboardPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _activeIndex = 0;

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
              onPressed: () => back(),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: hexToColor('#9BA9B3'),
              )),
          title: KText(
            text: 'My Approval Dashboard',
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
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ApprovalRequests(),
            // MyApprovalDashboardMyRequests(),
            Container(),
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
          Tab(text: 'Approval Requests'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'My Requests')),
        ],
      );
}

class ApprovalRequests extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    myApprovalDashboardC.getTransportOrder(transportOrderNo: '');
    myApprovalDashboardC.getChangeRequest();
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';

    return SingleChildScrollView(
      child: Obx(
        () =>

            //  myApprovalDashboardC.transportOrder.isEmpty
            //     ? myApprovalDashboardC.isLoading.value
            //         ? SizedBox(
            //             height: Get.height / 1.5,
            //             child: Center(
            //               child: Loading(),
            //             ),
            //           )
            //         : SizedBox(
            //             height: Get.height / 1.5,
            //             child: Center(child: KText(text: 'No data found')),
            //           )
            //     :

            Column(
          children: [
            SizedBox(
              height: 30,
            ),
            if (myApprovalDashboardC.transportOrder.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'trucklogo'),
                            SizedBox(width: 5),
                            KText(
                              text: 'TO Approval Requests',
                              bold: true,
                              fontSize: 14,
                              color: hexToColor('#41525A'),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: hexToColor('#FFECD6'),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: KText(
                              text:
                                  '0${myApprovalDashboardC.transportOrder.length}',
                              color: hexToColor('#FFA133'),
                              fontSize: 18,
                              bold: true,
                            ),
                          ),
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
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: myApprovalDashboardC.transportOrder.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = myApprovalDashboardC.transportOrder[index];
                        return Container(
                          width: Get.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: hexToColor('#F6FBFF'),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: hexToColor('#DBECFB'),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  boxShadow: item!.isExpanded!
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                          BoxShadow(
                                            color: Colors.transparent,
                                            offset: Offset(0, 0),
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: Offset(0, 0),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Transport Order ',
                                                color: hexToColor('#80939D'),
                                              ),
                                              KText(
                                                text:
                                                    '${item.transportOrderNo}',
                                                bold: true,
                                                fontSize: 13,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 50),
                                                child: KText(
                                                  text: 'Date',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                              ),
                                              if (item.transportOrderDate !=
                                                  null)
                                                KText(
                                                  text: formatDate(
                                                      date: item
                                                          .transportOrderDate!),
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
                                          SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              myApprovalDashboardC
                                                  .isExpandedItem(
                                                id: item.id!,
                                                value: item.isExpanded!,
                                              );
                                            },
                                            child: Icon(
                                              item.isExpanded!
                                                  ? EvaIcons
                                                      .arrowIosUpwardOutline
                                                  : EvaIcons
                                                      .arrowIosDownwardOutline,
                                              color: hexToColor('#80939D'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: hexToColor('#DBECFB'),
                                      thickness: 1,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              KText(
                                                text: 'Logistics Provider',
                                                bold: true,
                                                fontSize: 13,
                                                color: hexToColor('#80939D'),
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 5,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: KText(
                                                    text: item.transporterAgencyName !=
                                                            null
                                                        ? '${item.transporterAgencyName}'
                                                        : '',
                                                    bold: true,
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              if (item.transporterAgencyName ==
                                                  null)
                                                UserAvatar(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!item.isExpanded!)
                                Divider(
                                  color: hexToColor('#DBECFB'),
                                  thickness: 1,
                                  height: 1,
                                ),
                              if (item.isExpanded!)
                                Container(
                                  // height: 100,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      // color: hexToColor('#DBECFB'),
                                      ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Logistics Provider',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text:
                                                      '${item.transporterAgencyName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                KText(
                                                  text: 'Receiving Party ',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text:
                                                      '${item.receiverAgencyName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                KText(
                                                  text:
                                                      'Source Location (Loading point) ',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text: item.sourceLocName !=
                                                              'null' &&
                                                          item.sourceLocName !=
                                                              null
                                                      ? '${item.sourceLocName}'
                                                      : '',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                KText(
                                                  text:
                                                      'Destination Location (Unloading Point) ',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text:
                                                      '${item.destinationLocName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    //item.singleReceiver
                                                    CheckBox(
                                                      value:
                                                          item.singleReceiver!,
                                                      onChanged: (value) {
                                                        // kLog(value);
                                                      },
                                                    ),
                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          'Single Receiving Person',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    //  UserAvatar(),
                                                    item.receiverUsername !=
                                                            null
                                                        ? Container(
                                                            height: 38,
                                                            width: 38,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                    blurRadius:
                                                                        2.0,
                                                                  ),
                                                                ]),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  Image.network(
                                                                '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.receiverUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          )
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                AppTheme.color4,
                                                            radius: 45,
                                                            child: RenderSvg(
                                                                path:
                                                                    'avatar_placeholder'),
                                                          ),

                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          '${item.receiverFullname}',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    CheckBox(
                                                      value: item
                                                          .singleInspectorAtDropLocation!,
                                                      onChanged: (value) {
                                                        // kLog(value);
                                                      },
                                                    ),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      child: KText(
                                                        text:
                                                            'Single Goods Inspector at the Drop Location',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    item.inspectorAtDropLocationUsername !=
                                                            null
                                                        ? Container(
                                                            height: 38,
                                                            width: 38,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                    blurRadius:
                                                                        2.0,
                                                                  ),
                                                                ]),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  Image.network(
                                                                '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.inspectorAtDropLocationUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          )
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                AppTheme.color4,
                                                            radius: 45,
                                                            child: RenderSvg(
                                                                path:
                                                                    'avatar_placeholder'),
                                                          ),
                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          '${item.inspectorAtDropLocationFullname}',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text:
                                                          'Goods Inspector at the Loading Point',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    item.inspectorAtLoadingPointUsername !=
                                                            null
                                                        ? Container(
                                                            height: 38,
                                                            width: 38,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                    blurRadius:
                                                                        2.0,
                                                                  ),
                                                                ]),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  Image.network(
                                                                '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.inspectorAtLoadingPointUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          )
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                AppTheme.color4,
                                                            radius: 45,
                                                            child: RenderSvg(
                                                                path:
                                                                    'avatar_placeholder'),
                                                          ),
                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          '${item.inspectorAtLoadingPointFullname}',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    CheckBox(
                                                      value:
                                                          item.singleDropLoc!,
                                                      onChanged: (value) {
                                                        // kLog(value);
                                                      },
                                                    ),
                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          'Single Drop Location',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                KText(
                                                  text:
                                                      '${item.destinationLocName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    CheckBox(
                                                      value: item
                                                          .prescribeTravelPath!,
                                                      onChanged: (value) {
                                                        // kLog(value);
                                                      },
                                                    ),
                                                    SizedBox(width: 5),
                                                    KText(
                                                      text:
                                                          'Prescribe Travel Path',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                KText(
                                                  text:
                                                      '${item.travelPathName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                                Divider(
                                                  color: hexToColor('#80939D'),
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        KText(
                                                          text:
                                                              'Total Quantity ',
                                                          fontSize: 13,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                        KText(
                                                          text:
                                                              '${item.totalQuantity}',
                                                          fontSize: 13,
                                                          color: hexToColor(
                                                              '#80939D'),
                                                        ),
                                                        SizedBox(
                                                          width: 35,
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        KText(
                                                          text:
                                                              'Gross Transportation Fee',
                                                          fontSize: 13,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                        KText(
                                                          text:
                                                              '${item.grossAmount}',
                                                          fontSize: 13,
                                                          color: hexToColor(
                                                              '#80939D'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (item.transportOrderLines!
                                                  .isNotEmpty)
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  itemCount: item
                                                      .transportOrderLines!
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final list =
                                                        item.transportOrderLines![
                                                            index];
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        top: 12,
                                                        left: 10,
                                                        right: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              width: 1.5,
                                                              color: hexToColor(
                                                                  '#DBECFB'))),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            //width: Get.width,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // border: Border.all(color: Colors.green),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              5),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              5),
                                                                    ),
                                                                    // border: Border.all(),
                                                                    color: hexToColor(
                                                                        '#DBECFB')),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width: 6),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    myApprovalDashboardC
                                                                        .isExpandedItemOfItem(
                                                                      id: item
                                                                          .id!,
                                                                      value: list
                                                                          .isExpanded!,
                                                                      itemId: list
                                                                          .id!,
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    list.isExpanded!
                                                                        ? EvaIcons
                                                                            .arrowIosUpwardOutline
                                                                        : EvaIcons
                                                                            .arrowIosDownwardOutline,
                                                                    color: hexToColor(
                                                                        '#80939D'),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Expanded(
                                                                  child: KText(
                                                                    text:
                                                                        '${list.productName}',
                                                                    bold: true,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 6),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 12,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Row(
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
                                                                          'Code ',
                                                                      fontSize:
                                                                          13,
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                    ),
                                                                    KText(
                                                                      text:
                                                                          '${list.productFullcode}',
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    KText(
                                                                      text:
                                                                          'Drop Location ',
                                                                      fontSize:
                                                                          13,
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                    ),
                                                                    KText(
                                                                      text:
                                                                          '${list.dropLocName}',
                                                                      color: hexToColor(
                                                                          '#515D64'),
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                              color: hexToColor(
                                                                  '#DBECFB')),
                                                          if (list.isExpanded!)
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          'Distance'),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '${list.distanceKm} Km'),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          'Quantity'),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                TextFormField(
                                                                              textAlign: TextAlign.center,
                                                                              initialValue: '${list.baseUomQuantity}',
                                                                              decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.all(0),
                                                                                isDense: true,
                                                                                labelStyle: TextStyle(color: hexToColor('#FF0000')),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: hexToColor('#DBECFB')),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          KText(
                                                                            text: list.baseUom != null
                                                                                ? '${list.baseUom}'
                                                                                : '',
                                                                            fontSize:
                                                                                14,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          'Weight'),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                70,
                                                                            child:
                                                                                TextFormField(
                                                                              textAlign: TextAlign.center,
                                                                              initialValue: '${list.weightKg}',
                                                                              decoration: InputDecoration(
                                                                                contentPadding: EdgeInsets.all(0),
                                                                                isDense: true,
                                                                                labelStyle: TextStyle(color: hexToColor('#FF0000')),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: hexToColor('#DBECFB')),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          KText(
                                                                            text:
                                                                                'Kg',
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Divider(
                                                                    color: hexToColor(
                                                                        '#DBECFB')),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 10,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          KText(
                                                                            text:
                                                                                'Transportation Fee',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                hexToColor('#41525A'),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Spacer(),
                                                                      KText(
                                                                        text:
                                                                            '',
                                                                        fontSize:
                                                                            14,
                                                                        bold:
                                                                            true,
                                                                        color:
                                                                            hexToColor(
                                                                          '#41525A',
                                                                        ),
                                                                      ),
                                                                      // KText(
                                                                      //   text: 'Kg',
                                                                      //   fontSize: 14,
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   height: 16,
                                                                // ),
                                                                // Padding(
                                                                //   padding:
                                                                //         EdgeInsets.only(left: 10, right: 10),
                                                                //   child: Row(
                                                                //     mainAxisAlignment:
                                                                //         MainAxisAlignment.spaceBetween,
                                                                //     children: [
                                                                //       Row(
                                                                //         mainAxisAlignment:
                                                                //             MainAxisAlignment.spaceBetween,
                                                                //         children: [
                                                                //           Text('26345634'),
                                                                //           SizedBox(
                                                                //             width: 10,
                                                                //           ),
                                                                //           Text('-'),
                                                                //           SizedBox(
                                                                //             width: 10,
                                                                //           ),
                                                                //           Text('21741273'),
                                                                //         ],
                                                                //       ),
                                                                //       Text('5 Kg'),
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Row(
                                                              children: [
                                                                // Container(
                                                                //     height: 1, width: 50, color: hexToColor('#DBECFB')),
                                                                // SizedBox(
                                                                //   width: 50,
                                                                // ),
                                                                // Container(
                                                                //     height: 1, width: 60, color: hexToColor('#DBECFB')),
                                                                // SizedBox(
                                                                //   width: 120,
                                                                // ),
                                                                // Container(
                                                                //     height: 1, width: 50, color: hexToColor('#DBECFB'))
                                                              ],
                                                            ),
                                                          ),
                                                          if (list.isExpanded!)
                                                            Divider(
                                                                color: hexToColor(
                                                                    '#DBECFB')),
                                                          list.isExpanded!
                                                              ? Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    bottom: 6,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              KText(
                                                                                text: 'Goods Receiver ',
                                                                                fontSize: 13,
                                                                                color: hexToColor('#80939D'),
                                                                              ),
                                                                              RenderSvg(
                                                                                path: 'icon_search_elements',
                                                                                width: 25,
                                                                                color: hexToColor('#66A1D9'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          KText(
                                                                            text: item.receiverFullname != null
                                                                                ? '${item.receiverAgencyName} '
                                                                                : '',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                hexToColor('#515D64'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              KText(
                                                                                text: 'Goods Inspector ',
                                                                                fontSize: 13,
                                                                                color: hexToColor('#80939D'),
                                                                              ),
                                                                              RenderSvg(
                                                                                path: 'icon_search_elements',
                                                                                width: 25,
                                                                                color: hexToColor('#66A1D9'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          KText(
                                                                            text: item.receiverFullname != null
                                                                                ? '${item.inspectorAtLoadingPointFullname} '
                                                                                : '',
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                hexToColor('#515D64'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    bottom: 6,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          'Quantity'),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                              '${list.baseUomQuantity} '),
                                                                          Text(list.baseUom != null
                                                                              ? '${list.baseUom}'
                                                                              : ''),
                                                                        ],
                                                                      ),
                                                                      //   '${list.baseUomQuantity!.toInt()} ${list.baseUom}'),
                                                                    ],
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              SizedBox(height: 15),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.vertical(
                                    bottom: Radius.circular(4),
                                  ),
                                  boxShadow: item.isExpanded!
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0, -2),
                                          ),
                                          BoxShadow(
                                            color: Colors.transparent,
                                            offset: Offset(0, 0),
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            offset: Offset(0, 0),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  children: [
                                    if (item.isExpanded!)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Remarks',
                                              color: hexToColor('#80939D'),
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Remarks here...',
                                                hintStyle: TextStyle(
                                                  color: hexToColor('#D9D9D9'),
                                                  fontSize: 14,
                                                ),
                                                isDense: true,
                                              ),
                                            ),
                                            SizedBox(height: 20)
                                          ],
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 20),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty
                                                .all<Size?>(Size(109, 35)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    hexToColor('#FF9191')),
                                            visualDensity:
                                                VisualDensity(horizontal: 2),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                // side: BorderSide(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            myApprovalDashboardC
                                                .postTransportOrderApprove(
                                              id: item.id,
                                              status: 'Rejected',
                                            );
                                          },
                                          child: Text(
                                            'Reject',
                                            style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty
                                                .all<Size?>(Size(109, 35)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    hexToColor('#49CDAB')),
                                            visualDensity:
                                                VisualDensity(horizontal: 2),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                // side: BorderSide(color: Colors.red),
                                              ),
                                            ),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(Colors.white
                                                    .withOpacity(.2)),
                                          ),
                                          onPressed: () {
                                            myApprovalDashboardC
                                                .postTransportOrderApprove(
                                              id: item.id,
                                              status: 'Approved',
                                            );
                                          },
                                          child: Text(
                                            'Approve',
                                            style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     myApprovalDashboardC
                                        //         .postTransportOrderApprove(
                                        //             status: 'Rejected',
                                        //             transportOrderNo: '');
                                        //   },
                                        //   child: Container(
                                        //     height: 34,
                                        //     width: 116,
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.all(
                                        //                 Radius.circular(8)),
                                        //         color:
                                        //             hexToColor('#FF9191')),
                                        //     child: Center(
                                        //       child: KText(
                                        //         text: 'Reject',
                                        //         fontSize: 16,
                                        //         color: Colors.white,
                                        //         bold: true,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     myApprovalDashboardC
                                        //         .postTransportOrderApprove(
                                        //       status: 'Approved',
                                        //       transportOrderNo: '',
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     height: 34,
                                        //     width: 116,
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.all(
                                        //                 Radius.circular(8)),
                                        //         color:
                                        //             hexToColor('#49CDAB')),
                                        //     child: Center(
                                        //       child: KText(
                                        //         text: 'Approve',
                                        //         fontSize: 16,
                                        //         color: Colors.white,
                                        //         bold: true,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            SizedBox(
              height: 10,
            ),

            if (myApprovalDashboardC.changeRequest.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'trucklogo'),
                            SizedBox(width: 5),
                            KText(
                              text: 'Change Request Approval',
                              bold: true,
                              fontSize: 14,
                              color: hexToColor('#41525A'),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: hexToColor('#FFECD6'),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: KText(
                              text:
                                  '${myApprovalDashboardC.changeRequest.length}',
                              color: hexToColor('#FFA133'),
                              fontSize: 18,
                              bold: true,
                            ),
                          ),
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
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: myApprovalDashboardC.changeRequest.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = myApprovalDashboardC.changeRequest[index];
                        return Container(
                          width: Get.width,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: hexToColor('#F6FBFF'),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: hexToColor('#DBECFB'),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  // boxShadow: item.isExpanded!
                                  //     ? [
                                  //         BoxShadow(
                                  //           color: Colors.grey.withOpacity(.3),
                                  //           spreadRadius: 1,
                                  //           blurRadius: 2,
                                  //           offset: Offset(0, 2),
                                  //         ),
                                  //         BoxShadow(
                                  //           color: Colors.transparent,
                                  //           offset: Offset(0, 0),
                                  //         ),
                                  //         BoxShadow(
                                  //           color: Colors.grey.shade300,
                                  //           offset: Offset(0, 0),
                                  //         )
                                  //       ]
                                  //     : [],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'CR Number#',
                                                color: hexToColor('#80939D'),
                                              ),
                                              KText(
                                                text: '${item.requestRefno}',
                                                bold: true,
                                                fontSize: 13,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SizedBox(
                                                width: 35,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          // Column(
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           EdgeInsets.only(left: 50),
                                          //       child: KText(
                                          //         text: 'Date',
                                          //         fontSize: 13,
                                          //         color: hexToColor('#80939D'),
                                          //       ),
                                          //     ),

                                          // KText(
                                          //   text: formatDate(
                                          //       date: item
                                          //           .transportOrderDate!),
                                          //   bold: true,
                                          //   fontSize: 13,
                                          //   color: hexToColor('#515D64'),
                                          // ),
                                          // SizedBox(
                                          //   width: 35,
                                          // ),
                                          // Icon(
                                          //   uiC.isExpanded.value
                                          //       ? EvaIcons.arrowIosUpwardOutline
                                          //       : EvaIcons.arrowIosDownwardOutline,
                                          //   color: hexToColor('#80939D'),
                                          // ),
                                          //   ],
                                          // ),
                                          //    SizedBox(width: 8),
                                          //   GestureDetector(
                                          // onTap: () {
                                          //   myApprovalDashboardC
                                          //       .isExpandedItem1(
                                          //     id: item.id!,
                                          //     value: item.isExpanded!,
                                          //   );
                                          // },
                                          // child: Icon(
                                          //   item.isExpanded!
                                          //       ? EvaIcons
                                          //           .arrowIosUpwardOutline
                                          //       : EvaIcons
                                          //           .arrowIosDownwardOutline,
                                          //   color: hexToColor('#80939D'),
                                          // ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: hexToColor('#DBECFB'),
                                      thickness: 1,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              KText(
                                                text: 'Requester Name',
                                                bold: true,
                                                fontSize: 13,
                                                color: hexToColor('#80939D'),
                                              ),
                                              Spacer(),
                                              Expanded(
                                                flex: 5,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: KText(
                                                    text:
                                                        '${item.requesterFullname}',
                                                    bold: true,
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              UserAvatar(),
                                            ],
                                          ),
                                          if (item.statusCode != '03' &&
                                              item.statusCode != '02')
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(width: 20),

                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all<Size?>(
                                                                Size(109, 35)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                hexToColor(
                                                                    '#FF9191')),
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: 2),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        // side: BorderSide(color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    myApprovalDashboardC
                                                        .editChangeRequest(
                                                            item: item,
                                                            status: 'Rejected',
                                                            statuscode: '02');
                                                  },
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                      fontFamily: 'Manrope',
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all<Size?>(
                                                                Size(109, 35)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                hexToColor(
                                                                    '#49CDAB')),
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: 2),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        // side: BorderSide(color: Colors.red),
                                                      ),
                                                    ),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Colors
                                                                .white
                                                                .withOpacity(
                                                                    .2)),
                                                  ),
                                                  onPressed: () {
                                                    myApprovalDashboardC
                                                        .editChangeRequest(
                                                            item: item,
                                                            status: 'Approved',
                                                            statuscode: '03');
                                                  },
                                                  child: Text(
                                                    'Approve',
                                                    style: TextStyle(
                                                      fontFamily: 'Manrope',
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                // InkWell(
                                                //   onTap: () {
                                                //     // myApprovalDashboardC
                                                //     //     .postTransportOrderApprove(
                                                //     //         status: 'Rejected',
                                                //     //         transportOrderNo: '');
                                                //   },
                                                //   child: Container(
                                                //     height: 34,
                                                //     width: 116,
                                                //     decoration: BoxDecoration(
                                                //         borderRadius:
                                                //             BorderRadius.all(
                                                //                 Radius.circular(
                                                //                     8)),
                                                //         color: hexToColor(
                                                //             '#FF9191')),
                                                //     child: Center(
                                                //       child: KText(
                                                //         text: 'Reject',
                                                //         fontSize: 16,
                                                //         color: Colors.white,
                                                //         bold: true,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                // InkWell(
                                                //   onTap: () {
                                                //     // myApprovalDashboardC
                                                //     //     .postTransportOrderApprove(
                                                //     //   status: 'Approved',
                                                //     //   transportOrderNo: '',
                                                //     // );
                                                //   },
                                                //   child: Container(
                                                //     height: 34,
                                                //     width: 116,
                                                //     decoration: BoxDecoration(
                                                //         borderRadius:
                                                //             BorderRadius.all(
                                                //                 Radius.circular(
                                                //                     8)),
                                                //         color: hexToColor(
                                                //             '#49CDAB')),
                                                //     child: Center(
                                                //       child: KText(
                                                //         text: 'Approve',
                                                //         fontSize: 16,
                                                //         color: Colors.white,
                                                //         bold: true,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),

                                                SizedBox(width: 20),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // if (!item.isExpanded!)
                              //   Divider(
                              //     color: hexToColor('#DBECFB'),
                              //     thickness: 1,
                              //     height: 1,
                              //   ),
                              // if (item.isExpanded!)
                              //   Container(
                              //     // height: 100,
                              //     width: Get.width,
                              //     decoration: BoxDecoration(
                              //         // color: hexToColor('#DBECFB'),
                              //         ),
                              //     child: Column(
                              //       children: [
                              //         SizedBox(height: 10),
                              //         Column(
                              //           children: [
                              //             Padding(
                              //               padding: EdgeInsets.only(
                              //                   left: 15, right: 15),
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.start,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   KText(
                              //                     text: 'Logistics Provider',
                              //                     fontSize: 13,
                              //                     color: hexToColor('#80939D'),
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         '{item.transporterAgencyName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   KText(
                              //                     text: 'Receiving Party ',
                              //                     fontSize: 13,
                              //                     color: hexToColor('#80939D'),
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         '{item.receiverAgencyName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         'Source Location (Loading point) ',
                              //                     fontSize: 13,
                              //                     color: hexToColor('#80939D'),
                              //                   ),
                              //                   KText(
                              //                     text: '{item.sourceLocName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         'Destination Location (Unloading Point) ',
                              //                     fontSize: 13,
                              //                     color: hexToColor('#80939D'),
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         '{item.destinationLocName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       //item.singleReceiver
                              //                       // CheckBox(
                              //                       //   value:
                              //                       //       item.singleReceiver!,
                              //                       //   onChanged: (value) {
                              //                       //    // kLog(value);
                              //                       //   },
                              //                       // ),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             'Single Receiving Person',
                              //                         fontSize: 13,
                              //                         color:
                              //                             hexToColor('#80939D'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   SizedBox(height: 5),
                              //                   Row(
                              //                     children: [
                              //                       UserAvatar(),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             '{item.receiverUsername}',
                              //                         fontSize: 14,
                              //                         color:
                              //                             hexToColor('#515D64'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       // CheckBox(
                              //                       //   value: item
                              //                       //       .singleInspectorAtDropLocation!,
                              //                       //   onChanged: (value) {
                              //                       //    // kLog(value);
                              //                       //   },
                              //                       // ),
                              //                       SizedBox(width: 5),
                              //                       Expanded(
                              //                         child: KText(
                              //                           text:
                              //                               'Single Goods Inspector at the Drop Location',
                              //                           fontSize: 13,
                              //                           color: hexToColor(
                              //                               '#80939D'),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   SizedBox(height: 5),
                              //                   Row(
                              //                     children: [
                              //                       UserAvatar(),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             '{item.inspectorAtDropLocationUsername}',
                              //                         fontSize: 14,
                              //                         color:
                              //                             hexToColor('#515D64'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       KText(
                              //                         text:
                              //                             'Goods Inspector at the Loading Point',
                              //                         fontSize: 13,
                              //                         color:
                              //                             hexToColor('#80939D'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       UserAvatar(),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             '{item.inspectorAtLoadingPointUsername}',
                              //                         fontSize: 14,
                              //                         color:
                              //                             hexToColor('#515D64'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       // CheckBox(
                              //                       //   value:
                              //                       //       item.singleDropLoc!,
                              //                       //   onChanged: (value) {
                              //                       //    // kLog(value);
                              //                       //   },
                              //                       // ),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             'Single Drop Location',
                              //                         fontSize: 13,
                              //                         color:
                              //                             hexToColor('#80939D'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   KText(
                              //                     text:
                              //                         '{item.destinationLocName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                   SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Row(
                              //                     children: [
                              //                       // CheckBox(
                              //                       //   value: item
                              //                       //       .prescribeTravelPath!,
                              //                       //   onChanged: (value) {
                              //                       //    // kLog(value);
                              //                       //   },
                              //                       // ),
                              //                       SizedBox(width: 5),
                              //                       KText(
                              //                         text:
                              //                             'Prescribe Travel Path',
                              //                         fontSize: 13,
                              //                         color:
                              //                             hexToColor('#80939D'),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   KText(
                              //                     text: '{item.travelPathName}',
                              //                     fontSize: 14,
                              //                     color: hexToColor('#515D64'),
                              //                   ),
                              //                   Divider(
                              //                     color: hexToColor('#80939D'),
                              //                     thickness: 1,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             SizedBox(height: 10),
                              //             Column(
                              //               children: [
                              //                 Padding(
                              //                   padding: EdgeInsets.only(
                              //                     left: 15,
                              //                     right: 15,
                              //                   ),
                              //                   child: Row(
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment
                              //                             .spaceBetween,
                              //                     children: [
                              //                       Column(
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment
                              //                                 .start,
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           KText(
                              //                             text:
                              //                                 'Total Quantity ',
                              //                             fontSize: 13,
                              //                             color: hexToColor(
                              //                                 '#515D64'),
                              //                           ),
                              //                           KText(
                              //                             text:
                              //                                 '{item.totalQuantity}',
                              //                             fontSize: 13,
                              //                             color: hexToColor(
                              //                                 '#80939D'),
                              //                           ),
                              //                           SizedBox(
                              //                             width: 35,
                              //                           ),
                              //                         ],
                              //                       ),
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .end,
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment.end,
                              //                         children: [
                              //                           KText(
                              //                             text:
                              //                                 'Gross Transportation Fee',
                              //                             fontSize: 13,
                              //                             color: hexToColor(
                              //                                 '#515D64'),
                              //                           ),
                              //                           KText(
                              //                             text:
                              //                                 '{item.grossAmount}',
                              //                             fontSize: 13,
                              //                             color: hexToColor(
                              //                                 '#80939D'),
                              //                           ),
                              //                         ],
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //                 // if (item.transportOrderLines!
                              //                 //     .isNotEmpty)
                              //                 //   ListView.builder(
                              //                 //     shrinkWrap: true,
                              //                 //     primary: false,
                              //                 //     itemCount: item
                              //                 //         .transportOrderLines!
                              //                 //         .length,
                              //                 //     itemBuilder:
                              //                 //         (BuildContext context,
                              //                 //             int index) {
                              //                 //       final list =
                              //                 //           item.transportOrderLines![
                              //                 //               index];
                              //                 //       return Container(
                              //                 //         margin: EdgeInsets.only(
                              //                 //           top: 12,
                              //                 //           left: 10,
                              //                 //           right: 10,
                              //                 //         ),
                              //                 //         decoration: BoxDecoration(
                              //                 //             color: Colors.white,
                              //                 //             borderRadius:
                              //                 //                 BorderRadius
                              //                 //                     .circular(5),
                              //                 //             border: Border.all(
                              //                 //                 width: 1.5,
                              //                 //                 color: hexToColor(
                              //                 //                     '#DBECFB'))),
                              //                 //         child: Column(
                              //                 //           children: [
                              //                 //             Container(
                              //                 //               //width: Get.width,
                              //                 //               height: 40,
                              //                 //               decoration:
                              //                 //                   BoxDecoration(
                              //                 //                       // border: Border.all(color: Colors.green),
                              //                 //                       borderRadius:
                              //                 //                           BorderRadius
                              //                 //                               .only(
                              //                 //                         topLeft: Radius
                              //                 //                             .circular(
                              //                 //                                 5),
                              //                 //                         topRight:
                              //                 //                             Radius.circular(
                              //                 //                                 5),
                              //                 //                       ),
                              //                 //                       // border: Border.all(),
                              //                 //                       color: hexToColor(
                              //                 //                           '#DBECFB')),
                              //                 //               child: Row(
                              //                 //                 children: [
                              //                 //                   SizedBox(
                              //                 //                       width: 6),
                              //                 //                   GestureDetector(
                              //                 //                     onTap: () {
                              //                 //                       myApprovalDashboardC
                              //                 //                           .isExpandedItemOfItem(
                              //                 //                         id: item
                              //                 //                             .id!,
                              //                 //                         value: list
                              //                 //                             .isExpanded!,
                              //                 //                         itemId: list
                              //                 //                             .id!,
                              //                 //                       );
                              //                 //                     },
                              //                 //                     child: Icon(
                              //                 //                       list.isExpanded!
                              //                 //                           ? EvaIcons
                              //                 //                               .arrowIosUpwardOutline
                              //                 //                           : EvaIcons
                              //                 //                               .arrowIosDownwardOutline,
                              //                 //                       color: hexToColor(
                              //                 //                           '#80939D'),
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   SizedBox(
                              //                 //                       width: 5),
                              //                 //                   Expanded(
                              //                 //                     child: KText(
                              //                 //                       text:
                              //                 //                           '${list.productName}',
                              //                 //                       bold: true,
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   SizedBox(
                              //                 //                       width: 6),
                              //                 //                 ],
                              //                 //               ),
                              //                 //             ),
                              //                 //             SizedBox(
                              //                 //               height: 12,
                              //                 //             ),
                              //                 //             Padding(
                              //                 //               padding:
                              //                 //                   EdgeInsets.only(
                              //                 //                       left: 10,
                              //                 //                       right: 10),
                              //                 //               child: Row(
                              //                 //                 mainAxisAlignment:
                              //                 //                     MainAxisAlignment
                              //                 //                         .spaceBetween,
                              //                 //                 children: [
                              //                 //                   Column(
                              //                 //                     crossAxisAlignment:
                              //                 //                         CrossAxisAlignment
                              //                 //                             .start,
                              //                 //                     children: [
                              //                 //                       KText(
                              //                 //                         text:
                              //                 //                             'Code ',
                              //                 //                         fontSize:
                              //                 //                             13,
                              //                 //                         color: hexToColor(
                              //                 //                             '#515D64'),
                              //                 //                       ),
                              //                 //                       KText(
                              //                 //                         text:
                              //                 //                             '${list.productFullcode}',
                              //                 //                         color: hexToColor(
                              //                 //                             '#515D64'),
                              //                 //                         fontSize:
                              //                 //                             14,
                              //                 //                       ),
                              //                 //                     ],
                              //                 //                   ),
                              //                 //                   Column(
                              //                 //                     crossAxisAlignment:
                              //                 //                         CrossAxisAlignment
                              //                 //                             .end,
                              //                 //                     children: [
                              //                 //                       KText(
                              //                 //                         text:
                              //                 //                             'Drop Location ',
                              //                 //                         fontSize:
                              //                 //                             13,
                              //                 //                         color: hexToColor(
                              //                 //                             '#515D64'),
                              //                 //                       ),
                              //                 //                       KText(
                              //                 //                         text:
                              //                 //                             '${list.dropLocName}',
                              //                 //                         color: hexToColor(
                              //                 //                             '#515D64'),
                              //                 //                         fontSize:
                              //                 //                             14,
                              //                 //                       ),
                              //                 //                     ],
                              //                 //                   ),
                              //                 //                 ],
                              //                 //               ),
                              //                 //             ),
                              //                 //             Divider(
                              //                 //                 color: hexToColor(
                              //                 //                     '#DBECFB')),
                              //                 //             if (list.isExpanded!)
                              //                 //               Column(
                              //                 //                 children: [
                              //                 //                   Padding(
                              //                 //                     padding: EdgeInsets
                              //                 //                         .only(
                              //                 //                             left:
                              //                 //                                 10,
                              //                 //                             right:
                              //                 //                                 10),
                              //                 //                     child: Row(
                              //                 //                       mainAxisAlignment:
                              //                 //                           MainAxisAlignment
                              //                 //                               .spaceBetween,
                              //                 //                       children: [
                              //                 //                         Text(
                              //                 //                             'Distance'),
                              //                 //                         SizedBox(
                              //                 //                           width:
                              //                 //                               10,
                              //                 //                         ),
                              //                 //                         Text(
                              //                 //                             '${list.distanceKm} Km'),
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   SizedBox(
                              //                 //                       height: 10),
                              //                 //                   Padding(
                              //                 //                     padding: EdgeInsets
                              //                 //                         .symmetric(
                              //                 //                             horizontal:
                              //                 //                                 10),
                              //                 //                     child: Row(
                              //                 //                       mainAxisAlignment:
                              //                 //                           MainAxisAlignment
                              //                 //                               .spaceBetween,
                              //                 //                       children: [
                              //                 //                         Text(
                              //                 //                             'Quantity'),
                              //                 //                         Row(
                              //                 //                           children: [
                              //                 //                             SizedBox(
                              //                 //                               width:
                              //                 //                                   70,
                              //                 //                               child:
                              //                 //                                   TextFormField(
                              //                 //                                 textAlign: TextAlign.center,
                              //                 //                                 initialValue: '${list.baseUomQuantity}',
                              //                 //                                 decoration: InputDecoration(
                              //                 //                                   contentPadding: EdgeInsets.all(0),
                              //                 //                                   isDense: true,
                              //                 //                                   labelStyle: TextStyle(color: hexToColor('#FF0000')),
                              //                 //                                   enabledBorder: UnderlineInputBorder(
                              //                 //                                     borderSide: BorderSide(color: hexToColor('#DBECFB')),
                              //                 //                                   ),
                              //                 //                                 ),
                              //                 //                               ),
                              //                 //                             ),
                              //                 //                             KText(
                              //                 //                               text: list.baseUom != null
                              //                 //                                   ? '${list.baseUom}'
                              //                 //                                   : '',
                              //                 //                               fontSize:
                              //                 //                                   14,
                              //                 //                             )
                              //                 //                           ],
                              //                 //                         ),
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   SizedBox(
                              //                 //                       height: 10),
                              //                 //                   Padding(
                              //                 //                     padding: EdgeInsets
                              //                 //                         .symmetric(
                              //                 //                             horizontal:
                              //                 //                                 10),
                              //                 //                     child: Row(
                              //                 //                       mainAxisAlignment:
                              //                 //                           MainAxisAlignment
                              //                 //                               .spaceBetween,
                              //                 //                       children: [
                              //                 //                         Text(
                              //                 //                             'Weight'),
                              //                 //                         Row(
                              //                 //                           children: [
                              //                 //                             SizedBox(
                              //                 //                               width:
                              //                 //                                   70,
                              //                 //                               child:
                              //                 //                                   TextFormField(
                              //                 //                                 textAlign: TextAlign.center,
                              //                 //                                 initialValue: '${list.weightKg}',
                              //                 //                                 decoration: InputDecoration(
                              //                 //                                   contentPadding: EdgeInsets.all(0),
                              //                 //                                   isDense: true,
                              //                 //                                   labelStyle: TextStyle(color: hexToColor('#FF0000')),
                              //                 //                                   enabledBorder: UnderlineInputBorder(
                              //                 //                                     borderSide: BorderSide(color: hexToColor('#DBECFB')),
                              //                 //                                   ),
                              //                 //                                 ),
                              //                 //                               ),
                              //                 //                             ),
                              //                 //                             KText(
                              //                 //                               text:
                              //                 //                                   'Kg',
                              //                 //                               fontSize:
                              //                 //                                   14,
                              //                 //                             ),
                              //                 //                           ],
                              //                 //                         )
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   Divider(
                              //                 //                       color: hexToColor(
                              //                 //                           '#DBECFB')),
                              //                 //                   Padding(
                              //                 //                     padding:
                              //                 //                         EdgeInsets
                              //                 //                             .only(
                              //                 //                       left: 10,
                              //                 //                       right: 10,
                              //                 //                       top: 10,
                              //                 //                     ),
                              //                 //                     child: Row(
                              //                 //                       children: [
                              //                 //                         Row(
                              //                 //                           mainAxisAlignment:
                              //                 //                               MainAxisAlignment.spaceBetween,
                              //                 //                           children: [
                              //                 //                             KText(
                              //                 //                               text:
                              //                 //                                   'Transportation Fee',
                              //                 //                               fontSize:
                              //                 //                                   14,
                              //                 //                               color:
                              //                 //                                   hexToColor('#41525A'),
                              //                 //                             ),
                              //                 //                             SizedBox(
                              //                 //                               width:
                              //                 //                                   10,
                              //                 //                             ),
                              //                 //                           ],
                              //                 //                         ),
                              //                 //                         Spacer(),
                              //                 //                         KText(
                              //                 //                           text:
                              //                 //                               'BDT  95,000',
                              //                 //                           fontSize:
                              //                 //                               14,
                              //                 //                           bold:
                              //                 //                               true,
                              //                 //                           color:
                              //                 //                               hexToColor(
                              //                 //                             '#41525A',
                              //                 //                           ),
                              //                 //                         ),
                              //                 //                         // KText(
                              //                 //                         //   text: 'Kg',
                              //                 //                         //   fontSize: 14,
                              //                 //                         // )
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   ),
                              //                 //                   // SizedBox(
                              //                 //                   //   height: 16,
                              //                 //                   // ),
                              //                 //                   // Padding(
                              //                 //                   //   padding:
                              //                 //                   //         EdgeInsets.only(left: 10, right: 10),
                              //                 //                   //   child: Row(
                              //                 //                   //     mainAxisAlignment:
                              //                 //                   //         MainAxisAlignment.spaceBetween,
                              //                 //                   //     children: [
                              //                 //                   //       Row(
                              //                 //                   //         mainAxisAlignment:
                              //                 //                   //             MainAxisAlignment.spaceBetween,
                              //                 //                   //         children: [
                              //                 //                   //           Text('26345634'),
                              //                 //                   //           SizedBox(
                              //                 //                   //             width: 10,
                              //                 //                   //           ),
                              //                 //                   //           Text('-'),
                              //                 //                   //           SizedBox(
                              //                 //                   //             width: 10,
                              //                 //                   //           ),
                              //                 //                   //           Text('21741273'),
                              //                 //                   //         ],
                              //                 //                   //       ),
                              //                 //                   //       Text('5 Kg'),
                              //                 //                   //     ],
                              //                 //                   //   ),
                              //                 //                   // ),
                              //                 //                 ],
                              //                 //               ),
                              //                 //             Padding(
                              //                 //               padding:
                              //                 //                   EdgeInsets.only(
                              //                 //                       left: 10),
                              //                 //               child: Row(
                              //                 //                 children: [
                              //                 //                   // Container(
                              //                 //                   //     height: 1, width: 50, color: hexToColor('#DBECFB')),
                              //                 //                   // SizedBox(
                              //                 //                   //   width: 50,
                              //                 //                   // ),
                              //                 //                   // Container(
                              //                 //                   //     height: 1, width: 60, color: hexToColor('#DBECFB')),
                              //                 //                   // SizedBox(
                              //                 //                   //   width: 120,
                              //                 //                   // ),
                              //                 //                   // Container(
                              //                 //                   //     height: 1, width: 50, color: hexToColor('#DBECFB'))
                              //                 //                 ],
                              //                 //               ),
                              //                 //             ),
                              //                 //             if (list.isExpanded!)
                              //                 //               Divider(
                              //                 //                   color: hexToColor(
                              //                 //                       '#DBECFB')),
                              //                 //             list.isExpanded!
                              //                 //                 ? Padding(
                              //                 //                     padding:
                              //                 //                         EdgeInsets
                              //                 //                             .only(
                              //                 //                       left: 10,
                              //                 //                       right: 10,
                              //                 //                       bottom: 6,
                              //                 //                     ),
                              //                 //                     child: Row(
                              //                 //                       mainAxisAlignment:
                              //                 //                           MainAxisAlignment
                              //                 //                               .spaceBetween,
                              //                 //                       children: [
                              //                 //                         Column(
                              //                 //                           crossAxisAlignment:
                              //                 //                               CrossAxisAlignment.start,
                              //                 //                           children: [
                              //                 //                             Row(
                              //                 //                               children: [
                              //                 //                                 KText(
                              //                 //                                   text: 'Goods Receiver ',
                              //                 //                                   fontSize: 13,
                              //                 //                                   color: hexToColor('#80939D'),
                              //                 //                                 ),
                              //                 //                                 RenderSvg(
                              //                 //                                   path: 'icon_search_elements',
                              //                 //                                   width: 25,
                              //                 //                                   color: hexToColor('#66A1D9'),
                              //                 //                                 ),
                              //                 //                               ],
                              //                 //                             ),
                              //                 //                             KText(
                              //                 //                               text: item.receiverFullname != null
                              //                 //                                   ? '${item.receiverAgencyName} '
                              //                 //                                   : '',
                              //                 //                               fontSize:
                              //                 //                                   14,
                              //                 //                               color:
                              //                 //                                   hexToColor('#515D64'),
                              //                 //                             ),
                              //                 //                           ],
                              //                 //                         ),
                              //                 //                         Column(
                              //                 //                           crossAxisAlignment:
                              //                 //                               CrossAxisAlignment.end,
                              //                 //                           children: [
                              //                 //                             Row(
                              //                 //                               children: [
                              //                 //                                 KText(
                              //                 //                                   text: 'Goods Inspector ',
                              //                 //                                   fontSize: 13,
                              //                 //                                   color: hexToColor('#80939D'),
                              //                 //                                 ),
                              //                 //                                 RenderSvg(
                              //                 //                                   path: 'icon_search_elements',
                              //                 //                                   width: 25,
                              //                 //                                   color: hexToColor('#66A1D9'),
                              //                 //                                 ),
                              //                 //                               ],
                              //                 //                             ),
                              //                 //                             KText(
                              //                 //                               text: item.receiverFullname != null
                              //                 //                                   ? '${item.inspectorAtLoadingPointFullname} '
                              //                 //                                   : '',
                              //                 //                               fontSize:
                              //                 //                                   15,
                              //                 //                               color:
                              //                 //                                   hexToColor('#515D64'),
                              //                 //                             ),
                              //                 //                           ],
                              //                 //                         ),
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   )
                              //                 //                 : Padding(
                              //                 //                     padding:
                              //                 //                         EdgeInsets
                              //                 //                             .only(
                              //                 //                       left: 10,
                              //                 //                       right: 10,
                              //                 //                       bottom: 6,
                              //                 //                     ),
                              //                 //                     child: Row(
                              //                 //                       mainAxisAlignment:
                              //                 //                           MainAxisAlignment
                              //                 //                               .spaceBetween,
                              //                 //                       children: [
                              //                 //                         Text(
                              //                 //                             'Quantity'),
                              //                 //                         Row(
                              //                 //                           children: [
                              //                 //                             Text(
                              //                 //                                 '${list.baseUomQuantity} '),
                              //                 //                             Text(list.baseUom != null
                              //                 //                                 ? '${list.baseUom}'
                              //                 //                                 : ''),
                              //                 //                           ],
                              //                 //                         ),
                              //                 //                         //   '${list.baseUomQuantity!.toInt()} ${list.baseUom}'),
                              //                 //                       ],
                              //                 //                     ),
                              //                 //                   ),
                              //                 //           ],
                              //                 //         ),
                              //                 //       );
                              //                 //     },
                              //                 //   ),

                              //                 SizedBox(height: 15),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(vertical: 15),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius:
                              //         BorderRadiusDirectional.vertical(
                              //       bottom: Radius.circular(4),
                              //     ),
                              //     boxShadow: item.isExpanded!
                              //         ? [
                              //             BoxShadow(
                              //               color: Colors.grey.withOpacity(.3),
                              //               spreadRadius: 1,
                              //               blurRadius: 2,
                              //               offset: Offset(0, -2),
                              //             ),
                              //             BoxShadow(
                              //               color: Colors.transparent,
                              //               offset: Offset(0, 0),
                              //             ),
                              //             BoxShadow(
                              //               color: Colors.grey.shade300,
                              //               offset: Offset(0, 0),
                              //             )
                              //           ]
                              //         : [],
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       if (item.isExpanded!)
                              //         Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               horizontal: 15),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               KText(
                              //                 text: 'Remarks',
                              //                 color: hexToColor('#80939D'),
                              //               ),
                              //               TextField(
                              //                 decoration: InputDecoration(
                              //                   hintText: 'Remarks here...',
                              //                   hintStyle: TextStyle(
                              //                     color: hexToColor('#D9D9D9'),
                              //                     fontSize: 14,
                              //                   ),
                              //                   isDense: true,
                              //                 ),
                              //               ),
                              //               SizedBox(height: 20)
                              //             ],
                              //           ),
                              //         ),
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(width: 20),
                              //           ElevatedButton(
                              //             style: ButtonStyle(
                              //               minimumSize: MaterialStateProperty
                              //                   .all<Size?>(Size(109, 35)),
                              //               backgroundColor:
                              //                   MaterialStateProperty.all<
                              //                           Color>(
                              //                       hexToColor('#FF9191')),
                              //               visualDensity:
                              //                   VisualDensity(horizontal: 2),
                              //               shape: MaterialStateProperty.all<
                              //                   RoundedRectangleBorder>(
                              //                 RoundedRectangleBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(5.0),
                              //                   // side: BorderSide(color: Colors.red),
                              //                 ),
                              //               ),
                              //             ),
                              //             onPressed: () {
                              //               myApprovalDashboardC
                              //                   .postTransportOrderApprove(
                              //                 id: item.id,
                              //                 status: 'Rejected',
                              //               );
                              //             },
                              //             child: Text(
                              //               'Reject',
                              //               style: TextStyle(
                              //                 fontFamily: 'Manrope',
                              //                 fontSize: 16.0,
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //           ),

                              //           ElevatedButton(
                              //             style: ButtonStyle(
                              //               minimumSize: MaterialStateProperty
                              //                   .all<Size?>(Size(109, 35)),
                              //               backgroundColor:
                              //                   MaterialStateProperty.all<
                              //                           Color>(
                              //                       hexToColor('#49CDAB')),
                              //               visualDensity:
                              //                   VisualDensity(horizontal: 2),
                              //               shape: MaterialStateProperty.all<
                              //                   RoundedRectangleBorder>(
                              //                 RoundedRectangleBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(5.0),
                              //                   // side: BorderSide(color: Colors.red),
                              //                 ),
                              //               ),
                              //               overlayColor: MaterialStateProperty
                              //                   .all<Color>(Colors.white
                              //                       .withOpacity(.2)),
                              //             ),
                              //             onPressed: () {
                              //               myApprovalDashboardC
                              //                   .postTransportOrderApprove(
                              //                 id: item.id,
                              //                 status: 'Approved',
                              //               );
                              //             },
                              //             child: Text(
                              //               'Approve',
                              //               style: TextStyle(
                              //                 fontFamily: 'Manrope',
                              //                 fontSize: 16.0,
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //           ),
                              // InkWell(
                              //   onTap: () {
                              //     // myApprovalDashboardC
                              //     //     .postTransportOrderApprove(
                              //     //         status: 'Rejected',
                              //     //         transportOrderNo: '');
                              //   },
                              //   child: Container(
                              //     height: 34,
                              //     width: 116,
                              //     decoration: BoxDecoration(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(8)),
                              //         color: hexToColor('#FF9191')),
                              //     child: Center(
                              //       child: KText(
                              //         text: 'Reject',
                              //         fontSize: 16,
                              //         color: Colors.white,
                              //         bold: true,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     // myApprovalDashboardC
                              //     //     .postTransportOrderApprove(
                              //     //   status: 'Approved',
                              //     //   transportOrderNo: '',
                              //     // );
                              //   },
                              //   child: Container(
                              //     height: 34,
                              //     width: 116,
                              //     decoration: BoxDecoration(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(8)),
                              //         color: hexToColor('#49CDAB')),
                              //     child: Center(
                              //       child: KText(
                              //         text: 'Approve',
                              //         fontSize: 16,
                              //         color: Colors.white,
                              //         bold: true,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              //           SizedBox(width: 20),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            /////////////////////////////////////////
            ///----------------------------/////////

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   child: Column(
            //     children: [
            //       SizedBox(height: 15),
            //       Row(
            //         children: [
            //           RenderSvg(path: 'icon_test'),
            //           SizedBox(width: 5),
            //           KText(
            //             text: 'Test Approval Requests',
            //             bold: true,
            //             fontSize: 14,
            //             color: hexToColor('#41525A'),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       DottedLine(
            //         lineThickness: 0.1,
            //         dashColor: Colors.black,
            //       ),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Container(
            //         width: Get.width,
            //         decoration: BoxDecoration(
            //           color: hexToColor('#F6FBFF'),
            //           borderRadius: BorderRadius.all(Radius.circular(5)),
            //           border: Border.all(
            //             color: hexToColor('#DBECFB'),
            //             width: 1,
            //           ),
            //         ),
            //         child: Column(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius:
            //                     BorderRadius.vertical(top: Radius.circular(4)),
            //                 boxShadow: uiC.isExpanded.value
            //                     ? [
            //                         BoxShadow(
            //                           color: Colors.grey.withOpacity(.3),
            //                           spreadRadius: 1,
            //                           blurRadius: 2,
            //                           offset: Offset(0, 2),
            //                         ),
            //                         BoxShadow(
            //                           color: Colors.transparent,
            //                           offset: Offset(0, 0),
            //                         ),
            //                         BoxShadow(
            //                           color: Colors.grey.shade300,
            //                           offset: Offset(0, 0),
            //                         )
            //                       ]
            //                     : [],
            //               ),
            //               child: Column(
            //                 children: [
            //                   Padding(
            //                     padding: EdgeInsets.only(
            //                         left: 15, right: 15, top: 10),
            //                     child: Row(
            //                       children: [
            //                         Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             KText(
            //                               text: 'Transport Order ',
            //                               color: hexToColor('#80939D'),
            //                             ),

            //                             KText(
            //                               text: 'S2SD83SD8 ',
            //                               bold: true,
            //                               fontSize: 13,
            //                               color: hexToColor('#515D64'),
            //                             ),
            //                             SizedBox(
            //                               width: 35,
            //                             ),
            //                             // Icon(
            //                             //   uiC.isExpanded.value
            //                             //       ? EvaIcons.arrowIosUpwardOutline
            //                             //       : EvaIcons.arrowIosDownwardOutline,
            //                             //   color: hexToColor('#80939D'),
            //                             // ),
            //                           ],
            //                         ),
            //                         Spacer(),
            //                         Column(
            //                           children: [
            //                             Padding(
            //                               padding: EdgeInsets.only(left: 50),
            //                               child: KText(
            //                                 text: 'Date',
            //                                 fontSize: 13,
            //                                 color: hexToColor('#80939D'),
            //                               ),
            //                             ),

            //                             KText(
            //                               text: '01 Sep 2022',
            //                               bold: true,
            //                               fontSize: 13,
            //                               color: hexToColor('#515D64'),
            //                             ),
            //                             SizedBox(
            //                               width: 35,
            //                             ),
            //                             // Icon(
            //                             //   uiC.isExpanded.value
            //                             //       ? EvaIcons.arrowIosUpwardOutline
            //                             //       : EvaIcons.arrowIosDownwardOutline,
            //                             //   color: hexToColor('#80939D'),
            //                             // ),
            //                           ],
            //                         ),
            //                         SizedBox(width: 8),
            //                         GestureDetector(
            //                           onTap: () {
            //                             uiC.isExpanded.toggle();
            //                           },
            //                           child: Icon(
            //                             uiC.isExpanded.value
            //                                 ? EvaIcons.arrowIosUpwardOutline
            //                                 : EvaIcons.arrowIosDownwardOutline,
            //                             color: hexToColor('#80939D'),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   Divider(
            //                     color: hexToColor('#DBECFB'),
            //                     thickness: 1,
            //                   ),
            //                   Container(
            //                     padding: EdgeInsets.only(
            //                         left: 15, right: 15, bottom: 10),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           children: [
            //                             KText(
            //                               text: 'Transport Orderer',
            //                               bold: true,
            //                               fontSize: 13,
            //                               color: hexToColor('#80939D'),
            //                             ),
            //                             Spacer(),
            //                             KText(
            //                               text: 'Arif Hossain',
            //                               bold: true,
            //                               fontSize: 13,
            //                               color: hexToColor('#80939D'),
            //                             ),
            //                             SizedBox(width: 5),
            //                             Container(
            //                               height: 38,
            //                               width: 38,
            //                               decoration: BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius:
            //                                     BorderRadius.circular(50),
            //                                 boxShadow: [
            //                                   BoxShadow(
            //                                     color:
            //                                         Colors.grey.withOpacity(.5),
            //                                     spreadRadius: 1,
            //                                     blurRadius: 1,
            //                                     offset: Offset(0, 0),
            //                                   ),
            //                                 ],
            //                               ),
            //                               child: Padding(
            //                                 padding: EdgeInsets.all(1.0),
            //                                 child: ClipRRect(
            //                                   borderRadius:
            //                                       BorderRadius.circular(50),
            //                                   child: Image.asset(
            //                                     '${Constants.imgPath}/bill.jpg',
            //                                     width: 37,
            //                                     height: 37,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             if (!uiC.isExpanded.value)
            //               Divider(
            //                 color: hexToColor('#DBECFB'),
            //                 thickness: 1,
            //                 height: 1,
            //               ),
            //             if (uiC.isExpanded.value)
            //               Container(
            //                 // height: 100,
            //                 width: Get.width,
            //                 decoration: BoxDecoration(
            //                     // color: hexToColor('#DBECFB'),
            //                     ),
            //                 child: Column(
            //                   children: [
            //                     SizedBox(height: 10),
            //                     Column(
            //                       children: [
            //                         Padding(
            //                           padding:
            //                               EdgeInsets.only(left: 15, right: 15),
            //                           child: Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               KText(
            //                                 text: 'Transport Agency',
            //                                 fontSize: 13,
            //                                 color: hexToColor('#80939D'),
            //                               ),
            //                               KText(
            //                                 text: 'Delta Traport Solution ',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               KText(
            //                                 text: 'Receiving Party ',
            //                                 fontSize: 13,
            //                                 color: hexToColor('#80939D'),
            //                               ),
            //                               KText(
            //                                 text: 'Jessore Trade Agency',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               KText(
            //                                 text:
            //                                     'Source Location (Loading point) ',
            //                                 fontSize: 13,
            //                                 color: hexToColor('#80939D'),
            //                               ),
            //                               KText(
            //                                 text: 'BMTF Factory, Gazipur ',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               KText(
            //                                 text:
            //                                     'Destination Location (Unloading Point) ',
            //                                 fontSize: 13,
            //                                 color: hexToColor('#80939D'),
            //                               ),
            //                               KText(
            //                                 text: 'Jessore Sadar, Jessore',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Icon(
            //                                     Icons
            //                                         .check_box_outline_blank_sharp,
            //                                     color: hexToColor('#84BEF3'),
            //                                   ),
            //                                   KText(
            //                                     text: 'Single Receiving Person',
            //                                     fontSize: 13,
            //                                     color: hexToColor('#80939D'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Container(
            //                                     height: 38,
            //                                     width: 38,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(50),
            //                                     ),
            //                                     child: Padding(
            //                                       padding: EdgeInsets.all(1.0),
            //                                       child: ClipRRect(
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                                 50),
            //                                         child: Image.asset(
            //                                           '${Constants.imgPath}/bill.jpg',
            //                                           width: 37,
            //                                           height: 37,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   SizedBox(
            //                                     width: 5,
            //                                   ),
            //                                   KText(
            //                                     text: 'Jafor Uddin Ahmed',
            //                                     fontSize: 14,
            //                                     color: hexToColor('#515D64'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Icon(
            //                                     Icons
            //                                         .check_box_outline_blank_sharp,
            //                                     color: hexToColor('#84BEF3'),
            //                                   ),
            //                                   Expanded(
            //                                     child: KText(
            //                                       text:
            //                                           'Single Goods Inspector at the Drop Location',
            //                                       fontSize: 13,
            //                                       color: hexToColor('#80939D'),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Container(
            //                                     height: 38,
            //                                     width: 38,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(50),
            //                                     ),
            //                                     child: Padding(
            //                                       padding: EdgeInsets.all(1.0),
            //                                       child: ClipRRect(
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                                 50),
            //                                         child: Image.asset(
            //                                           '${Constants.imgPath}/bill.jpg',
            //                                           width: 37,
            //                                           height: 37,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   SizedBox(
            //                                     width: 5,
            //                                   ),
            //                                   KText(
            //                                     text: 'Jafor Uddin Ahmed',
            //                                     fontSize: 14,
            //                                     color: hexToColor('#515D64'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   KText(
            //                                     text:
            //                                         'Goods Inspector at the Loading Point',
            //                                     fontSize: 13,
            //                                     color: hexToColor('#80939D'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Container(
            //                                     height: 38,
            //                                     width: 38,
            //                                     decoration: BoxDecoration(
            //                                       color: Colors.white,
            //                                       borderRadius:
            //                                           BorderRadius.circular(50),
            //                                     ),
            //                                     child: Padding(
            //                                       padding: EdgeInsets.all(1.0),
            //                                       child: ClipRRect(
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                                 50),
            //                                         child: Image.asset(
            //                                           '${Constants.imgPath}/bill.jpg',
            //                                           width: 37,
            //                                           height: 37,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   SizedBox(
            //                                     width: 5,
            //                                   ),
            //                                   KText(
            //                                     text: 'Tamal Sarkar',
            //                                     fontSize: 14,
            //                                     color: hexToColor('#515D64'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Icon(
            //                                     Icons
            //                                         .check_box_outline_blank_sharp,
            //                                     color: hexToColor('#84BEF3'),
            //                                   ),
            //                                   KText(
            //                                     text: 'Single Drop Location',
            //                                     fontSize: 13,
            //                                     color: hexToColor('#80939D'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               KText(
            //                                 text: '(Destination Location Only)',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                               SizedBox(
            //                                 height: 10,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   Icon(
            //                                     Icons
            //                                         .check_box_outline_blank_sharp,
            //                                     color: hexToColor('#84BEF3'),
            //                                   ),
            //                                   KText(
            //                                     text: 'Prescribe Travel Path',
            //                                     fontSize: 13,
            //                                     color: hexToColor('#80939D'),
            //                                   ),
            //                                 ],
            //                               ),
            //                               KText(
            //                                 text:
            //                                     'BMTF Factory --> Jessore Sadar',
            //                                 fontSize: 14,
            //                                 color: hexToColor('#515D64'),
            //                               ),
            //                               Divider(
            //                                 color: hexToColor('#80939D'),
            //                                 thickness: 1,
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         SizedBox(height: 10),
            //                         Column(
            //                           children: [
            //                             Padding(
            //                               padding: EdgeInsets.only(
            //                                 left: 15,
            //                                 right: 15,
            //                               ),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment.start,
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       KText(
            //                                         text: 'Total Quantity ',
            //                                         fontSize: 13,
            //                                         color:
            //                                             hexToColor('#515D64'),
            //                                       ),
            //                                       KText(
            //                                         text: '1245',
            //                                         fontSize: 13,
            //                                         color:
            //                                             hexToColor('#80939D'),
            //                                       ),
            //                                       SizedBox(
            //                                         width: 35,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.end,
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment.end,
            //                                     children: [
            //                                       KText(
            //                                         text:
            //                                             'Gross Transportation Fee',
            //                                         fontSize: 13,
            //                                         color:
            //                                             hexToColor('#515D64'),
            //                                       ),
            //                                       KText(
            //                                         text: '253,265',
            //                                         fontSize: 13,
            //                                         color:
            //                                             hexToColor('#80939D'),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             ListView.builder(
            //                               shrinkWrap: true,
            //                               primary: false,
            //                               itemCount: 1,
            //                               itemBuilder: (BuildContext context,
            //                                   int index) {
            //                                 return Obx(
            //                                   () => GestureDetector(
            //                                     onTap: () => materialC
            //                                         .isExpanded
            //                                         .toggle(),
            //                                     child: Container(
            //                                       margin: EdgeInsets.only(
            //                                         top: 12,
            //                                         left: 10,
            //                                         right: 10,
            //                                       ),
            //                                       decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           borderRadius:
            //                                               BorderRadius.circular(
            //                                                   5),
            //                                           border: Border.all(
            //                                               width: 1.5,
            //                                               color: hexToColor(
            //                                                   '#DBECFB'))),
            //                                       child: Column(
            //                                         children: [
            //                                           Container(
            //                                             //width: Get.width,
            //                                             height: 40,
            //                                             decoration:
            //                                                 BoxDecoration(
            //                                                     // border: Border.all(color: Colors.green),
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .only(
            //                                                       topLeft: Radius
            //                                                           .circular(
            //                                                               5),
            //                                                       topRight: Radius
            //                                                           .circular(
            //                                                               5),
            //                                                     ),
            //                                                     // border: Border.all(),
            //                                                     color: hexToColor(
            //                                                         '#DBECFB')),
            //                                             child: Row(
            //                                               children: [
            //                                                 SizedBox(
            //                                                   width: 12,
            //                                                 ),
            //                                                 Icon(
            //                                                   materialC
            //                                                           .isExpanded
            //                                                           .value
            //                                                       ? EvaIcons
            //                                                           .arrowIosUpwardOutline
            //                                                       : EvaIcons
            //                                                           .arrowIosDownwardOutline,
            //                                                   color: hexToColor(
            //                                                       '#80939D'),
            //                                                 ),
            //                                                 KText(
            //                                                   text:
            //                                                       'Item Name 01',
            //                                                   bold: true,
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           ),
            //                                           SizedBox(
            //                                             height: 12,
            //                                           ),
            //                                           Padding(
            //                                             padding:
            //                                                 EdgeInsets.only(
            //                                                     left: 10,
            //                                                     right: 10),
            //                                             child: Row(
            //                                               mainAxisAlignment:
            //                                                   MainAxisAlignment
            //                                                       .spaceBetween,
            //                                               children: [
            //                                                 Column(
            //                                                   crossAxisAlignment:
            //                                                       CrossAxisAlignment
            //                                                           .start,
            //                                                   children: [
            //                                                     Row(
            //                                                       children: [
            //                                                         KText(
            //                                                           text:
            //                                                               'Code ',
            //                                                           fontSize:
            //                                                               13,
            //                                                           color: hexToColor(
            //                                                               '#515D64'),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                     materialC
            //                                                             .isExpanded
            //                                                             .value
            //                                                         ? Padding(
            //                                                             padding:
            //                                                                 EdgeInsets.only(
            //                                                               top:
            //                                                                   0,
            //                                                             ),
            //                                                             child:
            //                                                                 KText(
            //                                                               text:
            //                                                                   'A213456',
            //                                                               color:
            //                                                                   hexToColor('#515D64'),
            //                                                               fontSize:
            //                                                                   14,
            //                                                             ),
            //                                                           )
            //                                                         : Container(
            //                                                             margin:
            //                                                                 EdgeInsets.all(0),
            //                                                             padding:
            //                                                                 EdgeInsets.all(0),
            //                                                           )
            //                                                   ],
            //                                                 ),
            //                                                 Column(
            //                                                   crossAxisAlignment:
            //                                                       CrossAxisAlignment
            //                                                           .end,
            //                                                   children: [
            //                                                     Row(
            //                                                       children: [
            //                                                         KText(
            //                                                           text:
            //                                                               'Drop Location ',
            //                                                           fontSize:
            //                                                               13,
            //                                                           color: hexToColor(
            //                                                               '#515D64'),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                     materialC
            //                                                             .isExpanded
            //                                                             .value
            //                                                         ? Padding(
            //                                                             padding:
            //                                                                 EdgeInsets.only(
            //                                                               top:
            //                                                                   0,
            //                                                             ),
            //                                                             child:
            //                                                                 KText(
            //                                                               text:
            //                                                                   'Location 01',
            //                                                               color:
            //                                                                   hexToColor('#515D64'),
            //                                                               fontSize:
            //                                                                   14,
            //                                                             ),
            //                                                           )
            //                                                         : Container(
            //                                                             margin:
            //                                                                 EdgeInsets.all(0),
            //                                                             padding:
            //                                                                 EdgeInsets.all(0),
            //                                                           )
            //                                                   ],
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           ),
            //                                           // SizedBox(
            //                                           //   height: 5,
            //                                           // ),
            //                                           materialC.isExpanded.value
            //                                               ? Column(
            //                                                   children: [
            //                                                     Divider(
            //                                                         color: hexToColor(
            //                                                             '#DBECFB')),
            //                                                     Padding(
            //                                                       padding: EdgeInsets
            //                                                           .only(
            //                                                               left:
            //                                                                   10,
            //                                                               right:
            //                                                                   10),
            //                                                       child: Row(
            //                                                         mainAxisAlignment:
            //                                                             MainAxisAlignment
            //                                                                 .spaceBetween,
            //                                                         children: [
            //                                                           Row(
            //                                                             mainAxisAlignment:
            //                                                                 MainAxisAlignment.spaceBetween,
            //                                                             children: [
            //                                                               Text(
            //                                                                   'Distance'),
            //                                                               SizedBox(
            //                                                                 width:
            //                                                                     10,
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           Text(
            //                                                               '50 Kg'),
            //                                                         ],
            //                                                       ),
            //                                                     ),
            //                                                     Padding(
            //                                                       padding:
            //                                                           EdgeInsets
            //                                                               .only(
            //                                                         left: 10,
            //                                                         right: 10,
            //                                                         top: 10,
            //                                                       ),
            //                                                       child: Row(
            //                                                         children: [
            //                                                           Row(
            //                                                             mainAxisAlignment:
            //                                                                 MainAxisAlignment.spaceBetween,
            //                                                             children: [
            //                                                               Text(
            //                                                                   'Quantity'),
            //                                                               SizedBox(
            //                                                                 width:
            //                                                                     10,
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           Spacer(),
            //                                                           SizedBox(
            //                                                             width:
            //                                                                 70,
            //                                                             child:
            //                                                                 TextField(
            //                                                               decoration:
            //                                                                   InputDecoration(
            //                                                                 contentPadding:
            //                                                                     EdgeInsets.all(0),
            //                                                                 isDense:
            //                                                                     true,
            //                                                                 hintText:
            //                                                                     '649',
            //                                                                 labelStyle:
            //                                                                     TextStyle(color: hexToColor('#FF0000')),
            //                                                                 enabledBorder:
            //                                                                     UnderlineInputBorder(
            //                                                                   borderSide: BorderSide(color: hexToColor('#DBECFB')),
            //                                                                 ),
            //                                                               ),
            //                                                             ),
            //                                                           ),
            //                                                           KText(
            //                                                             text:
            //                                                                 'Pcs',
            //                                                             fontSize:
            //                                                                 14,
            //                                                           )
            //                                                         ],
            //                                                       ),
            //                                                     ),

            //                                                     Padding(
            //                                                       padding:
            //                                                           EdgeInsets
            //                                                               .only(
            //                                                         left: 10,
            //                                                         right: 10,
            //                                                         top: 10,
            //                                                       ),
            //                                                       child: Row(
            //                                                         children: [
            //                                                           Row(
            //                                                             mainAxisAlignment:
            //                                                                 MainAxisAlignment.spaceBetween,
            //                                                             children: [
            //                                                               Text(
            //                                                                   'Weight'),
            //                                                               SizedBox(
            //                                                                 width:
            //                                                                     10,
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           Spacer(),
            //                                                           SizedBox(
            //                                                             width:
            //                                                                 70,
            //                                                             child:
            //                                                                 TextField(
            //                                                               decoration:
            //                                                                   InputDecoration(
            //                                                                 contentPadding:
            //                                                                     EdgeInsets.all(0),
            //                                                                 isDense:
            //                                                                     true,
            //                                                                 hintText:
            //                                                                     '649',
            //                                                                 labelStyle:
            //                                                                     TextStyle(color: hexToColor('#FF0000')),
            //                                                                 enabledBorder:
            //                                                                     UnderlineInputBorder(
            //                                                                   borderSide: BorderSide(color: hexToColor('#DBECFB')),
            //                                                                 ),
            //                                                               ),
            //                                                             ),
            //                                                           ),
            //                                                           KText(
            //                                                             text:
            //                                                                 'Kg',
            //                                                             fontSize:
            //                                                                 14,
            //                                                           )
            //                                                         ],
            //                                                       ),
            //                                                     ),
            //                                                     Divider(
            //                                                         color: hexToColor(
            //                                                             '#DBECFB')),
            //                                                     Padding(
            //                                                       padding:
            //                                                           EdgeInsets
            //                                                               .only(
            //                                                         left: 10,
            //                                                         right: 10,
            //                                                         top: 10,
            //                                                       ),
            //                                                       child: Row(
            //                                                         children: [
            //                                                           Row(
            //                                                             mainAxisAlignment:
            //                                                                 MainAxisAlignment.spaceBetween,
            //                                                             children: [
            //                                                               KText(
            //                                                                 text:
            //                                                                     'Transportation Fee',
            //                                                                 fontSize:
            //                                                                     14,
            //                                                                 color:
            //                                                                     hexToColor('#41525A'),
            //                                                               ),
            //                                                               SizedBox(
            //                                                                 width:
            //                                                                     10,
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           Spacer(),
            //                                                           KText(
            //                                                             text:
            //                                                                 'BDT  95,000',
            //                                                             fontSize:
            //                                                                 14,
            //                                                             bold:
            //                                                                 true,
            //                                                             color:
            //                                                                 hexToColor(
            //                                                               '#41525A',
            //                                                             ),
            //                                                           ),
            //                                                           // KText(
            //                                                           //   text: 'Kg',
            //                                                           //   fontSize: 14,
            //                                                           // )
            //                                                         ],
            //                                                       ),
            //                                                     ),
            //                                                     // SizedBox(
            //                                                     //   height: 16,
            //                                                     // ),
            //                                                     // Padding(
            //                                                     //   padding:
            //                                                     //         EdgeInsets.only(left: 10, right: 10),
            //                                                     //   child: Row(
            //                                                     //     mainAxisAlignment:
            //                                                     //         MainAxisAlignment.spaceBetween,
            //                                                     //     children: [
            //                                                     //       Row(
            //                                                     //         mainAxisAlignment:
            //                                                     //             MainAxisAlignment.spaceBetween,
            //                                                     //         children: [
            //                                                     //           Text('26345634'),
            //                                                     //           SizedBox(
            //                                                     //             width: 10,
            //                                                     //           ),
            //                                                     //           Text('-'),
            //                                                     //           SizedBox(
            //                                                     //             width: 10,
            //                                                     //           ),
            //                                                     //           Text('21741273'),
            //                                                     //         ],
            //                                                     //       ),
            //                                                     //       Text('5 Kg'),
            //                                                     //     ],
            //                                                     //   ),
            //                                                     // ),
            //                                                   ],
            //                                                 )
            //                                               : Column(
            //                                                   children: [
            //                                                     Padding(
            //                                                       padding:
            //                                                           EdgeInsets
            //                                                               .only(
            //                                                         left: 10,
            //                                                         right: 10,
            //                                                         top: 0,
            //                                                       ),
            //                                                       child: Row(
            //                                                         mainAxisAlignment:
            //                                                             MainAxisAlignment
            //                                                                 .spaceBetween,
            //                                                         children: [
            //                                                           Row(
            //                                                             mainAxisAlignment:
            //                                                                 MainAxisAlignment.spaceBetween,
            //                                                             children: [
            //                                                               KText(
            //                                                                 text:
            //                                                                     'A213456',
            //                                                                 color:
            //                                                                     hexToColor('#515D64'),
            //                                                                 fontSize:
            //                                                                     14,
            //                                                               )
            //                                                             ],
            //                                                           ),
            //                                                           SizedBox(
            //                                                             height:
            //                                                                 6,
            //                                                           ),
            //                                                           KText(
            //                                                             text:
            //                                                                 'Location 01',
            //                                                             color: hexToColor(
            //                                                                 '#515D64'),
            //                                                             fontSize:
            //                                                                 14,
            //                                                           )
            //                                                         ],
            //                                                       ),
            //                                                     ),
            //                                                   ],
            //                                                 ),
            //                                           Padding(
            //                                             padding:
            //                                                 EdgeInsets.only(
            //                                                     left: 10),
            //                                             child: Row(
            //                                               children: [
            //                                                 // Container(
            //                                                 //     height: 1, width: 50, color: hexToColor('#DBECFB')),
            //                                                 // SizedBox(
            //                                                 //   width: 50,
            //                                                 // ),
            //                                                 // Container(
            //                                                 //     height: 1, width: 60, color: hexToColor('#DBECFB')),
            //                                                 // SizedBox(
            //                                                 //   width: 120,
            //                                                 // ),
            //                                                 // Container(
            //                                                 //     height: 1, width: 50, color: hexToColor('#DBECFB'))
            //                                               ],
            //                                             ),
            //                                           ),
            //                                           Divider(
            //                                               color: hexToColor(
            //                                                   '#DBECFB')),
            //                                           materialC.isExpanded.value
            //                                               ? Padding(
            //                                                   padding:
            //                                                       EdgeInsets
            //                                                           .only(
            //                                                     left: 10,
            //                                                     right: 10,
            //                                                     bottom: 6,
            //                                                   ),
            //                                                   child: Row(
            //                                                     mainAxisAlignment:
            //                                                         MainAxisAlignment
            //                                                             .spaceBetween,
            //                                                     children: [
            //                                                       Column(
            //                                                         crossAxisAlignment:
            //                                                             CrossAxisAlignment
            //                                                                 .start,
            //                                                         children: [
            //                                                           Row(
            //                                                             children: [
            //                                                               KText(
            //                                                                 text:
            //                                                                     'Goods Receiver ',
            //                                                                 fontSize:
            //                                                                     13,
            //                                                                 color:
            //                                                                     hexToColor('#80939D'),
            //                                                               ),
            //                                                               RenderSvg(
            //                                                                 path:
            //                                                                     'icon_search_elements',
            //                                                                 width:
            //                                                                     25,
            //                                                                 color:
            //                                                                     hexToColor('#66A1D9'),
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           KText(
            //                                                             text:
            //                                                                 'Abdul Karim',
            //                                                             fontSize:
            //                                                                 14,
            //                                                             color: hexToColor(
            //                                                                 '#515D64'),
            //                                                           ),
            //                                                         ],
            //                                                       ),
            //                                                       Column(
            //                                                         crossAxisAlignment:
            //                                                             CrossAxisAlignment
            //                                                                 .end,
            //                                                         children: [
            //                                                           Row(
            //                                                             children: [
            //                                                               KText(
            //                                                                 text:
            //                                                                     'Goods Inspector ',
            //                                                                 fontSize:
            //                                                                     13,
            //                                                                 color:
            //                                                                     hexToColor('#80939D'),
            //                                                               ),
            //                                                               RenderSvg(
            //                                                                 path:
            //                                                                     'icon_search_elements',
            //                                                                 width:
            //                                                                     25,
            //                                                                 color:
            //                                                                     hexToColor('#66A1D9'),
            //                                                               ),
            //                                                             ],
            //                                                           ),
            //                                                           KText(
            //                                                             text:
            //                                                                 'Tamal Sarkar',
            //                                                             fontSize:
            //                                                                 15,
            //                                                             color: hexToColor(
            //                                                                 '#515D64'),
            //                                                           ),
            //                                                         ],
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                 )
            //                                               : Padding(
            //                                                   padding:
            //                                                       EdgeInsets
            //                                                           .only(
            //                                                     left: 10,
            //                                                     right: 10,
            //                                                     bottom: 6,
            //                                                   ),
            //                                                   child: Row(
            //                                                     mainAxisAlignment:
            //                                                         MainAxisAlignment
            //                                                             .spaceBetween,
            //                                                     children: [
            //                                                       Text(
            //                                                           'Quantity'),
            //                                                       Text(
            //                                                           '450 PCs'),
            //                                                     ],
            //                                                   ),
            //                                                 ),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 );
            //                               },
            //                             ),
            //                             SizedBox(height: 15),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             Container(
            //               padding: EdgeInsets.symmetric(vertical: 15),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadiusDirectional.vertical(
            //                   bottom: Radius.circular(4),
            //                 ),
            //                 boxShadow: uiC.isExpanded.value
            //                     ? [
            //                         BoxShadow(
            //                           color: Colors.grey.withOpacity(.3),
            //                           spreadRadius: 1,
            //                           blurRadius: 2,
            //                           offset: Offset(0, -2),
            //                         ),
            //                         BoxShadow(
            //                           color: Colors.transparent,
            //                           offset: Offset(0, 0),
            //                         ),
            //                         BoxShadow(
            //                           color: Colors.grey.shade300,
            //                           offset: Offset(0, 0),
            //                         )
            //                       ]
            //                     : [],
            //               ),
            //               child: Column(
            //                 children: [
            //                   if (uiC.isExpanded.value)
            //                     Padding(
            //                       padding: EdgeInsets.symmetric(horizontal: 15),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           KText(
            //                             text: 'Remarks',
            //                             color: hexToColor('#80939D'),
            //                           ),
            //                           TextField(
            //                             decoration: InputDecoration(
            //                               hintText: 'Remarks here...',
            //                               hintStyle: TextStyle(
            //                                 color: hexToColor('#D9D9D9'),
            //                                 fontSize: 14,
            //                               ),
            //                               isDense: true,
            //                             ),
            //                           ),
            //                           SizedBox(height: 20)
            //                         ],
            //                       ),
            //                     ),
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       SizedBox(width: 20),
            //                       InkWell(
            //                         onTap: () {
            //                           showTopSnackBar(
            //                             context,
            //                             CustomSnackBar.error(
            //                               message: 'Rejected',
            //                             ),
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 34,
            //                           width: 116,
            //                           decoration: BoxDecoration(
            //                               borderRadius: BorderRadius.all(
            //                                   Radius.circular(8)),
            //                               color: hexToColor('#FF9191')),
            //                           child: Center(
            //                             child: KText(
            //                               text: 'Reject',
            //                               fontSize: 16,
            //                               color: Colors.white,
            //                               bold: true,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       InkWell(
            //                         onTap: () {
            //                           push(AssignVehicleAndDriverPage());
            //                           Get.snackbar(
            //                             'Status',
            //                             'Approved',
            //                             colorText: AppTheme.black,
            //                             backgroundColor:
            //                                 AppTheme.appHomePageColor,
            //                             snackPosition: SnackPosition.BOTTOM,
            //                           );
            //                         },
            //                         child: Container(
            //                           height: 34,
            //                           width: 116,
            //                           decoration: BoxDecoration(
            //                               borderRadius: BorderRadius.all(
            //                                   Radius.circular(8)),
            //                               color: hexToColor('#49CDAB')),
            //                           child: Center(
            //                             child: KText(
            //                               text: 'Approve',
            //                               fontSize: 16,
            //                               color: Colors.white,
            //                               bold: true,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       SizedBox(width: 20),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 30,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class MyApprovalDashboardMyRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            //   height: 50,
            //   width: Get.width,
            //   // margin: EdgeInsets.symmetric(vertical: .5),

            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border(
            //       bottom: BorderSide(width: 2, color: Colors.grey.shade300),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap: () => back(),
            //         child: RenderSvg(
            //           path: 'icon_back',
            //           width: 13.0,
            //         ),
            //       ),
            //       KText(
            //         text: 'My Approval Dashboard',
            //         fontSize: 16,
            //         color: hexToColor('#41525A'),
            //         bold: true,
            //       ),
            //       SizedBox()
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 44,
            //   color: hexToColor('#EEF0F6'),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'trucklogo'),
                      SizedBox(width: 5),
                      KText(
                        text: 'Transport Requests',
                        bold: true,
                      ),
                      Spacer(),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: hexToColor('#FFECD6')),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: KText(
                            text: '03',
                            fontSize: 18,
                            bold: true,
                            color: hexToColor('#FFA133'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DottedLine(dashLength: 0.5),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#E1FFF7'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#C0F9EA'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#49CDAB'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Approved ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                      //     CustomTextFieldVegicle(
                      //       title: "Passport Exp Date",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#EDF7FF'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#DBECFB'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#84BEF3'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Pending ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                      //     CustomTextFieldVegicle(
                      //       title: "Passport Exp Date",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#FFE1E1'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#FFD1D1'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#FF9191'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Rejected ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_test'),
                      SizedBox(width: 5),
                      KText(
                        text: 'Test Approval Requests',
                        bold: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DottedLine(dashLength: 0.5),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#E1FFF7'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#C0F9EA'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#49CDAB'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Approved ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#FFE1E1'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#FFD1D1'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#FF9191'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Rejected ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
