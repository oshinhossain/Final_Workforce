import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../helpers/loading.dart';

import '../widgets/custom_textfield_with_dropdown.dart';

class SiteInspectionPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    siteInspectionC.getProjectName();

    return WillPopScope(
      onWillPop: () {
        siteInspectionC.disposeData();
        return Future(
          () => true,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              back();
              siteInspectionC.disposeData();
            },
          ),
          title: KText(
            text: 'Site Inspection',
            bold: true,
            fontSize: 16,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                  top: BorderSide(width: 1.5, color: Colors.grey.shade300),
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(height: 3),
                    if (siteInspectionC.projectNameList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: siteInspectionC
                                .selectedProject.value!.projectName,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: siteInspectionC.projectNameList.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  siteInspectionC.selectedProject.value = item;
                                  //  siteCompletionC.pId.value = item.id!;
                                },
                                value: item.projectName,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 35,
                                  ),
                                  child: SizedBox(
                                    width: Get.width / 1.3,
                                    child: KText(
                                      text: item.projectName,
                                      fontSize: 13,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (item) {
                              //// kLog('value');
                            },
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  KText(
                                    text: 'Geography',
                                    color: hexToColor('#80939D'),
                                    fontSize: 13,
                                  ),
                                  KText(
                                    text: '*',
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap:
                                    siteInspectionC.searchLocationBottomSheet,
                                child: RenderSvg(
                                  path: 'icon_search_user',
                                  height: 20.0,
                                  width: 20.0,
                                  color: Color(0xff9BA9B3),
                                ),
                              )
                            ],
                          ),
                          if (siteInspectionC.siteLocations.value != null)
                            KText(
                              text: siteInspectionC.siteLocations.value == null
                                  ? ''
                                  : '${siteInspectionC.siteLocations.value!.geoLevel2Name} > ${siteInspectionC.siteLocations.value!.geoLevel3Name} > ${siteInspectionC.siteLocations.value!.geoLevel4Name}',
                              maxLines: 3,
                            ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              siteInspectionC.isGoogleMap.value
                  ? gmap.GoogleMap(
                      // controller: gMapC.kMapController,
                      myLocationEnabled: true,
                      trafficEnabled: true,
                      buildingsEnabled: true,
                      mapToolbarEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      rotateGesturesEnabled: true,
                      // indoorViewEnabled: true,
                      mapType: gmap.MapType.normal,
                      initialCameraPosition: gmap.CameraPosition(
                        target: siteInspectionC.allMarkers.isEmpty
                            ? gmap.LatLng(locationC.latLng.value.latitude,
                                locationC.latLng.value.longitude)
                            : siteInspectionC.allMarkers.first.position,
                        zoom: 18,
                      ),
                      markers: siteInspectionC.allMarkers,
                      //  markers: Set<gmap.Marker>.of(siteInspectionC.allMarkers),
                      // onCameraMoveStarted: ,
                      // onCameraMove: (position) => CameraPosition(
                      //   target: siteCompletionStatusC.allMarkers.first.position,
                      //   zoom: 18,
                      // ),
                      onMapCreated: (gmap.GoogleMapController controller) {
                        siteInspectionC.mapController = controller;
                      },
                      polygons: Set<gmap.Polygon>.of(siteInspectionC.polygone),
                      //  polylines: siteCompletionStatusC.polyline,
                    )
                  : FlutterMap(
                      mapController: siteInspectionC.kMapControllerSiteLocation,
                      options: MapOptions(
                        absorbPanEventsOnScrollables: false,
                        center: LatLng(locationC.latLng.value.latitude,
                            locationC.latLng.value.longitude),
                        zoom: 15,
                        maxZoom: 90,
                        // onTap: (tapPosition, latLng) {
                        //  // kLog(latLng);
                        //   if (siteInspectionC.addMarker.value) {
                        //     // siteCompletionC.addProject(latLng);
                        //   }
                        // },
                      ),
                      children: [
                        // ---------------google Satellite Map view -------------------
                        TileLayer(
                          urlTemplate: siteInspectionC
                                  .isSateliteViewEnable.value
                              ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
                              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.ctrendssoftware.workforce',
                        ),

                        // =========== To show current location on map ===============
                        CircleLayer(
                          circles: siteInspectionC.currentLocationCircleMarker,
                        ),

                        //================== Draw area polygon =====================

                        PolygonLayer(
                          polygonCulling: false,
                          polygons: [
                            Polygon(
                              points: siteInspectionC.pointsForPolygon,
                              // color: Colors.blue,
                              borderStrokeWidth: 3,
                              borderColor: hexToColor('#00D8A0'),
                              // color: hexToColor('#e6f2d9').withOpacity(.8),
                              // isFilled: true,
                            ),
                          ],
                        ),

                        MarkerLayer(
                            markers: siteInspectionC.projectSiteMarkers),

                        // MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),
                      ],
                    ),
              if (siteInspectionC.isLoading.value)
                Positioned(top: 150, right: 150, child: Loading()),
              Positioned(
                top: 15,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteInspectionC.isGoogleMap.toggle();
                    //  siteCompletionStatusC.disposeData();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Container(
                      height: 35, width: 35,
                      //  padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          //  borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle),
                      child: Center(
                        child: KText(
                          text: siteInspectionC.isGoogleMap.value ? 'O' : 'G',
                          fontSize: 18,
                          color: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 10,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // color: AppTheme.siteLocationSelect ,
                        color: hexToColor('#9BA9B3'),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RenderSvg(
                        path: 'filter',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteInspectionC.isPlotingEnable.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: siteInspectionC.isPlotingEnable.value
                            ? AppTheme.siteLocationSelect
                            : hexToColor('#9BA9B3'),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RenderSvg(
                        path: 'info-icon',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 145,
                right: 10,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: RenderSvg(
                        path: 'refresh_icon',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 190,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteInspectionC.isSateliteViewEnable.toggle();
                    // requestSiteRelocationC.getAreaByIds();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.map,
                        color: siteInspectionC.isSateliteViewEnable.value
                            ? null
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // bottom: 0,
                top: 230,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteInspectionC.showCurrentLocationOnMap();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: RenderSvg(
                        path: 'my_place_active',
                      ),
                    ),
                  ),
                ),
              ),
              if (siteInspectionC.isPlotingEnable.value)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    // height: 350,
                    decoration: BoxDecoration(
                      color: hexToColor('#f5f5f5').withOpacity(1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: KText(
                                text: 'Legends:',
                                bold: true,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  siteInspectionC.isPlotingEnable.toggle(),
                              icon: Icon(Icons.close),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashColor: hexToColor('#D9D9D9'),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Wifi AP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${siteInspectionC.wifiApCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'wifiap-icon'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Light Post',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteInspectionC.lightPostCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'light-post',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'POP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${siteInspectionC.popCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'pop-icon'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Building',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteInspectionC.buildingCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'building',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'New Pole  ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${siteInspectionC.newPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'new-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Electricity Pole ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      text: '(${siteInspectionC.elePoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'electricity-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Telephone Pole ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      //  text: '(0)',
                                      text: '(${siteInspectionC.telPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'telephone-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Not-Inspected ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteInspectionC.notInspectedCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'footprint',
                                      color: Colors.transparent,
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Compliant ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      //  text: '(0)',
                                      text:
                                          '(${siteInspectionC.compliantCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Non-Compliant ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          // '(${requestSiteRelocationC.otherMarkers.length})',
                                          '(${siteInspectionC.nonCompliantCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'cross_icon',
                                      color: Colors.red,
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
