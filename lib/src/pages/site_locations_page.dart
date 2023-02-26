import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../widgets/custom_textfield_with_dropdown.dart';

class SiteLocationsPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    //  siteLocationsC.siteSearch();
    siteLocationsC.getProjectName();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            back();
          },
        ),
        title: KText(
          text: 'Site Locations',
          bold: true,
          fontSize: 16,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                top: BorderSide(width: 1.5, color: Colors.grey.shade300),
              ),
            ),
            child: Obx(
              () => Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (siteLocationsC.projectNameList.isNotEmpty)
                      Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: siteLocationsC.selectedProject.value!.projectName,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: siteLocationsC.projectNameList.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  siteLocationsC.selectedProject.value = item;
                                },
                                value: item.projectName,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 20,
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
                            onChanged: (item) {},
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: KText(
                              text: siteLocationsC.siteLocationsV2.value == null
                                  ? ''
                                  : '${siteLocationsC.siteLocationsV2.value!.commonFields!.level2name} > ${siteLocationsC.siteLocationsV2.value!.commonFields!.level3name} > ${siteLocationsC.siteLocationsV2.value!.commonFields!.level4name}'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: siteLocationsC.searchLocationBottomSheet,
                            child: RenderSvg(
                              path: 'icon_search_user',
                              height: 20.0,
                              width: 20.0,
                              color: Color(0xff9BA9B3),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            FlutterMap(
              mapController: siteLocationsC.kMapControllerSiteLocation,
              options: MapOptions(
                center: LatLng(23.5414747089055, 90.78792035579683),
                zoom: 13,
                maxZoom: 90,
              ),
              children: [
                // ---------------google Satellite Map view -------------------
                // 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
                // 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
                TileLayer(
                  //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  urlTemplate: siteLocationsC.isSateliteViewEnable.value
                      ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
                      : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.ctrendssoftware.workforce',
                ),

                CircleLayer(
                  circles: siteLocationsC.currentLocationCircleMarker,
                ),

                //================== Draw area polygon =====================

                PolygonLayer(
                  polygonCulling: false,
                  polygons: [
                    Polygon(
                        points: siteLocationsC.pointsForPolygon,
                        // color: Colors.blue,
                        borderStrokeWidth: 3,
                        borderColor: hexToColor('#00D8A0')
                        // color: hexToColor('#e6f2d9').withOpacity(.8),
                        // isFilled: true,
                        ),
                  ],
                ),

                // MarkerLayer(markers: siteLocationsC.markers),

                if (siteLocationsC.isEPole.value == true) MarkerLayer(markers: siteLocationsC.ePoleMarkers),

                if (siteLocationsC.isPop.value == true) MarkerLayer(markers: siteLocationsC.popMarkers),
                if (siteLocationsC.isTelPole.value == true) MarkerLayer(markers: siteLocationsC.telPoleMarkers),
                if (siteLocationsC.isLocalIsp.value == true) MarkerLayer(markers: siteLocationsC.localIspMarkers),
                if (siteLocationsC.isnewPole.value == true) MarkerLayer(markers: siteLocationsC.newPoleMarkers),
                if (siteLocationsC.isBuilding.value == true) MarkerLayer(markers: siteLocationsC.buildingMarkers),
                if (siteLocationsC.isBts.value == true) MarkerLayer(markers: siteLocationsC.btsMarkers),
                if (siteLocationsC.islightPost.value == true) MarkerLayer(markers: siteLocationsC.lightPostMarkers),
                if (siteLocationsC.isFootPrint.value == true) MarkerLayer(markers: siteLocationsC.footPrintMarkers),
                if (siteLocationsC.isOther.value == true) MarkerLayer(markers: siteLocationsC.otherMarkers),
                if (siteLocationsC.isCableTv.value == true) MarkerLayer(markers: siteLocationsC.cableTvMarkers),
                if (siteLocationsC.isWifi.value == true) MarkerLayer(markers: siteLocationsC.wifiMarkers),
              ],
            ),
            if (siteLocationsC.isLoading.value) Positioned(top: 150, right: 150, child: Loading()),
            Positioned(
              bottom: 290,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  siteLocationsC.showCurrentLocationOnMap();
                },
                child: Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: siteLocationsC.currentLocationCircleMarker.isNotEmpty
                            ? AppTheme.siteLocationSelect
                            : hexToColor('#9BA9B3'),
                        borderRadius: BorderRadius.circular(50)),
                    child: RenderSvg(
                      path: 'my_place_active',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: InkWell(
                onTap: () {
                  siteLocationsC.isPlotingEnable.toggle();
                },
                child: Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // color: AppTheme.siteLocationSelect ,
                      color: siteLocationsC.isPlotingEnable.value ? AppTheme.siteLocationSelect : hexToColor('#9BA9B3'),
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
              top: 80,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(1.5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
                  child: RenderSvg(
                    path: 'info-icon',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              right: 10,
              child: InkWell(
                onTap: () {
                  siteLocationsC.isSateliteViewEnable.toggle();
                  // siteLocationsC.getAreaByIds();
                },
                child: Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.map,
                      color: siteLocationsC.isSateliteViewEnable.value ? null : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 10,
              child: InkWell(
                onTap: () {
                  // siteLocationsC.getAreaByIds();
                },
                child: Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
                    child: RenderSvg(
                      path: 'refresh_icon',
                    ),
                  ),
                ),
              ),
            ),
            if (siteLocationsC.isPlotingEnable.value)
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: 280,
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
                              text: 'Legends: ',
                              fontSize: 13,
                              bold: true,
                              color: Colors.black,
                            ),
                            GestureDetector(
                              onTap: () {
                                siteLocationsC.isBts.value = true;
                                siteLocationsC.isBuilding.value = true;
                                siteLocationsC.isEPole.value = true;
                                siteLocationsC.isFootPrint.value = true;
                                siteLocationsC.isOther.value = true;
                                siteLocationsC.isCableTv.value = true;
                                siteLocationsC.isPop.value = true;
                                siteLocationsC.isTelPole.value = true;
                                siteLocationsC.isLocalIsp.value = true;
                                siteLocationsC.isWifi.value = true;
                                siteLocationsC.islightPost.value = true;
                                siteLocationsC.isnewPole.value = true;
                              },
                              child: KText(
                                text: '[Select all]',
                                color: AppTheme.siteLocationtext,
                                bold: true,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                siteLocationsC.isBts.value = false;
                                siteLocationsC.isBuilding.value = false;
                                siteLocationsC.isEPole.value = false;
                                siteLocationsC.isFootPrint.value = false;
                                siteLocationsC.isOther.value = false;
                                siteLocationsC.isCableTv.value = false;
                                siteLocationsC.isPop.value = false;
                                siteLocationsC.isTelPole.value = false;
                                siteLocationsC.isLocalIsp.value = false;
                                siteLocationsC.isWifi.value = false;
                                siteLocationsC.islightPost.value = false;
                                siteLocationsC.isnewPole.value = false;
                              },
                              child: KText(
                                text: '[Deselect all]',
                                bold: true,
                                color: AppTheme.siteLocationtext,
                              ),
                            ),
                            IconButton(
                              onPressed: () => siteLocationsC.isPlotingEnable.toggle(),
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isWifi.value,
                                        onChanged: (_) {
                                          siteLocationsC.isWifi.toggle();
                                          // siteLocationsC.kMapControllerSiteLocation
                                          //     .move(LatLng(23.531003989570795, 90.78254520893097), 13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Wifi AP ',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.wifiMarkers.length})',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.islightPost.value,
                                        onChanged: (_) {
                                          siteLocationsC.islightPost.toggle();

                                          // if (siteLocationsC
                                          //     .lightPostList.isNotEmpty) {
                                          //   siteLocationsC
                                          //       .kMapControllerSiteLocation
                                          //       .move(
                                          //           LatLng(
                                          //               siteLocationsC
                                          //                   .lightPostList[0]
                                          //                   .latitude!,
                                          //               siteLocationsC
                                          //                   .lightPostList[0]
                                          //                   .longitude!),
                                          //           13);
                                          // }
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Light Post',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.lightPostMarkers.length})',
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isPop.value,
                                        onChanged: (_) {
                                          siteLocationsC.isPop.toggle();
                                          // siteLocationsC.kMapControllerSiteLocation
                                          //     .move(LatLng(23.541504216565652, 90.79269468784332), 13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'POP ',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.popMarkers.length})',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isBuilding.value,
                                        onChanged: (_) {
                                          siteLocationsC.isBuilding.toggle();
                                          // if (siteLocationsC
                                          //     .onBuildingList.isNotEmpty) {
                                          //   siteLocationsC
                                          //       .kMapControllerSiteLocation
                                          //       .move(
                                          //           LatLng(
                                          //               siteLocationsC
                                          //                   .onBuildingList[0]
                                          //                   .latitude!,
                                          //               siteLocationsC
                                          //                   .onBuildingList[0]
                                          //                   .longitude!),
                                          //           13);
                                          // }
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Building',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.buildingMarkers.length})',
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isnewPole.value,
                                        onChanged: (_) {
                                          siteLocationsC.isnewPole.toggle();
                                          // siteLocationsC
                                          //     .kMapControllerSiteLocation
                                          //     .move(
                                          //         LatLng(
                                          //             siteLocationsC
                                          //                 .newPoleList[0]
                                          //                 .latitude!,
                                          //             siteLocationsC
                                          //                 .newPoleList[0]
                                          //                 .longitude!),
                                          //         13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'New Pole  ',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.newPoleMarkers.length})',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isBts.value,
                                        onChanged: (_) {
                                          siteLocationsC.isBts.toggle();
                                          siteLocationsC.kMapControllerSiteLocation
                                              .move(LatLng(23.541740277608465, 90.79306483268739), 13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'BTS ',
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isEPole.value,
                                        onChanged: (_) {
                                          siteLocationsC.isEPole.toggle();

                                          // siteLocationsC
                                          //     .kMapControllerSiteLocation
                                          //     .move(
                                          //   LatLng(
                                          //     siteLocationsC
                                          //         .ePoleList[0].latitude!,
                                          //     siteLocationsC
                                          //         .ePoleList[0].longitude!,
                                          //   ),
                                          //   13,
                                          // );
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
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
                                    text: '(${siteLocationsC.ePoleMarkers.length})',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isFootPrint.value,
                                        onChanged: (_) {
                                          siteLocationsC.isFootPrint.toggle();
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
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
                        height: 12,
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isTelPole.value,
                                        onChanged: (_) {
                                          siteLocationsC.isTelPole.toggle();
                                          // siteLocationsC.kMapControllerSiteLocation
                                          //     .move(LatLng(24.097857534493652, 90.34757673740388), 13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
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
                                    text: '(0)',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isCableTv.value,
                                        onChanged: (_) {
                                          siteLocationsC.isCableTv.toggle();
                                          // siteLocationsC
                                          //     .kMapControllerSiteLocation
                                          //     .move(
                                          //         LatLng(
                                          //             siteLocationsC
                                          //                 .noPoleList[0]
                                          //                 .latitude!,
                                          //             siteLocationsC
                                          //                 .noPoleList[0]
                                          //                 .longitude!),
                                          //         13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: KText(
                                      text: 'Cable TV Operator ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.cableTvMarkers.length})',
                                    color: AppTheme.siteLocationSelect,
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  Spacer(),
                                  RenderImg(
                                    path: 'cable_tv.jpeg',
                                    width: 17,
                                  ),
                                  // RenderSvg(path: 'others'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
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
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isLocalIsp.value,
                                        onChanged: (_) {
                                          siteLocationsC.isLocalIsp.toggle();
                                          // siteLocationsC.kMapControllerSiteLocation
                                          //     .move(LatLng(24.097857534493652, 90.34757673740388), 13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
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
                                    text: '(${siteLocationsC.localIspMarkers.length})',
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
                              width: 25,
                            ),
                            Expanded(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Checkbox(
                                        checkColor: hexToColor('#84BEF3'),
                                        activeColor: Colors.transparent,
                                        value: siteLocationsC.isOther.value,
                                        onChanged: (_) {
                                          siteLocationsC.isOther.toggle();
                                          // siteLocationsC
                                          //     .kMapControllerSiteLocation
                                          //     .move(
                                          //         LatLng(
                                          //             siteLocationsC
                                          //                 .noPoleList[0]
                                          //                 .latitude!,
                                          //             siteLocationsC
                                          //                 .noPoleList[0]
                                          //                 .longitude!),
                                          //         13);
                                        },
                                        side: MaterialStateBorderSide.resolveWith((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return BorderSide(color: Colors.red);
                                          } else {
                                            return BorderSide(color: hexToColor('#84BEF3'));
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Others ',
                                    bold: true,
                                    fontSize: 11,
                                  ),
                                  KText(
                                    text: '(${siteLocationsC.otherMarkers.length})',
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
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
