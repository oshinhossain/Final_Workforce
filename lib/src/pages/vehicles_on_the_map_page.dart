import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';

import '../config/app_theme.dart';

import '../helpers/hex_color.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';

// ignore: must_be_immutable
class VehicleOnTheMapPage extends StatelessWidget with Base {
  List<LatLng> points = <LatLng>[
    LatLng(23.7779, 90.4100),
    LatLng(23.7779, 90.4135),
    LatLng(23.7779, 90.4120),
    LatLng(23.7774, 90.4149),
    LatLng(23.7760, 90.4159),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            back();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KText(text: 'Vehicles on The Map', bold: true, fontSize: 15),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  // mapFilter();
                  vehicleOnTheMapC.isPlotingEnable.toggle();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: AppTheme.bdrColor2, width: 1),
                  ),
                  height: 40,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KText(text: 'Filter', fontSize: 15),
                      SizedBox(
                        width: 10,
                      ),

                      Icon(
                        vehicleOnTheMapC.isPlotingEnable.value
                            ? EvaIcons.arrowIosUpwardOutline
                            : EvaIcons.arrowIosDownwardOutline,
                        color: hexToColor('#80939D'),
                      ),
                      //  RenderSvg(path: 'dropdown'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        titleSpacing: -1,
        shadowColor: AppTheme.black,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => SizedBox(
                    height: Get.height - 90,
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController:
                              vehicleOnTheMapC.kVehicleOnTheMapController,
                          options: MapOptions(
                            center: LatLng(23.7779, 90.4100),
                            zoom: 15.0,
                            minZoom: 1.0,
                            maxZoom: 90,
                          ),
                          children: [
                            TileLayer(
                              userAgentPackageName:
                                  'com.ctrendssoftware.workforce',
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              // subdomains: ['a', 'b', 'c'],
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
                                        height: 100,
                                        width: 100,
                                      ));
                                },
                                point: LatLng(23.7779, 90.4100),
                              ),
                            ]),
                            PolylineLayer(
                              polylineCulling: true,
                              polylines: [
                                Polyline(
                                  points: points,
                                  color: hexToColor('#000000'),
                                  //  isDotted: true,
                                  borderColor: Colors.tealAccent,
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 2,
                                  borderStrokeWidth: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (vehicleOnTheMapC.isPlotingEnable.value)
                          Positioned(
                            top: 0,
                            child: Container(
                              width: Get.width,
                              height: 260,
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            KText(
                                                text: 'Transport Order',
                                                color: AppTheme.nTextC),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: transportOrderBottomSheet,
                                              child: RenderSvg(
                                                path: 'icon_search_elements',
                                                width: 26,
                                                color: hexToColor('#66A1D9'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        KText(
                                            text: 'S123456',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Vehicle',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'DH-KHA 21345',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Transport Agency',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Dhaka Transport Agency',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Customer (TO)',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'BMTF',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Source District',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Gazipur',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Destination District',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Jessore',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 34,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: hexToColor('#007BEC'),
                                    ),
                                    child: Center(
                                      child: KText(
                                          text: 'Filter',
                                          bold: true,
                                          fontSize: 16,
                                          color: hexToColor('#FFFFFF')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 40,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppTheme.white.withOpacity(.7),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              hexToColor('#007BEC')),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                    child: Text(''),
                                  ),
                                ),
                                SizedBox(width: 5),
                                KText(text: 'Start Place', fontSize: 10),
                                SizedBox(width: 5),
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: TextButton(
                                    onPressed: () {
                                      print('object');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              hexToColor('#FFA133')),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                    child: Text(''),
                                  ),
                                ),
                                SizedBox(width: 5),
                                KText(text: 'Drop Location', fontSize: 10),
                                SizedBox(width: 5),
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: TextButton(
                                    onPressed: () {
                                      print('object');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              hexToColor('#8F0CF5')),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                    child: Text(''),
                                  ),
                                ),
                                SizedBox(width: 5),
                                KText(text: 'Vehicle', fontSize: 10),
                                SizedBox(width: 5),
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: TextButton(
                                    onPressed: () {
                                      print('object');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              hexToColor('#00D8A0')),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                    child: Text(''),
                                  ),
                                ),
                                SizedBox(width: 5),
                                KText(text: 'Destination', fontSize: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  transportOrderBottomSheet() async {
    try {
      await Get.bottomSheet(
          isScrollControlled: true,
          persistent: false,
          isDismissible: true,
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 500,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ));

      //backgroundColor: Colors.white,

    } catch (e) {
      print(e);
    }
  }
}
