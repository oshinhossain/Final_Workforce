import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/start_journey_page.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/loading.dart';

class ConfirmTransportOrderReadinessBYReceiverPage extends StatefulWidget {
  final String? transportOrderNo;
  final String? vehicleRegistrationNo;
  final bool? isFromNotification;

  ConfirmTransportOrderReadinessBYReceiverPage({
    this.transportOrderNo,
    this.vehicleRegistrationNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmTransportOrderReadinessBYReceiverPageState createState() =>
      _ConfirmTransportOrderReadinessBYReceiverPageState();
}

class _ConfirmTransportOrderReadinessBYReceiverPageState
    extends State<ConfirmTransportOrderReadinessBYReceiverPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );

    //***************************************//
    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      confirmRecipientReadinessC.getReceiverConfirmRecipientReadiness(
        transportOrderNo: widget.transportOrderNo!,
        vehicleRegistrationNo: widget.vehicleRegistrationNo!,
      );
    } else {
      confirmRecipientReadinessC.getReceiverConfirmRecipientReadiness(
        transportOrderNo: '20221002.00001',
        vehicleRegistrationNo: '444444',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    confirmRecipientReadinessC.remarks.value = '';
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
            text: 'Confirm Recipient Readiness',
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
            BasicData(),
            Materials(),
            Evidence(),
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
                  : _activeIndex == 2
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
          Tab(text: 'Basic Data'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Materials')),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Evidence')),
        ],
      );

  Widget basicData() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      KText(
                        text: 'Transport Order',
                        fontSize: 14,
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 30,
                        width: 40,
                        child: IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            // openBottomSheet();
                          },
                          icon: SvgPicture.asset(
                            '${Constants.svgPath}/icon_search_elements.svg',
                            color: hexToColor('#66A1D9'),
                            width: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  KText(
                    text: 'S2SD82SD8',
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  KText(
                    text: 'Date',
                    fontSize: 14,
                  ),
                  KText(
                    text: '01 Sep 2022',
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: hexToColor('#EBEBEC'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            avatar: false,
            title: 'Sending Party (who placed the Order)',
            srchText: 'Jessore Trade Agency',
          ),
          TextFieldWidget(
            title: 'Source Location (Loading Point)',
            srchText: 'BMTF Factory, Gazipur',
            avatar: false,
          ),
          TextFieldWidget(
            srchText: 'Jessore Sadar, Jessore',
            hasCheckbox: false,
            // searchIcon: false,
            title: 'Destination Location (Unloading Point)',
          ),
          Row(
            children: [
              RenderSvg(path: 'trucklogo'),
              // SvgPicture.asset('${Constants.svgPath}/trucklogo.svg'),
              SizedBox(
                width: 5,
              ),
              KText(
                text: 'Vehicles',
                fontSize: 16,
                color: hexToColor('#41525A'),
                bold: true,
              ),
            ],
          ),
          Divider(
            color: hexToColor('#515D64'),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 155,
            width: double.infinity,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(5)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1, color: hexToColor('#FFE9CF')),
              color: hexToColor('#FFFFFF'),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 15, top: 5),
                        child: KText(
                          text: 'Dhaka Metro X123456',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Type: Truck',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                              bold: false,
                            ),
                            KText(
                              text: 'Capacity: 5 Ton',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                              bold: false,
                            ),
                            KText(
                              text: 'Brand: Tata',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                              bold: false,
                            ),
                            KText(
                              text: 'Driver: Nurul Islam',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                              bold: false,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 14, left: 5, bottom: 16, right: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white60),
                        child: Image.asset(
                          '${Constants.imgPath}/truck.png',
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 10),
          //   child: Row(
          //     children: [
          //       RenderSvg(path: 'icon_path'),
          //       // SvgPicture.asset('${Constants.svgPath}/icon_path.svg'),
          //       SizedBox(
          //         width: 5,
          //       ),
          //       KText(
          //         text: 'Travel Route',
          //         fontSize: 16,
          //         color: hexToColor('#41525A'),
          //         bold: true,
          //       ),
          //       Spacer(),
          //       KText(
          //         text: '15 Km',
          //         color: hexToColor('#80939D'),
          //         fontSize: 15,
          //       ),
          //       SizedBox(
          //         width: 12,
          //       )
          //     ],
          //   ),
          // ),
          // Divider(
          //   color: hexToColor('#515D64'),
          // ),
          // SizedBox(
          //   height: 300,
          //   width: double.infinity,
          //   // color: hexToColor('#FFE9CF'),
          //   child: RenderImg(
          //     path: 'map.jpeg',
          //     fit: BoxFit.fill,
          //   ),
          // ),

          SizedBox(
            height: 15,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            KText(
              text: 'Remarks',
              color: hexToColor('#80939D'),
            ),
            KText(
              text: 'Remarks Here',
              color: hexToColor('#D9D9D9'),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: hexToColor('#515D64'),
            ),
          ]),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  // showTopSnackBar(
                  //   context,
                  //   CustomSnackBar.error(
                  //     message: 'Canceled',
                  //   ),
                  // );
                },
                child: Container(
                  height: 35,
                  width: 100,
                  // ignore: sort_child_properties_last
                  child: Center(
                    child: KText(
                      text: 'Cancel',
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#FFA133'),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  //1 ui missing start Journey updated by oshin Apu//

                  push(StartJourneyPage());

                  //  push(UnloadMaterialsVehicle());
                  Get.snackbar(
                    'Status',
                    'Recipient Ready',
                    colorText: AppTheme.black,
                    backgroundColor: AppTheme.appHomePageColor,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Container(
                  height: 35,
                  width: 100,
                  // ignore: sort_child_properties_last
                  child: Center(
                    child: KText(
                      text: 'Confirm',
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#007BEC'),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget materials() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => GestureDetector(
              onTap: () => materialC.isExpanded.toggle(),
              child: Container(
                margin: EdgeInsets.only(top: 12),
                height: materialC.isExpanded.value ? 200 : 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: hexToColor('#DBECFB'), width: 2)),
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: 40,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(12),
                          // border: Border.all(),
                          color: hexToColor('#DBECFB')),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_box_outlined,
                            color: hexToColor('#84BEF3'),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          KText(
                            text: 'Item Name 01 (Code)',
                            bold: true,
                          ),
                          Spacer(),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            materialC.isExpanded.value
                                ? EvaIcons.arrowIosUpwardOutline
                                : EvaIcons.arrowIosDownwardOutline,
                            color: hexToColor('#80939D'),
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
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Serial Number'),
                          KText(text: 'Weight'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    materialC.isExpanded.value
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: '26345634'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(text: '-'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(text: '21741273'),
                                      ],
                                    ),
                                    KText(text: '155 Kg'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: '26345634'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(text: '-'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(text: '21741273'),
                                      ],
                                    ),
                                    KText(text: '155 Kg'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: '26345634'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color:
                                                        hexToColor('#DBECFB'))),
                                            child: Center(
                                                child: KText(text: '-'))),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(text: '21741273'),
                                      ],
                                    ),
                                    KText(text: '155 Kg'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                              height: 1,
                              width: 50,
                              color: hexToColor('#DBECFB')),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                              height: 1,
                              width: 60,
                              color: hexToColor('#DBECFB')),
                          SizedBox(
                            width: 120,
                          ),
                          Container(
                              height: 1,
                              width: 50,
                              color: hexToColor('#DBECFB'))
                        ],
                      ),
                    ),
                    Divider(color: hexToColor('#DBECFB')),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Quantity'),
                          KText(text: '450 PCs'),
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
    );
  }

  Widget evidence() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: 410,
        width: double.maxFinite,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(5)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 1, color: hexToColor('#FFE9CF')),
          color: hexToColor('#FFFFFF'),
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
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: hexToColor('#FFE9CF'),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 14,
                      ),
                      RenderSvg(path: 'icon_5'),
                      //  Image.asset('${Constants.imgPath}/stocklogo.png'),
                      SizedBox(
                        width: 5,
                      ),
                      KText(
                        text: 'Pictures of Receiving Location',
                        fontSize: 15,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                      Spacer(),
                      RenderSvg(path: 'icon_add_box'),
                      SizedBox(
                        width: 12,
                      ),
                      // SvgPicture.asset('${Constants.svgPath}/icon_add_box.svg'),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(14.0),
                  height: 340,
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey, width: 3)),
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset(
                            '${Constants.imgPath}/evidence_truck_icon_01.png',
                            height: 142.73,
                            fit: BoxFit.cover),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset(
                            '${Constants.imgPath}/evidence_truck_icon_02.png',
                            fit: BoxFit.cover),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset(
                            '${Constants.imgPath}/evidence_truck_icon_03.png',
                            fit: BoxFit.cover),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset(
                            '${Constants.imgPath}/evidence_truck_icon_04.png',
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool searchIcon;
  final bool avatar;
  final bool hasCheckbox;
  final String srchText;

  TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = false,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    required this.srchText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isActive = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              if (widget.hasCheckbox)
                Padding(
                  padding: EdgeInsets.only(right: 5),
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
                      padding: EdgeInsets.only(right: 10),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                '${Constants.imgPath}/bill.jpg',
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
              ),
            ],
          ),
          Divider(color: hexToColor('#515D64')),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BasicData extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => confirmRecipientReadinessC.vehicleInfo.value == null
          ? confirmRecipientReadinessC.isLoading.value
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
          : Builder(builder: (context) {
              final item = confirmRecipientReadinessC.vehicleInfo.value;
              return ListView(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                KText(
                                  text: 'Transport Order',
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            KText(
                              text: item!.transportOrderNo != null
                                  ? '${item.transportOrderNo}'
                                  : '',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Date',
                              color: hexToColor('#80939D'),
                            ),
                            if (item.transportOrderDate != null)
                              KText(
                                text:
                                    formatDate(date: item.transportOrderDate!),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: hexToColor('#EBEBEC'),
                  ),
                  SizedBox(height: 10),
                  // TextFieldWidget(
                  //   avatar: false,
                  //   title: 'Sending Party (who placed the Order)',
                  //   srchText: '',
                  // ),
                  TextFieldWidget(
                    title: 'Source Location (Loading Point)',
                    srchText: item.sourceLocName != null
                        ? '${item.sourceLocName}'
                        : '',
                    avatar: false,
                  ),
                  TextFieldWidget(
                    title: 'Destination Location (Unloading Point)',
                    srchText: item.destinationLocName != null
                        ? '${item.destinationLocName}'
                        : '',
                    hasCheckbox: false,
                    // searchIcon: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'trucklogo'),
                            SizedBox(width: 5),
                            KText(
                              text: 'Vehicles',
                              fontSize: 16,
                              color: hexToColor('#41525A'),
                              bold: true,
                            ),
                          ],
                        ),
                        Divider(color: hexToColor('#515D64')),
                        SizedBox(height: 12),
                        Container(
                          height: 155,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                width: 1, color: hexToColor('#FFE9CF')),
                            color: hexToColor('#FFFFFF'),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5, left: 15, top: 5),
                                      child: KText(
                                        text: item.registrationNo,
                                        fontSize: 16,
                                        color: hexToColor('#41525A'),
                                        bold: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Type: ${item.vehicleType}',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                          KText(
                                            text: 'Capacity: ',
                                            // text: 'Capacity: ${item.capacity}',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                          KText(
                                            text: 'Brand: ${item.brand}',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                          KText(
                                            text:
                                                'Driver: ${item.driverFullname}',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 150,
                                      padding: EdgeInsets.only(
                                          top: 14,
                                          left: 5,
                                          bottom: 16,
                                          right: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white60),
                                      child: RenderSvg(path: 'image_vehicle'),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 10),
                  //         child: Row(
                  //           children: [
                  //             RenderSvg(path: 'icon_path'),
                  //             // SvgPicture.asset('${Constants.svgPath}/icon_path.svg'),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             KText(
                  //               text: 'Travel Route',
                  //               fontSize: 16,
                  //               color: hexToColor('#41525A'),
                  //               bold: true,
                  //             ),
                  //             Spacer(),
                  //             KText(
                  //                 text: '14 Km',
                  //                 color: AppTheme.nTextLightC,
                  //                 fontSize: 15),
                  //           ],
                  //         ),
                  //       ),
                  //       Divider(color: hexToColor('#515D64')),
                  //       SizedBox(
                  //         height: 300,
                  //         width: double.infinity,
                  //         // color: hexToColor('#FFE9CF'),
                  //         child: RenderImg(
                  //           path: 'map.jpeg',
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // KText(
                          //   text: 'Remarks',
                          //   color: hexToColor('#80939D'),
                          // ),
                          TextField(
                            onChanged: confirmRecipientReadinessC.remarks,
                            decoration: InputDecoration(
                              hintText: 'Remark Here',
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Divider(
                          //   color: hexToColor('#515D64'),
                          // ),
                        ]),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              // showTopSnackBar(
                              //   context,
                              //   CustomSnackBar.error(
                              //     message: 'Canceled',
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              // ignore: sort_child_properties_last
                              child: Center(
                                child: KText(
                                  text: 'Cancel',
                                  color: Colors.white,
                                  bold: true,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: hexToColor('#FFA133'),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: item.registrationNo!.isNotEmpty &&
                                    item.transportOrderNo!.isNotEmpty
                                ? () {
                                    confirmRecipientReadinessC
                                        .postReceiverConfirmRecipientReadiness(
                                      registrationNo: item.registrationNo!,
                                      transportOrderNo: item.transportOrderNo!,
                                    );
                                    confirmRecipientReadinessC
                                        .postEvidenceAttachment(
                                      registrationNo: item.registrationNo!,
                                      id: item.transportOrderId,
                                    );
                                  }
                                : null,
                            // onTap: () {
                            //   push(StartJourneyPage());
                            //   Get.snackbar(
                            //     'Status',
                            //     'Vehicle Ready',
                            //     colorText: AppTheme.black,
                            //     backgroundColor: AppTheme.appHomePageColor,
                            //     snackPosition: SnackPosition.BOTTOM,
                            //   );
                            // },
                            child: Container(
                              height: 35,
                              width: 100,
                              // ignore: sort_child_properties_last
                              child: Center(
                                child:
                                    confirmRecipientReadinessC.isLoading.value
                                        ? Loading(
                                            color: Colors.white,
                                          )
                                        : KText(
                                            text: 'Confirm',
                                            color: Colors.white,
                                            bold: true,
                                          ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: item.registrationNo!.isNotEmpty &&
                                        item.transportOrderNo!.isNotEmpty
                                    ? hexToColor('#007BEC')
                                    : hexToColor('#007BEC').withOpacity(.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            }),
    );
  }
}

class Materials extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => confirmRecipientReadinessC.itemList.isEmpty
          ? Center(child: Loading())
          : Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: confirmRecipientReadinessC.itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = confirmRecipientReadinessC.itemList[index];
                  return Obx(
                    () => GestureDetector(
                      onTap: () => materialC.isExpanded.toggle(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        // height: materialC.isExpanded.value ? 200 : 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: hexToColor('#DBECFB'), width: 2),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(12),
                                  // border: Border.all(),
                                  color: hexToColor('#DBECFB')),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.check_box_outlined,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: KText(
                                      text:
                                          '${item.productName} (${item.productCode})',
                                      bold: true,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    materialC.isExpanded.value
                                        ? EvaIcons.arrowIosUpwardOutline
                                        : EvaIcons.arrowIosDownwardOutline,
                                    color: hexToColor('#80939D'),
                                  ),
                                  SizedBox(width: 5)
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Serial Number',
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text: 'Weight',
                                        color: hexToColor('#80939D'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                          text: item.productSerial != null
                                              ? '${item.productSerial}'
                                              : ''),
                                      KText(
                                          text: item.weightCapacity != null
                                              ? '${item.weightCapacity!}'
                                              : '0.0'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: hexToColor('#DBECFB')),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Quantity',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Row(
                                    children: [
                                      KText(text: '${item.baseUomQuantity} '),
                                      KText(
                                          text: item.baseUom != null
                                              ? '${item.baseUom}'
                                              : ''),
                                    ],
                                  ),
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
            ),
    );
  }
}

class Evidence extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => confirmRecipientReadinessC.vehicleInfo.value == null
          ? Center(child: Loading())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        // final item =
                        //     loadMaterialsToVehicleC.transportOrderVehicle[index];
                        return Obx(
                          () => Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  width: 1, color: hexToColor('#FFE9CF')),
                              color: hexToColor('#FFFFFF'),
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
                                                width: 14,
                                              ),
                                              RenderSvg(path: 'trucklogo'),
                                              // SvgPicture.asset(
                                              //     '${Constants.svgPath}/trucklogo.svg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              KText(
                                                text: confirmRecipientReadinessC
                                                    .vehicleInfo
                                                    .value!
                                                    .registrationNo,
                                                fontSize: 16,
                                                color: hexToColor('#41525A'),
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                confirmRecipientReadinessC
                                                    .pickMultiImage();
                                              },
                                              child: RenderSvg(
                                                  path: 'icon_add_box'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    confirmRecipientReadinessC
                                            .imagefiles.isEmpty
                                        ? SizedBox()
                                        : GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                            ),
                                            itemCount:
                                                confirmRecipientReadinessC
                                                    .imagefiles.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final item =
                                                  confirmRecipientReadinessC
                                                      .imagefiles[index];
                                              return Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.file(
                                                        File(item.path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Global.confirmDialog(
                                                          onConfirmed: () {
                                                            confirmRecipientReadinessC
                                                                .imagefiles
                                                                .removeAt(
                                                                    index);
                                                            Get.back();
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(60),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.white
                                                              .withOpacity(0.5),
                                                        ),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
