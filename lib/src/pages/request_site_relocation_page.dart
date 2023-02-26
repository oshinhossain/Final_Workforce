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
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../helpers/loading.dart';
import '../map/dragmarker.dart';
import '../widgets/custom_textfield_with_dropdown.dart';

class RequestSiteRelocationPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    requestSiteRelocationC.getProjectName();

    return WillPopScope(
      onWillPop: () {
        requestSiteRelocationC.disposeData();
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
              requestSiteRelocationC.disposeData();
              back();
            },
          ),
          title: KText(
            text: 'Setup Project Sites',
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
                    if (requestSiteRelocationC.projectNameList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: requestSiteRelocationC
                                .selectedProject.value!.projectName,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: requestSiteRelocationC.projectNameList
                                .map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  requestSiteRelocationC.selectedProject.value =
                                      item;
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
                                onTap: requestSiteRelocationC
                                    .searchLocationBottomSheet,
                                child: RenderSvg(
                                  path: 'icon_search_user',
                                  height: 20.0,
                                  width: 20.0,
                                  color: Color(0xff9BA9B3),
                                ),
                              )
                            ],
                          ),
                          if (requestSiteRelocationC.siteLocations.value !=
                              null)
                            KText(
                              text: requestSiteRelocationC
                                          .siteLocations.value ==
                                      null
                                  ? ''
                                  : '${requestSiteRelocationC.siteLocations.value!.geoLevel2Name} > ${requestSiteRelocationC.siteLocations.value!.geoLevel3Name} > ${requestSiteRelocationC.siteLocations.value!.geoLevel4Name}',
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
              requestSiteRelocationC.isGoogleMap.value
                  ? gmap.GoogleMap(
                      // controller: gMapC.kMapController,
                      myLocationEnabled: true,
                      trafficEnabled: true,
                      buildingsEnabled: true,
                      mapToolbarEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: false,
                      rotateGesturesEnabled: true,

                      // indoorViewEnabled: true,
                      mapType: gmap.MapType.normal,
                      initialCameraPosition: gmap.CameraPosition(
                        target: requestSiteRelocationC.allMarkers.isEmpty
                            ? gmap.LatLng(locationC.currentLatLng!.latitude,
                                locationC.currentLatLng!.longitude)
                            : requestSiteRelocationC.allMarkers.first.position,
                        zoom: 13,
                      ),
                      // circles: Set<gmap.Circle>.of(requestSiteRelocationC.allSites),
                      markers: requestSiteRelocationC.deleteMarker.value
                          ? Set<gmap.Marker>.of(
                              requestSiteRelocationC.dropMarkers)
                          : requestSiteRelocationC.editMarker.value
                              ? Set<gmap.Marker>.of(
                                  requestSiteRelocationC.editMarkers)
                              : requestSiteRelocationC.dragMarker.value
                                  ? Set<gmap.Marker>.of(
                                      requestSiteRelocationC.dragMarkers)
                                  : Set<gmap.Marker>.of(
                                      requestSiteRelocationC.allMarkers),
                      // onCameraMoveStarted: ,
                      onCameraMove: (position) => gmap.CameraPosition(
                        target:
                            requestSiteRelocationC.allMarkers.first.position,
                        zoom: 13,
                      ),
                      onMapCreated: (controller) =>
                          requestSiteRelocationC.mapController,
                      polygons:
                          Set<gmap.Polygon>.of(requestSiteRelocationC.polygone),
                    )
                  : FlutterMap(
                      mapController:
                          requestSiteRelocationC.kMapControllerSiteLocation,
                      options: MapOptions(
                        absorbPanEventsOnScrollables: false,
                        center: LatLng(locationC.currentLatLng!.latitude,
                            locationC.currentLatLng!.latitude),
                        zoom: 13,
                        maxZoom: 90,
                        onTap: (tapPosition, latLng) {
                          // kLog(latLng);
                          if (requestSiteRelocationC.addMarker.value) {
                            requestSiteRelocationC.addProject(latLng);
                          }
                        },
                      ),
                      children: [
                        // ---------------google Satellite Map view -------------------
                        TileLayer(
                          urlTemplate: requestSiteRelocationC
                                  .isSateliteViewEnable.value
                              ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
                              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.ctrendssoftware.workforce',
                        ),

                        // =========== To show current location on map ===============
                        CircleLayer(
                          circles: requestSiteRelocationC
                              .currentLocationCircleMarker,
                        ),

                        //================== Draw area polygon =====================

                        PolygonLayer(
                          polygonCulling: false,
                          polygons: [
                            Polygon(
                              points: requestSiteRelocationC.pointsForPolygon,
                              // color: Colors.blue,
                              borderStrokeWidth: 3,
                              borderColor: hexToColor('#00D8A0'),
                              // color: hexToColor('#e6f2d9').withOpacity(.8),
                              // isFilled: true,
                            ),
                          ],
                        ),

                        PolylineLayer(
                          polylineCulling: false,
                          polylines: requestSiteRelocationC.linkPolylines,
                        ),

                        // MarkerLayer(markers: requestSiteRelocationC.markers),
                        requestSiteRelocationC.dragMarker.value
                            ? DragMarkers(
                                markers:
                                    requestSiteRelocationC.projectSiteMarkers2,
                              )
                            : MarkerLayer(
                                markers:
                                    requestSiteRelocationC.projectSiteMarkers),
                        requestSiteRelocationC.deleteMarker.value
                            ? MarkerLayer(
                                markers: requestSiteRelocationC
                                    .projectSiteDropMarkers,
                              )
                            : MarkerLayer(
                                markers:
                                    requestSiteRelocationC.projectSiteMarkers),
                        requestSiteRelocationC.editMarker.value
                            ? MarkerLayer(
                                markers: requestSiteRelocationC
                                    .projectSiteEditMarkers,
                              )
                            : MarkerLayer(
                                markers:
                                    requestSiteRelocationC.projectSiteMarkers),

                        DragMarkers(
                          markers: requestSiteRelocationC.addProjectSiteMarkers,
                        ),
                        // MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),
                      ],
                    ),
              if (requestSiteRelocationC.isLoading.value)
                Positioned(top: 150, right: 150, child: Loading()),
              Positioned(
                top: 15,
                right: 10,
                child: InkWell(
                  onTap: () {
                    requestSiteRelocationC.isGoogleMap.toggle();
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
                          text: requestSiteRelocationC.isGoogleMap.value
                              ? 'O'
                              : 'G',
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
                        borderRadius: BorderRadius.circular(50)),
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
                    if (requestSiteRelocationC.addDriver.value) {
                      requestSiteRelocationC.addDriver.toggle();
                    } else {
                      requestSiteRelocationC.isPlotingEnable.toggle();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: requestSiteRelocationC.isPlotingEnable.value ||
                                requestSiteRelocationC.addDriver.value
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
                top: 140,
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
                top: 180,
                right: 10,
                child: InkWell(
                  onTap: () {
                    requestSiteRelocationC.isSateliteViewEnable.toggle();
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
                        color: requestSiteRelocationC.isSateliteViewEnable.value
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
                    requestSiteRelocationC.showCurrentLocationOnMap();
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
              if (requestSiteRelocationC.isPlotingEnable.value)
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
                        Container(
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 6,
                            top: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: '',
                                fontSize: 13,
                                bold: true,
                                color: Colors.black,
                              ),
                              if (requestSiteRelocationC
                                  .projectSiteList.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                    onPressed: () {
                                      requestSiteRelocationC.addMarkerDialog();
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(0)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            width: 1.5,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: RenderSvg(
                                      path: 'add_driver',
                                      height: 20,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              if (requestSiteRelocationC
                                  .projectSiteList.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                      onPressed: () {
                                        requestSiteRelocationC.addMarker.value =
                                            false;
                                        requestSiteRelocationC
                                            .deleteMarker.value = false;
                                        requestSiteRelocationC
                                            .dragMarker.value = false;

                                        requestSiteRelocationC.editMarker
                                            .toggle();
                                        if (requestSiteRelocationC
                                            .editMarker.value) {
                                          requestSiteRelocationC.siteSearchV2();
                                        }
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(0)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: BorderSide(
                                              width: 1.5,
                                              color: requestSiteRelocationC
                                                      .editMarker.value
                                                  ? Colors.greenAccent
                                                  : Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: requestSiteRelocationC
                                                .editMarker.value
                                            ? Colors.greenAccent
                                            : Colors.blueAccent,
                                      )),
                                ),
                              if (requestSiteRelocationC
                                  .projectSiteList.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                    onPressed: () {
                                      requestSiteRelocationC.addMarker.value =
                                          false;
                                      requestSiteRelocationC
                                          .deleteMarker.value = false;
                                      requestSiteRelocationC.editMarker.value =
                                          false;

                                      requestSiteRelocationC.dragMarker
                                          .toggle();
                                      if (requestSiteRelocationC
                                          .dragMarker.value) {
                                        requestSiteRelocationC.siteSearchV2();
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(0)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            width: 1.5,
                                            color: requestSiteRelocationC
                                                    .dragMarker.value
                                                ? Colors.greenAccent
                                                : Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.offline_share,
                                      color: requestSiteRelocationC
                                              .dragMarker.value
                                          ? Colors.greenAccent
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              if (requestSiteRelocationC
                                      .projectSiteList.isNotEmpty &&
                                  requestSiteRelocationC.newSite.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                    onPressed: () {
                                      requestSiteRelocationC
                                          .relocationSite('relocate');
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(0)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            width: 1.5,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Icon(Icons.done_sharp
                                        // path: 'add_driver',
                                        // height: 20,
                                        // color: Colors.blueAccent,
                                        ),
                                  ),
                                ),
                              if (requestSiteRelocationC
                                  .projectSiteList.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                    onPressed: () {
                                      requestSiteRelocationC.addMarker.value =
                                          false;
                                      requestSiteRelocationC.editMarker.value =
                                          false;
                                      requestSiteRelocationC.dragMarker.value =
                                          false;
                                      requestSiteRelocationC.deleteMarker
                                          .toggle();
                                      if (requestSiteRelocationC
                                          .deleteMarker.value) {
                                        requestSiteRelocationC.siteSearchV2();
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.all(0)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            width: 1.5,
                                            color: requestSiteRelocationC
                                                    .deleteMarker.value
                                                ? Colors.red
                                                : Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: RenderSvg(
                                      path: 'icon_delete',
                                      height: 30,
                                      color: requestSiteRelocationC
                                              .deleteMarker.value
                                          ? Colors.red
                                          : Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              IconButton(
                                onPressed: () => requestSiteRelocationC
                                    .isPlotingEnable
                                    .toggle(),
                                icon: Icon(Icons.close),
                                color: Colors.grey,
                              )
                            ],
                          ),
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text:
                                          '(${requestSiteRelocationC.wifiApCount})',
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          '(${requestSiteRelocationC.lightPostCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'light-post'),
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text:
                                          '(${requestSiteRelocationC.popCount})',
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          '(${requestSiteRelocationC.buildingCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'building'),
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text:
                                          '(${requestSiteRelocationC.newPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'new-pole'),
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
                                      text: 'BTS ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      // text: '(0)',
                                      text:
                                          '(${requestSiteRelocationC.btsCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'BTS'),
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text:
                                          '(${requestSiteRelocationC.elePoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'electricity-pole'),
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
                                      text: 'Footprints ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(0)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'footprint'),
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text:
                                          '(${requestSiteRelocationC.telPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'telephone-pole',
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
                                      text: 'Cable TV Operator ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          // '(${requestSiteRelocationC.otherMarkers.length})',
                                          '(${requestSiteRelocationC.cableTvCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderImg(
                                      path: 'cable_tv.jpeg',
                                      width: 17,
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
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Local ISP ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      //  text: '(0)',
                                      text:
                                          '(${requestSiteRelocationC.localIspCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderImg(
                                      path: 'local_isp.jpeg',
                                      width: 17,
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
                                      text: 'Others ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          // '(${requestSiteRelocationC.otherMarkers.length})',
                                          '(${requestSiteRelocationC.otherPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'others'),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
