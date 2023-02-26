import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/state_manager.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:get/get.dart';

class TranspotationHistoryPage extends StatefulWidget {
  @override
  State<TranspotationHistoryPage> createState() => _TranspotationHistoryPageState();
}

class _TranspotationHistoryPageState extends State<TranspotationHistoryPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 4,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: hexToColor('#9BA9B3'),
            )),
        title: KText(
          text: 'Transpotation History',
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
              padding: EdgeInsets.only(left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
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
          AllTransportHistoryPage(),
          InTransitTransportHistoryPage(),
          DeliveredTransportHistoryPage(),
          CancelledTransportHistoryPage(),
        ],
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(fontFamily: 'Manrope', fontSize: 14.0, color: Colors.amber, fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: _activeIndex == 0
              ? BorderRadius.only(topLeft: Radius.circular(5.0))
              : _activeIndex == 3
                  ? BorderRadius.only(topRight: Radius.circular(5.0))
                  : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'All'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1, color: hexToColor('#EEF0F6')),
                      right: BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'In Transit')),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Delivered')),
          Tab(text: 'Cancelled'),
        ],
      );
}

class AllTransportHistoryPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    transotationHistoryC.getTranspotationHistory('ALL');

    return Obx(
      () => transotationHistoryC.allHistoryList.isEmpty
          ? Center(child: Loading())
          : ListView.builder(
              itemCount: transotationHistoryC.allHistoryList.length,
              itemBuilder: (context, index) {
                final item = transotationHistoryC.allHistoryList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 34,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            color: AppTheme.borderColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ExpandIcon(
                                  color: Colors.grey,
                                  expandedColor: Colors.grey,
                                  disabledColor: Colors.grey,
                                  isExpanded: item.isExpand!,
                                  onPressed: (v) {
                                    transotationHistoryC.exapndItem(item);
                                  },
                                ),
                                KText(text: 'transport oder no.'),
                              ],
                            ),
                            KText(
                              text: item.transportOrderNo,
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETS',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.ets!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETD',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.etd!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RenderImg(path: 't1.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: item.vehicleRegNo,
                                    fontSize: 14,
                                    color: AppTheme.textColor,
                                    bold: true,
                                  ),
                                  Container(
                                    height: 22,
                                    width: 70,
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: item.status == 'DELIVERED'
                                            ? AppTheme.compltColor
                                            : item.status == 'CANCELLED'
                                                ? AppTheme.cancletColor
                                                : AppTheme.inTransitColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Center(
                                      child: KText(
                                        text: item.status,
                                        color: Colors.white,
                                        fontSize: 11,
                                        bold: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: RenderImg(
                                      path: 'p1.png',
                                    ),
                                  ),
                                  KText(
                                    text: item.driverName,
                                    color: AppTheme.textfieldColor,
                                    fontSize: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Transport Agency',
                              color: AppTheme.textfieldColor,
                              fontSize: 13,
                            ),
                            Spacer(),
                            Flexible(
                              child: KText(
                                text: item.transporterAgencyName,
                                color: AppTheme.txtColor,
                                fontSize: 14,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Visibility(
                          visible: item.isExpand!,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Items',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      width: Get.width * .7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: item.items!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              KText(
                                                text: item.items![index],
                                                color: AppTheme.txtColor,
                                                fontSize: 14,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Source',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.sourceLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Destination',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.destinationLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Distance',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.distanceKm.toString(),
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Map View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: FlutterMap(
                                  mapController: mapViewC.kMapController,
                                  options: MapOptions(
                                    center: LatLng(23.777176, 90.412521),
                                    zoom: 15.0,
                                    minZoom: 1.0,
                                    maxZoom: 90,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.ctrendssoftware.workforce',
                                    ),
                                    CircleLayer(circles: [
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4100),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.primaryColor,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4135),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4120),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7774, 90.4149),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7760, 90.4159),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.delivrdColor,
                                      ),
                                    ]),
                                    MarkerLayer(markers: [
                                      Marker(
                                        //marker
                                        width: 30.0,
                                        height: 30.0,
                                        builder: (context) {
                                          return GestureDetector(
                                              onTap: () {},
                                              child: RenderImg(
                                                path: 'loc.png',
                                                height: 30,
                                                width: 30,
                                              ));
                                        },
                                        point: LatLng(23.7760, 90.4135),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.primaryColor,
                                  ),
                                  KText(text: 'Starting'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.color2,
                                  ),
                                  KText(text: 'Drop'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.plocColor,
                                  ),
                                  KText(text: 'Present Location'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.delivrdColor,
                                  ),
                                  Flexible(child: KText(text: 'Destination')),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Timeline View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Starting Place'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '12:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-1'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '02:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-2'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '07:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: RenderImg(path: 'loc_2.png'),
                                              ),
                                              KText(text: 'Present Location'),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 18),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-3'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '01:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.delivrdColor,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination Place'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 29,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 76,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 125,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 174,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 219,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 268,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 302,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Remarks from Transport Agency',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Remarks from Transport AgencyBind the poles strongly. Because the truck may tremble at times.',
                                        style: TextStyle(color: AppTheme.txtColor, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      item.isExpand!
                          ? Container()
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  transotationHistoryC.exapndItem(item);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  height: 34,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: AppTheme.borderColor,
                                      )),
                                  child: Center(
                                    child: KText(
                                      text: 'Timeline View',
                                      fontSize: 15,
                                      color: AppTheme.primaryColor,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }),
    );
  }
}

class InTransitTransportHistoryPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    transotationHistoryC.getTranspotationHistory('IN_TRANSIT');
    return Obx(
      () => transotationHistoryC.allHistoryList.isEmpty
          ? Center(child: Loading())
          : ListView.builder(
              itemCount: transotationHistoryC.allHistoryList.length,
              itemBuilder: (context, index) {
                final item = transotationHistoryC.allHistoryList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 34,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            color: AppTheme.borderColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ExpandIcon(
                                  color: Colors.grey,
                                  expandedColor: Colors.grey,
                                  disabledColor: Colors.grey,
                                  isExpanded: item.isExpand!,
                                  onPressed: (v) {
                                    transotationHistoryC.exapndItem(item);
                                  },
                                ),
                                KText(text: 'transport oder no.'),
                              ],
                            ),
                            KText(
                              text: item.transportOrderNo,
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETS',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.ets!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETD',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.etd!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RenderImg(path: 't1.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: item.vehicleRegNo,
                                fontSize: 15,
                                color: AppTheme.textColor,
                                bold: true,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: RenderImg(
                                      path: 'p1.png',
                                    ),
                                  ),
                                  KText(
                                    text: item.driverName,
                                    color: AppTheme.textfieldColor,
                                    fontSize: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Transport Agency',
                              color: AppTheme.textfieldColor,
                              fontSize: 13,
                            ),
                            Spacer(),
                            Flexible(
                              child: KText(
                                text: item.transporterAgencyName,
                                color: AppTheme.txtColor,
                                fontSize: 14,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Visibility(
                          visible: item.isExpand!,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Items',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      width: Get.width * .7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: item.items!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              KText(
                                                text: item.items![index],
                                                color: AppTheme.txtColor,
                                                fontSize: 14,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Source',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.sourceLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Destination',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.destinationLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Distance',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.distanceKm.toString(),
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Map View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: FlutterMap(
                                  mapController: mapViewC.kMapController,
                                  options: MapOptions(
                                    center: LatLng(23.777176, 90.412521),
                                    zoom: 15.0,
                                    minZoom: 1.0,
                                    maxZoom: 90,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.ctrendssoftware.workforce',
                                    ),
                                    CircleLayer(circles: [
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4100),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.primaryColor,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4135),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4120),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7774, 90.4149),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7760, 90.4159),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.delivrdColor,
                                      ),
                                    ]),
                                    MarkerLayer(markers: [
                                      Marker(
                                        //marker
                                        width: 30.0,
                                        height: 30.0,
                                        builder: (context) {
                                          return GestureDetector(
                                              onTap: () {},
                                              child: RenderImg(
                                                path: 'loc.png',
                                                height: 30,
                                                width: 30,
                                              ));
                                        },
                                        point: LatLng(23.7760, 90.4135),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.primaryColor,
                                  ),
                                  KText(text: 'Starting'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.color2,
                                  ),
                                  KText(text: 'Drop'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.plocColor,
                                  ),
                                  KText(text: 'Present Location'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.delivrdColor,
                                  ),
                                  Flexible(child: KText(text: 'Destination')),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Timeline View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Starting Place'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '12:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-1'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '02:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-2'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '07:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: RenderImg(path: 'loc_2.png'),
                                              ),
                                              KText(text: 'Present Location'),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 18),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-3'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '01:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.delivrdColor,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination Place'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 29,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 76,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 125,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 174,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 219,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 268,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 302,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Remarks from Transport Agency',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Remarks from Transport AgencyBind the poles strongly. Because the truck may tremble at times.',
                                        style: TextStyle(color: AppTheme.txtColor, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      item.isExpand!
                          ? Container()
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  transotationHistoryC.exapndItem(item);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  height: 34,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: AppTheme.borderColor,
                                      )),
                                  child: Center(
                                    child: KText(
                                      text: 'Timeline View',
                                      fontSize: 15,
                                      color: AppTheme.primaryColor,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }),
    );
  }
}

class DeliveredTransportHistoryPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    transotationHistoryC.getTranspotationHistory('DELIVERED');
    return Obx(
      () => transotationHistoryC.allHistoryList.isEmpty
          ? Center(child: Loading())
          : ListView.builder(
              itemCount: transotationHistoryC.allHistoryList.length,
              itemBuilder: (context, index) {
                final item = transotationHistoryC.allHistoryList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 34,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            color: AppTheme.borderColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ExpandIcon(
                                  color: Colors.grey,
                                  expandedColor: Colors.grey,
                                  disabledColor: Colors.grey,
                                  isExpanded: item.isExpand!,
                                  onPressed: (v) {
                                    transotationHistoryC.exapndItem(item);
                                  },
                                ),
                                KText(text: 'transport oder no.'),
                              ],
                            ),
                            KText(
                              text: item.transportOrderNo,
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETS',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.ets!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETD',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.etd!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RenderImg(path: 't1.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: item.vehicleRegNo,
                                fontSize: 15,
                                color: AppTheme.textColor,
                                bold: true,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: RenderImg(
                                      path: 'p1.png',
                                    ),
                                  ),
                                  KText(
                                    text: item.driverName,
                                    color: AppTheme.textfieldColor,
                                    fontSize: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Transport Agency',
                              color: AppTheme.textfieldColor,
                              fontSize: 13,
                            ),
                            Spacer(),
                            Flexible(
                              child: KText(
                                text: item.transporterAgencyName,
                                color: AppTheme.txtColor,
                                fontSize: 14,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Visibility(
                          visible: item.isExpand!,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Items',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      width: Get.width * .7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: item.items!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              KText(
                                                text: item.items![index],
                                                color: AppTheme.txtColor,
                                                fontSize: 14,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Source',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.sourceLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Destination',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.destinationLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Distance',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.distanceKm.toString(),
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Map View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: FlutterMap(
                                  mapController: mapViewC.kMapController,
                                  options: MapOptions(
                                    center: LatLng(23.777176, 90.412521),
                                    zoom: 15.0,
                                    minZoom: 1.0,
                                    maxZoom: 90,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.ctrendssoftware.workforce',
                                    ),
                                    CircleLayer(circles: [
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4100),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.primaryColor,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4135),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4120),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7774, 90.4149),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7760, 90.4159),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.delivrdColor,
                                      ),
                                    ]),
                                    MarkerLayer(markers: [
                                      Marker(
                                        //marker
                                        width: 30.0,
                                        height: 30.0,
                                        builder: (context) {
                                          return GestureDetector(
                                              onTap: () {},
                                              child: RenderImg(
                                                path: 'loc.png',
                                                height: 30,
                                                width: 30,
                                              ));
                                        },
                                        point: LatLng(23.7760, 90.4135),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.primaryColor,
                                  ),
                                  KText(text: 'Starting'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.color2,
                                  ),
                                  KText(text: 'Drop'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.plocColor,
                                  ),
                                  KText(text: 'Present Location'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.delivrdColor,
                                  ),
                                  Flexible(child: KText(text: 'Destination')),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Timeline View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Starting Place'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '12:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-1'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '02:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-2'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '07:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: RenderImg(path: 'loc_2.png'),
                                              ),
                                              KText(text: 'Present Location'),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 18),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-3'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '01:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.delivrdColor,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination Place'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 29,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 76,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 125,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 174,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 219,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 268,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 302,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Remarks from Transport Agency',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Remarks from Transport AgencyBind the poles strongly. Because the truck may tremble at times.',
                                        style: TextStyle(color: AppTheme.txtColor, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      item.isExpand!
                          ? Container()
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  transotationHistoryC.exapndItem(item);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  height: 34,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: AppTheme.borderColor,
                                      )),
                                  child: Center(
                                    child: KText(
                                      text: 'Timeline View',
                                      fontSize: 15,
                                      color: AppTheme.primaryColor,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }),
    );
  }
}

class CancelledTransportHistoryPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    transotationHistoryC.getTranspotationHistory('CANCELLED');
    return Obx(
      () => transotationHistoryC.allHistoryList.isEmpty
          ? Center(child: Loading())
          : ListView.builder(
              itemCount: transotationHistoryC.allHistoryList.length,
              itemBuilder: (context, index) {
                final item = transotationHistoryC.allHistoryList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.borderColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 34,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            color: AppTheme.borderColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ExpandIcon(
                                  color: Colors.grey,
                                  expandedColor: Colors.grey,
                                  disabledColor: Colors.grey,
                                  isExpanded: item.isExpand!,
                                  onPressed: (v) {
                                    transotationHistoryC.exapndItem(item);
                                  },
                                ),
                                KText(text: 'transport oder no.'),
                              ],
                            ),
                            KText(
                              text: item.transportOrderNo,
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETS',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.ets!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'ETD',
                                  fontSize: 14,
                                  color: AppTheme.textfieldColor,
                                ),
                                KText(
                                  text: formatDate(date: item.etd!),
                                  fontSize: 15,
                                  color: AppTheme.txtColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RenderImg(path: 't1.png'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: item.vehicleRegNo,
                                fontSize: 15,
                                color: AppTheme.textColor,
                                bold: true,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: RenderImg(
                                      path: 'p1.png',
                                    ),
                                  ),
                                  KText(
                                    text: item.driverName,
                                    color: AppTheme.textfieldColor,
                                    fontSize: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Transport Agency',
                              color: AppTheme.textfieldColor,
                              fontSize: 13,
                            ),
                            Spacer(),
                            Flexible(
                              child: KText(
                                text: item.transporterAgencyName,
                                color: AppTheme.txtColor,
                                fontSize: 14,
                                bold: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.borderColor,
                      ),
                      Visibility(
                          visible: item.isExpand!,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Items',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      width: Get.width * .7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: item.items!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              KText(
                                                text: item.items![index],
                                                color: AppTheme.txtColor,
                                                fontSize: 14,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Source',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.sourceLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Destination',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.destinationLocName,
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Distance',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    KText(
                                      text: item.distanceKm.toString(),
                                      color: AppTheme.txtColor,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Map View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: FlutterMap(
                                  mapController: mapViewC.kMapController,
                                  options: MapOptions(
                                    center: LatLng(23.777176, 90.412521),
                                    zoom: 15.0,
                                    minZoom: 1.0,
                                    maxZoom: 90,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.ctrendssoftware.workforce',
                                    ),
                                    CircleLayer(circles: [
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4100),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.primaryColor,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4135),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7779, 90.4120),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7774, 90.4149),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.color2,
                                      ),
                                      CircleMarker(
                                        point: LatLng(23.7760, 90.4159),
                                        radius: 6,
                                        color: Colors.white,
                                        borderStrokeWidth: 4,
                                        borderColor: AppTheme.delivrdColor,
                                      ),
                                    ]),
                                    MarkerLayer(markers: [
                                      Marker(
                                        //marker
                                        width: 30.0,
                                        height: 30.0,
                                        builder: (context) {
                                          return GestureDetector(
                                              onTap: () {},
                                              child: RenderImg(
                                                path: 'loc.png',
                                                height: 30,
                                                width: 30,
                                              ));
                                        },
                                        point: LatLng(23.7760, 90.4135),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.primaryColor,
                                  ),
                                  KText(text: 'Starting'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.color2,
                                  ),
                                  KText(text: 'Drop'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.plocColor,
                                  ),
                                  KText(text: 'Present Location'),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    height: 10,
                                    width: 10,
                                    color: AppTheme.delivrdColor,
                                  ),
                                  Flexible(child: KText(text: 'Destination')),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Timeline View',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Starting Place'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '12:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-1'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '02:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-2'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '07:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: RenderImg(path: 'loc_2.png'),
                                              ),
                                              KText(text: 'Present Location'),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          height: 30,
                                          width: 97,
                                          decoration: BoxDecoration(
                                              color: AppTheme.timeBoxColor,
                                              border: Border.all(width: 1, color: AppTheme.bdrColor2),
                                              borderRadius:
                                                  BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                          child: Center(child: KText(text: '01-Oct-2022')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 18),
                                          child: Row(
                                            children: [
                                              KText(text: '10:00 am'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.color2,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination loc-3'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 22, top: 29),
                                          child: Row(
                                            children: [
                                              KText(text: '01:00 pm'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: AppTheme.delivrdColor,
                                                  child: CircleAvatar(
                                                    radius: 3,
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              KText(text: 'Destination Place'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 29,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 76,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 125,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 174,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 219,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 268,
                                      left: 96,
                                      child: Container(
                                        height: 18,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                    Positioned(
                                      top: 302,
                                      left: 96,
                                      child: Container(
                                        height: 30,
                                        width: 1,
                                        color: AppTheme.bdrColor2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppTheme.borderColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Remarks from Transport Agency',
                                      color: AppTheme.textfieldColor,
                                      fontSize: 13,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Remarks from Transport AgencyBind the poles strongly. Because the truck may tremble at times.',
                                        style: TextStyle(color: AppTheme.txtColor, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      item.isExpand!
                          ? Container()
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  transotationHistoryC.exapndItem(item);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 15),
                                  height: 34,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: AppTheme.borderColor,
                                      )),
                                  child: Center(
                                    child: KText(
                                      text: 'Timeline View',
                                      fontSize: 15,
                                      color: AppTheme.primaryColor,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }),
    );
  }
}
