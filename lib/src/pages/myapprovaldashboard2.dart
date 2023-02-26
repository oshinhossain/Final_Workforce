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
import '../helpers/route.dart';
import '../widgets/title_bar.dart';
import 'assign_vehicle_and_driver_page.dart';

class MyApprovalDashboard2 extends StatefulWidget with Base {
  @override
  State<MyApprovalDashboard2> createState() => _MyApprovalDashboard2();
}

class _MyApprovalDashboard2 extends State<MyApprovalDashboard2>
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
          TitleBar(title: '     My Approval Dashboard'),
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
    myApprovalDashboardC.getTransportOrder(transportOrderNo: '221024.00001');
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
                  height: 1450,
                  margin: EdgeInsets.only(top: 12),
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border:
                          Border.all(color: hexToColor('#DBECFB'), width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                KText(
                                  text: 'Transport Orderer',
                                  bold: true,
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                                Spacer(),
                                KText(
                                  text: 'Arif Hossain',
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
                          ],
                        ),
                      ),
                      Divider(
                        color: hexToColor('#DBECFB'),
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Transport Agency',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: 'Delta Traport Solution ',
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
                              text: 'Jessore Trade Agency',
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
                              text: 'Source Location (Loading point) ',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: 'BMTF Factory, Gazipur ',
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
                              text: 'Destination Location (Unloading Point) ',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: 'Jessore Sadar, Jessore',
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
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: hexToColor('#84BEF3'),
                                ),
                                KText(
                                  text: 'Single Receiving Person',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
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
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Jafor Uddin Ahmed',
                                  fontSize: 14,
                                  color: hexToColor('#515D64'),
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
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: hexToColor('#84BEF3'),
                                ),
                                KText(
                                  text:
                                      'Single Goods Inspector at the Drop Location',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
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
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Jafor Uddin Ahmed',
                                  fontSize: 14,
                                  color: hexToColor('#515D64'),
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
                                  text: 'Goods Inspector at the Loading Point',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
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
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Tamal Sarkar',
                                  fontSize: 14,
                                  color: hexToColor('#515D64'),
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
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: hexToColor('#84BEF3'),
                                ),
                                KText(
                                  text: 'Single Drop Location',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            KText(
                              text: '(Destination Location Only)',
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
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: hexToColor('#84BEF3'),
                                ),
                                KText(
                                  text: 'Prescribe Travel Path',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            KText(
                              text: 'BMTF Factory --> Jessore Sadar',
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
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Total Quantity ',
                                      fontSize: 13,
                                      color: hexToColor('#515D64'),
                                    ),

                                    KText(
                                      text: '1245',
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
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
                                        text: 'Gross Transportation Fee',
                                        fontSize: 13,
                                        color: hexToColor('#515D64'),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 168),
                                      child: KText(
                                        text: '253,265',
                                        fontSize: 13,
                                        color: hexToColor('#515D64'),
                                      ),
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
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => GestureDetector(
                                  onTap: () => materialC.isExpanded.toggle(),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 12,
                                      left: 10,
                                      right: 10,
                                    ),
                                    height:
                                        materialC.isExpanded.value ? 315 : 135,
                                    //width: Get.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1.5,
                                            color: hexToColor('#DBECFB'))),
                                    child: Column(
                                      children: [
                                        Container(
                                          //width: Get.width,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.green),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                              // border: Border.all(),
                                              color: hexToColor('#DBECFB')),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Icon(
                                                materialC.isExpanded.value
                                                    ? EvaIcons
                                                        .arrowIosUpwardOutline
                                                    : EvaIcons
                                                        .arrowIosDownwardOutline,
                                                color: hexToColor('#80939D'),
                                              ),
                                              KText(
                                                text: 'Item Name 01',
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Code ',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#515D64'),
                                                      ),
                                                    ],
                                                  ),
                                                  materialC.isExpanded.value
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 0,
                                                          ),
                                                          child: KText(
                                                            text: 'A213456',
                                                            color: hexToColor(
                                                                '#515D64'),
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                        )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Drop Location ',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#515D64'),
                                                      ),
                                                    ],
                                                  ),
                                                  materialC.isExpanded.value
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 0,
                                                          ),
                                                          child: KText(
                                                            text: 'Location 01',
                                                            color: hexToColor(
                                                                '#515D64'),
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          padding:
                                                              EdgeInsets.all(0),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        materialC.isExpanded.value
                                            ? Column(
                                                children: [
                                                  Divider(
                                                      color: hexToColor(
                                                          '#DBECFB')),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Distance'),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Text('50 Kg'),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Quantity'),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        SizedBox(
                                                          width: 70,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              isDense: true,
                                                              hintText: '649',
                                                              labelStyle: TextStyle(
                                                                  color: hexToColor(
                                                                      '#FF0000')),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: hexToColor(
                                                                        '#DBECFB')),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        KText(
                                                          text: 'Pcs',
                                                          fontSize: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text('Weight'),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        SizedBox(
                                                          width: 70,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              isDense: true,
                                                              hintText: '649',
                                                              labelStyle: TextStyle(
                                                                  color: hexToColor(
                                                                      '#FF0000')),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: hexToColor(
                                                                        '#DBECFB')),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        KText(
                                                          text: 'Kg',
                                                          fontSize: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                      color: hexToColor(
                                                          '#DBECFB')),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            KText(
                                                              text:
                                                                  'Transportation Fee',
                                                              fontSize: 14,
                                                              color: hexToColor(
                                                                  '#41525A'),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        KText(
                                                          text: 'BDT  95,000',
                                                          fontSize: 14,
                                                          bold: true,
                                                          color: hexToColor(
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
                                              )
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            KText(
                                                              text: 'A213456',
                                                              color: hexToColor(
                                                                  '#515D64'),
                                                              fontSize: 14,
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        KText(
                                                          text: 'Location 01',
                                                          color: hexToColor(
                                                              '#515D64'),
                                                          fontSize: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
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
                                        Divider(color: hexToColor('#DBECFB')),
                                        materialC.isExpanded.value
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
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
                                                        Row(
                                                          children: [
                                                            KText(
                                                              text:
                                                                  'Goods Receiver ',
                                                              fontSize: 13,
                                                              color: hexToColor(
                                                                  '#80939D'),
                                                            ),
                                                            RenderSvg(
                                                              path:
                                                                  'icon_search_elements',
                                                              width: 25,
                                                              color: hexToColor(
                                                                  '#66A1D9'),
                                                            ),
                                                          ],
                                                        ),
                                                        KText(
                                                          text: 'Abdul Karim',
                                                          fontSize: 14,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            KText(
                                                              text:
                                                                  'Goods Inspector ',
                                                              fontSize: 13,
                                                              color: hexToColor(
                                                                  '#80939D'),
                                                            ),
                                                            RenderSvg(
                                                              path:
                                                                  'icon_search_elements',
                                                              width: 25,
                                                              color: hexToColor(
                                                                  '#66A1D9'),
                                                            ),
                                                          ],
                                                        ),
                                                        KText(
                                                          text: 'Tamal Sarkar',
                                                          fontSize: 15,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Quantity'),
                                                    Text('450 PCs'),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Padding(
                          //   padding:   EdgeInsets.only(
                          //       left: 20, right: 15, top: 20),
                          //   child: Row(
                          //     children: [
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           KText(
                          //             text: 'Remarks',
                          //             fontSize: 13,
                          //             color: hexToColor('#515D64'),
                          //           ),

                          //           KText(
                          //             text: 'Remarks here...',
                          //             fontSize: 13,
                          //             color: hexToColor('#80939D'),
                          //           ),

                          //           // Icon(
                          //           //   uiC.isExpanded.value
                          //           //       ? EvaIcons.arrowIosUpwardOutline
                          //           //       : EvaIcons.arrowIosDownwardOutline,
                          //           //   color: hexToColor('#80939D'),
                          //           // ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 12),
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border:
                          Border.all(color: hexToColor('#DBECFB'), width: 1)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, right: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'Remarks ',
                                  fontSize: 13,
                                  color: hexToColor('#80939D'),
                                ),

                                KText(
                                  text: 'Remarks Here ',
                                  fontSize: 13,
                                  color: hexToColor('#D9D9D9'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Icon(
                                //   uiC.isExpanded.value
                                //       ? EvaIcons.arrowIosUpwardOutline
                                //       : EvaIcons.arrowIosDownwardOutline,
                                //   color: hexToColor('#80939D'),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Divider(
                          color: hexToColor('#DBECFB'),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                // showTopSnackBar(
                                //   context,
                                //   CustomSnackBar.error(
                                //     message: 'Rejected',
                                //   ),
                                // );
                              },
                              child: InkWell(
                                onTap: () {
                                  // showTopSnackBar(
                                  //   context,
                                  //   CustomSnackBar.error(
                                  //     message: 'Rejected',
                                  //   ),
                                  // );
                                },
                                child: Container(
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
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                push(AssignVehicleAndDriverPage());
                                Get.snackbar(
                                  'Status',
                                  'Approved',
                                  colorText: AppTheme.black,
                                  backgroundColor: AppTheme.appHomePageColor,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: Container(
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
                            InkWell(
                              onTap: () {
                                push(AssignVehicleAndDriverPage());

                                // showTopSnackBar(
                                //   context,
                                //   CustomSnackBar.success(
                                //     message: 'Approved',
                                //   ),
                                // );
                              },
                              child: Container(
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
                SizedBox(
                  height: 20,
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
                      bold: true,
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
                Container(
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
          SizedBox(
            height: 10,
          ),
        ],
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
