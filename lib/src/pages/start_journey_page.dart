import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';

import '../helpers/route.dart';

class StartJourneyPage extends StatefulWidget {
  final String? transportOrderNo;
  final bool? isFromNotification;

  StartJourneyPage({
    this.transportOrderNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmTransportReadinessPageState createState() =>
      _ConfirmTransportReadinessPageState();
}

class _ConfirmTransportReadinessPageState extends State<StartJourneyPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );

    //***************************************//
    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      startJourneyDriverConfirmC.getstartjourney(
        transportOrderNo: widget.transportOrderNo!,
      );
    } else {
      startJourneyDriverConfirmC.getstartjourney(
        transportOrderNo: '221018.00001',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    startJourneyDriverConfirmC.driverRemarks.value = '';
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
            text: 'Start Journey',
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
          Tab(text: 'Basic Data'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Materials')),
        ],
      );
}

class BasicData extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => startJourneyDriverConfirmC.startJourney.value == null
          ? Center(child: Loading())
          : Builder(
              builder: (context) {
                final item = startJourneyDriverConfirmC.startJourney.value;

                return ListView(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                text: item!.transportOrderNo,
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
                                  text: formatDate(
                                      date: item.transportOrderDate!),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: hexToColor('#EBEBEC')),
                    SizedBox(height: 8),
                    if (item.receivingPartyName != null)
                      TextFieldWidget(
                        avatar: false,
                        title: 'Receving Party',
                        srchText: item.receivingPartyName!,
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                                              // text:
                                              //     'Capacity: ${item.capacity}',
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
                    //         padding: EdgeInsets.only(top: 10),
                    //         child: Row(
                    //           children: [
                    //             RenderSvg(path: 'icon_path'),
                    //             SizedBox(width: 5),
                    //             KText(
                    //               text: 'Travel Route',
                    //               fontSize: 16,
                    //               color: hexToColor('#41525A'),
                    //               bold: true,
                    //             ),
                    //             Spacer(),
                    //             KText(
                    //               text: '15 Km',
                    //               color: AppTheme.nTextLightC,
                    //               fontSize: 15,
                    //             ),
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
                    //       SizedBox(height: 15),
                    //     ],
                    //   ),
                    // ),

                    // //---------
                    // //Travel Path

                    // if (assignVehicleAndDriverC.travelPath.value != null)
                    //   Builder(builder: (context) {
                    //     final item = assignVehicleAndDriverC.travelPath.value;
                    //     return Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SvgPicture.asset(
                    //                 '${Constants.svgPath}/icon_path.svg'),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             KText(
                    //               text: 'Travle Route',
                    //               bold: true,
                    //               fontSize: 14,
                    //               color: hexToColor('#41525A'),
                    //             ),
                    //             Spacer(),
                    //             KText(
                    //               text: '${item!.pathLenghtKm} Km',
                    //               bold: false,
                    //               fontSize: 14,
                    //               color: hexToColor('#41525A'),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         DottedLine(
                    //           lineThickness: 0.1,
                    //           dashColor: Colors.black,
                    //         ),
                    //         SizedBox(height: 10),
                    //         KText(
                    //           text: item.travelPathName,
                    //           color: hexToColor('#515D64'),
                    //         ),
                    //         SizedBox(height: 10),
                    //         Container(
                    //           height: 190,
                    //           width: Get.width,
                    //           decoration: BoxDecoration(
                    //             color: hexToColor('#FFE9CF'),
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(5),
                    //             child: FlutterMap(
                    //               mapController: mapViewC.kMapController,
                    //               options: MapOptions(
                    //                 center: item.points![0],
                    //                 zoom: 14.0,
                    //                 minZoom: 1.0,
                    //                 maxZoom: 90,
                    //               ),
                    //               children: [
                    //                 TileLayer(
                    //                   userAgentPackageName:
                    //                       'com.ctrendssoftware.workforce',
                    //                   urlTemplate:
                    //                       'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    //                   // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    //                   // subdomains: ['a', 'b', 'c'],
                    //                 ),
                    //                 MarkerLayer(
                    //                   markers: [
                    //                     Marker(
                    //                       //marker
                    //                       width: 40.0,
                    //                       height: 10.0,

                    //                       builder: (context) {
                    //                         return GestureDetector(
                    //                           onTap: () {},
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.only(
                    //                               bottom: 50,
                    //                               right: 8,
                    //                             ),
                    //                             child: Icon(
                    //                               Icons.location_on,
                    //                               color: hexToColor('#007BEC'),
                    //                               size: 40,
                    //                             ),
                    //                           ),
                    //                           // child: RenderImg(
                    //                           //   path: 'man-1.png',
                    //                           //   height: 30,
                    //                           //   width: 30,
                    //                           // ),
                    //                         );
                    //                       },
                    //                       point: item.points!.first,
                    //                     ),
                    //                     Marker(
                    //                       //marker
                    //                       width: 40.0,
                    //                       height: 40.0,

                    //                       builder: (context) {
                    //                         return GestureDetector(
                    //                           onTap: () {},
                    //                           child: Icon(
                    //                             Icons.location_on,
                    //                             color: hexToColor('#00D8A0'),
                    //                             size: 40,
                    //                           ),
                    //                           // child: RenderImg(
                    //                           //   path: 'man-1.png',
                    //                           //   height: 30,
                    //                           //   width: 30,
                    //                           // ),
                    //                         );
                    //                       },
                    //                       point: item.points!.last,
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 // ***************************
                    //                 PolylineLayer(
                    //                   polylineCulling: false,
                    //                   polylines: [
                    //                     Polyline(
                    //                       points: item.points!,
                    //                       // points: [
                    //                       //   LatLng(13.035606, 77.562381),
                    //                       // ],
                    //                       color: Colors.green,
                    //                       isDotted: true,
                    //                       borderColor: Colors.amber,
                    //                       strokeCap: StrokeCap.round,
                    //                       strokeWidth: 5,
                    //                       borderStrokeWidth: 5,
                    //                     ),
                    //                   ],
                    //                 ),

                    //                 PolygonLayer(
                    //                   polygonCulling: false,
                    //                   polygons: [
                    //                     Polygon(
                    //                       points: [
                    //                         LatLng(0, 0),
                    //                         LatLng(5, 5),
                    //                         LatLng(10, 10),
                    //                       ],
                    //                       color: hexToColor('#63FF7C')
                    //                           .withOpacity(0.5),
                    //                       isDotted: true,
                    //                       isFilled: true,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(height: 6),
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               height: 20,
                    //               width: 25,
                    //               child: TextButton(
                    //                 onPressed: () {
                    //                   print('object');
                    //                 },
                    //                 style: ButtonStyle(
                    //                   backgroundColor: MaterialStateProperty.all(
                    //                       hexToColor('#007BEC')),
                    //                   shape: MaterialStateProperty.all<
                    //                       RoundedRectangleBorder>(
                    //                     RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(0),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 child: Text(''),
                    //               ),
                    //             ),
                    //             SizedBox(width: 7),
                    //             KText(text: 'Starting'),
                    //             SizedBox(width: 7),
                    //             SizedBox(
                    //               height: 20,
                    //               width: 25,
                    //               child: TextButton(
                    //                 onPressed: () {
                    //                   print('object');
                    //                 },
                    //                 style: ButtonStyle(
                    //                   backgroundColor: MaterialStateProperty.all(
                    //                       hexToColor('#FFA133')),
                    //                   shape: MaterialStateProperty.all<
                    //                       RoundedRectangleBorder>(
                    //                     RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(0),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 child: Text(''),
                    //               ),
                    //             ),
                    //             SizedBox(width: 7),
                    //             KText(text: 'Drop'),
                    //             SizedBox(width: 7),
                    //             SizedBox(
                    //               height: 20,
                    //               width: 25,
                    //               child: TextButton(
                    //                 onPressed: () {
                    //                   print('object');
                    //                 },
                    //                 style: ButtonStyle(
                    //                   backgroundColor: MaterialStateProperty.all(
                    //                       hexToColor('#00D8A0')),
                    //                   shape: MaterialStateProperty.all<
                    //                       RoundedRectangleBorder>(
                    //                     RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(0),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 child: Text(''),
                    //               ),
                    //             ),
                    //             SizedBox(width: 7),
                    //             KText(text: 'Destination'),
                    //             SizedBox(width: 7),
                    //           ],
                    //         ),
                    //       ],
                    //     );
                    //   }),
                    // //------------

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            initialValue: startJourneyDriverConfirmC
                                        .driverRemarks.value ==
                                    ''
                                ? ''
                                : startJourneyDriverConfirmC
                                    .driverRemarks.value,
                            onChanged: startJourneyDriverConfirmC.driverRemarks,
                            maxLines: 5,
                            minLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Remarks Here',
                              contentPadding: EdgeInsets.all(5),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: .1)),
                            ),
                          ),
                          SizedBox(height: 30),
                          Obx(
                            () => Center(
                              child: InkWell(
                                onTap: () {
                                  startJourneyDriverConfirmC.postStartJourny(
                                    registrationNo: item.registrationNo!,
                                    transportOrderNo: item.transportOrderNo!,
                                  );
                                },
                                child: Container(
                                  height: 34,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: hexToColor('#007BEC'),
                                  ),
                                  child: Center(
                                    child: startJourneyDriverConfirmC
                                            .isLoading.value
                                        ? Loading(color: Colors.white)
                                        : KText(
                                            text: 'Start Journey',
                                            bold: true,
                                            fontSize: 16,
                                            color: hexToColor('#FFFFFF'),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class Materials extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Center(child: KText(text: 'No item found.'));
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
