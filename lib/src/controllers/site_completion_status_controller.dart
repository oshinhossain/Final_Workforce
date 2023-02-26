import 'dart:convert';

import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';

import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';

import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/convert_map_data.dart';

import 'package:workforce/src/helpers/global_dialog.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import 'package:workforce/src/models/geography.dart';

import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';

import 'package:workforce/src/services/api_service.dart';

import '../helpers/log.dart';
import '../map/dragmarker.dart';

import '../models/project_dropdown.dart';
import 'agencyController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class SiteCompletionStausController extends GetxController with ApiService {
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);

  gmap.GoogleMapController? mapController;

  final isPlotingEnable = RxBool(true);

  final isLoading = RxBool(false);
  final issubmit = RxBool(false);
  final isLoadding = RxBool(false);

  final siteLocations = Rx<ProjectSites?>(null);
  final projectSiteList = RxList<ProjectSites?>([]);

  final newPoleList = RxList<NewPole>();
  final ePoleList = RxList<ElectricityPole>();
  final noPoleList = RxList<NoPole>();
  final onBuildingList = RxList<OnBuilding>();
  final lightPostList = RxList<LightPost>();

//=======================================
  final projectSiteMarkers = RxList<Marker>();

  final projectSiteMarkers2 = RxList<DragMarker>();

  //====================================================

  final newPoleCount = RxInt(0);
  final elePoleCount = RxInt(0);
  final telPoleCount = RxInt(0);
  final lightPostCount = RxInt(0);
  final buildingCount = RxInt(0);
  final otherPoleCount = RxInt(0);

  final cableTvCount = RxInt(0);
  final localIspCount = RxInt(0);

  final wifiApCount = RxInt(0);
  final popCount = RxInt(0);
  final btsCount = RxInt(0);

  final completeCount = RxInt(0);
  final abortedCount = RxInt(0);
  final wsrCount = RxInt(0);

  final locations = RxList<Geograpphy>();

  final search = RxString('');

  final levelFullCode = RxString('');
  final geol4Id = RxString('');

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);

  // =============== To draw ploygon on map =============

  final pointsForPolygon = RxList<LatLng>([]);
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);

  // =============== To change view of map =============

  final isSateliteViewEnable = RxBool(false);
  final allMarkers = RxList<gmap.Marker>();
  final polygone = RxList<gmap.Polygon>();

  //====================== get geo area =================================

  //====================== Add site dialog =================================
  final isGoogleMap = RxBool(false);

  //-------------------------------------

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  //------------------------------------------------------
  //Get Project Name
  //------------------------------------------------------

  Future<void> getProjectName() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: ApiEndpoint.getProjectNameUrl(),
        queryParameters: params,
      );

      //// kLog(jsonEncode(res.data));
      if (res.statusCode != 404 &&
          res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final pojectInfo = res.data['data']
            .map((json) =>
                ProjectDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectDropdown>() as List<ProjectDropdown>;
        if (pojectInfo.isNotEmpty) {
          projectNameList.clear();
          projectNameList.addAll(pojectInfo);
          selectedProject.value = projectNameList[0];
        }

        isLoading.value = false;
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void getAreaByIds() async {
    // isLoading.value = true;
    final username = Get.put(UserController()).username;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'username': username,
      'areaType': 'COUNTRY UNIT',
      'areaLevel': 4,
      'polygonNeeded': true,
      'geoAreaIds': [geol4Id.value],
      'countryCode': 'BD'
    };
    pointsForPolygon.clear();
    final res = await postDynamic(
      path: ApiEndpoint.getAreaByIdsUrl(),
      body: body,
      authentication: true,
    );

    final coordinates = jsonDecode(
            res.data['data'][0]['areaPolygonJSON'] as String)['coordinates']
        as List;

    pointsForPolygon.value =
        ConvertMaPData().convertPointsForPolygon(coordinates);
    pointsForGmapPolygon.value =
        ConvertMaPData().convertPointsForGmapPolygon(coordinates);
    polygone.add(gmap.Polygon(
      fillColor: Colors.transparent,
      points: pointsForGmapPolygon,
      polygonId: gmap.PolygonId('1'),
      strokeColor: hexToColor('#00D8A0'),
      strokeWidth: 3,
    ));
  }

  void siteSearchV2() async {
    try {
      isLoading.value = true;

      final username = Get.put(UserController()).username;
      // final gMapc = Get.put(GoogleMapViewController());
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,

        'areaLevelFullCodes': [levelFullCode.value],
        'pId': selectedProject.value!.id
        // // 'areaLevelFullCode': 'BD30261429',
      };

      // kLog(body);

      final res = await postDynamic(
          path: ApiEndpoint.getSiteUrl(), body: body, authentication: true);
      // kLog(res.data);

      newPoleCount.value = 0;
      elePoleCount.value = 0;
      telPoleCount.value = 0;
      lightPostCount.value = 0;
      buildingCount.value = 0;
      otherPoleCount.value = 0;

      wifiApCount.value = 0;
      popCount.value = 0;
      btsCount.value = 0;
      abortedCount.value = 0;
      completeCount.value = 0;
      wsrCount.value = 0;
      final bounds = LatLngBounds();

      //================== Project Sites Circles =================

      final projectSiteListData = res.data['data']
          .map((json) => ProjectSites.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<ProjectSites>() as List<ProjectSites>;

      siteLocations.value = null;
      siteLocations.value = projectSiteListData.first;

      if (projectSiteListData.isNotEmpty) {
        projectSiteList.clear();
        projectSiteMarkers.clear();
        allMarkers.clear();
        //Add project site
        projectSiteList.addAll(projectSiteListData);

        // ignore: avoid_function_literals_in_foreach_calls
        projectSiteListData.forEach((x) async {
          if (x.pillarType == 'Electricity Pole') {
            elePoleCount.value++;
          } else if (x.pillarType == 'New Pole') {
            newPoleCount.value++;
          } else if (x.pillarType == 'Light Post') {
            lightPostCount.value++;
          } else if (x.pillarType == 'Telephone Pole') {
            telPoleCount.value++;
          } else {
            buildingCount.value++;
          }

          if (x.functionType == 'Wifi Router') {
            wifiApCount.value++;
          }

          if (x.functionType == 'POP') {
            popCount.value++;
          }
          if (x.functionType == 'BTS') {
            btsCount.value++;
          }
          if (x.workStatus == 'Completed') {
            completeCount.value++;
          }
          if (x.workStatus == 'Aborted') {
            abortedCount.value++;
          }
          if (x.workStatus == 'Started' ||
              x.workStatus == 'Restarted' ||
              x.workStatus == 'WIP') {
            wsrCount.value++;
          }
          projectSiteMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    siteCompletionDialog(x: x);
                  },
                  child: x.functionType == 'Cable Point'
                      ? x.workStatus == 'Completed'
                          ? RenderSvg(
                              path: x.pillarType == 'Electricity Pole'
                                  ? 'dot-red-complete'
                                  : x.pillarType == 'Light Post'
                                      ? 'dot-violet-complete'
                                      : x.pillarType == 'New Pole'
                                          ? 'dot-orange-complete'
                                          : x.pillarType == 'Telephone Pole'
                                              ? 'dot-blue-complete'
                                              : 'dot-black-complete')
                          : x.workStatus == 'Aborted'
                              ? RenderSvg(
                                  path: x.pillarType == 'Electricity Pole'
                                      ? 'dot-red-aborted'
                                      : x.pillarType == 'Light Post'
                                          ? 'dot-violet-aborted'
                                          : x.pillarType == 'New Pole'
                                              ? 'dot-orange-aborted'
                                              : x.pillarType == 'Telephone Pole'
                                                  ? 'dot-blue-aborted'
                                                  : 'dot-black-aborted')
                              : x.workStatus == 'Started' ||
                                      x.workStatus == 'Restarted' ||
                                      x.workStatus == 'WIP'
                                  ? RenderSvg(
                                      path: x.pillarType == 'Electricity Pole'
                                          ? 'dot-red-wip-started-restarted'
                                          : x.pillarType == 'Light Post'
                                              ? 'dot-violet-wip-started-restarted'
                                              : x.pillarType == 'New Pole'
                                                  ? 'dot-orange-wip-started-restarted'
                                                  : x.pillarType ==
                                                          'Telephone Pole'
                                                      ? 'dot-blue-wip-started-restarted'
                                                      : 'dot-black-wip-started-restarted')
                                  : RenderSvg(
                                      height: 12,
                                      path: x.pillarType == 'Electricity Pole'
                                          ? 'electricity-pole'
                                          : x.pillarType == 'Light Post'
                                              ? 'light-post'
                                              : x.pillarType == 'New Pole'
                                                  ? 'new-pole'
                                                  : x.pillarType ==
                                                          'Telephone Pole'
                                                      ? 'telephone-pole'
                                                      : 'building')
                      : Icon(
                          Icons.location_on,
                          color: x.functionType == 'Wifi Router'
                              ? Colors.green
                              : Colors.red,
                          size: 40,
                        ),
                );
              },
            ),
          );

          getMarkerImg(functionType, pillerType) {
            switch (functionType) {
              case 'Cable Point':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/pole.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/new_pole.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/light_post.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/tel.png'
                                : 'assets/img/building.png';
              case 'Wifi Router':
                return 'assets/img/wifi.png';
              case 'POP':
                return 'assets/img/pop.png';
            }
          }

          checkMarkerStatus(functionType, pillerType, workStatus) {
            switch (workStatus) {
              case 'Completed':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-complete.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-complete.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-complete.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-complete.png'
                                : 'assets/img/dot-black-complete.png';

              case 'Aborted':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-aborted.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-aborted.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-aborted.png'
                            : pillerType == 'Telephone Po le'
                                ? 'assets/img/dot-blue-aborted.png'
                                : 'assets/img/dot-black-aborted.png';
              case 'Started':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-wip-started-restarted.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-wip-started-restarted.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-wip-started-restarted.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-wip-started-restarted.png'
                                : 'assets/img/dot-black-wip-started-restarted.png';
              case 'Restarted':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-wip-started-restarted.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-wip-started-restarted.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-wip-started-restarted.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-wip-started-restarted.png'
                                : 'assets/img/dot-black-wip-started-restarted.png';
              case 'WIP':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-wip-started-restarted.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-wip-started-restarted.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-wip-started-restarted.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-wip-started-restarted.png'
                                : 'assets/img/dot-black-wip-started-restarted.png';
              default:
                return getMarkerImg(functionType, pillerType);
            }
          }

          final Uint8List markerIcon = await getBytesFromAsset(
              '${checkMarkerStatus(x.functionType, x.pillarType, x.workStatus)}',
              50);
          allMarkers.add(
            gmap.Marker(
                position: gmap.LatLng(x.latitude!, x.longitude!),
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                onTap: () {
                  siteCompletionDialog(x: x);
                }),
          );

          if (!isGoogleMap.value) {
            bounds.extend(LatLng(x.latitude!, x.longitude!));
            kMapControllerSiteLocation.fitBounds(
              bounds,
              options: const FitBoundsOptions(
                padding: EdgeInsets.all(30),
              ),
            );
          } else {
            mapController?.animateCamera(
              gmap.CameraUpdate.newCameraPosition(
                gmap.CameraPosition(
                  bearing: 270.0,
                  target: gmap.LatLng(x.latitude!, x.longitude!),
                  tilt: 30.0,
                  zoom: 14.0,
                ),
              ),
            );
          }
        });
      }

      isLoading.value =
          false; //  'geoAreaIds': ['0000825d-b253-42d0-9971-8b0354c1dfa9'],
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  searchLocationBottomSheet() async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 420,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Search Geography',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      // kLog(value);
                      if (search.value.isNotEmpty) {
                        addGeography();
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (search.value.isNotEmpty) {
                            addGeography();
                          }
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: search.value.isNotEmpty
                              ? hexToColor('#FFA133')
                              : hexToColor('#9BA9B3'),
                        ),
                      ),
                      // focusedBorder: InputBorder.none,
                      hintText: 'Search here...',
                    ),
                  ),
                  isLoadding.value
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Loading()
                            ],
                          ),
                        )
                      : locations.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: RenderSvg(
                                  path: 'search_list',
                                  width: 60,
                                  color: hexToColor('#9BA9B3'),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 280,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: locations.length,
                                  itemBuilder: (context, index) {
                                    final item = locations[index];
                                    return GestureDetector(
                                      onTap: () {
                                        levelFullCode.value =
                                            item.levelFullcode as String;
                                        geol4Id.value =
                                            item.geoLevel4Id as String;
                                        getAreaByIds();
                                        siteSearchV2();
                                        // siteSearch();
                                        //kLog(item.id);
                                        back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppTheme.textColor,
                                              width: .2,
                                            ),
                                          ),
                                        ),
                                        child: KText(
                                          text:
                                              '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
                                          bold: true,
                                          fontSize: 13,
                                          maxLines: 3,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        search.value = '';
        locations.clear();

        isLoadding.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  siteCompletionDialog({
    required ProjectSites x,
  }) {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Site Completion Status',
      widget:
          //  Obx(
          //   () =>

          Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: 'Site Name ',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                Spacer(),
                KText(
                  text: 'Site ID',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: KText(
                    text: x.siteName,
                    color: AppTheme.nTextC,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                KText(
                  text: x.siteCode,
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                KText(
                  text: 'Function Type ',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
              ],
            ),
            KText(
              text: x.functionType,
              fontSize: 14,
              color: AppTheme.nTextC,
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    KText(
                      text: 'Pole Type ',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    KText(
                      text: 'Power Source ',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: x.pillarType,
                  fontSize: 14,
                  color: AppTheme.nTextC,
                ),
                Spacer(),
                KText(
                  text: x.powerSource,
                  fontSize: 14,
                  color: AppTheme.nTextC,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: 'Place Type ',
              color: AppTheme.nTextLightC,
              fontSize: 13,
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: x.placeType,
              fontSize: 14,
              color: AppTheme.nTextC,
            ),

            SizedBox(
              width: 15,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                KText(
                  text: 'Address ',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            KText(
              text: x.siteAddress,
              color: AppTheme.nTextC,
              fontSize: 14,
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: 'Geography Point',
              color: AppTheme.nTextLightC,
              fontSize: 13,
            ),
            SizedBox(
              height: 10,
            ),
            KText(
              text: 'Lat: ${x.latitude},',
              color: AppTheme.nTextC,
              fontSize: 14,
            ),
            KText(
              //  text: 'Long: ${locationC.currentLatLng!.longitude},',
              text: 'Long: ${x.longitude},',
              color: AppTheme.nTextC,
              fontSize: 14,
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: 'Custodian Name',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                Spacer(),
                KText(
                  text: 'Mobile No.',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: KText(
                    text: x.custodianFullname != 'null' &&
                            x.custodianFullname != null
                        ? '${x.custodianFullname}'
                        : '',
                    color: AppTheme.nTextC,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                KText(
                  text: x.custodianMobile != 'null' && x.custodianMobile != null
                      ? '${x.custodianMobile}'
                      : '',
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: 'NID No.',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                Spacer(),
                KText(
                  text: 'Email',
                  color: AppTheme.nTextLightC,
                  fontSize: 13,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: x.custodianNid != 'null' && x.custodianNid != null
                      ? '${x.custodianNid}'
                      : '',
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                Spacer(),
                KText(
                  text: x.custodianEmail != 'null' && x.custodianEmail != null
                      ? '${x.custodianEmail}'
                      : '',
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            KText(
              fontSize: 13,
              text: 'Username (WF app)',
              color: AppTheme.nTextLightC,
            ),
            SizedBox(
              height: 5,
            ),
            KText(
              text: x.creatorUsername != 'null' && x.creatorUsername != null
                  ? '${x.creatorUsername}'
                  : '',
              color: AppTheme.nTextC,
              fontSize: 14,
            ),

            SizedBox(
              height: 10,
            ),
            KText(
              fontSize: 13,
              text: 'Custodian Address',
              color: AppTheme.nTextLightC,
            ),
            SizedBox(
              height: 5,
            ),

            KText(
              text: x.custodianAddress != 'null' && x.custodianAddress != null
                  ? '${x.custodianAddress}'
                  : '',
              color: AppTheme.nTextC,
              fontSize: 14,
            ),

            SizedBox(
              height: 10,
            ),

            KText(
              fontSize: 13,
              text: 'Current Status',
              color: AppTheme.nTextLightC,
            ),
            SizedBox(
              height: 5,
            ),

            KText(
              text: x.workStatus != 'null' && x.workStatus != null
                  ? '${x.workStatus}'
                  : '',
              color: AppTheme.nTextC,
              fontSize: 14,
            ),

            SizedBox(height: 25),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size?>(Size(109, 35)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      hexToColor('#FFA133'),
                    ),
                    visualDensity: VisualDensity(horizontal: 2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        // side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //  isStart.value = false;
                    back();
                  },
                  child: KText(
                    text: 'Close',
                    fontSize: 16.0,
                    bold: true,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  addGeography() async {
    try {
      if (search.value.isNotEmpty) {
        isLoadding.value = true;

        final body = {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'SURVEY',
          'uiCodes': ['0000'],
          'areaLevel': 4,
          'areaType': 'COUNTRY UNIT',
          'countryCode': 'BD',
          'searchText': search.value,
          'ids': [selectedProject.value!.id]
        };

        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrlV2(),
          body: body,
          authentication: true,
        );

        final data = res.data['data']
            .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Geograpphy>() as List<Geograpphy>;
        locations.clear();
        locations.addAll(data);
        isLoadding.value = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //--------------------------------------

  /// To get current location and show on map.
  void showCurrentLocationOnMap({bool cameraMove = false}) {
    currentLocationCircleMarker.clear();
    // if (isCurrentLocationEnable.value) {
    try {
      final currentLatLng = locationC.getCurrenLatLng();

      if (currentLatLng != null) {
        kMapControllerSiteLocation.move(currentLatLng, 14);
        currentLocationCircleMarker.add(
          CircleMarker(
            point: currentLatLng,
            radius: 9,
            useRadiusInMeter: false,
            color: Colors.blue,
            borderStrokeWidth: 3,
            borderColor: Colors.white,
          ),
        );
      }
    } catch (e) {
      // kLog(e.toString());
    }
    // }
  }

  void disposeData() {
    projectSiteMarkers.clear();
    allMarkers.clear();
    pointsForGmapPolygon.clear();
    siteLocations.value = null;
    projectSiteMarkers2.clear();

    newPoleCount.value = 0;
    elePoleCount.value = 0;
    telPoleCount.value = 0;
    lightPostCount.value = 0;
    buildingCount.value = 0;
    otherPoleCount.value = 0;

    wifiApCount.value = 0;
    popCount.value = 0;
    btsCount.value = 0;

    wsrCount.value = 0;
    abortedCount.value = 0;
    completeCount.value = 0;

    locations.clear();

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }
}
