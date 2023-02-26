import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../widgets/custom_textfield_with_dropdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class NetworkTopologyPage extends StatefulWidget {
  @override
  State<NetworkTopologyPage> createState() => _NetworkTopologyPageState();
}

class _NetworkTopologyPageState extends State<NetworkTopologyPage> with Base {
  @override
  void dispose() {
    networkTopologyC.siteLocations.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  networkTopologyC.siteSearch();
    networkTopologyC.getProjectName();

    return WillPopScope(
      onWillPop: () {
        networkTopologyC.disposeData();
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
              networkTopologyC.disposeData();
              back();
            },
          ),
          title: KText(
            text: 'Network Topology on Map',
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
                    if (networkTopologyC.projectNameList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: networkTopologyC.selectedProject.value!.id,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: networkTopologyC.projectNameList.map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  networkTopologyC.selectedProject.value = item;
                                },
                                value: item.id,
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
                              networkTopologyC.projectId.value = item!;

                              // kLog(networkTopologyC.projectId.value);
                            },
                          ),
                        ),
                      ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           KText(
                    //             text: 'Area Type',
                    //             color: hexToColor('#80939D'),
                    //             fontSize: 13,
                    //           ),
                    //           KText(
                    //             text: 'Country Unit',
                    //             color: hexToColor('#515D64'),
                    //             fontSize: 14,
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           KText(
                    //             text: 'Level',
                    //             color: hexToColor('#80939D'),
                    //             fontSize: 13,
                    //           ),
                    //           KText(
                    //             text: '4',
                    //             color: hexToColor('#515D64'),
                    //             fontSize: 14,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              KText(
                                text: 'Geography ',
                                color: hexToColor('#80939D'),
                                fontSize: 13,
                              ),
                              KText(
                                text: '*',
                                color: Colors.red,
                                bold: true,
                              ),
                              SizedBox(width: 1),
                              InkWell(
                                onTap:
                                    networkTopologyC.searchLocationBottomSheet,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
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
                          if (networkTopologyC.siteLocations.value != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: KText(
                                  maxLines: 3,
                                  text: networkTopologyC.siteLocations.value ==
                                          null
                                      ? ''
                                      : '${networkTopologyC.siteLocations.value!.geoLevel2Name} > ${networkTopologyC.siteLocations.value!.geoLevel3Name} > ${networkTopologyC.siteLocations.value!.geoLevel4Name}'),
                            ),
                        ],
                      ),
                    ),

                    Divider(
                      height: 1,
                      color: hexToColor('#80939D'),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.share,
                    //         color: Colors.amber,
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       KText(
                    //         text: 'Topology on Map',
                    //         fontSize: 18,
                    //         color: hexToColor('#41525A'),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Expanded(
                    //           child: KText(
                    //               text: networkTopologyC
                    //                           .siteLocationsV2.value ==
                    //                       null
                    //                   ? ''
                    //                   : '${networkTopologyC.siteLocationsV2.value!.commonFields!.level2name} > ${networkTopologyC.siteLocationsV2.value!.commonFields!.level3name} > ${networkTopologyC.siteLocationsV2.value!.commonFields!.level4name}'),
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.only(right: 10),
                    //           child: GestureDetector(
                    //             onTap:
                    //                 networkTopologyC.searchLocationBottomSheet,
                    //             child: RenderSvg(
                    //               path: 'icon_search_user',
                    //               height: 20.0,
                    //               width: 20.0,
                    //               color: Color(0xff9BA9B3),
                    //             ),
                    //           ),
                    //         )
                    //       ]),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:
            //  networkTopologyC.siteLocations.value == null
            //     ? Center(child: KText(text: 'No Data Found'))
            //     :
            Obx(
          () => Stack(
            children: [
              // !networkTopologyC.isGoogleMap.value
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
                mapType: networkTopologyC.isSateliteViewEnable.value
                    ? gmap.MapType.satellite
                    : gmap.MapType.normal,
                initialCameraPosition: gmap.CameraPosition(
                  target: networkTopologyC.googleMapMarkers.isEmpty
                      ? gmap.LatLng(locationC.latLng.value.latitude,
                          locationC.latLng.value.longitude)
                      : networkTopologyC.googleMapMarkers.first.position,
                  zoom: 18,
                ),
                markers: Set<gmap.Marker>.of(
                    networkTopologyC.googleMapProjectSiteMarkers),
                // onCameraMoveStarted: ,
                onCameraMove: (position) => gmap.CameraPosition(
                  target: networkTopologyC.googleMapMarkers.isEmpty
                      ? gmap.LatLng(locationC.latLng.value.latitude,
                          locationC.latLng.value.longitude)
                      : networkTopologyC.googleMapMarkers.first.position,
                  zoom: 18,
                ),
                onMapCreated: (gmap.GoogleMapController controller) {
                  networkTopologyC.mapController = controller;
                },
                polygons:
                    Set<gmap.Polygon>.of(networkTopologyC.googleMapPolygone),
                polylines: Set<gmap.Polyline>.of(
                    networkTopologyC.googleMapLinkPolylines),
              ),
              // : FlutterMap(
              //     mapController: networkTopologyC.kMapControllerSiteLocation,
              //     options: MapOptions(
              //       center: LatLng(locationC.latLng.value.latitude, locationC.latLng.value.longitude),
              //       //   center: LatLng(23.5414747089055, 90.78792035579683),
              //       zoom: 13,
              //       maxZoom: 90,
              //     ),
              //     children: [
              //       // ---------------google Satellite Map view -------------------
              //       // 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
              //       // 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
              //       TileLayer(
              //         //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              //         urlTemplate: networkTopologyC.isSateliteViewEnable.value
              //             ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
              //             : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              //         userAgentPackageName: 'com.ctrendssoftware.workforce',
              //       ),

              //       // =========== To show current location on map ===============
              //       CircleLayer(
              //         circles: networkTopologyC.currentLocationCircleMarker,
              //       ),

              //       //================== Draw area polygon =====================

              //       PolygonLayer(
              //         polygonCulling: false,
              //         polygons: [
              //           Polygon(
              //             points: networkTopologyC.pointsForPolygon,
              //             // color: Colors.blue,
              //             borderStrokeWidth: 3,
              //             borderColor: hexToColor('#00D8A0'),
              //             // color: hexToColor('#e6f2d9').withOpacity(.8),
              //             // isFilled: true,
              //           ),
              //         ],
              //       ),

              //       PolylineLayer(
              //         polylineCulling: false,
              //         polylines: networkTopologyC.linkPolylines,
              //       ),

              //       // MarkerLayer(markers: networkTopologyC.markers),

              //       MarkerLayer(
              //           markers: networkTopologyC.editMarker.value
              //               ? networkTopologyC.projectSiteEditMarkers
              //               : networkTopologyC.projectSiteMarkers),
              //     ],
              //   ),
              if (networkTopologyC.isLoading.value)
                Positioned(top: 150, right: 150, child: Loading()),
              Positioned(
                // bottom: 0,
                top: 50,
                right: 10,
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     networkTopologyC.isGoogleMap.toggle();
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(1.5),
                    //     decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    //     child: Container(
                    //       height: 35, width: 35,
                    //       //  padding: EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //           color: hexToColor('#9BA9B3'),
                    //           //  borderRadius: BorderRadius.circular(50),
                    //           shape: BoxShape.circle),
                    //       child: Center(
                    //         child: KText(
                    //           text: !networkTopologyC.isGoogleMap.value ? 'O' : 'G',
                    //           fontSize: 18,
                    //           color: Colors.white,
                    //           bold: true,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 5),
                    InkWell(
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
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        networkTopologyC.isPlotingEnable.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: networkTopologyC.isPlotingEnable.value
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
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        networkTopologyC.isSateliteViewEnable.toggle();
                        // networkTopologyC.getAreaByIds();
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
                            color: networkTopologyC.isSateliteViewEnable.value
                                ? null
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        // networkTopologyC.getAreaByIds();
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
                          child: RenderSvg(
                            path: 'refresh_icon',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    if (!networkTopologyC.isGoogleMap.value)
                      GestureDetector(
                        onTap: () {
                          if (networkTopologyC.isGoogleMap.value) {
                            // kLog('Get current location');
                          } else {
                            networkTopologyC.showCurrentLocationOnMap();
                          }
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
                    SizedBox(height: 5),
                  ],
                ),
              ),
              if (networkTopologyC.isPlotingEnable.value)
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
                                text: 'Legends: ',
                                fontSize: 13,
                                bold: true,
                                color: Colors.black,
                              ),
                              if (networkTopologyC.applianceList.isNotEmpty)
                                SizedBox(
                                  width: 35,
                                  height: 32,
                                  child: TextButton(
                                      onPressed: () {
                                        networkTopologyC.editMarker.toggle();
                                        if (networkTopologyC.editMarker.value) {
                                          networkTopologyC.siteSearchV2();
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
                                              color: networkTopologyC
                                                      .editMarker.value
                                                  ? Colors.greenAccent
                                                  : Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: networkTopologyC.editMarker.value
                                            ? Colors.greenAccent
                                            : Colors.blueAccent,
                                      )),
                                ),
                              IconButton(
                                onPressed: () =>
                                    networkTopologyC.isPlotingEnable.toggle(),
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
                                      text: 'Fiber Link ',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    KText(
                                      text:
                                          //  '(${networkTopologyC.ofcLength.value.round().ceilToDouble()} Km)',
                                          '(${networkTopologyC.ofcLength.value.toStringAsFixed(2)} Km)',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    // RenderSvg(path: 'wifiap-icon'),
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
                                          '(${networkTopologyC.ofcCore12.value.toStringAsFixed(2)} Km)',
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
                                      text: '4 Core ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${networkTopologyC.ofcCore4.value.toStringAsFixed(2)} Km)',
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
                                          '(${networkTopologyC.ofcCore24.value.toStringAsFixed(2)} Km)',
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
                                      text: '8 Core ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${networkTopologyC.ofcCore8.value.toStringAsFixed(2)} Km)',
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
                                          '(${networkTopologyC.ofcCoreOthers.value.toStringAsFixed(2)} Km)',
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
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashColor: hexToColor('#D9D9D9'),
                          ),
                        ),
                        SizedBox(
                          height: 8,
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
                                      text: '(${networkTopologyC.wifiApCount})',
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
                                          '(${networkTopologyC.lightPostCount})',
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
                                      text: '(${networkTopologyC.popCount})',
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
                                          '(${networkTopologyC.buildingCount})',
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
                                          '(${networkTopologyC.newPoleCount})',
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
                                      text: '(${networkTopologyC.btsCount})',
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
                                          '(${networkTopologyC.elePoleCount})',
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
                                      text:
                                          '(${networkTopologyC.telPoleCount})',
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
                                          '(${networkTopologyC.cableTvCount})',
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
                                      text:
                                          '(${networkTopologyC.localIspCount}) ',
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
                                          '(${networkTopologyC.otherPoleCount})',
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
