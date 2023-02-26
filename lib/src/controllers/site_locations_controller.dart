// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/log.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/area_polygon.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/project_dropdown.dart';
import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';
import 'package:workforce/src/services/api_service.dart';

class SiteLocationsController extends GetxController with ApiService {
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);

  final isPlotingEnable = RxBool(true);
  final isPop = RxBool(false);
  final isWifi = RxBool(false);
  final isnewPole = RxBool(false);
  final isEPole = RxBool(false);
  final islightPost = RxBool(false);
  final isTelPole = RxBool(false);
  final isLocalIsp = RxBool(false);
  final isBts = RxBool(false);
  final isBuilding = RxBool(false);
  final isOther = RxBool(false);
  final isCableTv = RxBool(false);
  final isFootPrint = RxBool(false);
  final isLoading = RxBool(false);
  final isLoadding = RxBool(false);

  // final siteLocations = Rx<SiteLocation?>(null);
  final siteLocationsV2 = Rx<SiteLocationV2?>(null);
  final areaPolygon = Rx<AreaPolygon?>(null);
  final markerList = RxList<ProjectSites>();

  final locationList = RxList<SiteLocation>();

  final newPoleList = RxList<NewPole>();
  final ePoleList = RxList<ElectricityPole>();
  final noPoleList = RxList<NoPole>();
  final onBuildingList = RxList<OnBuilding>();
  final lightPostList = RxList<LightPost>();

  final markers = RxList<Marker>();
  final wifiMarkers = RxList<Marker>();
  final popMarkers = RxList<Marker>();
  final newPoleMarkers = RxList<Marker>();
  final ePoleMarkers = RxList<Marker>();
  final telPoleMarkers = RxList<Marker>();
  final lightPostMarkers = RxList<Marker>();
  final buildingMarkers = RxList<Marker>();
  final btsMarkers = RxList<Marker>();
  final footPrintMarkers = RxList<Marker>();
  final otherMarkers = RxList<Marker>();
  final cableTvMarkers = RxList<Marker>();
  final localIspMarkers = RxList<Marker>();

  final locations = RxList<Geograpphy>();

  final search = RxString('');
  final levelFullCode = RxString('');
  final geol4Id = RxString('');

  final lat = RxDouble(0.0);
  final long = RxDouble(0.0);

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);
  final selectProjectName = RxString('Constraction');
  // =============== To draw ploygon on map =============

  final pointsForPolygon = RxList<LatLng>([]);

  // =============== To change view of map =============

  final isSateliteViewEnable = RxBool(false);

  //====================== get geo area =================================

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

      // kLog(jsonEncode(res.data));
      if (res.data['status'] != null &&
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
          // maintainTestTypeCreateC
          //     .getMaintainTestType(selectedProject.value!.id!);
        }

        isLoading.value = false;
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  List<LatLng> convertPointsForPolygon(List coordinates) {
    final latLngList = coordinates[0][0];
    // final latLngList2 = latLngList[0];
    List<LatLng> points = [];

    for (final latLngValue in latLngList) {
      final item = LatLng(
        double.parse('${latLngValue[1]}'),
        double.parse('${latLngValue[0]}'),
      );

      points.add(item);
    }
    return points;
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
      //  'geoAreaIds': ['0000825d-b253-42d0-9971-8b0354c1dfa9'],
      'countryCode': 'BD'
    };
    pointsForPolygon.clear();
    final res = await postDynamic(
      path: ApiEndpoint.getAreaByIdsUrl(),
      body: body,
      authentication: true,
    );
    // kLog(jsonEncode(res.data));
    // final coordinates = jsonDecode(res.data['data']['areaPolygonJSON'] as String)['coordinates'] as List;
    final coordinates = jsonDecode(
            res.data['data'][0]['areaPolygonJSON'] as String)['coordinates']
        as List;

    pointsForPolygon.value = convertPointsForPolygon(coordinates);
    // kMapControllerSiteLocation.move(
    //     LatLng(pointsForPolygon[0].latitude, pointsForPolygon[0].longitude),
    //     15);
  }

  void siteSearchV2() async {
    isLoading.value = true;
    // final username = Get.put(UserController()).username;
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'pId': selectedProject.value!.id!,
      'searchText': levelFullCode.value,
    };
    // kLog(levelFullCode);
    final res = await postDynamic(
        //path: ApiEndpoint.getSiteUrl(),
        path: ApiEndpoint.getSiteLocV2Url(),
        body: body,
        authentication: true);

    // kLog(res.data);
    siteLocationsV2.value = null;
    final siteLoc =
        SiteLocationV2.fromJson(res.data['data'] as Map<String, dynamic>);
    siteLocationsV2.value = siteLoc;

    wifiMarkers.clear();
    popMarkers.clear();
    newPoleMarkers.clear();
    ePoleMarkers.clear();
    buildingMarkers.clear();
    otherMarkers.clear();
    localIspMarkers.clear();
    cableTvMarkers.clear();
    lightPostMarkers.clear();
    footPrintMarkers.clear();

//======== To Set bouns on map ============
    final bounds = LatLngBounds();

    final ePole = siteLocationsV2.value!.projectSites!
        .where(
            (x) => x.pillarType == 'Electricity Pole' && x.workStatus != 'New')
        .toList();

    if (ePole.isNotEmpty) {
      ePole.forEach((x) {
        ePoleMarkers.add(
          Marker(
            point: LatLng(x.latitude!, x.longitude!),
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    persistent: false,
                    isDismissible: true,
                    SizedBox(
                      height: Get.height * .9,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 20),
                              height: 60,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: hexToColor('#FFB661'),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                              ),
                              child: Center(
                                  child: Column(
                                children: [
                                  KText(
                                    text: 'Project Site : ${x.siteName}',
                                    bold: true,
                                    fontSize: 16,
                                  ),
                                  KText(
                                    text: 'Type -${x.pillarType}',
                                    bold: true,
                                    fontSize: 16,
                                  ),
                                ],
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 80,
                                left: 10,
                                right: 10,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Geography',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text:
                                        '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Pole Type',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.pillarType != null
                                                  ? x.pillarType
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Power Source',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.powerSource != null
                                                  ? x.powerSource
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Place Type',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.placeType != null
                                                  ? x.placeType
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Place Name',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.siteName != null
                                                  ? x.siteName
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  KText(
                                    text: 'Address',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text:
                                        '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  KText(
                                    text: 'Geography Point',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: 'Lat: ${x.latitude}'),
                                  KText(text: 'Long: ${x.longitude}'),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Potential Beneficiaries',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.potentialBeneficiaryCount
                                                  .toString()),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Priority',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.priorityName != null
                                                  ? x.priorityName
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Custodian Name',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianFullname != null
                                                  ? x.custodianFullname
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Mobile No.',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianMobile != null
                                                  ? x.custodianMobile
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'NID No.',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianNid != null
                                                  ? x.custodianNid
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Email',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianEmail != null
                                                  ? x.custodianEmail
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  KText(
                                    text: 'Custodian Address',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text: x.custodianAddress != null
                                        ? x.custodianAddress
                                        : '',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  KText(
                                    text: 'Captured Images',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: back,
                                      child: Container(
                                        height: 34,
                                        width: 109,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: hexToColor('#449EF1')),
                                        child: Center(
                                          child: KText(
                                            text: 'Close',
                                            bold: true,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
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
                },
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10,
                ),
              );
            },
          ),
        );
        isEPole.value = true;

        bounds.extend(LatLng(x.latitude!, x.longitude!));
      });
    }
    final newPole = siteLocationsV2.value!.projectSites!
        .where((x) => x.pillarType == 'New Pole' && x.workStatus != 'New')
        .toList();

    if (newPole.isNotEmpty) {
      newPole.forEach((x) {
        newPoleMarkers.add(
          Marker(
            point: LatLng(x.latitude!, x.longitude!),
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    persistent: false,
                    isDismissible: true,
                    SizedBox(
                      height: Get.height * .9,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 20),
                              height: 60,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: hexToColor('#FFB661'),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                              ),
                              child: Center(
                                  child: Column(
                                children: [
                                  KText(
                                    text: 'Project Site :',
                                    bold: true,
                                    fontSize: 16,
                                  ),
                                  KText(
                                    text: 'Type -${x.pillarType}',
                                    bold: true,
                                    fontSize: 16,
                                  ),
                                ],
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 80,
                                left: 10,
                                right: 10,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Geography',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text:
                                        '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Pole Type',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.pillarType != null
                                                  ? x.pillarType
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Power Source',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.powerSource != null
                                                  ? x.powerSource
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Place Type',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.placeType != null
                                                  ? x.placeType
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Place Name',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.siteName != null
                                                  ? x.siteName
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  KText(
                                    text: 'Address',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text:
                                        '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  KText(
                                    text: 'Geography Point',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: 'Lat: ${x.latitude}'),
                                  KText(text: 'Long: ${x.longitude}'),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Potential Beneficiaries',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.potentialBeneficiaryCount
                                                  .toString()),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Priority',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.priorityName != null
                                                  ? x.priorityName
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Custodian Name',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianFullname != null
                                                  ? x.custodianFullname
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Mobile No.',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianMobile != null
                                                  ? x.custodianMobile
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'NID No.',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianNid != null
                                                  ? x.custodianNid
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Email',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                              text: x.custodianEmail != null
                                                  ? x.custodianEmail
                                                  : ''),
                                          SizedBox(
                                              width: Get.width * .4,
                                              child: Divider()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  KText(
                                    text: 'Custodian Address',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text: x.custodianAddress != null
                                        ? x.custodianAddress
                                        : '',
                                    maxLines: 2,
                                  ),
                                  Divider(),
                                  KText(
                                    text: 'Captured Images',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTap: back,
                                      child: Container(
                                        height: 34,
                                        width: 109,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: hexToColor('#449EF1')),
                                        child: Center(
                                          child: KText(
                                            text: 'Close',
                                            bold: true,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
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
                },
                child: Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 10,
                ),
              );
            },
          ),
        );
        isnewPole.value = true;
        bounds.extend(LatLng(x.latitude!, x.longitude!));
      });
    }

    final buildingHouse = siteLocationsV2.value!.projectSites!
        .where((x) =>
            (x.pillarType == 'Building/House' ||
                x.pillarType == 'On Building') &&
            x.workStatus != 'New')
        .toList();

    if (buildingHouse.isNotEmpty) {
      buildingHouse.forEach(
        (x) {
          buildingMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 10,
                  ),
                );
              },
            ),
          );
          isBuilding.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }
    final lightPost = siteLocationsV2.value!.projectSites!
        .where((x) => x.pillarType == 'Light Post' && x.workStatus != 'New')
        .toList();

    if (lightPost.isNotEmpty) {
      lightPost.forEach(
        (x) {
          lightPostMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.circle,
                    color: hexToColor('#A533FF'),
                    size: 10,
                  ),
                );
              },
            ),
          );
          islightPost.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }

    final noPool = siteLocationsV2.value!.projectSites!
        .where((x) => x.pillarType == 'No Pole' && x.workStatus != 'New')
        .toList();

    if (noPool.isNotEmpty) {
      noPool.forEach(
        (x) {
          otherMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black,
                    size: 28,
                  ),
                );
              },
            ),
          );
          isOther.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }
    final wifiRouters = siteLocationsV2.value!.projectSites!
        .where((x) => x.functionType == 'Wifi Router')
        .toList();

    if (wifiRouters.isNotEmpty) {
      wifiRouters.forEach(
        (x) {
          wifiMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 28,
                  ),
                );
              },
            ),
          );
          isWifi.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }
    final cableTv = siteLocationsV2.value!.projectSites!
        .where((x) => x.functionType == 'Cable TV Operator')
        .toList();

    if (cableTv.isNotEmpty) {
      cableTv.forEach(
        (x) {
          cableTvMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 28,
                  ),
                );
              },
            ),
          );
          isCableTv.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }
    final localIsp = siteLocationsV2.value!.projectSites!
        .where((x) => x.functionType == 'Local ISP')
        .toList();

    if (localIsp.isNotEmpty) {
      localIsp.forEach(
        (x) {
          localIspMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.yellow,
                    size: 28,
                  ),
                );
              },
            ),
          );
          isCableTv.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }

    final POP = siteLocationsV2.value!.projectSites!
        .where((x) => x.functionType == 'POP')
        .toList();

    if (POP.isNotEmpty) {
      POP.forEach(
        (x) {
          popMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      persistent: false,
                      isDismissible: true,
                      SizedBox(
                        height: Get.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                height: 60,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: hexToColor('#FFB661'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Center(
                                    child: Column(
                                  children: [
                                    KText(
                                      text: 'Project Site :',
                                    ),
                                    KText(
                                      text: 'Type -${x.pillarType}',
                                      bold: true,
                                      fontSize: 16,
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 80,
                                  left: 10,
                                  right: 10,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Geography',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Pole Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.pillarType != null
                                                    ? x.pillarType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Power Source',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.powerSource != null
                                                    ? x.powerSource
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Type',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.placeType != null
                                                    ? x.placeType
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Place Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.siteName != null
                                                    ? x.siteName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text:
                                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Geography Point',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(text: 'Lat: ${x.latitude}'),
                                    KText(text: 'Long: ${x.longitude}'),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Potential Beneficiaries',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x
                                                    .potentialBeneficiaryCount
                                                    .toString()),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Priority',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.priorityName != null
                                                    ? x.priorityName
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Custodian Name',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text:
                                                    x.custodianFullname != null
                                                        ? x.custodianFullname
                                                        : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Mobile No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianMobile != null
                                                    ? x.custodianMobile
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'NID No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianNid != null
                                                    ? x.custodianNid
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Email',
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                                text: x.custodianEmail != null
                                                    ? x.custodianEmail
                                                    : ''),
                                            SizedBox(
                                                width: Get.width * .4,
                                                child: Divider()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'Custodian Address',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: x.custodianAddress != null
                                          ? x.custodianAddress
                                          : '',
                                      maxLines: 2,
                                    ),
                                    Divider(),
                                    KText(
                                      text: 'Captured Images',
                                      color: hexToColor('#80939D'),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: back,
                                        child: Container(
                                          height: 34,
                                          width: 109,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hexToColor('#449EF1')),
                                          child: Center(
                                            child: KText(
                                              text: 'Close',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
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
                  },
                  child: Icon(
                    Icons.location_on,
                    color: hexToColor('#F51616'),
                    size: 28,
                  ),
                );
              },
            ),
          );
          isPop.value = true;
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        },
      );
    }

    // for (var x in siteLocationsV2.value!.projectSites!) {
    //   switch (x.pillarType) {
    //     case 'Electricity Pole':
    //       break;
    //     case 'New Pole':
    //       newPoleMarkers.add(
    //         Marker(
    //           point: LatLng(x.latitude!, x.longitude!),
    //           builder: (_) {
    //             return GestureDetector(
    //                 onTap: () {
    //                   Get.bottomSheet(
    //                     isScrollControlled: true,
    //                     persistent: false,
    //                     isDismissible: true,
    //                     SizedBox(
    //                       height: Get.height * .9,
    //                       child: SingleChildScrollView(
    //                         child: Column(
    //                           children: [
    //                             Container(
    //                               margin: EdgeInsets.only(
    //                                   left: 10, right: 10, top: 20),
    //                               height: 60,
    //                               width: Get.width,
    //                               decoration: BoxDecoration(
    //                                 color: hexToColor('#FFB661'),
    //                                 borderRadius: BorderRadius.only(
    //                                     topLeft: Radius.circular(5),
    //                                     topRight: Radius.circular(5)),
    //                               ),
    //                               child: Center(
    //                                   child: Column(
    //                                 children: [
    //                                   KText(
    //                                     text: 'Project Site :',
    //                                     bold: true,
    //                                     fontSize: 16,
    //                                   ),
    //                                   KText(
    //                                     text: 'Type -${x.pillarType}',
    //                                     bold: true,
    //                                     fontSize: 16,
    //                                   ),
    //                                 ],
    //                               )),
    //                             ),
    //                             Container(
    //                               margin: EdgeInsets.only(
    //                                 bottom: 80,
    //                                 left: 10,
    //                                 right: 10,
    //                               ),
    //                               padding: EdgeInsets.symmetric(horizontal: 10),
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.only(
    //                                     bottomLeft: Radius.circular(5),
    //                                     bottomRight: Radius.circular(5)),
    //                               ),
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   KText(text: 'Geography'),
    //                                   KText(
    //                                     text:
    //                                         '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Pole Type'),
    //                                           KText(
    //                                               text: x.pillarType != null
    //                                                   ? x.pillarType
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Power Source'),
    //                                           KText(
    //                                               text: x.powerSource != null
    //                                                   ? x.powerSource
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Place Type'),
    //                                           KText(
    //                                               text: x.placeType != null
    //                                                   ? x.placeType
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Place Name'),
    //                                           KText(
    //                                               text: x.siteName != null
    //                                                   ? x.siteName
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   KText(text: 'Address'),
    //                                   KText(
    //                                     text:
    //                                         '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   KText(text: 'Geography Point'),
    //                                   KText(text: 'Lat: ${x.latitude}'),
    //                                   KText(text: 'Long: ${x.longitude}'),
    //                                   Divider(),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(
    //                                               text:
    //                                                   'Potential Beneficiaries'),
    //                                           KText(
    //                                               text: x
    //                                                   .potentialBeneficiaryCount
    //                                                   .toString()),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Priority'),
    //                                           KText(
    //                                               text: x.priorityName != null
    //                                                   ? x.priorityName
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Custodian Name'),
    //                                           KText(
    //                                               text: x.custodianFullname !=
    //                                                       null
    //                                                   ? x.custodianFullname
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Mobile No.'),
    //                                           KText(
    //                                               text:
    //                                                   x.custodianMobile != null
    //                                                       ? x.custodianMobile
    //                                                       : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'NID No.'),
    //                                           KText(
    //                                               text: x.custodianNid != null
    //                                                   ? x.custodianNid
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Email'),
    //                                           KText(
    //                                               text: x.custodianEmail != null
    //                                                   ? x.custodianEmail
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   KText(text: 'Custodian Address'),
    //                                   KText(
    //                                     text: x.custodianAddress != null
    //                                         ? x.custodianAddress
    //                                         : '',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   KText(text: 'Captured Images'),
    //                                   Center(
    //                                     child: GestureDetector(
    //                                       onTap: back,
    //                                       child: Container(
    //                                         height: 34,
    //                                         width: 109,
    //                                         margin: EdgeInsets.symmetric(
    //                                             vertical: 50),
    //                                         decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(5),
    //                                             color: hexToColor('#449EF1')),
    //                                         child: Center(
    //                                           child: KText(
    //                                             text: 'Close',
    //                                             bold: true,
    //                                             color: Colors.white,
    //                                             fontSize: 16,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Icon(
    //                   Icons.circle,
    //                   color: Colors.orange,
    //                   size: 10,
    //                 ));
    //           },
    //         ),
    //       );
    //       isnewPole.value = true;
    //       break;
    //     case 'Building/House':
    //       buildingMarkers.add(
    //         Marker(
    //           point: LatLng(x.latitude!, x.longitude!),
    //           builder: (_) {
    //             return GestureDetector(
    //                 onTap: () {
    //                   Get.bottomSheet(
    //                     isScrollControlled: true,
    //                     persistent: false,
    //                     isDismissible: true,
    //                     SizedBox(
    //                       height: Get.height * .9,
    //                       child: SingleChildScrollView(
    //                         child: Column(
    //                           children: [
    //                             Container(
    //                               margin: EdgeInsets.only(
    //                                   left: 10, right: 10, top: 20),
    //                               height: 60,
    //                               width: Get.width,
    //                               decoration: BoxDecoration(
    //                                 color: hexToColor('#FFB661'),
    //                                 borderRadius: BorderRadius.only(
    //                                     topLeft: Radius.circular(5),
    //                                     topRight: Radius.circular(5)),
    //                               ),
    //                               child: Center(
    //                                   child: Column(
    //                                 children: [
    //                                   KText(
    //                                     text: 'Project Site :',
    //                                     bold: true,
    //                                     fontSize: 16,
    //                                   ),
    //                                   KText(
    //                                     text: 'Type -${x.pillarType}',
    //                                     bold: true,
    //                                     fontSize: 16,
    //                                   ),
    //                                 ],
    //                               )),
    //                             ),
    //                             Container(
    //                               margin: EdgeInsets.only(
    //                                 bottom: 80,
    //                                 left: 10,
    //                                 right: 10,
    //                               ),
    //                               padding: EdgeInsets.symmetric(horizontal: 10),
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.only(
    //                                     bottomLeft: Radius.circular(5),
    //                                     bottomRight: Radius.circular(5)),
    //                               ),
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   KText(text: 'Geography'),
    //                                   KText(
    //                                     text:
    //                                         '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Pole Type'),
    //                                           KText(
    //                                               text: x.pillarType != null
    //                                                   ? x.pillarType
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Power Source'),
    //                                           KText(
    //                                               text: x.powerSource != null
    //                                                   ? x.powerSource
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Place Type'),
    //                                           KText(
    //                                               text: x.placeType != null
    //                                                   ? x.placeType
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Place Name'),
    //                                           KText(
    //                                               text: x.siteName != null
    //                                                   ? x.siteName
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   KText(text: 'Address'),
    //                                   KText(
    //                                     text:
    //                                         '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   KText(text: 'Geography Point'),
    //                                   KText(text: 'Lat: ${x.latitude}'),
    //                                   KText(text: 'Long: ${x.longitude}'),
    //                                   Divider(),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(
    //                                               text:
    //                                                   'Potential Beneficiaries'),
    //                                           KText(
    //                                               text: x
    //                                                   .potentialBeneficiaryCount
    //                                                   .toString()),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Priority'),
    //                                           KText(
    //                                               text: x.priorityName != null
    //                                                   ? x.priorityName
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Custodian Name'),
    //                                           KText(
    //                                               text: x.custodianFullname !=
    //                                                       null
    //                                                   ? x.custodianFullname
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Mobile No.'),
    //                                           KText(
    //                                               text:
    //                                                   x.custodianMobile != null
    //                                                       ? x.custodianMobile
    //                                                       : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.spaceBetween,
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'NID No.'),
    //                                           KText(
    //                                               text: x.custodianNid != null
    //                                                   ? x.custodianNid
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.spaceBetween,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           KText(text: 'Email'),
    //                                           KText(
    //                                               text: x.custodianEmail != null
    //                                                   ? x.custodianEmail
    //                                                   : ''),
    //                                           SizedBox(
    //                                               width: Get.width * .4,
    //                                               child: Divider()),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   KText(text: 'Custodian Address'),
    //                                   KText(
    //                                     text: x.custodianAddress != null
    //                                         ? x.custodianAddress
    //                                         : '',
    //                                     maxLines: 2,
    //                                   ),
    //                                   Divider(),
    //                                   KText(text: 'Captured Images'),
    //                                   Center(
    //                                     child: GestureDetector(
    //                                       onTap: back,
    //                                       child: Container(
    //                                         height: 34,
    //                                         width: 109,
    //                                         margin: EdgeInsets.symmetric(
    //                                             vertical: 50),
    //                                         decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(5),
    //                                             color: hexToColor('#449EF1')),
    //                                         child: Center(
    //                                           child: KText(
    //                                             text: 'Close',
    //                                             bold: true,
    //                                             color: Colors.white,
    //                                             fontSize: 16,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Icon(
    //                   Icons.circle,
    //                   color: Colors.black,
    //                   size: 10,
    //                 ));
    //           },
    //         ),
    //       );
    //       isBuilding.value = true;
    //       break;

    //     default:
    //   }

    //   kMapControllerSiteLocation.move(
    //     LatLng(x.latitude!, x.longitude!),
    //     13,
    //   );

    //   // for (var x in siteLocationsV2.value!.projectSites!) {
    //   //   if (x.functionType == 'Wifi Router') {
    //   //    // kLog('yes');
    //   //   }
    //   // }

    //   final sss = siteLocationsV2.value!.projectSites!
    //       .where((x) => x.functionType == 'Wifi Router')
    //       .toList();

    //  // kLog(sss.length);
    //   if (sss.isNotEmpty) {
    //    // kLog(sss.length);
    //   }
    // }

    // final projectSiteData = res.data['data']['projectSites']
    //     .map((json) => ProjectSites.fromJson(json as Map<String, dynamic>))
    //     .toList()
    //     .cast<ProjectSites>() as List<ProjectSites>;

    // markerList.clear();
    // markerList.addAll(projectSiteData);
    //// kLog(jsonEncode(projectSiteData[0]));

    // for (var x in markerList) {
    //   markers.add(Marker(
    //       point: LatLng(x.latitude!, x.longitude!),
    //       builder: (_) {
    //         return GestureDetector(
    //           onTap: () {
    //             Get.bottomSheet(
    //               isScrollControlled: true,
    //               persistent: false,
    //               isDismissible: true,
    //               SizedBox(
    //                 height: Get.height * .9,
    //                 child: SingleChildScrollView(
    //                   child: Column(
    //                     children: [
    //                       Container(
    //                         margin:
    //                             EdgeInsets.only(left: 10, right: 10, top: 20),
    //                         height: 60,
    //                         width: Get.width,
    //                         decoration: BoxDecoration(
    //                           color: hexToColor('#FFB661'),
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(5),
    //                               topRight: Radius.circular(5)),
    //                         ),
    //                         child: Center(
    //                             child: Column(
    //                           children: [
    //                             KText(
    //                               text: 'Project Site :',
    //                               bold: true,
    //                               fontSize: 16,
    //                             ),
    //                             KText(
    //                               text: 'Type -${x.pillarType}',
    //                               bold: true,
    //                               fontSize: 16,
    //                             ),
    //                           ],
    //                         )),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(
    //                           bottom: 80,
    //                           left: 10,
    //                           right: 10,
    //                         ),
    //                         padding: EdgeInsets.symmetric(horizontal: 10),
    //                         decoration: BoxDecoration(
    //                           color: Colors.white,
    //                           borderRadius: BorderRadius.only(
    //                               bottomLeft: Radius.circular(5),
    //                               bottomRight: Radius.circular(5)),
    //                         ),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             KText(text: 'Geography'),
    //                             KText(
    //                               text:
    //                                   '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
    //                               maxLines: 2,
    //                             ),
    //                             Divider(),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Pole Type'),
    //                                     KText(
    //                                         text: x.pillarType != null
    //                                             ? x.pillarType
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Power Source'),
    //                                     KText(
    //                                         text: x.powerSource != null
    //                                             ? x.powerSource
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Place Type'),
    //                                     KText(
    //                                         text: x.placeType != null
    //                                             ? x.placeType
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Place Name'),
    //                                     KText(
    //                                         text: x.siteName != null
    //                                             ? x.siteName
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             KText(text: 'Address'),
    //                             KText(
    //                               text:
    //                                   '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
    //                               maxLines: 2,
    //                             ),
    //                             Divider(),
    //                             KText(text: 'Geography Point'),
    //                             KText(text: 'Lat: ${x.latitude}'),
    //                             KText(text: 'Long: ${x.longitude}'),
    //                             Divider(),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Potential Beneficiaries'),
    //                                     KText(
    //                                         text: x.potentialBeneficiaryCount
    //                                             .toString()),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Priority'),
    //                                     KText(
    //                                         text: x.priorityName != null
    //                                             ? x.priorityName
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Custodian Name'),
    //                                     KText(
    //                                         text: x.custodianFullname != null
    //                                             ? x.custodianFullname
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Mobile No.'),
    //                                     KText(
    //                                         text: x.custodianMobile != null
    //                                             ? x.custodianMobile
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'NID No.'),
    //                                     KText(
    //                                         text: x.custodianNid != null
    //                                             ? x.custodianNid
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     KText(text: 'Email'),
    //                                     KText(
    //                                         text: x.custodianEmail != null
    //                                             ? x.custodianEmail
    //                                             : ''),
    //                                     SizedBox(
    //                                         width: Get.width * .4,
    //                                         child: Divider()),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             KText(text: 'Custodian Address'),
    //                             KText(
    //                               text: x.custodianAddress != null
    //                                   ? x.custodianAddress
    //                                   : '',
    //                               maxLines: 2,
    //                             ),
    //                             Divider(),
    //                             KText(text: 'Captured Images'),
    //                             Center(
    //                               child: GestureDetector(
    //                                 onTap: back,
    //                                 child: Container(
    //                                   height: 34,
    //                                   width: 109,
    //                                   margin:
    //                                       EdgeInsets.symmetric(vertical: 50),
    //                                   decoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(5),
    //                                       color: hexToColor('#449EF1')),
    //                                   child: Center(
    //                                     child: KText(
    //                                       text: 'Close',
    //                                       bold: true,
    //                                       color: Colors.white,
    //                                       fontSize: 16,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //           child: x.functionType == 'Cable Point'
    //               ? Icon(
    //                   Icons.circle,
    //                   color: x.pillarType == 'Electricity Pole'
    //                       ? Colors.red
    //                       : x.pillarType == 'New Pole'
    //                           ? Colors.orange
    //                           : x.pillarType == 'Building/House'
    //                               ? Colors.black
    //                               : x.pillarType == 'Light Post'
    //                                   ? Colors.purple
    //                                   : Colors.black,
    //                   size: 10,
    //                 )
    //               : RenderSvg(
    //                   path: 'wifiap-icon',
    //                   color: x.functionType == 'Wifi Router'
    //                       ? Colors.green
    //                       : x.functionType == 'POP'
    //                           ? Colors.red
    //                           : Colors.black,
    //                 ),
    //         );
    //       }));
    // }
    isLoading.value = false;

    kMapControllerSiteLocation.fitBounds(
      bounds,
      options: const FitBoundsOptions(
        padding: EdgeInsets.all(30),
      ),
    );
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
                    text: 'Search Location',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
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
                                        print('data=>:$levelFullCode');
                                        geol4Id.value =
                                            item.geoLevel4Id as String;
                                        getAreaByIds();
                                        siteSearchV2();
                                        // siteSearch();
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
                                        // child: KText(
                                        //   text: '${item.geoLevel4Name}',
                                        //   bold: true,
                                        //   fontSize: 15,
                                        // ),
                                        child: KText(
                                          maxLines: 3,
                                          text: item.geoLevel4Name!.isEmpty
                                              ? ''
                                              : '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
                                        ),

                                        //  KText(
                                        //             textOverflow:
                                        //                 TextOverflow.visible,
                                        //             text: item!.projectName !=
                                        //                     null
                                        //                 ? '${item.projectName}'
                                        //                 : '',
                                        //             bold: true,
                                        //             fontSize: 14,
                                        //             //  bold: true,
                                        //           ),
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
          //  'ids': ['330c5fea-cd51-4b25-8ed6-ce78486e4886'],
          'ids': [selectedProject.value!.id]
        };
        kLog(selectedProject.value!.id);
        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrlV2(),
          body: body,
          authentication: true,
        );

        final data = res.data['data']
            .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Geograpphy>() as List<Geograpphy>;

        //// kLog(data[0].toJson());

        locations.clear();
        locations.addAll(data);
        isLoadding.value = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

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

  // void siteSearch() async {
  //   isLoading.value = true;

  //   final token = Get.put(UserController()).currentUser.value!.token;
  //   final header = {
  //     'Content-Type': 'application/json',
  //     'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',,
  //     'Authorization': token,
  //   };
  //   final body = {
  //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //     'appCode': 'SURVEY',
  //     'uiCodes': ['0000'],
  //     'areaLevel': 4,
  //     'areaType': 'COUNTRY UNIT',
  //     'countryCode': 'BD',
  //     'searchText': levelFullCode.value,
  //   };

  //   final res = await postDynamic(
  //     path: ApiEndpoint.getSiteLocUrl(),
  //     body: body,
  //     header: header,
  //   );

  //   final siteLoc = SiteLocation.fromJson(res.data['data'] as Map<String, dynamic>);
  //   siteLocations.value = siteLoc;
  //   //  print(siteLoc);
  //   // Add item list
  //   final newpoletData = res.data['data']['pillarTypes']['newPole']
  //       .map((json) => NewPole.fromJson(json as Map<String, dynamic>))
  //       .toList()
  //       .cast<NewPole>() as List<NewPole>;

  //   newPoleList.clear();
  //   newPoleList.addAll(newpoletData);
  //   if (newPoleList.isNotEmpty) isnewPole.value = true;
  //   //kMapControllerSiteLocation.move(LatLng(x.latitude!, x.longitude!), 13);

  //   for (var x in newPoleList) {
  //     newPoleMarkers.add(Marker(
  //         point: LatLng(x.latitude!, x.longitude!),
  //         builder: (_) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.bottomSheet(
  //                 isScrollControlled: true,
  //                 persistent: false,
  //                 isDismissible: true,
  //                 SingleChildScrollView(
  //                     child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 10),
  //                       height: 60,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         color: hexToColor('#FFB661'),
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //                       ),
  //                       child: Center(
  //                           child: KText(
  //                         text: 'Project Site : Type -${x.pillarType}',
  //                         bold: true,
  //                         fontSize: 16,
  //                       )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           KText(text: 'Geography'),
  //                           KText(text: '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Pole Type'),
  //                                   KText(text: x.pillarType != null ? x.pillarType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Power Source'),
  //                                   KText(text: x.powerSource != null ? x.powerSource : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Type'),
  //                                   KText(text: x.placeType != null ? x.placeType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Name'),
  //                                   KText(text: x.siteName != null ? x.siteName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Address'),
  //                           KText(text: '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} '),
  //                           Divider(),
  //                           KText(text: 'Geography Point'),
  //                           KText(text: 'Lat: ${x.latitude}'),
  //                           KText(text: 'Long: ${x.longitude}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Potential Beneficiaries'),
  //                                   KText(text: x.potentialBeneficiaryCount.toString()),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Priority'),
  //                                   KText(text: x.priorityName != null ? x.priorityName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Custodian Name'),
  //                                   KText(text: x.custodianFullname != null ? x.custodianFullname : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Mobile No.'),
  //                                   KText(text: x.custodianMobile != null ? x.custodianMobile : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'NID No.'),
  //                                   KText(text: x.custodianNid != null ? x.custodianNid : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Email'),
  //                                   KText(text: x.custodianEmail != null ? x.custodianEmail : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Custodian Address'),
  //                           KText(text: x.custodianAddress != null ? x.custodianAddress : ''),
  //                           Divider(),
  //                           KText(text: 'Captured Images'),
  //                           Center(
  //                             child: GestureDetector(
  //                               onTap: back,
  //                               child: Container(
  //                                 height: 34,
  //                                 width: 109,
  //                                 margin: EdgeInsets.symmetric(vertical: 50),
  //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
  //                                 child: Center(
  //                                   child: KText(
  //                                     text: 'Close',
  //                                     bold: true,
  //                                     color: Colors.white,
  //                                     fontSize: 16,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //               );
  //             },
  //             child: Icon(
  //               Icons.circle,
  //               color: Colors.orange,
  //               size: 10,
  //             ),
  //           );
  //         }));
  //   }

  //   final ePoleData = res.data['data']['pillarTypes']['electricityPole']
  //       .map((json) => ElectricityPole.fromJson(json as Map<String, dynamic>))
  //       .toList()
  //       .cast<ElectricityPole>() as List<ElectricityPole>;
  //   ePoleList.clear();
  //   ePoleList.addAll(ePoleData);
  //   if (ePoleList.isNotEmpty) isEPole.value = true;
  //   for (var x in ePoleList) {
  //     ePoleMarkers.add(Marker(
  //         point: LatLng(x.latitude!, x.longitude!),
  //         builder: (_) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.bottomSheet(
  //                 isScrollControlled: true,
  //                 persistent: false,
  //                 isDismissible: true,
  //                 SingleChildScrollView(
  //                     child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 10),
  //                       height: 60,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         color: hexToColor('#FFB661'),
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //                       ),
  //                       child: Center(
  //                           child: KText(
  //                         text: 'Project Site : Type -${x.pillarType}',
  //                         bold: true,
  //                         fontSize: 16,
  //                       )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           KText(text: 'Geography'),
  //                           KText(text: '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Pole Type'),
  //                                   KText(text: x.pillarType != null ? x.pillarType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Power Source'),
  //                                   KText(text: x.powerSource != null ? x.powerSource : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Type'),
  //                                   KText(text: x.placeType != null ? x.placeType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Name'),
  //                                   KText(text: x.siteName != null ? x.siteName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Address'),
  //                           KText(text: '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} '),
  //                           Divider(),
  //                           KText(text: 'Geography Point'),
  //                           KText(text: 'Lat: ${x.latitude}'),
  //                           KText(text: 'Long: ${x.longitude}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Potential Beneficiaries'),
  //                                   KText(text: x.potentialBeneficiaryCount.toString()),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Priority'),
  //                                   KText(text: x.priorityName != null ? x.priorityName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Custodian Name'),
  //                                   KText(text: x.custodianFullname != null ? x.custodianFullname : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Mobile No.'),
  //                                   KText(text: x.custodianMobile != null ? x.custodianMobile : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'NID No.'),
  //                                   KText(text: x.custodianNid != null ? x.custodianNid : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Email'),
  //                                   KText(text: x.custodianEmail != null ? x.custodianEmail : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Custodian Address'),
  //                           KText(text: x.custodianAddress != null ? x.custodianAddress : ''),
  //                           Divider(),
  //                           KText(text: 'Captured Images'),
  //                           Center(
  //                             child: GestureDetector(
  //                               onTap: back,
  //                               child: Container(
  //                                 height: 34,
  //                                 width: 109,
  //                                 margin: EdgeInsets.symmetric(vertical: 50),
  //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
  //                                 child: Center(
  //                                   child: KText(
  //                                     text: 'Close',
  //                                     bold: true,
  //                                     color: Colors.white,
  //                                     fontSize: 16,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //               );
  //             },
  //             child: Icon(
  //               Icons.circle,
  //               color: Colors.red,
  //               size: 10,
  //             ),
  //           );
  //         }));
  //   }

  //   final noPoleData = res.data['data']['pillarTypes']['noPole']
  //       .map((json) => NoPole.fromJson(json as Map<String, dynamic>))
  //       .toList()
  //       .cast<NoPole>() as List<NoPole>;
  //   noPoleList.clear();
  //   noPoleList.addAll(noPoleData);
  //   if (noPoleList.isNotEmpty) isOther.value = true;
  //   for (var x in noPoleList) {
  //     otherMarkers.add(Marker(
  //         point: LatLng(x.latitude!, x.longitude!),
  //         builder: (_) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.bottomSheet(
  //                 isScrollControlled: true,
  //                 persistent: false,
  //                 isDismissible: true,
  //                 SingleChildScrollView(
  //                     child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 10),
  //                       height: 60,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         color: hexToColor('#FFB661'),
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //                       ),
  //                       child: Center(
  //                           child: KText(
  //                         text: 'Project Site : Type -${x.pillarType}',
  //                         bold: true,
  //                         fontSize: 16,
  //                       )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           KText(text: 'Geography'),
  //                           KText(text: '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Pole Type'),
  //                                   KText(text: x.pillarType != null ? x.pillarType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Power Source'),
  //                                   KText(text: x.powerSource != null ? x.powerSource : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Type'),
  //                                   KText(text: x.placeType != null ? x.placeType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Name'),
  //                                   KText(text: x.siteName != null ? x.siteName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Address'),
  //                           KText(text: '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} '),
  //                           Divider(),
  //                           KText(text: 'Geography Point'),
  //                           KText(text: 'Lat: ${x.latitude}'),
  //                           KText(text: 'Long: ${x.longitude}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Potential Beneficiaries'),
  //                                   KText(text: x.potentialBeneficiaryCount.toString()),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Priority'),
  //                                   KText(text: x.priorityName != null ? x.priorityName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Custodian Name'),
  //                                   KText(text: x.custodianFullname != null ? x.custodianFullname : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Mobile No.'),
  //                                   KText(text: x.custodianMobile != null ? x.custodianMobile : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'NID No.'),
  //                                   KText(text: x.custodianNid != null ? x.custodianNid : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Email'),
  //                                   KText(text: x.custodianEmail != null ? x.custodianEmail : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Custodian Address'),
  //                           KText(text: x.custodianAddress != null ? x.custodianAddress : ''),
  //                           Divider(),
  //                           KText(text: 'Captured Images'),
  //                           Center(
  //                             child: GestureDetector(
  //                               onTap: back,
  //                               child: Container(
  //                                 height: 34,
  //                                 width: 109,
  //                                 margin: EdgeInsets.symmetric(vertical: 50),
  //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
  //                                 child: Center(
  //                                   child: KText(
  //                                     text: 'Close',
  //                                     bold: true,
  //                                     color: Colors.white,
  //                                     fontSize: 16,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //               );
  //             },
  //             child: RenderSvg(
  //               path: 'wifiap-icon',
  //               color: Colors.black,
  //             ),
  //           );
  //         }));
  //   }

  //   final onBuildData = res.data['data']['pillarTypes']['onBuilding']
  //       .map((json) => OnBuilding.fromJson(json as Map<String, dynamic>))
  //       .toList()
  //       .cast<OnBuilding>() as List<OnBuilding>;
  //   onBuildingList.clear();
  //   onBuildingList.addAll(onBuildData);
  //   if (onBuildingList.isNotEmpty) isBuilding.value = true;
  //   for (var x in onBuildingList) {
  //     buildingMarkers.add(Marker(
  //         point: LatLng(x.latitude!, x.longitude!),
  //         builder: (_) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.bottomSheet(
  //                 isScrollControlled: true,
  //                 persistent: false,
  //                 isDismissible: true,
  //                 SingleChildScrollView(
  //                     child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 10),
  //                       height: 60,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         color: hexToColor('#FFB661'),
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //                       ),
  //                       child: Center(
  //                           child: KText(
  //                         text: 'Project Site : Type -${x.pillarType}',
  //                         bold: true,
  //                         fontSize: 16,
  //                       )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           KText(text: 'Geography'),
  //                           KText(text: '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Pole Type'),
  //                                   KText(text: x.pillarType != null ? x.pillarType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Power Source'),
  //                                   KText(text: x.powerSource != null ? x.powerSource : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Type'),
  //                                   KText(text: x.placeType != null ? x.placeType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Name'),
  //                                   KText(text: x.siteName != null ? x.siteName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Address'),
  //                           KText(text: '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} '),
  //                           Divider(),
  //                           KText(text: 'Geography Point'),
  //                           KText(text: 'Lat: ${x.latitude}'),
  //                           KText(text: 'Long: ${x.longitude}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Potential Beneficiaries'),
  //                                   KText(text: x.potentialBeneficiaryCount.toString()),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Priority'),
  //                                   KText(text: x.priorityName != null ? x.priorityName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Custodian Name'),
  //                                   KText(text: x.custodianFullname != null ? x.custodianFullname : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Mobile No.'),
  //                                   KText(text: x.custodianMobile != null ? x.custodianMobile : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'NID No.'),
  //                                   KText(text: x.custodianNid != null ? x.custodianNid : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Email'),
  //                                   KText(text: x.custodianEmail != null ? x.custodianEmail : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Custodian Address'),
  //                           KText(text: x.custodianAddress != null ? x.custodianAddress : ''),
  //                           Divider(),
  //                           KText(text: 'Captured Images'),
  //                           Center(
  //                             child: GestureDetector(
  //                               onTap: back,
  //                               child: Container(
  //                                 height: 34,
  //                                 width: 109,
  //                                 margin: EdgeInsets.symmetric(vertical: 50),
  //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
  //                                 child: Center(
  //                                   child: KText(
  //                                     text: 'Close',
  //                                     bold: true,
  //                                     color: Colors.white,
  //                                     fontSize: 16,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //               );
  //             },
  //             child: Icon(
  //               Icons.circle,
  //               color: Colors.black,
  //               size: 10,
  //             ),
  //           );
  //         }));
  //   }

  //   final lightPostData = res.data['data']['pillarTypes']['lightPost']
  //       .map((json) => LightPost.fromJson(json as Map<String, dynamic>))
  //       .toList()
  //       .cast<LightPost>() as List<LightPost>;
  //   lightPostList.clear();
  //   lightPostList.addAll(lightPostData);
  //   if (lightPostList.isNotEmpty) islightPost.value = true;
  //   for (var x in lightPostList) {
  //     lightPostMarkers.add(Marker(
  //         point: LatLng(x.latitude!, x.longitude!),
  //         builder: (_) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.bottomSheet(
  //                 isScrollControlled: true,
  //                 persistent: false,
  //                 isDismissible: true,
  //                 SingleChildScrollView(
  //                     child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 10),
  //                       height: 60,
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         color: hexToColor('#FFB661'),
  //                         borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //                       ),
  //                       child: Center(
  //                           child: KText(
  //                         text: 'Project Site : Type -${x.pillarType}',
  //                         bold: true,
  //                         fontSize: 16,
  //                       )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           KText(text: 'Geography'),
  //                           KText(text: '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Pole Type'),
  //                                   KText(text: x.pillarType != null ? x.pillarType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Power Source'),
  //                                   KText(text: x.powerSource != null ? x.powerSource : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Type'),
  //                                   KText(text: x.placeType != null ? x.placeType : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Place Name'),
  //                                   KText(text: x.siteName != null ? x.siteName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Address'),
  //                           KText(text: '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} '),
  //                           Divider(),
  //                           KText(text: 'Geography Point'),
  //                           KText(text: 'Lat: ${x.latitude}'),
  //                           KText(text: 'Long: ${x.longitude}'),
  //                           Divider(),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Potential Beneficiaries'),
  //                                   KText(text: x.potentialBeneficiaryCount.toString()),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Priority'),
  //                                   KText(text: x.priorityName != null ? x.priorityName : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Custodian Name'),
  //                                   KText(text: x.custodianFullname != null ? x.custodianFullname : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Mobile No.'),
  //                                   KText(text: x.custodianMobile != null ? x.custodianMobile : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'NID No.'),
  //                                   KText(text: x.custodianNid != null ? x.custodianNid : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                               Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   KText(text: 'Email'),
  //                                   KText(text: x.custodianEmail != null ? x.custodianEmail : ''),
  //                                   SizedBox(width: Get.width * .4, child: Divider()),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           KText(text: 'Custodian Address'),
  //                           KText(text: x.custodianAddress != null ? x.custodianAddress : ''),
  //                           Divider(),
  //                           KText(text: 'Captured Images'),
  //                           Center(
  //                             child: GestureDetector(
  //                               onTap: back,
  //                               child: Container(
  //                                 height: 34,
  //                                 width: 109,
  //                                 margin: EdgeInsets.symmetric(vertical: 50),
  //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
  //                                 child: Center(
  //                                   child: KText(
  //                                     text: 'Close',
  //                                     bold: true,
  //                                     color: Colors.white,
  //                                     fontSize: 16,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //               );
  //             },
  //             child: Icon(
  //               Icons.circle,
  //               color: Colors.purple,
  //               size: 10,
  //             ),
  //           );
  //         }));
  //   }

  //   kMapControllerSiteLocation.move(LatLng(siteLocations.value!.header!.latitude!, siteLocations.value!.header!.longitude!), 13);
  //   isLoading.value = false;
  // }
}
