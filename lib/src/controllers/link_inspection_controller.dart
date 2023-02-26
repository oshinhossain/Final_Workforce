import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/convert_map_data.dart';
import 'package:workforce/src/helpers/global_dialog.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/area_polygon.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/links.dart';
import 'package:workforce/src/models/model_list.dart';
import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';
import 'package:workforce/src/services/api_service.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/image_compress.dart';
import '../helpers/log.dart';
import '../models/appliances.dart';
import '../models/project_dropdown.dart';
import 'agencyController.dart';

class LinkInspectionController extends GetxController with ApiService {
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);
  final isGoogleMap = RxBool(true);
  final isPlotingEnable = RxBool(true);

  final isLoading = RxBool(false);
  final issubmit = RxBool(false);
  final isLoadding = RxBool(false);

  final siteLocations = Rx<ProjectSites?>(null);
  final projectSiteList = RxList<ProjectSites?>([]);
  final applianceList = RxList<Appliances?>([]);

  final areaPolygon = Rx<AreaPolygon?>(null);

  final modelList = RxList<ModelList>();

  final locationList = RxList<SiteLocation>();

//=======================================
  final projectSiteMarkers = RxList<Marker>();

  // final isStart = RxBool(false);

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

  final notInspectedCount = RxInt(0);
  final nonCompliantCount = RxInt(0);
  final compliantCount = RxInt(0);

  final locations = RxList<Geograpphy>();

  final search = RxString('');
  final remarks = RxString('');

  final levelFullCode = RxString('');
  final geol4Id = RxString('');

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);

  // =============== To draw ploygon on map =============

  final pointsForPolygon = RxList<LatLng>([]);

  // =============== To change view of map =============

  final isSateliteViewEnable = RxBool(false);

  //====================== get geo area =================================

  final isCheck = RxBool(false);

  final veryfyResult = RxString('');

  final selectedDate = RxString('');

  //-------------------------------------
  final ofcLength = RxDouble(0);
  final ofcCore4 = RxDouble(0);
  final ofcCore8 = RxDouble(0);
  final ofcCore12 = RxDouble(0);
  final ofcCore24 = RxDouble(0);
  final ofcCoreOthers = RxDouble(0);
//-------------google map-----------------
  final allMarkers = RxSet<gmap.Marker>();
  final polygone = RxList<gmap.Polygon>();
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);
  gmap.GoogleMapController? mapController;
  final googleMapLinkPolylines = RxSet<gmap.Polyline>();
  final inspectedPolylines = RxSet<gmap.Circle>();

  //-------------------------------------
  final linkList = RxList<Links?>([]);
  final linkUpdateList = RxList<Links?>([]);

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

    // pointsForPolygon.value = ConvertMaPData().convertPointsForPolygon(coordinates);
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
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'areaLevelFullCode': levelFullCode.value,
        'projectId': selectedProject.value!.id,
      };

      // kLog(params);

      final res = await getDynamic(
          path: ApiEndpoint.getNmsNetworkLinkPointsUrl(),
          queryParameters: params,
          authentication: true);

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

      //================== Links =================

      final linkData = res.data['data']['links']
          .map((json) => Links.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<Links>() as List<Links>;

      // kLog(linkData);
      //----------------------//

      if (linkData.isNotEmpty) {
        linkList.clear();
        linkList.addAll(linkData);
        ofcLength.value = 0;
        ofcCore4.value = 0;
        ofcCore8.value = 0;
        ofcCore12.value = 0;
        ofcCore24.value = 0;
        ofcCoreOthers.value = 0;

        // ignore: avoid_function_literals_in_foreach_calls
        linkData.forEach(
          (x) async {
            List<gmap.LatLng> googleMapPoints = [];
            gmap.LatLng? point;
            // ignore: avoid_function_literals_in_foreach_calls
            x.linkPoints!.forEach((element) async {
              ofcLength.value += x.linkLengthKm!;
              //  linkLenght.value += x.linkLengthKm!;
              if (x.totalOfcCores == 4) {
                ofcCore4.value += x.linkLengthKm!;
              } else if (x.totalOfcCores == 8) {
                ofcCore8.value += x.linkLengthKm!;
              } else if (x.totalOfcCores == 12) {
                ofcCore12.value += x.linkLengthKm!;
              } else if (x.totalOfcCores == 24) {
                ofcCore24.value += x.linkLengthKm!;
              } else {
                ofcCoreOthers.value += x.linkLengthKm!;
                // notStartedWork.value += x.linkLengthKm!;
              }

              googleMapPoints
                  .add(gmap.LatLng(element.latitude!, element.longitude!));
              final middle = x.linkPoints!.length / 2;
              point = (gmap.LatLng(x.linkPoints![middle.toInt()].latitude!,
                  x.linkPoints![middle.toInt()].longitude!));
            });
            googleMapLinkPolylines.add(
              gmap.Polyline(
                polylineId: gmap.PolylineId(x.id!),
                consumeTapEvents: true,
                points: googleMapPoints,
                jointType: gmap.JointType.round,
                // endCap: gmap.Cap.roundCap,
                // startCap: gmap.Cap.roundCap,
                patterns: x.verificationResult != 'Compliant' &&
                        x.verificationResult != 'Non-compliant'
                    ? <gmap.PatternItem>[
                        gmap.PatternItem.dash(10),
                        gmap.PatternItem.gap(2),
                      ]
                    : <gmap.PatternItem>[],
                width: 5,
                onTap: () {
                  isCheck.value = x.isChecked!;
                  LinkInspectionDialog(x: x);
                },
                color: x.totalOfcCores == 4
                    ? Colors.blue
                    : x.totalOfcCores == 8
                        ? Colors.purple
                        : x.totalOfcCores == 12
                            ? Colors.green
                            : x.totalOfcCores == 24
                                ? Colors.red
                                : Colors.orange,
              ),
            );

            getMarkerImg(verificationResult) {
              switch (verificationResult) {
                case 'Compliant':
                  return 'assets/img/check.png';

                case 'Non-compliant':
                  return 'assets/img/cross.png';
              }
            }

            final Uint8List markerIcon = await ConvertMaPData()
                .getBytesFromAsset('${getMarkerImg(x.verificationResult)}', 50);

            allMarkers.add(
              gmap.Marker(
                  position: point!,
                  markerId: gmap.MarkerId(x.id!),
                  icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                  // anchor: x.functionType == 'Cable Point' ? Offset(0, 0) : Offset(0.5, 1.0),
                  onTap: () {}),
            );
          },
        );
      }

      //----------------//

      if (linkData.isNotEmpty) {
        //   //Add app liance
        //  linkList.addAll(linkData);

        // ignore: avoid_function_literals_in_foreach_calls

        linkList.clear();
        linkList.addAll(linkData);
        ofcLength.value = 0;
        ofcCore4.value = 0;
        ofcCore8.value = 0;
        ofcCore12.value = 0;
        ofcCore24.value = 0;
        ofcCoreOthers.value = 0;

        // ignore: avoid_function_literals_in_foreach_calls
        linkData.forEach((x) async {
          // ***** Google map linkPoints *****
          // --------------------------------------------------
          List<gmap.LatLng> googleMapPoints = [];
          gmap.LatLng? point;
          ofcLength.value += x.linkLengthKm!;
          if (x.totalOfcCores == 4) {
            ofcCore4.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 8) {
            ofcCore8.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 12) {
            ofcCore12.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 24) {
            ofcCore24.value += x.linkLengthKm!;
          } else {
            ofcCoreOthers.value += x.linkLengthKm!;
          }
          // ignore: avoid_function_literals_in_foreach_calls
          x.linkPoints!.forEach((element) async {
            googleMapPoints
                .add(gmap.LatLng(element.latitude!, element.longitude!));
            final middle = x.linkPoints!.length / 2;
            point = (gmap.LatLng(x.linkPoints![middle.toInt()].latitude!,
                x.linkPoints![middle.toInt()].longitude!));
          });

          //Google Map
          googleMapLinkPolylines.add(
            gmap.Polyline(
              polylineId: gmap.PolylineId(x.id!),
              consumeTapEvents: true,
              points: googleMapPoints,
              jointType: gmap.JointType.round,
              // endCap: gmap.Cap.roundCap,
              // startCap: gmap.Cap.roundCap,
              patterns: x.verificationResult != 'Compliant' &&
                      x.verificationResult != 'Non-compliant'
                  ? <gmap.PatternItem>[
                      gmap.PatternItem.dash(10),
                      gmap.PatternItem.gap(2),
                    ]
                  : <gmap.PatternItem>[],
              width: 5,
              onTap: () {
                isCheck.value = x.isChecked!;
                LinkInspectionDialog(x: x);
              },
              color: x.totalOfcCores == 4
                  ? Colors.blue
                  : x.totalOfcCores == 8
                      ? Colors.purple
                      : x.totalOfcCores == 12
                          ? Colors.green
                          : x.totalOfcCores == 24
                              ? Colors.red
                              : Colors.orange,
            ),
          );

          getMarkerImg(verificationResult) {
            switch (verificationResult) {
              case 'Compliant':
                return 'assets/img/check.png';

              case 'Non-compliant':
                return 'assets/img/cross.png';
            }
          }

          final Uint8List markerIcon = await ConvertMaPData()
              .getBytesFromAsset('${getMarkerImg(x.verificationResult)}', 50);

          allMarkers.add(
            gmap.Marker(
                position: point!,
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                // anchor: x.functionType == 'Cable Point' ? Offset(0, 0) : Offset(0.5, 1.0),
                onTap: () {}),
          );
          // --------------------------------------------------
          // ***** Google map linkPoints end *****
        });
      }

      //================== Project Sites Circles =================

      final projectSiteListData = res.data['data']['projectSites']
          .map((json) => ProjectSites.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<ProjectSites>() as List<ProjectSites>;

      siteLocations.value = null;
      siteLocations.value = projectSiteListData.first;

      if (projectSiteListData.isNotEmpty) {
        projectSiteList.clear();
        projectSiteMarkers.clear();
        //Add project site
        projectSiteList.addAll(projectSiteListData);

        // ignore: avoid_function_literals_in_foreach_calls
        projectSiteListData.forEach((x) async {
          if (x.pillarType == 'Electricity Pole') {
            elePoleCount.value++;
          } else if (x.pillarType == 'New Pole') {
            newPoleCount.value++;
          } else if (x.pillarType == 'Building/House' ||
              x.pillarType == 'On Building') {
            buildingCount.value++;
          } else if (x.pillarType == 'Light Post') {
            lightPostCount.value++;
          } else if (x.pillarType == 'Telephone Pole') {
            telPoleCount.value++;
          } else {
            // otherPoleCount.value++;
            // buildingCount.value++;
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
          if (x.verificationResult != 'Compliant' &&
              x.verificationResult == 'Non-compliant') {
            // projectSiteList[projectSiteList.indexWhere((element) => element.workStatus==x.workStatus)].
            notInspectedCount.value++;
          }
          if (x.verificationResult == 'Compliant') {
            compliantCount.value++;
          }
          if (x.verificationResult == 'Non-compliant') {
            nonCompliantCount.value++;
          }

          if (x.verificationResult == 'Compliant') {
            x.isChecked = true;
            // isCheck.value = x.isChecked!;
          } else {
            x.isChecked = false;
            // isCheck.value = x.isChecked!;
          }
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

          checkMarkerInspetionStatus(
              functionType, pillerType, workStatus, verificationResult) {
            switch (verificationResult) {
              case 'Compliant':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-check.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-check.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-check.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-check.png'
                                : 'assets/img/dot-black-check.png';

              case 'Non-compliant':
                return pillerType == 'Electricity Pole'
                    ? 'assets/img/dot-red-cross.png'
                    : pillerType == 'New Pole'
                        ? 'assets/img/dot-orange-cross.png'
                        : pillerType == 'Light Post'
                            ? 'assets/img/dot-violet-cross.png'
                            : pillerType == 'Telephone Pole'
                                ? 'assets/img/dot-blue-cross.png'
                                : 'assets/img/dot-black-cross.png';

              default:
                return checkMarkerStatus(functionType, pillerType, workStatus);
            }
          }

          final Uint8List markerIcon = await ConvertMaPData().getBytesFromAsset(
              '${checkMarkerInspetionStatus(x.functionType, x.pillarType, x.workStatus, x.verificationResult)}',
              50);
          allMarkers.add(
            gmap.Marker(
                position: gmap.LatLng(x.latitude!, x.longitude!),
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                flat: true,

                //   anchor: x.functionType == 'Cable Point' ? Offset(0.5, 0) : Offset(0.5, 1.0),
                onTap: () {
                  isCheck.value = x.isChecked!;
                  // siteInspectionDialog(x: x);
                }),
          );
          if (isGoogleMap.value) {
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

      isLoading.value = false;
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
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
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
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          nonCompliantCount.value = 0;
                          notInspectedCount.value = 0;
                          compliantCount.value = 0;
                          veryfyResult.value = '';
                          ofcLength.value = 0;
                          ofcCore4.value = 0;
                          ofcCore8.value = 0;
                          ofcCore12.value = 0;
                          ofcCore24.value = 0;
                          ofcCoreOthers.value = 0;
                          allMarkers.clear();

                          polygone.clear();
                          googleMapLinkPolylines.clear();
                          linkList.clear();
                          remarks.value = '';
                          addGeography();
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

  LinkInspectionDialog({
    required Links x,
  }) {
    locationC.locationListener();
    Color getColor(Set<MaterialState> states) {
      Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.searchColor;
    }

    GlobalDialog.addSiteDialog(
      title: 'Link Inspection',
      widget: Obx(
        () => Container(
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
                    text: 'Link Name ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  Spacer(),
                  KText(
                    text: 'Link ID',
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
                      text: x.linkName,
                      color: AppTheme.nTextC,
                      fontSize: 14,
                      maxLines: 2,
                    ),
                  ),
                  Spacer(),
                  KText(
                    text: x.linkCode,
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
                text: x.site1Address,
                fontSize: 14,
                color: AppTheme.nTextC,
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
                //   locationC.currentLatLng!.latitude
                text: 'Lat: ${x.site1Latitude},',
                color: AppTheme.nTextC,
                fontSize: 14,
              ),
              KText(
                text: 'Long: ${x.site1Longitude},',
                color: AppTheme.nTextC,
                fontSize: 14,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      KText(
                        text: 'Current Status: ',
                        color: AppTheme.nTextLightC,
                      ),
                      Spacer(),
                      KText(
                        text: 'Date',
                        color: AppTheme.nTextLightC,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      KText(
                        text: '${x.workStatus}',
                      ),
                      Spacer(),
                      GestureDetector(
                          //    onTap: selectDate,
                          child: KText(
                              text: selectedDate.value.isEmpty
                                  ? formatDate(date: DateTime.now().toString())
                                  : selectedDate.value))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //KText(text: x.isChecked.toString()),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 10,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isCheck.value,
                          onChanged: (v) {
                            updateCheckbox(x);
                            isCheck.value = x.isChecked!;
                            // kLog('checkbox value ${x.isChecked}');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      KText(
                        text: 'Site found complaint',
                        color: AppTheme.nTextLightC,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  KText(
                    text: 'Remarks',
                    color: AppTheme.nTextLightC,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: x.verifierComments != 'null' &&
                              x.verifierComments != null
                          ? '${x.verifierComments}'
                          : '',
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          updateRemarks(
                            currentItem: x,
                            remarks: value,
                          );
                        } else {
                          updateRemarks(
                            currentItem: x,
                            remarks: '',
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'remarks',
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        labelStyle: TextStyle(
                          color: hexToColor('#515D64'),
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: hexToColor('#DBECFB')),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagefiles.isEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                ),
                                itemCount: 2,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return DottedBorder(
                                    color: hexToColor('#FFE1BF'),
                                    strokeWidth: 2,
                                    dashPattern: [4, 4],
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(5),
                                    child: Container(
                                      // height: 130,
                                      width: double.infinity,
                                      color: hexToColor('#FFFBF7'),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () => pickMultiImage(),
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                            size: 15,
                                          ),
                                        ),
                                      ),

                                      //background color of inner container
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: imagefiles.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = imagefiles[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                imagefiles.removeAt(index);
                                                back();
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(60),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.white.withOpacity(0.5),
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
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133'),
                        ),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        back();
                      },
                      child: KText(
                        text: 'Close',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            // hexToColor('#007BEC'),
                            hexToColor('#007BEC')),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        //  currentStatus.value = x.workStatus!;
                        if (x.isChecked!) {
                          veryfyResult.value = 'Compliant';
                        } else {
                          veryfyResult.value = 'Non-compliant';
                        }

                        // kLog(veryfyResult.value);
                        linkUpdateList.add(x);
                        updateLinkStatus(
                          veryficationResult: veryfyResult.value,
                        );
                      },
                      child: issubmit.value
                          ? Loading(
                              color: Colors.white,
                            )
                          : KText(
                              text: 'Submit',
                              fontSize: 16.0,
                              bold: true,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
          'ids': [selectedProject.value!.id],
        };

        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrlV2(),
          body: body,
          // authentication: true,
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
        // if (cameraMove) {
        //   kMapControllerSiteLocation.move(currentLatLng, 14);
        // } else {
        //   kMapControllerSiteLocation.move(currentLatLng, kMapControllerSiteLocation.zoom);
        // }
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
    siteLocations.value = null;
    allMarkers.clear();
    polygone.clear();
    googleMapLinkPolylines.clear();
    linkList.clear();
    ofcLength.value = 0;
    ofcCore4.value = 0;
    ofcCore8.value = 0;
    ofcCore12.value = 0;
    ofcCore24.value = 0;
    ofcCoreOthers.value = 0;
    remarks.value = '';
    newPoleCount.value = 0;
    elePoleCount.value = 0;
    telPoleCount.value = 0;
    lightPostCount.value = 0;
    buildingCount.value = 0;
    otherPoleCount.value = 0;
    veryfyResult.value = '';
    nonCompliantCount.value = 0;
    notInspectedCount.value = 0;
    compliantCount.value = 0;

    wifiApCount.value = 0;
    popCount.value = 0;
    btsCount.value = 0;

    locations.clear();

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }

  updateLinkStatus({String? veryficationResult}) async {
    issubmit.value = true;
    final username = Get.put(UserController()).username;
    String? id;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'appCode': ApiEndpoint.SHOUT_APP_CODE,
      'actionType': 'inspect',
      'modelList': linkUpdateList.map((item) {
        id = item!.id;
        return {
          'id': item.id,
          'agencyId': item.agencyId,
          'agencyCode': item.agencyCode,
          'agencyName': item.agencyName,
          'projectId': selectedProject.value!.id,
          'projectCode': selectedProject.value!.projectCode,
          'projectName': selectedProject.value!.projectName,
          'linkCode': item.linkCode,
          'linkName': item.linkName,
          'linkType': item.linkType,
          'site1Code': item.site1Code,
          'site1Name': item.site1Name,
          'site1Latitude': item.site1Latitude,
          'site1Longitude': item.site1Longitude,
          'site1Address': item.site1Address,
          'site2Code': item.site2Code,
          'site2Name': item.site2Name,
          'site2Latitude': item.site2Latitude,
          'site2Longitude': item.site2Longitude,
          'site2Address': item.site2Address,
          'linkLengthKm': item.linkLengthKm,
          'linkCondition': item.linkCondition,
          'workStatusCode': item.workStatusCode,
          'workStatus': item.workStatus,
          'workStartDate': item.workStartDate,
          'onairDate': item.onairDate,
          'lifeLengthYrs': item.lifeLengthYrs,
          'eol': item.eol,
          'mediaType': item.mediaType,
          'placementType': item.placementType,
          'ductNo': item.ductNo,
          'totalCapGbps': item.totalCapGbps,
          'usedCapGbps': item.usedCapGbps,
          'availableCapGbps': item.availableCapGbps,
          'totalOfcCores': item.totalCapGbps,
          'usedOfcCores': item.usedOfcCores,
          'freeOfcCores': item.freeOfcCores,
          'site1SnmpVersion': item.site1SnmpVersion,
          'site1SnmpIp': item.site1SnmpIp,
          'site1SnmpUdpPort': item.site1SnmpUdpPort,
          'site1SnmpCommunity': item.site1SnmpCommunityString,
          'site1SnmpSecurityLevel': item.site1SnmpSecurityLevel,
          'site1SnmpAuth': item.site1SnmpAuth,
          'site1SnmpEncryption': item.site1SnmpEncryption,
          'site1SnmpUsername': item.site1SnmpUsername,
          'site1SnmpGroup': item.site1SnmpGroup,
          'site1SnmpPassword': item.site1SnmpPassword,
          'site1SnmpConnectStyle': item.site1SnmpConnectStyle,
          'site2SnmpVersion': item.site2SnmpVersion,
          'site2SnmpIp': item.site2SnmpIp,
          'site2SnmpUdpPort': item.site2SnmpUdpPort,
          'site2SnmpCommunity': item.site2SnmpCommunityString,
          'site2SnmpSecurityLevel': item.site2SnmpSecurityLevel,
          'site2SnmpAuth': item.site2SnmpAuth,
          'site2SnmpEncryption': item.site2SnmpEncryption,
          'site2SnmpUsername': item.site2SnmpUsername,
          'site2SnmpGroup': item.site2SnmpGroup,
          'site2SnmpPassword': item.site2SnmpPassword,
          'site2SnmpConnectStyle': item.site2SnmpConnectStyle,
          'providerAgencyId': item.providerAgencyId,
          'providerAgencyCode': item.providerAgencyCode,
          'providerAgencyName': item.providerAgencyName,
          'monthlyRent': item.monthlyRent,
          'contactPerson': item.contactPerson,
          'contactNumbers': item.contactNumbers,
          'areaType': item.areaType,
          'areaLevel': item.areaLevel,
          'levelType': item.levelType,
          'levelFullcode': item.levelFullcode,
          'countryCode': item.countryCode,
          'countryName': item.countryName,
          'site1GeoLevel1Id': item.site1GeoLevel1Id,
          'site1GeoLevel1Code': item.site1GeoLevel1Code,
          'site1GeoLevel1Name': item.site1GeoLevel1Name,
          'site1GeoLevel2Id': item.site1GeoLevel2Id,
          'site1GeoLevel2Code': item.site1GeoLevel2Code,
          'site1GeoLevel2Name': item.site1GeoLevel2Name,
          'site1GeoLevel3Id': item.site1GeoLevel3Id,
          'site1GeoLevel3Code': item.site1GeoLevel3Code,
          'site1GeoLevel3Name': item.site1GeoLevel3Name,
          'site1GeoLevel4Id': item.site1GeoLevel4Id,
          'site1GeoLevel4Code': item.site1GeoLevel4Code,
          'site1GeoLevel4Name': item.site1GeoLevel4Name,
          'site1GeoLevel5Id': item.site1GeoLevel5Id,
          'site1GeoLevel5Code': item.site1GeoLevel5Code,
          'site1GeoLevel5Name': item.site1GeoLevel5Name,
          'site2GeoLevel1Id': item.site2GeoLevel1Id,
          'site2GeoLevel1Code': item.site2GeoLevel1Code,
          'site2GeoLevel1Name': item.site2GeoLevel1Name,
          'site2GeoLevel2Id': item.site2GeoLevel2Id,
          'site2GeoLevel2Code': item.site2GeoLevel2Code,
          'site2GeoLevel2Name': item.site2GeoLevel2Name,
          'site2GeoLevel3Id': item.site2GeoLevel3Id,
          'site2GeoLevel3Code': item.site2GeoLevel3Code,
          'site2GeoLevel3Name': item.site2GeoLevel3Name,
          'site2GeoLevel4Id': item.site2GeoLevel4Id,
          'site2GeoLevel4Code': item.site2GeoLevel4Code,
          'site2GeoLevel4Name': item.site2GeoLevel4Name,
          'site2GeoLevel5Id': item.site2GeoLevel5Id,
          'site2GeoLevel5Code': item.site2GeoLevel5Code,
          'site2GeoLevel5Name': item.site2GeoLevel5Name,
          'verificationResult': veryficationResult,
          'verifiedOn': item.verifiedOn,
          'verifiedAt': item.verifiedAt,
          'verifierUsername': item.verifierUsername,
          'verifierFullname': item.verifierFullname,
          'verifierMobile': item.verifierMobile,
          'verifierEmail': item.verifierEmail,
          'verifierComments': item.verifierComments,
          'isInspectionCleared': item.inspectionCleared,
        };
      }).toList()
    };
    // return;
    final res = await postDynamic(
      path: ApiEndpoint.linkUpdateUrl(),
      body: body,
      authentication: true,
    );
    // kLog(body);
    // kLog('response printed');
    // kLog(res.data);
    if (res.data['status'] != null &&
        res.data['status'].contains('successful') == true) {
      issubmit.value = false;
      linkUpdateList.clear();
      linkList[linkList.indexWhere((element) => element!.id == id!)]!
          .verificationResult = veryfyResult.value;
      // kLog(veryfyResult.value);
      nonCompliantCount.value = 0;
      compliantCount.value = 0;
      notInspectedCount.value = 0;
      veryfyResult.value = '';
      remarks.value = '';

      // ignore: avoid_function_literals_in_foreach_calls
      linkList.forEach((x) async {
        List<gmap.LatLng> googleMapPoints = [];
        gmap.LatLng? point;
        // ignore: avoid_function_literals_in_foreach_calls
        x!.linkPoints!.forEach((element) {
          ofcLength.value += x.linkLengthKm!;
          if (x.totalOfcCores == 4) {
            ofcCore4.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 8) {
            ofcCore8.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 12) {
            ofcCore12.value += x.linkLengthKm!;
          } else if (x.totalOfcCores == 24) {
            ofcCore24.value += x.linkLengthKm!;
          } else {
            ofcCoreOthers.value += x.linkLengthKm!;
          }
          googleMapPoints
              .add(gmap.LatLng(element.latitude!, element.longitude!));
          final middle = x.linkPoints!.length / 2;
          point = (gmap.LatLng(x.linkPoints![middle.toInt()].latitude!,
              x.linkPoints![middle.toInt()].longitude!));
        });
        getMarkerImg(verificationResult) {
          switch (verificationResult) {
            case 'Compliant':
              return 'assets/img/check.png';

            case 'Non-compliant':
              return 'assets/img/cross.png';
          }
        }

        final Uint8List markerIcon = await ConvertMaPData()
            .getBytesFromAsset('${getMarkerImg(x.verificationResult)}', 50);

        allMarkers.add(
          gmap.Marker(
              position: point!,
              markerId: gmap.MarkerId(x.id!),
              icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
              // anchor: x.functionType == 'Cable Point' ? Offset(0, 0) : Offset(0.5, 1.0),
              onTap: () {}),
        );
        //Google Map

        // --------------------------------------------------
        // ***** Google map linkPoints end *****

        if (x.verificationResult != 'Compliant' &&
            x.verificationResult != 'Non-compliant') {
          notInspectedCount.value++;
        }
        if (x.verificationResult == 'Compliant') {
          compliantCount.value++;
        }
        if (x.verificationResult == 'Non-compliant') {
          nonCompliantCount.value++;
        }

        googleMapLinkPolylines.add(
          gmap.Polyline(
            polylineId: gmap.PolylineId(x.id!),
            consumeTapEvents: true,
            points: googleMapPoints,
            jointType: gmap.JointType.round,
            endCap: gmap.Cap.roundCap,
            startCap: gmap.Cap.roundCap,
            patterns: x.verificationResult != 'Compliant' &&
                    x.verificationResult != 'Non-compliant'
                ? <gmap.PatternItem>[
                    gmap.PatternItem.dash(10),
                    gmap.PatternItem.gap(2),
                  ]
                : <gmap.PatternItem>[],
            width: 5,
            onTap: () {
              isCheck.value = x.isChecked!;
              LinkInspectionDialog(x: x);
            },
            color: x.totalOfcCores == 4
                ? Colors.blue
                : x.totalOfcCores == 8
                    ? Colors.purple
                    : x.totalOfcCores == 12
                        ? Colors.green
                        : x.totalOfcCores == 24
                            ? Colors.red
                            : Colors.orange,
          ),
        );
      });

      back();
      DialogHelper.successDialog(
        title: 'Success!',
        msg: res.data['message'].toString(),
        color: hexToColor('#00B485'),
        path: 'success-circular',
        onPressed: () {
          linkUpdateList.clear();
          remarks.value = '';

          back();
          // disposeData();
          siteSearchV2();
        },
      );
    } else {
      issubmit.value = false;
      DialogHelper.successDialog(
        title: 'Unsuccessful!',
        msg: res.data['message'][0].toString(),
        color: hexToColor('#FF3C3C'),
        path: 'cancel_circle',
        onPressed: () {
          linkUpdateList.clear();
          back();
          siteSearchV2();
        },
      );
    }
  }

  updateCheckbox(Links v) {
    final item = linkList.singleWhere((x) => x!.id == v.id);

    item!.isChecked = item.isChecked! ? false : true;

    linkList[linkList.indexOf(item)] = item;
  }

  updateRemarks({
    Links? currentItem,
    String? remarks,
  }) {
    final item = linkList.singleWhere((x) => x!.id == currentItem!.id);
    item!.verifierComments = remarks;

    linkList[linkList.indexOf(item)] = item;
  }
//------------//

  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);

  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imagePicker.pickImage(source: ImageSource.camera);

      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);

        // Image compress function
        final img = await compressFile(file: pickedImage.value);

        // kLog('image size ...............');
        // kLog(img.readAsBytesSync().lengthInBytes / 1024);

        // Load compress image
        pickedImage.value = img;
        imagefiles.add(pickedImage.value!);
        // kLog(imagefiles.length);
      }
    } catch (e) {
      print('error while picking file.');
    }
  }
}
