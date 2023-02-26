import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';

import '../helpers/loading.dart';
import '../helpers/render_svg.dart';

class ConfirmTransportOrderReadinessByDriverPage extends StatefulWidget {
  final String? transportOrderNo;
  final bool? isFromNotification;

  ConfirmTransportOrderReadinessByDriverPage({
    this.transportOrderNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmTransportOrderReadinessByDriverPageState createState() =>
      _ConfirmTransportOrderReadinessByDriverPageState();
}

class _ConfirmTransportOrderReadinessByDriverPageState
    extends State<ConfirmTransportOrderReadinessByDriverPage>
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
      confirmTransportReadinessC.getDriverConfirmTransportReadiness(
        transportOrderNo: widget.transportOrderNo!,
      );
    } else {
      confirmTransportReadinessC.getDriverConfirmTransportReadiness(
        transportOrderNo: '221018.00001',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    confirmTransportReadinessC.remarks.value = '';
    confirmTransportReadinessC.vehicleInfo.value = null;
    confirmTransportReadinessC.itemList.clear();
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
            text: 'Confirm Transport Readiness',
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
      () => confirmTransportReadinessC.vehicleInfo.value == null
          ? Center(child: Loading())
          : Builder(builder: (context) {
              final item = confirmTransportReadinessC.vehicleInfo.value;

              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                KText(
                                  text: 'Transport Order',
                                  fontSize: 14,
                                  color: hexToColor('#80939D'),
                                ),
                              ],
                            ),
                            KText(
                              text: '${item!.transportOrderNo}',
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
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: formatDate(date: item.transportOrderDate!),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: hexToColor('#EBEBEC')),
                  SizedBox(height: 6),
                  TextFieldWidget(
                    avatar: false,
                    title: 'Receiving Party ',
                    srchText: '${item.receivingPartyName}',
                  ),
                  TextFieldWidget(
                    title: 'Source Location (Loading Point)',
                    srchText: '${item.sourceLocName}',
                    avatar: false,
                  ),
                  TextFieldWidget(
                    title: 'Destination Location (Unloading Point)',
                    srchText: '${item.destinationLocName}',
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
                                            //   text: 'Capacity: ${item.capacity}',
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
                                      width: 200,
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
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(top: 10),
                  //         child: Row(
                  //           children: [
                  //             RenderSvg(path: 'icon_path'),
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
                  //                 text: '20 Km',
                  //                 color: AppTheme.nTextLightC,
                  //                 fontSize: 15),
                  //           ],
                  //         ),
                  //       ),
                  //       Divider(color: hexToColor('#515D64')),
                  //       // KText(
                  //       //   text:
                  //       //       'BMTF Factory, Gazipur -> Jessore Sadar, Jessore',
                  //       //   color: hexToColor('#515D64'),
                  //       // ),
                  //       SizedBox(
                  //         height: 300,
                  //         width: double.infinity,
                  //         // color: hexToColor('#FFE9CF'),
                  //         child: RenderImg(
                  //           path: 'map.jpeg',
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //       SizedBox(height: 20),

                  //       // if (assignVehicleAndDriverC.travelPath.value != null)
                  //       //   Builder(builder: (context) {
                  //       //     final item =
                  //       //         assignVehicleAndDriverC.travelPath.value;
                  //       //     return Column(
                  //       //       children: [
                  //       //         Row(
                  //       //           children: [
                  //       //             SvgPicture.asset(
                  //       //                 '${Constants.svgPath}/icon_path.svg'),
                  //       //             SizedBox(
                  //       //               width: 10,
                  //       //             ),
                  //       //             KText(
                  //       //               text: 'Travle Route ddd',
                  //       //               bold: true,
                  //       //               fontSize: 14,
                  //       //               color: hexToColor('#41525A'),
                  //       //             ),
                  //       //             Spacer(),
                  //       //             KText(
                  //       //               text: '${item!.pathLenghtKm} Km',
                  //       //               bold: false,
                  //       //               fontSize: 14,
                  //       //               color: hexToColor('#41525A'),
                  //       //             ),
                  //       //           ],
                  //       //         ),
                  //       //         SizedBox(
                  //       //           height: 10,
                  //       //         ),
                  //       //         DottedLine(
                  //       //           lineThickness: 0.1,
                  //       //           dashColor: Colors.black,
                  //       //         ),
                  //       //         SizedBox(height: 10),
                  //       //         KText(
                  //       //           text: item.travelPathName,
                  //       //           color: hexToColor('#515D64'),
                  //       //         ),
                  //       //         SizedBox(height: 10),
                  //       //         Container(
                  //       //           height: 190,
                  //       //           width: Get.width,
                  //       //           decoration: BoxDecoration(
                  //       //             color: hexToColor('#FFE9CF'),
                  //       //             borderRadius: BorderRadius.circular(5),
                  //       //           ),
                  //       //           child: ClipRRect(
                  //       //             borderRadius: BorderRadius.circular(5),
                  //       //             child: FlutterMap(
                  //       //               mapController: mapViewC.kMapController,
                  //       //               options: MapOptions(
                  //       //                 center: item.points![0],
                  //       //                 zoom: 14.0,
                  //       //                 minZoom: 1.0,
                  //       //                 maxZoom: 90,
                  //       //               ),
                  //       //               children: [
                  //       //                 TileLayer(
                  //       //                   userAgentPackageName:
                  //       //                       'com.ctrendssoftware.workforce',
                  //       //                   urlTemplate:
                  //       //                       'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //       //                   // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  //       //                   // subdomains: ['a', 'b', 'c'],
                  //       //                 ),
                  //       //                 MarkerLayer(
                  //       //                   markers: [
                  //       //                     Marker(
                  //       //                       //marker
                  //       //                       width: 40.0,
                  //       //                       height: 10.0,

                  //       //                       builder: (context) {
                  //       //                         return GestureDetector(
                  //       //                           onTap: () {},
                  //       //                           child: Padding(
                  //       //                             padding:
                  //       //                                 const EdgeInsets.only(
                  //       //                               bottom: 50,
                  //       //                               right: 8,
                  //       //                             ),
                  //       //                             child: Icon(
                  //       //                               Icons.location_on,
                  //       //                               color:
                  //       //                                   hexToColor('#007BEC'),
                  //       //                               size: 40,
                  //       //                             ),
                  //       //                           ),
                  //       //                           // child: RenderImg(
                  //       //                           //   path: 'man-1.png',
                  //       //                           //   height: 30,
                  //       //                           //   width: 30,
                  //       //                           // ),
                  //       //                         );
                  //       //                       },
                  //       //                       point: item.points!.first,
                  //       //                     ),
                  //       //                     Marker(
                  //       //                       //marker
                  //       //                       width: 40.0,
                  //       //                       height: 40.0,

                  //       //                       builder: (context) {
                  //       //                         return GestureDetector(
                  //       //                           onTap: () {},
                  //       //                           child: Icon(
                  //       //                             Icons.location_on,
                  //       //                             color:
                  //       //                                 hexToColor('#00D8A0'),
                  //       //                             size: 40,
                  //       //                           ),
                  //       //                           // child: RenderImg(
                  //       //                           //   path: 'man-1.png',
                  //       //                           //   height: 30,
                  //       //                           //   width: 30,
                  //       //                           // ),
                  //       //                         );
                  //       //                       },
                  //       //                       point: item.points!.last,
                  //       //                     ),
                  //       //                   ],
                  //       //                 ),
                  //       //                 // ***************************
                  //       //                 PolylineLayer(
                  //       //                   polylineCulling: false,
                  //       //                   polylines: [
                  //       //                     Polyline(
                  //       //                       points: item.points!,
                  //       //                       // points: [
                  //       //                       //   LatLng(13.035606, 77.562381),
                  //       //                       // ],
                  //       //                       color: Colors.green,
                  //       //                       isDotted: true,
                  //       //                       borderColor: Colors.amber,
                  //       //                       strokeCap: StrokeCap.round,
                  //       //                       strokeWidth: 5,
                  //       //                       borderStrokeWidth: 5,
                  //       //                     ),
                  //       //                   ],
                  //       //                 ),

                  //       //                 PolygonLayer(
                  //       //                   polygonCulling: false,
                  //       //                   polygons: [
                  //       //                     Polygon(
                  //       //                       points: [
                  //       //                         LatLng(0, 0),
                  //       //                         LatLng(5, 5),
                  //       //                         LatLng(10, 10),
                  //       //                       ],
                  //       //                       color: hexToColor('#63FF7C')
                  //       //                           .withOpacity(0.5),
                  //       //                       isDotted: true,
                  //       //                       isFilled: true,
                  //       //                     ),
                  //       //                   ],
                  //       //                 ),
                  //       //               ],
                  //       //             ),
                  //       //           ),
                  //       //         ),
                  //       //         SizedBox(height: 6),
                  //       //         Row(
                  //       //           children: [
                  //       //             SizedBox(
                  //       //               height: 20,
                  //       //               width: 25,
                  //       //               child: TextButton(
                  //       //                 onPressed: () {
                  //       //                   print('object');
                  //       //                 },
                  //       //                 style: ButtonStyle(
                  //       //                   backgroundColor:
                  //       //                       MaterialStateProperty.all(
                  //       //                           hexToColor('#007BEC')),
                  //       //                   shape: MaterialStateProperty.all<
                  //       //                       RoundedRectangleBorder>(
                  //       //                     RoundedRectangleBorder(
                  //       //                       borderRadius:
                  //       //                           BorderRadius.circular(0),
                  //       //                     ),
                  //       //                   ),
                  //       //                 ),
                  //       //                 child: Text(''),
                  //       //               ),
                  //       //             ),
                  //       //             SizedBox(width: 7),
                  //       //             KText(text: 'Starting'),
                  //       //             SizedBox(width: 7),
                  //       //             SizedBox(
                  //       //               height: 20,
                  //       //               width: 25,
                  //       //               child: TextButton(
                  //       //                 onPressed: () {
                  //       //                   print('object');
                  //       //                 },
                  //       //                 style: ButtonStyle(
                  //       //                   backgroundColor:
                  //       //                       MaterialStateProperty.all(
                  //       //                           hexToColor('#FFA133')),
                  //       //                   shape: MaterialStateProperty.all<
                  //       //                       RoundedRectangleBorder>(
                  //       //                     RoundedRectangleBorder(
                  //       //                       borderRadius:
                  //       //                           BorderRadius.circular(0),
                  //       //                     ),
                  //       //                   ),
                  //       //                 ),
                  //       //                 child: Text(''),
                  //       //               ),
                  //       //             ),
                  //       //             SizedBox(width: 7),
                  //       //             KText(text: 'Drop'),
                  //       //             SizedBox(width: 7),
                  //       //             SizedBox(
                  //       //               height: 20,
                  //       //               width: 25,
                  //       //               child: TextButton(
                  //       //                 onPressed: () {
                  //       //                   print('object');
                  //       //                 },
                  //       //                 style: ButtonStyle(
                  //       //                   backgroundColor:
                  //       //                       MaterialStateProperty.all(
                  //       //                           hexToColor('#00D8A0')),
                  //       //                   shape: MaterialStateProperty.all<
                  //       //                       RoundedRectangleBorder>(
                  //       //                     RoundedRectangleBorder(
                  //       //                       borderRadius:
                  //       //                           BorderRadius.circular(0),
                  //       //                     ),
                  //       //                   ),
                  //       //                 ),
                  //       //                 child: Text(''),
                  //       //               ),
                  //       //             ),
                  //       //             SizedBox(width: 7),
                  //       //             KText(text: 'Destination'),
                  //       //             SizedBox(width: 7),
                  //       //           ],
                  //       //         ),
                  //       //       ],
                  //       //     );
                  //       //   }),
                  //     ],
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onChanged: confirmTransportReadinessC.remarks,
                            decoration: InputDecoration(
                              hintText: 'Remark Here',
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 30),
                        ]),
                  ),
                  Obx(
                    () => Row(
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
                                  confirmTransportReadinessC
                                      .postDriverConfirmTransportReadiness(
                                    registrationNo: item.registrationNo!,
                                    transportOrderNo: item.transportOrderNo!,
                                  );
                                  confirmTransportReadinessC
                                      .postEvidenceAttachment(
                                          registrationNo: item.registrationNo!,
                                          id: item.transportOrderId);
                                }
                              : null,

                          // push(ConfirmRecipientPage());

                          child: Container(
                            height: 35,
                            width: 100,
                            // ignore: sort_child_properties_last
                            child: Center(
                              child: confirmTransportReadinessC.isLoading.value
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
      () => confirmTransportReadinessC.itemList.isEmpty
          ? Center(child: Loading())
          : Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: confirmTransportReadinessC.itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = confirmTransportReadinessC.itemList[index];
                  return Obx(
                    () => GestureDetector(
                      onTap: () => materialC.isExpanded.toggle(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        // height: materialC.isExpanded.value ? 200 : 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: hexToColor('#DBECFB'), width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                color: hexToColor('#DBECFB'),
                              ),
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
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
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
                                            : '',
                                      ),
                                      KText(
                                        text: item.weightCapacity != null
                                            ? '${item.weightCapacity}'
                                            : '0.0',
                                      ),
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
                                              ? ' ${item.baseUom}'
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
    return confirmTransportReadinessC.vehicleInfo == null
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                              text: confirmTransportReadinessC
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
                                              confirmTransportReadinessC
                                                  .pickMultiImage();
                                            },
                                            child:
                                                RenderSvg(path: 'icon_add_box'),
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
                                  confirmTransportReadinessC.imagefiles.isEmpty
                                      ? SizedBox()
                                      : GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                          ),
                                          itemCount: confirmTransportReadinessC
                                              .imagefiles.length,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final item =
                                                confirmTransportReadinessC
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
                                                          confirmTransportReadinessC
                                                              .imagefiles
                                                              .removeAt(index);
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.all(60),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.redAccent,
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
          );
  }
}
