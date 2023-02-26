import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../helpers/loading.dart';
import '../widgets/custom_textfield_with_dropdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class LinkWorkStatusPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    linkStatusC.getProjectName();

    return WillPopScope(
      onWillPop: () {
        linkStatusC.disposeData();
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
              linkStatusC.disposeData();
            },
          ),
          title: KText(
            text: 'Link Work Status',
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
                    if (linkStatusC.projectNameList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value:
                                linkStatusC.selectedProject.value!.projectName,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: linkStatusC.projectNameList.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  linkStatusC.selectedProject.value = item;
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
                                onTap: linkStatusC.searchLocationBottomSheet,
                                child: RenderSvg(
                                  path: 'icon_search_user',
                                  height: 20.0,
                                  width: 20.0,
                                  color: Color(0xff9BA9B3),
                                ),
                              )
                            ],
                          ),
                          if (linkStatusC.siteLocations.value != null)
                            KText(
                              text: linkStatusC.siteLocations.value == null
                                  ? ''
                                  : '${linkStatusC.siteLocations.value!.geoLevel2Name} > ${linkStatusC.siteLocations.value!.geoLevel3Name} > ${linkStatusC.siteLocations.value!.geoLevel4Name}',
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
              // siteCompletionC.isGoogleMap.value
              //     ?
              gmap.GoogleMap(
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
                mapType: linkStatusC.isSateliteViewEnable.value
                    ? gmap.MapType.satellite
                    : gmap.MapType.normal,
                initialCameraPosition: gmap.CameraPosition(
                  target: linkStatusC.allMarkers.isEmpty
                      ? gmap.LatLng(locationC.latLng.value.latitude,
                          locationC.latLng.value.longitude)
                      : linkStatusC.allMarkers.first.position,
                  zoom: 18,
                ),
                markers: linkStatusC.allMarkers,
                //  markers: Set<gmap.Marker>.of(siteInspectionC.allMarkers),
                // onCameraMoveStarted: ,
                // onCameraMove: (position) => CameraPosition(
                //   target: siteCompletionStatusC.allMarkers.first.position,
                //   zoom: 18,
                // ),

                onMapCreated: (gmap.GoogleMapController controller) {
                  linkStatusC.mapController = controller;
                },
                polygons: Set<gmap.Polygon>.of(linkStatusC.polygone),
                polylines: linkStatusC.googleMapLinkPolylines,
              ),
              // : FlutterMap(
              //     mapController: siteCompletionC.kMapControllerSiteLocation,
              //     options: MapOptions(
              //       absorbPanEventsOnScrollables: false,
              //       center: LatLng(locationC.currentLatLng!.latitude, locationC.currentLatLng!.longitude),
              //       zoom: 15,
              //       maxZoom: 90,
              //       onTap: (tapPosition, latLng) {
              //        // kLog(latLng);
              //       },
              //     ),
              //     children: [
              //       // ---------------google Satellite Map view -------------------
              //       TileLayer(
              //         urlTemplate: siteCompletionC.isSateliteViewEnable.value
              //             ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
              //             : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              //         userAgentPackageName: 'com.ctrendssoftware.workforce',
              //       ),

              //       // =========== To show current location on map ===============
              //       CircleLayer(
              //         circles: siteCompletionC.currentLocationCircleMarker,
              //       ),

              //       //================== Draw area polygon =====================

              //       PolygonLayer(
              //         polygonCulling: false,
              //         polygons: [
              //           Polygon(
              //             points: siteCompletionC.pointsForPolygon,
              //             // color: Colors.blue,
              //             borderStrokeWidth: 3,
              //             borderColor: hexToColor('#00D8A0'),
              //             // color: hexToColor('#e6f2d9').withOpacity(.8),
              //             // isFilled: true,
              //           ),
              //         ],
              //       ),

              //       MarkerLayer(markers: siteCompletionC.projectSiteMarkers),

              //       // MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),
              //     ],
              //   ),
              if (linkStatusC.isLoading.value)
                Positioned(top: 150, right: 150, child: Loading()),
              // Positioned(
              //   top: 15,
              //   right: 10,
              //   child: InkWell(
              //     onTap: () {
              //       linkStatusC.isGoogleMap.toggle();
              //       //  siteCompletionStatusC.disposeData();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(1.5),
              //       decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              //       child: Container(
              //         height: 35, width: 35,
              //         //  padding: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //             color: hexToColor('#9BA9B3'),
              //             //  borderRadius: BorderRadius.circular(50),
              //             shape: BoxShape.circle),
              //         child: Center(
              //           child: KText(
              //             text: linkStatusC.isGoogleMap.value ? 'F' : 'G',
              //             fontSize: 18,
              //             color: Colors.white,
              //             bold: true,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
                    linkStatusC.isPlotingEnable.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: linkStatusC.isPlotingEnable.value
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
                top: 185,
                right: 10,
                child: InkWell(
                  onTap: () {
                    linkStatusC.isSateliteViewEnable.toggle();
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
                        color: linkStatusC.isSateliteViewEnable.value
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
                    linkStatusC.showCurrentLocationOnMap();
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
              if (linkStatusC.isPlotingEnable.value)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: hexToColor('#f5f5f5').withOpacity(1),
                    ),
                    child: Column(
                      verticalDirection: VerticalDirection.down,
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
                                  linkStatusC.isPlotingEnable.toggle(),
                              icon: Icon(Icons.close),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashLength: 2,
                            dashGapRadius: .5,
                            lineThickness: 1.5,
                            dashColor: hexToColor('#D9D9D9'),
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Fiber Link ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          //  '(${networkTopologyC.ofcLength.value.round().ceilToDouble()} Km)',
                                          '(${linkStatusC.ofcLength.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    //  RenderSvg(path: 'wifiap-icon'),
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
                                      text: '12 Core ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.ofcCore12.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //test
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 16),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Row(
                        //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             SizedBox(
                        //               width: 5,
                        //             ),
                        //             KText(
                        //               text: 'Complete ',
                        //               bold: true,
                        //               fontSize: 11,
                        //             ),
                        //             KText(
                        //               text:
                        //                   //  '(${networkTopologyC.ofcLength.value.round().ceilToDouble()} Km)',
                        //                   '(${linkStatusC.completeWork.value.toStringAsFixed(2)} Km)',
                        //               color: AppTheme.siteLocationSelect,
                        //               bold: true,
                        //               fontSize: 11,
                        //             ),
                        //             Spacer(),
                        //             //  RenderSvg(path: 'wifiap-icon'),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 20,
                        //       ),
                        //       Expanded(
                        //         child: Row(
                        //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             SizedBox(
                        //               width: 5,
                        //             ),
                        //             KText(
                        //               text: '12 Core ',
                        //               bold: true,
                        //               fontSize: 11,
                        //             ),
                        //             KText(
                        //               text:
                        //                   '(${linkStatusC.ofcCore12.value.toStringAsFixed(2)} Km)',
                        //               color: AppTheme.siteLocationSelect,
                        //               bold: true,
                        //               fontSize: 11,
                        //             ),
                        //             Spacer(),
                        //             Container(
                        //               height: 5,
                        //               width: 15,
                        //               color: Colors.green,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

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
                                      width: 5,
                                    ),
                                    KText(
                                      text: '4 Core ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.ofcCore4.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.blue,
                                    )
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
                                      text: '24 Core',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.ofcCore24.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.red,
                                    )
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: '8 Core ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.ofcCore8.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.purple,
                                    )
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
                                      text: 'Other Cores',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.ofcCoreOthers.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.orange,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashLength: 2,
                            dashGapRadius: .5,
                            lineThickness: 1.5,
                            dashColor: hexToColor('#D9D9D9'),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        //test---------//

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
                                      text: 'Link lenght ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.linkLenght.toStringAsFixed(2)})',
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
                                      text: 'Not Started ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.notStartedWork.toStringAsFixed(2)})',
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Started ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.startedWork.toStringAsFixed(2)})',
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
                                      text: 'WIP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.wipWork.toStringAsFixed(2)})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'wifiap-icon'),
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Aborted ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.abortedWork.toStringAsFixed(2)})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'light-post'),
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
                                      text: 'Restarted ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.restartedWork.toStringAsFixed(2)})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'wifiap-icon'),
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Completed ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${linkStatusC.completeWork.toStringAsFixed(2)})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'light-post'),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        //------------//
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashLength: 2,
                            dashGapRadius: .5,
                            lineThickness: 1.5,
                            dashColor: hexToColor('#D9D9D9'),
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Wifi AP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${linkStatusC.wifiApCount})',
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
                                      text: '(${linkStatusC.lightPostCount})',
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'POP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${linkStatusC.popCount})',
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
                                      text: '(${linkStatusC.buildingCount})',
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
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'New Pole  ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text: '(${linkStatusC.newPoleCount})',
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
                                      text: '(${linkStatusC.btsCount})',
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
                                      text: '(${linkStatusC.elePoleCount})',
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
                                      text: '(${linkStatusC.telPoleCount})',
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
                                          // '(${networkTopologyC.otherMarkers.length})',
                                          '(${linkStatusC.cableTvCount})',
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 05),
                                      child: KText(
                                        text: 'Local ISP ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      text: '(${linkStatusC.localIspCount}) ',
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
                                          // '(${networkTopologyC.otherMarkers.length})',
                                          '(${linkStatusC.otherPoleCount})',
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
                          height: 30,
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
