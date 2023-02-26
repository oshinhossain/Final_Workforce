import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/convert_map_data.dart';
import 'package:workforce/src/helpers/get_file_name.dart';
import 'package:workforce/src/helpers/global_dialog.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/area_polygon.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/history_image_count_model.dart';
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

class SiteInspectionController extends GetxController with ApiService {
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

  final isStart = RxBool(false);

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

//-------------google map-----------------
  final allMarkers = RxSet<gmap.Marker>();
  final polygone = RxList<gmap.Polygon>();
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);
  gmap.GoogleMapController? mapController;

  //Evidence
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

  final evedenceImageCount = RxList<HistoryImageModel>();
  final evedenceImages = RxList<AllImagesModel>();

  // Evidence Image picker
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

      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'areaLevelFullCodes': [levelFullCode.value],
        if (selectedProject.value!.id!.isNotEmpty)
          'pId': selectedProject.value!.id!
      };

      final res = await postDynamic(
        path: ApiEndpoint.getSiteUrl(),
        body: body,
      );

      newPoleCount.value = 0;
      elePoleCount.value = 0;
      telPoleCount.value = 0;
      lightPostCount.value = 0;
      buildingCount.value = 0;
      otherPoleCount.value = 0;

      wifiApCount.value = 0;
      popCount.value = 0;
      btsCount.value = 0;

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
          projectSiteMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    isCheck.value = x.isChecked!;
                    siteInspectionDialog(x: x);
                  },
                  child: x.functionType == 'Cable Point'
                      ? x.verificationResult == 'Compliant'
                          ? RenderSvg(
                              path: x.pillarType == 'Electricity Pole'
                                  ? 'dot-red-check'
                                  : x.pillarType == 'Light Post'
                                      ? 'dot-violet-check'
                                      : x.pillarType == 'New Pole'
                                          ? 'dot-orange-check'
                                          : x.pillarType == 'Telephone Pole'
                                              ? 'dot-blue-check'
                                              : 'dot-black-check')
                          : x.verificationResult == 'Non-compliant'
                              ? RenderSvg(
                                  path: x.pillarType == 'Electricity Pole'
                                      ? 'dot-red-cross'
                                      : x.pillarType == 'Light Post'
                                          ? 'dot-violet-cross'
                                          : x.pillarType == 'New Pole'
                                              ? 'dot-orange-cross'
                                              : x.pillarType == 'Telephone Pole'
                                                  ? 'dot-blue-cross'
                                                  : 'dot-black-cross')
                              : x.workStatus == 'Completed'
                                  ? RenderSvg(
                                      path: x.pillarType == 'Electricity Pole'
                                          ? 'dot-red-complete'
                                          : x.pillarType == 'Light Post'
                                              ? 'dot-violet-complete'
                                              : x.pillarType == 'New Pole'
                                                  ? 'dot-orange-complete'
                                                  : x.pillarType ==
                                                          'Telephone Pole'
                                                      ? 'dot-blue-complete'
                                                      : 'dot-black-complete')
                                  : x.workStatus == 'Aborted'
                                      ? RenderSvg(
                                          path: x.pillarType ==
                                                  'Electricity Pole'
                                              ? 'dot-red-aborted'
                                              : x.pillarType == 'Light Post'
                                                  ? 'dot-violet-aborted'
                                                  : x.pillarType == 'New Pole'
                                                      ? 'dot-orange-aborted'
                                                      : x.pillarType ==
                                                              'Telephone Pole'
                                                          ? 'dot-blue-aborted'
                                                          : 'dot-black-aborted')
                                      : x.workStatus == 'Started' ||
                                              x.workStatus == 'Restarted' ||
                                              x.workStatus == 'WIP'
                                          ? RenderSvg(
                                              path: x.pillarType ==
                                                      'Electricity Pole'
                                                  ? 'dot-red-wip-started-restarted'
                                                  : x.pillarType == 'Light Post'
                                                      ? 'dot-violet-wip-started-restarted'
                                                      : x.pillarType ==
                                                              'New Pole'
                                                          ? 'dot-orange-wip-started-restarted'
                                                          : x.pillarType ==
                                                                  'Telephone Pole'
                                                              ? 'dot-blue-wip-started-restarted'
                                                              : 'dot-black-wip-started-restarted')
                                          : RenderSvg(
                                              height: 12,
                                              path: x.pillarType ==
                                                      'Electricity Pole'
                                                  ? 'electricity-pole'
                                                  : x.pillarType == 'Light Post'
                                                      ? 'light-post'
                                                      : x.pillarType ==
                                                              'New Pole'
                                                          ? 'new-pole'
                                                          : x.pillarType ==
                                                                  'Telephone Pole'
                                                              ? 'telephone-pole'
                                                              : 'building')
                      : x.verificationResult == 'Compliant'
                          ? RenderImg(
                              path: x.functionType == 'Wifi Router'
                                  ? 'marker-status-check12.png'
                                  : x.functionType == 'POP'
                                      ? 'marker-status-check10.png'
                                      : 'marker-status-check4.png')
                          : x.verificationResult == 'Non-compliant'
                              ? RenderImg(
                                  path: x.functionType == 'Wifi Router'
                                      ? 'marker-status-cross12.png'
                                      : x.functionType == 'POP'
                                          ? 'marker-status-cross10.png'
                                          : 'marker-status-cross4.png')
                              : x.workStatus == 'Completed'
                                  ? RenderImg(
                                      path: x.functionType == 'Wifi Router'
                                          ? 'marker-status-green12.png'
                                          : x.functionType == 'POP'
                                              ? 'marker-status-green10.png'
                                              : 'marker-status-green4.png')
                                  : x.workStatus == 'Aborted'
                                      ? RenderImg(
                                          path: x.functionType == 'Wifi Router'
                                              ? 'marker-status-red12.png'
                                              : x.functionType == 'POP'
                                                  ? 'marker-status-red10.png'
                                                  : 'marker-status-red4.png')
                                      : x.workStatus == 'Started' ||
                                              x.workStatus == 'Restarted' ||
                                              x.workStatus == 'WIP'
                                          ? RenderImg(
                                              path: x.functionType ==
                                                      'Wifi Router'
                                                  ? 'marker-status-blue12.png'
                                                  : x.functionType == 'POP'
                                                      ? 'marker-status-blue10.png'
                                                      : 'marker-status-blue4.png')
                                          : Icon(
                                              Icons.location_on,
                                              color: x.functionType ==
                                                      'Wifi Router'
                                                  ? Colors.green
                                                  : x.functionType == 'POP'
                                                      ? Colors.red
                                                      : Colors.black,
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
              default:
                return 'assets/img/other.png';
            }
          }

          checkMarkerStatus(functionType, pillerType, workStatus) {
            switch (workStatus) {
              case 'Completed':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-complete.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-complete.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-complete.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-complete.png'
                                    : 'assets/img/dot-black-complete.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-green12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-green10.png'
                            : 'assets/img/marker-status-green4.png';

              case 'Aborted':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-aborted.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-aborted.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-aborted.png'
                                : pillerType == 'Telephone Po le'
                                    ? 'assets/img/dot-blue-aborted.png'
                                    : 'assets/img/dot-black-aborted.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-red12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-red10.png'
                            : 'assets/img/marker-status-red4.png';
              case 'Started':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-wip-started-restarted.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-wip-started-restarted.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-wip-started-restarted.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-wip-started-restarted.png'
                                    : 'assets/img/dot-black-wip-started-restarted.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-blue12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-blue10.png'
                            : 'assets/img/marker-status-blue4.png';
              case 'Restarted':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-wip-started-restarted.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-wip-started-restarted.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-wip-started-restarted.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-wip-started-restarted.png'
                                    : 'assets/img/dot-black-wip-started-restarted.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-blue12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-blue10.png'
                            : 'assets/img/marker-status-blue4.png';
              case 'WIP':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-wip-started-restarted.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-wip-started-restarted.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-wip-started-restarted.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-wip-started-restarted.png'
                                    : 'assets/img/dot-black-wip-started-restarted.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-blue12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-blue10.png'
                            : 'assets/img/marker-status-blue4.png';
              default:
                return getMarkerImg(functionType, pillerType);
            }
          }

          checkMarkerInspetionStatus(
              functionType, pillerType, workStatus, verificationResult) {
            switch (verificationResult) {
              case 'Compliant':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-check.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-check.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-check.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-check.png'
                                    : 'assets/img/dot-black-check.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-check12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-check10.png'
                            : 'assets/img/marker-status-check4.png';

              case 'Non-compliant':
                return functionType == 'Cable Point'
                    ? pillerType == 'Electricity Pole'
                        ? 'assets/img/dot-red-cross.png'
                        : pillerType == 'New Pole'
                            ? 'assets/img/dot-orange-cross.png'
                            : pillerType == 'Light Post'
                                ? 'assets/img/dot-violet-cross.png'
                                : pillerType == 'Telephone Pole'
                                    ? 'assets/img/dot-blue-cross.png'
                                    : 'assets/img/dot-black-cross.png'
                    : functionType == 'Wifi Router'
                        ? 'assets/img/marker-status-cross12.png'
                        : functionType == 'POP'
                            ? 'assets/img/marker-status-cross10.png'
                            : 'assets/img/marker-status-cross4.png';

              default:
                return checkMarkerStatus(functionType, pillerType, workStatus);
            }
          }

          final Uint8List markerIcon = await ConvertMaPData().getBytesFromAsset(
              // ignore: unnecessary_string_interpolations
              '${checkMarkerInspetionStatus(x.functionType, x.pillarType, x.workStatus, x.verificationResult)}',
              50);
          allMarkers.add(
            gmap.Marker(
                position: gmap.LatLng(x.latitude!, x.longitude!),
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                onTap: () {
                  isCheck.value = x.isChecked!;
                  siteInspectionDialog(x: x);
                }),
          );

          bounds.extend(LatLng(x.latitude!, x.longitude!));
        });
      }

      isLoading.value = false;
      kMapControllerSiteLocation.fitBounds(
        bounds,
        options: const FitBoundsOptions(
          padding: EdgeInsets.all(30),
        ),
      );
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

  siteInspectionDialog({
    required ProjectSites x,
  }) {
    getFileCount(id: x.id!, status: x.workStatus);
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
      title: 'Site Inspection',
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
                text: 'Lat: ${x.latitude},',
                color: AppTheme.nTextC,
                fontSize: 14,
              ),
              KText(
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
                  KText(
                    text: '${x.custodianFullname}',
                  ),
                  Spacer(),
                  KText(
                    text: '${x.custodianMobile}',
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
                    text: '${x.custodianNid}',
                  ),
                  Spacer(),
                  KText(
                    text: '${x.custodianEmail}',
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
                text: '${x.creatorUsername != null ? x.creatorUsername : ''}',
              ),
              SizedBox(
                height: 10,
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
                text: '${x.custodianAddress}',
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
                      onChanged: remarks,
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
                  Row(
                    children: [
                      KText(
                        text: 'Evidence',
                        color: AppTheme.textfieldColor,
                        fontSize: 13,
                      ),
                      Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          pickMultiImage();
                        },
                        child: RenderSvg(
                          path: 'icon_camera',
                          width: 25.0,
                          color: hexToColor('#72778F'),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 80,
                    width: Get.width * .8,
                    child: Obx(() => evedenceImageCount.isEmpty
                            ? Center(
                                child: Loading(),
                              )
                            : int.parse(evedenceImageCount[evedenceImageCount
                                            .indexWhere((element) =>
                                                element.progressId == x.id)]
                                        .imageCount) ==
                                    0
                                ? Container(
                                    alignment: Alignment.center,
                                    width: Get.width * .8,
                                    height: 20,
                                    child: Text('No Image Found'))
                                : ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: evedenceImages[
                                            evedenceImages.indexWhere(
                                                (e) => e.progressId == x.id)]
                                        .images
                                        .map((e) => GestureDetector(
                                              onTap: () {
                                                Get.dialog(
                                                  barrierDismissible: false,
                                                  // backgroundColor: Colors.transparent,
                                                  // contentPadding: EdgeInsets.zero,
                                                  // content:
                                                  Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 45,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .8,
                                                        width: Get.width * .7,
                                                        child: PhotoView(
                                                            backgroundDecoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                            imageProvider:
                                                                NetworkImage(
                                                                    e)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: Container(
                                                  height: 45,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(e),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )
                        // : Text('data'),
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagefiles.isEmpty
                            ? SizedBox()
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
                        //    getFileCount(id: x.id!, status: x.workStatus);
                        isStart.value = false;
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
                        modelList.add(ModelList(
                            id: x.id,
                            remarks: remarks.value,
                            verifyResult: veryfyResult.value));
                        postPogress(
                            status: x.workStatus, statusCode: x.workStatusCode);
                        postEvidenceAttachment(
                            projectId: x.projectId,
                            siteId: x.id,
                            geoLevelId: x.geoLevel4Id);
                        isStart.value = false;
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
    modelList.clear();
    locations.clear();

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }

  postPogress({String? status, String? statusCode}) async {
    issubmit.value = true;
    final username = Get.put(UserController()).username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    String? id;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'statusCode': statusCode,
      'status': status,
      'type': 'inspector',
      'modelList': modelList.map((item) {
        id = item.id!;
        return {
          'id': item.id,
          'remarks': item.remarks,
          'verifyResult': item.verifyResult,
        };
      }).toList()
    };

    final res = await postDynamic(
      path: ApiEndpoint.sitePostPogressUrl(),
      body: body,
      authentication: true,
    );

    // kLog('body printed');
    // kLog(jsonEncode(body));
    // kLog('response printed');
    // kLog(res.data);
    if (res.data['status'] != null &&
        res.data['status'].contains('successful') == true) {
      issubmit.value = false;
      projectSiteList[
              projectSiteList.indexWhere((element) => element!.id == id!)]!
          .verifierComments = remarks.value;
      projectSiteList[
              projectSiteList.indexWhere((element) => element!.id == id!)]!
          .verificationResult = veryfyResult.value;

      // kLog(veryfyResult.value);
      // veryfyResult.value == 'Complaint' ? isChecked.value = true : false;
      nonCompliantCount.value = 0;
      compliantCount.value = 0;
      notInspectedCount.value = 0;
      veryfyResult.value = '';
      remarks.value = '';
      // currentStatus.value = 'Started';
      // ignore: avoid_function_literals_in_foreach_calls
      projectSiteList.forEach((x) async {
        if (x!.verificationResult != 'Compliant' &&
            x.verificationResult != 'Non-compliant') {
          //projectSiteList[projectSiteList.indexWhere((element) => element.workStatus==x.workStatus)].
          notInspectedCount.value++;
        }
        if (x.verificationResult == 'Compliant') {
          compliantCount.value++;
        }
        if (x.verificationResult == 'Non-compliant') {
          nonCompliantCount.value++;
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
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-complete.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-complete.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-complete.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-complete.png'
                                  : 'assets/img/dot-black-complete.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-green12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-green10.png'
                          : 'assets/img/marker-status-green4.png';

            case 'Aborted':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-aborted.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-aborted.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-aborted.png'
                              : pillerType == 'Telephone Po le'
                                  ? 'assets/img/dot-blue-aborted.png'
                                  : 'assets/img/dot-black-aborted.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-red12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-red10.png'
                          : 'assets/img/marker-status-red4.png';
            case 'Started':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-wip-started-restarted.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-wip-started-restarted.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-wip-started-restarted.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-wip-started-restarted.png'
                                  : 'assets/img/dot-black-wip-started-restarted.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-blue12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-blue10.png'
                          : 'assets/img/marker-status-blue4.png';
            case 'Restarted':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-wip-started-restarted.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-wip-started-restarted.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-wip-started-restarted.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-wip-started-restarted.png'
                                  : 'assets/img/dot-black-wip-started-restarted.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-blue12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-blue10.png'
                          : 'assets/img/marker-status-blue4.png';
            case 'WIP':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-wip-started-restarted.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-wip-started-restarted.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-wip-started-restarted.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-wip-started-restarted.png'
                                  : 'assets/img/dot-black-wip-started-restarted.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-blue12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-blue10.png'
                          : 'assets/img/marker-status-blue4.png';
            default:
              return getMarkerImg(functionType, pillerType);
          }
        }

        checkMarkerInspetionStatus(
            functionType, pillerType, workStatus, verificationResult) {
          switch (verificationResult) {
            case 'Compliant':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-check.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-check.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-check.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-check.png'
                                  : 'assets/img/dot-black-check.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-check12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-check10.png'
                          : 'assets/img/marker-status-check4.png';

            case 'Non-compliant':
              return functionType == 'Cable Point'
                  ? pillerType == 'Electricity Pole'
                      ? 'assets/img/dot-red-cross.png'
                      : pillerType == 'New Pole'
                          ? 'assets/img/dot-orange-cross.png'
                          : pillerType == 'Light Post'
                              ? 'assets/img/dot-violet-cross.png'
                              : pillerType == 'Telephone Pole'
                                  ? 'assets/img/dot-blue-cross.png'
                                  : 'assets/img/dot-black-cross.png'
                  : functionType == 'Wifi Router'
                      ? 'assets/img/marker-status-cross12.png'
                      : functionType == 'POP'
                          ? 'assets/img/marker-status-cross10.png'
                          : 'assets/img/marker-status-cross4.png';

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
              onTap: () {
                isCheck.value = x.isChecked!;
                siteInspectionDialog(x: x);
              }),
        );
      });
      //  back();
      DialogHelper.successDialog(
        title: 'Success!',
        msg: res.data['message'][0].toString(),
        color: hexToColor('#00B485'),
        path: 'success-circular',
        onPressed: () {
          modelList.clear();
          remarks.value = '';

          back();
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
          modelList.clear();
          back();
        },
      );
    }
  }

  postEvidenceAttachment({
    required String? projectId,
    required String? siteId,
    required String? geoLevelId,
  }) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;

      List<MultipartFile> attachments = [];
      for (var img in imagefiles) {
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_SITE_INSPECTION',
          'projectId': projectId,
          'geoLevelId': geoLevelId,
          'siteId': siteId,
          'files': attachments,
        },
      );
      await postDynamic(
        path: ApiEndpoint.siteEvedenseSave(),
        body: data,
      );

      imagefiles.clear();
      isLoading.value = false;
      back();
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

  //get File Count

  getFileCount({String? id, String? status}) async {
    try {
      isLoading.value = true;
      evedenceImageCount.clear();
      //  for (var element in projectSiteList) {
      // kLog(id);

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyId': selectedAgency!.agencyId,
        //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
        'username': username,
        'fileCategory': 'FILE_CATEGORY_SITE_INSPECTION',
        'fileRefId': id,
        'fileRefNo': '',

        'fileEntryUsername': ''
      };

      final res = await getDynamic(
        path: ApiEndpoint.getFileCount(),
        queryParameters: params,
      );
      //kLog('**************0 ${res.data['data']['fileCount']}');
      // kLog(res.data);
      evedenceImageCount.add(HistoryImageModel(
          progressId: id!,
          imageCount: res.data['data']['fileCount'].toString(),
          status: status!));

      evedenceImages
          .add(AllImagesModel(progressId: id, images: [], status: status));

      isLoading.value = false;
      //  }
      // ignore: unused_local_variable
      for (var element in evedenceImageCount) {
        print('image Count');
        // kLog('${element.progressId} ${element.imageCount}');
      }

      for (var element in evedenceImageCount) {
        if (element.imageCount != '0') {
          // kLog(evedenceImageCount.length);
          //// kLog(
          //     'status incoming: ${taskHistoryList[historyImageCount.indexWhere((element) => element.progressId == element.progressId)].status!}');
          await getImage(
            projectId: selectedProject.value!.id!,
            fileCount: int.parse(element.imageCount),
            siteId: element.progressId,
            geoLevelId: geol4Id.value,
          );
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
//get history image
  }

  getImage({
    required String projectId,
    required int fileCount,
    required String siteId,
    required String geoLevelId,
    // required String supportId
  }) {
    final username = Get.put(UserController()).username;

    evedenceImages[evedenceImages.indexWhere((e) => e.progressId == siteId)]
        .images
        .clear();
    for (int i = 0; i < fileCount; i++) {
      // kLog('inner loop $i');

      // kLog(
      //     '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}&username=$username&fileCategory=FILE_CATEGORY_SITE_INSPECTION&projectId=$projectId&geoLevelId=$geoLevelId&siteId=$siteId&activityId=&supportId=&progressId=&ids=&originalFileNameNeeded=&registrationNo=&status=&flag=${i + 1}');

      evedenceImages[evedenceImages.indexWhere((e) => e.progressId == siteId)]
          .images
          .add(
              '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}&username=$username&fileCategory=FILE_CATEGORY_SITE_INSPECTION&projectId=$projectId&geoLevelId=$geoLevelId&siteId=$siteId&activityId=&supportId=&progressId=&ids=&originalFileNameNeeded=&registrationNo=&status=&flag=${i + 1}');
    }
  }

  updateCheckbox(ProjectSites v) {
    final item = projectSiteList.singleWhere((x) => x!.id == v.id);

    item!.isChecked = item.isChecked! ? false : true;

    projectSiteList[projectSiteList.indexOf(item)] = item;
  }
}
