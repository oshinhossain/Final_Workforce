import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/convert_map_data.dart';
import 'package:workforce/src/helpers/get_file_name.dart';
import 'package:workforce/src/helpers/global_dialog.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/area_polygon.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/model_list.dart';
import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';
import 'package:workforce/src/models/site_relocation.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import '../helpers/dialogHelper.dart';
import '../helpers/image_compress.dart';
import '../helpers/log.dart';
import '../map/dragmarker.dart';
import '../models/appliances.dart';
import '../models/project_dropdown.dart';
import '../widgets/custom_textfield_with_dropdown.dart';
import 'agencyController.dart';

class RequestSiteRelocationController extends GetxController with ApiService {
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);
  final isGoogleMap = RxBool(true);
  final isPlotingEnable = RxBool(true);
  final allMarkers = RxList<gmap.Marker>();
  final dropMarkers = RxList<gmap.Marker>();
  final editMarkers = RxList<gmap.Marker>();
  final dragMarkers = RxList<gmap.Marker>();
  final allSites = RxList<gmap.Circle>();
  final polygone = RxList<gmap.Polygon>();

  gmap.GoogleMapController? mapController;
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);

  final isLoading = RxBool(false);
  final issubmit = RxBool(false);
  final isLoadding = RxBool(false);

  final addDriver = RxBool(false);

  //  final siteLocations = Rx<SiteLocation?>(null);
  final siteLocationsV2 = Rx<SiteLocationV2?>(null);
  final siteLocations = Rx<ProjectSites?>(null);
  final projectSiteList = RxList<ProjectSites?>([]);
  final projectSiteUpdateList = RxList<ProjectSites?>([]);
  final applianceList = RxList<Appliances?>([]);

  final areaPolygon = Rx<AreaPolygon?>(null);
  final markerList = RxList<ProjectSites>();

  final locationList = RxList<SiteLocation>();

  final newPoleList = RxList<NewPole>();
  final ePoleList = RxList<ElectricityPole>();
  final noPoleList = RxList<NoPole>();
  final onBuildingList = RxList<OnBuilding>();
  final lightPostList = RxList<LightPost>();

//=======================================
  final projectSiteMarkers = RxList<Marker>();
  final projectSiteMarkers2 = RxList<DragMarker>();
  final projectSiteDropMarkers = RxList<Marker>();
  final projectSiteEditMarkers = RxList<Marker>();
  final addProjectSiteMarkers = RxList<DragMarker>();
  final addPolylines = RxList<Polyline>();

  final updateApplianceList = RxList<ModelList>();
  final linkPolylines = RxList<Polyline>();

  final newSite = RxList<SiteRelocation>();
  final delSite = RxList<SiteRelocation>();

  //
  final addMarker = RxBool(false);
  final editMarker = RxBool(false);
  final deleteMarker = RxBool(false);
  final dragMarker = RxBool(false);

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

  final locations = RxList<Geograpphy>();

  final search = RxString('');
  final levelFullCode = RxString('');
  final geol4Id = RxString('');

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);
  final selectProjectName = RxString('Constraction');

  // =============== To draw ploygon on map =============

  final pointsForPolygon = RxList<LatLng>([]);

  // =============== To change view of map =============

  final isSateliteViewEnable = RxBool(false);

  //====================== get geo area =================================

  //====================== Add site dialog =================================

  final siteID = RxString('');
  final siteName = RxString('');

  final siteTypes = RxList([
    'Wifi Router',
    'Cable Point',
    'POP',
    'BTS',
    'Cable TV Operator',
    'Local ISP',
    'Others',
  ]);
  final selectedSiteType = RxString('Wifi Router');
  final poleTypes = RxList([
    'Electricity Pole',
    'Building/House',
    'Light Post',
    'New Pole',
    'On Building',
    'Telephone Pole',
  ]);
  final selectedPoleType = RxString('Electricity Pole');
  final powerSources = RxList([
    'Electricity',
    'Solar',
    'New Solar Panel Needed',
    'Generator',
  ]);
  final selectedPowerSource = RxString('Electricity');
  final placeTypes = RxList([
    'Bazar',
    'Bus Station',
    'Club',
    'College',
    'Cross Road',
    'District HQs',
    'Madrasah',
    'Market',
    'Other',
    'Play Ground',
    'School',
    'Tea Stall',
    'Train Station',
    'Union Parishad',
    'Upazila Parishad',
  ]);
  final selectedPlaceType = RxString('Bazar');
  final placeName = RxString('');
  final address = RxString('');
  final potentialBeneficiaries = RxString('');
  final priority = RxList([
    'Silver',
    'Gold',
    'Platinum',
  ]);
  final priorityCode = RxInt(3);
  final selectedPriority = RxString('Silver');
  final custodianName = RxString('');
  final custodianMobileNo = RxString('');
  final custodianNIDNo = RxString('');
  final custodianEmail = RxString('');
  final custodianAddress = RxString('');

  //-------------------------------------
  //Evidence
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------
  // DateTime? onAirDate;
  // DateTime? installDate;
//

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
        // pickedImageMemory.value = await pickedImage.value!.readAsBytes();
        // imagefiles.value = pickedfile;

        imagefiles.add(pickedImage.value!);
      }

      // pickedImage.value = File(pickedfile!.path);
      // File image

      // back();

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
    pointsForGmapPolygon.clear();
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

  void addProject(LatLng latLng) async {
    isLoading.value = true;

    final bounds = LatLngBounds();

    addProjectSiteMarkers.add(
      DragMarker(
        point: LatLng(latLng.latitude, latLng.longitude),
        onDragStart: (details, point) {
          print('Start point $point');
          // kLog('Start point $details');
        },
        onDragEnd: (details, point) {
          print('End point $point');
          // kLog('End point $details');
        },
        onDragUpdate: (details, point) {},
        feedbackBuilder: (ctx) => const Icon(Icons.edit_location, size: 75),
        feedbackOffset: const Offset(0.0, -18.0),
        onLongPress: (p0) {
          // Get.dialog(Container(
          //   height: 150,
          // ));
        },
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: RenderSvg(
              path: 'circle_add_marker',
            ),
          );
        },
      ),
    );
    bounds.extend(LatLng(latLng.latitude, latLng.longitude));

    addPolylines.add(
      Polyline(
        points: [LatLng(latLng.latitude, latLng.longitude)],
        color: Colors.orange,
        strokeWidth: 5,
      ),
    );
    isLoading.value = false;
    kMapControllerSiteLocation.fitBounds(
      bounds,
      options: const FitBoundsOptions(
        padding: EdgeInsets.all(30),
      ),
    );
  }

  void siteSearchV2() async {
    try {
      if (dragMarker.value) {
        // kLog('Drag Marker');
        projectSiteMarkers.clear();
        projectSiteMarkers2.clear();
        projectSiteEditMarkers.clear();
        newSite.clear();
        newPoleCount.value = 0;
        elePoleCount.value = 0;
        telPoleCount.value = 0;
        lightPostCount.value = 0;
        buildingCount.value = 0;
        otherPoleCount.value = 0;

        cableTvCount.value = 0;
        localIspCount.value = 0;

        wifiApCount.value = 0;
        popCount.value = 0;
        btsCount.value = 0;

        final bounds = LatLngBounds();

        //================== Project Sites Circles =================

        siteLocations.value = null;

        if (projectSiteList.isNotEmpty) {
          siteLocations.value = projectSiteList.first;
          // ignore: avoid_function_literals_in_foreach_calls
          projectSiteList.forEach((x) async {
            if (x!.pillarType == 'Electricity Pole') {
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

            projectSiteMarkers2.add(
              DragMarker(
                point: LatLng(x.latitude!, x.longitude!),
                onDragStart: (details, point) {
                  print('Start point $point');
                  // kLog('Start point $details');
                },
                onDragEnd: (details, point) {
                  print('End point $point');
                  // kLog('End point $details');
                  // kLog(point.latitude);
                  // kLog(point.longitude);
                  newSite.add(SiteRelocation(
                      siteId: x.id,
                      newLat: point.latitude,
                      newLong: point.longitude));

                  // kLog('newSite ${newSite.length}');
                },
                onDragUpdate: (details, point) {},
                feedbackBuilder: (ctx) => Icon(Icons.edit_location, size: 75),
                feedbackOffset: Offset(0.0, -18.0),
                builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      //updateMarkerDialog(x: x);
                      DialogHelper.showNetworkTopologyDetails(x: x);
                    },
                    child: x.functionType == 'Cable Point'
                        ? Icon(
                            Icons.add_circle,
                            color: x.pillarType == 'Electricity Pole'
                                ? Colors.red
                                : x.pillarType == 'New Pole'
                                    ? Colors.orange
                                    : x.pillarType == 'Light Post'
                                        ? hexToColor('#A533FF')
                                        : x.pillarType == 'Telephone Pole'
                                            ? hexToColor('#3379FF')
                                            : Colors.black,
                            size: 30,
                          )
                        : Icon(Icons.location_on,
                            color: x.functionType == 'Wifi Router'
                                ? Colors.green
                                : x.functionType == 'POP'
                                    ? Colors.red
                                    : x.functionType == 'BTS'
                                        ? Colors.lightGreenAccent
                                        : Colors.black),
                  );
                },
              ),
            );
            bounds.extend(LatLng(x.latitude!, x.longitude!));
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

            final Uint8List markerIcon = await ConvertMaPData()
                .getBytesFromAsset(
                    getMarkerImg(x.functionType, x.pillarType)!, 50);
            dragMarkers.add(
              gmap.Marker(
                  draggable: true,
                  position: gmap.LatLng(x.latitude!, x.longitude!),
                  markerId: gmap.MarkerId(x.id!),
                  icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                  onDragEnd: (point) {
                    // kLog(point.latitude);
                    // kLog(point.longitude);
                    newSite.add(SiteRelocation(
                        siteId: x.id,
                        newLat: point.latitude,
                        newLong: point.longitude));

                    // kLog('newSite ${newSite.length}');
                  },
                  onTap: () {
                    // updateMarkerDialog(x: x);
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
        // kLog('Zoom >>>>>>>>>>>>>>>:: ${kMapControllerSiteLocation.zoom}');
        kMapControllerSiteLocation.fitBounds(
          bounds,
          options: FitBoundsOptions(
            padding: EdgeInsets.all(30),
            zoom: kMapControllerSiteLocation.zoom,
          ),
        );
        // kMapControllerSiteLocation.move(
        //     LatLng(), kMapControllerSiteLocation.zoom);
      } else if (editMarker.value) {
        // kLog('Edit Marker');
        projectSiteMarkers.clear();
        projectSiteMarkers2.clear();
        projectSiteEditMarkers.clear();
        newSite.clear();
        newPoleCount.value = 0;
        elePoleCount.value = 0;
        telPoleCount.value = 0;
        lightPostCount.value = 0;
        buildingCount.value = 0;
        otherPoleCount.value = 0;

        cableTvCount.value = 0;
        localIspCount.value = 0;

        wifiApCount.value = 0;
        popCount.value = 0;
        btsCount.value = 0;

        final bounds = LatLngBounds();

        //================== Project Sites Circles =================

        siteLocations.value = null;

        if (projectSiteList.isNotEmpty) {
          siteLocations.value = projectSiteList.first;
          // ignore: avoid_function_literals_in_foreach_calls
          projectSiteList.forEach((x) async {
            if (x!.pillarType == 'Electricity Pole') {
              elePoleCount.value++;
            } else if (x.pillarType == 'New Pole') {
              newPoleCount.value++;
            } else if (x.pillarType == 'Light Post') {
              lightPostCount.value++;
            } else if (x.pillarType == 'Telephone Pole') {
              telPoleCount.value++;
            } else {
              // otherPoleCount.value++;
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

            projectSiteEditMarkers.add(
              Marker(
                point: LatLng(x.latitude!, x.longitude!),
                builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      if (x.functionType == 'Cable Point')
                        // ignore: curly_braces_in_flow_control_structures
                        updateMarkerDialog(x: x);
                    },
                    child: x.functionType == 'Cable Point'
                        ? CircleAvatar(
                            backgroundColor: x.pillarType == 'Electricity Pole'
                                ? Colors.red
                                : x.pillarType == 'New Pole'
                                    ? Colors.orange
                                    : x.pillarType == 'Light Post'
                                        ? hexToColor('#A533FF')
                                        : x.pillarType == 'Telephone Pole'
                                            ? hexToColor('#3379FF')
                                            : Colors.black,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        : Icon(Icons.location_on,
                            size: 40,
                            color: x.functionType == 'Wifi Router'
                                ? Colors.green
                                : x.functionType == 'POP'
                                    ? Colors.red
                                    : x.functionType == 'BTS'
                                        ? Colors.lightGreenAccent
                                        : Colors.black),
                  );
                },
              ),
            );
            bounds.extend(LatLng(x.latitude!, x.longitude!));

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

            final Uint8List markerIcon = await ConvertMaPData()
                .getBytesFromAsset(
                    getMarkerImg(x.functionType, x.pillarType)!, 50);
            editMarkers.add(
              gmap.Marker(
                  position: gmap.LatLng(x.latitude!, x.longitude!),
                  markerId: gmap.MarkerId(x.id!),
                  icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                  onTap: () {
                    updateMarkerDialog(x: x);
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
        //// kLog('Zoom >>>>>>>>>>>>>>>:: ${kMapControllerSiteLocation.zoom}');

        if (!isGoogleMap.value) {
          kMapControllerSiteLocation.fitBounds(
            bounds,
            options: FitBoundsOptions(
              padding: EdgeInsets.all(30),
              zoom: kMapControllerSiteLocation.zoom,
            ),
          );
        }
        // kMapControllerSiteLocation.move(
        //     LatLng(), kMapControllerSiteLocation.zoom);
      } else if (deleteMarker.value) {
        // kLog('Delete Marker');
        final bounds = LatLngBounds();
        projectSiteDropMarkers.clear();

        if (projectSiteList.isNotEmpty) {
          // ignore: avoid_function_literals_in_foreach_calls
          projectSiteList.forEach((x) async {
            if (x!.pillarType == 'Electricity Pole') {
              elePoleCount.value++;
            } else if (x.pillarType == 'New Pole') {
              newPoleCount.value++;
            } else if (x.pillarType == 'Light Post') {
              lightPostCount.value++;
            } else if (x.pillarType == 'Telephone Pole') {
              telPoleCount.value++;
            } else {
              // otherPoleCount.value++;
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

            projectSiteDropMarkers.add(
              Marker(
                point: LatLng(x.latitude!, x.longitude!),
                builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      GlobalDialog.confirmationDialog(
                          titleBackgroundColor: Colors.red,
                          confirmBackgroundColor: Colors.red,
                          cancelBackgroundColor: Colors.grey,
                          title: 'Drop',
                          msg: 'Are you sure?',
                          onPressed: () {
                            delSite.clear();
                            delSite.add(SiteRelocation(
                                siteId: x.id,
                                newLat: x.latitude,
                                newLong: x.longitude));
                            relocationSite('drop');
                            // kLog(delSite.length);
                            back();
                          });
                    },
                    child: x.functionType == 'Cable Point'
                        ? Icon(
                            Icons.cancel,
                            color: x.pillarType == 'Electricity Pole'
                                ? Colors.red
                                : x.pillarType == 'New Pole'
                                    ? Colors.orange
                                    : x.pillarType == 'Light Post'
                                        ? hexToColor('#A533FF')
                                        : x.pillarType == 'Telephone Pole'
                                            ? hexToColor('#3379FF')
                                            : Colors.black,
                            size: 30,
                          )
                        : Icon(
                            Icons.location_off_sharp,
                            color: x.functionType == 'Wifi Router'
                                ? Colors.green
                                : x.functionType == 'POP'
                                    ? Colors.red
                                    : x.functionType == 'BTS'
                                        ? Colors.lightGreenAccent
                                        : Colors.black,
                            size: 40,
                          ),
                  );
                },
              ),
            );

            bounds.extend(LatLng(x.latitude!, x.longitude!));

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

            final Uint8List markerIcon = await ConvertMaPData()
                .getBytesFromAsset(
                    getMarkerImg(x.functionType, x.pillarType)!, 50);
            dropMarkers.add(
              gmap.Marker(
                  position: gmap.LatLng(x.latitude!, x.longitude!),
                  markerId: gmap.MarkerId(x.id!),
                  icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                  onTap: () {
                    GlobalDialog.confirmationDialog(
                        titleBackgroundColor: Colors.red,
                        confirmBackgroundColor: Colors.red,
                        cancelBackgroundColor: Colors.grey,
                        title: 'Drop',
                        msg: 'Are you sure?',
                        onPressed: () {
                          delSite.clear();
                          delSite.add(SiteRelocation(
                              siteId: x.id,
                              newLat: x.latitude,
                              newLong: x.longitude));
                          relocationSite('drop');
                          // kLog(delSite.length);
                          back();
                        });
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
                  }),
            );
          });
          if (!isGoogleMap.value) {
            kMapControllerSiteLocation.fitBounds(
              bounds,
              options: const FitBoundsOptions(
                padding: EdgeInsets.all(30),
              ),
            );
          }
          // kLog('del list');
          // kLog(projectSiteDropMarkers.length);
          // kLog('project list');
          // kLog(projectSiteList.length);
        }
      } else {
        isLoading.value = true;

        final username = Get.put(UserController()).username;

        final body = {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,

          'areaLevelFullCodes': [levelFullCode.value],
          'pId': selectedProject.value!.id!
          // // 'areaLevelFullCode': 'BD30261429',
        };
        //   // kLog(params);

        final res = await postDynamic(
            path: ApiEndpoint.getSiteUrl(), body: body, authentication: true);

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

        if (projectSiteListData.isNotEmpty) {
          siteLocations.value = projectSiteListData.first;
          projectSiteList.clear();
          //Add project site
          projectSiteList.addAll(projectSiteListData);

          // ignore: avoid_function_literals_in_foreach_calls
          projectSiteListData.forEach((x) async {
            // kLog(jsonEncode(x));
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

            projectSiteMarkers.add(
              Marker(
                point: LatLng(x.latitude!, x.longitude!),
                builder: (_) {
                  return GestureDetector(
                      onTap: () {
                        DialogHelper.showNetworkTopologyDetails(x: x);
                      },
                      child: x.functionType == 'Cable Point'
                          ? x.workStatus != 'New'
                              ? Icon(
                                  Icons.circle,
                                  color: x.pillarType == 'Electricity Pole'
                                      ? Colors.red
                                      : x.pillarType == 'New Pole'
                                          ? Colors.orange
                                          : x.pillarType == 'Light Post'
                                              ? hexToColor('#A533FF')
                                              : x.pillarType == 'Telephone Pole'
                                                  ? hexToColor('#3379FF')
                                                  : Colors.black,
                                  size: 10,
                                )
                              : x.workStatus == 'New'
                                  ? CircleAvatar(
                                      radius: 4,
                                      backgroundColor: x.pillarType ==
                                              'Electricity Pole'
                                          ? Colors.red
                                          : x.pillarType == 'New Pole'
                                              ? Colors.orange
                                              : x.pillarType == 'Light Post'
                                                  ? hexToColor('#A533FF')
                                                  : x.pillarType ==
                                                          'Telephone Pole'
                                                      ? hexToColor('#3379FF')
                                                      : Colors.black,
                                      child: KText(
                                        text: 'N',
                                        color: Colors.white,
                                        bold: true,
                                      ),
                                    )
                                  : null
                          : Icon(
                              Icons.location_on_sharp,
                              color: x.functionType == 'Wifi Router'
                                  ? Colors.green
                                  : x.functionType == 'POP'
                                      ? Colors.red
                                      : x.functionType == 'BTS'
                                          ? Colors.lightGreenAccent
                                          : Colors.black,
                              size: 40,
                            ));
                },
              ),
            );
            bounds.extend(LatLng(x.latitude!, x.longitude!));

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

            final Uint8List markerIcon = await ConvertMaPData()
                .getBytesFromAsset(
                    getMarkerImg(x.functionType, x.pillarType)!, 50);
            allMarkers.add(
              gmap.Marker(
                  position: gmap.LatLng(x.latitude!, x.longitude!),
                  markerId: gmap.MarkerId(x.id!),
                  icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                  onTap: () {
                    DialogHelper.showNetworkTopologyDetails(x: x);
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
        if (!isGoogleMap.value) {
          kMapControllerSiteLocation.fitBounds(
            bounds,
            options: const FitBoundsOptions(
              padding: EdgeInsets.all(30),
            ),
          );
        }
      }
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
                    text: 'Search Location',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          projectSiteList.clear();
                          projectSiteMarkers.clear();

                          projectSiteEditMarkers.clear();
                          projectSiteDropMarkers.clear();
                          allMarkers.clear();
                          allSites.clear();
                          updateApplianceList.clear();
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

  addMarkerDialog() {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Add Site',
      widget: Obx(
        () => Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              KText(
                fontSize: 13,
                text: 'Project',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(height: 5),
              KText(
                fontSize: 14,
                text: '${selectedProject.value!.projectName}',
                color: AppTheme.nTextC,
              ),
              SizedBox(height: 10),
              KText(
                fontSize: 13,
                text: 'Geography',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(
                height: 5,
              ),
              KText(
                fontSize: 14,
                text:
                    '${siteLocations.value!.geoLevel2Name} > ${siteLocations.value!.geoLevel3Name} > ${siteLocations.value!.geoLevel4Name}',
                color: AppTheme.nTextC,
                maxLines: 2,
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
                        text: 'Site Name ',
                        color: AppTheme.nTextLightC,
                        fontSize: 13,
                      ),
                      KText(
                        text: '*',
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ],
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
                  SizedBox(
                    width: 200,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: siteName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        hintText: 'Site name ',
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
                  Spacer(),
                  KText(
                    text: '(auto)',
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
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                // height: 25,
                child: CustomTextFieldWithDropdown(
                  suffix: DropdownButton(
                    value: selectedSiteType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: siteTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          selectedSiteType.value = item;
                        },
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 32,
                          ),
                          child: SizedBox(
                            width: Get.width / 1.5,
                            child: KText(
                              text: item,
                              fontSize: 13,
                              maxLines: 3,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      KText(
                        text: 'Pole Type ',
                        color: AppTheme.nTextLightC,
                        fontSize: 13,
                      ),
                      KText(
                        text: '*',
                        color: Colors.red,
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
                      KText(
                        text: '*',
                        color: Colors.red,
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
                  SizedBox(
                    width: 130,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPoleType.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: poleTypes.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedPoleType.value = item;
                              print(selectedPoleType.value);
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
                                  fontSize: 13,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (item) {},
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 130,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPowerSource.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: powerSources.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedPowerSource.value = item;
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: 'Place Type ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                  Spacer(),
                  KText(
                    text: 'Place Name ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
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
                  SizedBox(
                    width: 130,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPlaceType.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: placeTypes.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedPlaceType.value = item;
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
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
                  Spacer(),
                  SizedBox(
                    width: 100,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: placeName,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'Place Name',
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
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,

                // (get text)
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                  initialValue: '',
                  onChanged: address,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Address',
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
                text:
                    'Lat: ${locationC.currentLatLng!.latitude}, Long: ${locationC.currentLatLng!.longitude}',
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
                    text: 'Potential Beneficiaries',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  Spacer(),
                  KText(
                    text: 'Priority',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
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
                  SizedBox(
                    width: 150,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: potentialBeneficiaries,
                      decoration: InputDecoration(
                        hintText: '00',
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
                  Spacer(),
                  SizedBox(
                    width: 100,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPriority.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: priority.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              if (item == 'Silver') {
                                selectedPriority.value = item;
                                priorityCode.value = 3;
                              } else if (item == 'Gold') {
                                priorityCode.value = 2;
                                selectedPriority.value = item;
                              } else {
                                priorityCode.value = 1;
                                selectedPriority.value = item;
                              }
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: 50,
                                child: KText(
                                  text: item,
                                  fontSize: 13,
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
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: custodianName,
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                  Spacer(),
                  SizedBox(
                    width: 120,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: custodianMobileNo,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'Number',
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
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: custodianNIDNo,
                      decoration: InputDecoration(
                        hintText: '0000',
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
                  Spacer(),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: custodianEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                text: 'Custodian Address',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: '',
                  onChanged: custodianAddress,
                  decoration: InputDecoration(
                    hintText: 'Custodian Address',
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  KText(
                    text: 'Captured Images',
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
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
                                        imagefiles.removeAt(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(60),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white.withOpacity(0.5),
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
                          ),
                        ),
                      ),
                      onPressed: () => back(),
                      child: KText(
                        text: 'Cancel',
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
                            validateAddNewPole()
                                ? hexToColor('#007BEC')
                                : hexToColor('#007BEC').withOpacity(.5)),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onPressed: validateAddNewPole()
                          ? () {
                              addProjectSite(
                                type: 'add',
                              );

                              postEvidenceAttachment(
                                  projectId: selectedProject.value!.id,
                                  siteId: siteID.value,
                                  geoLevelId: geol4Id.value);
                            }
                          : () {},
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

  addProjectSite({String? type}) async {
    try {
      issubmit.value = true;
      String? id;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'SHOUT',
        'modelList': type == 'edit'
            ? projectSiteUpdateList.map((item) {
                id = item!.id;
                return {
                  'id': item.id,
                  'agencyId': item.agencyId,
                  'agencyCode': item.agencyCode,
                  'agencyName': item.agencyName,
                  'projectId': selectedProject.value!.id,
                  'projectCode': selectedProject.value!.projectCode,
                  'projectName': selectedProject.value!.projectName,
                  'areaType': item.areaType,
                  'areaLevel': item.areaLevel,
                  'countryCode': item.countryCode,
                  'countryName': item.countryName,
                  'geoLevel1Id': item.geoLevel1Id,
                  'geoLevel1Code': item.geoLevel1Code,
                  'geoLevel1Name': item.geoLevel1Name,
                  'geoLevel2id': item.geoLevel2id,
                  'geoLevel2Code': item.geoLevel2Code,
                  'geoLevel2Name': item.geoLevel2Name,
                  'geoLevel3Id': item.geoLevel3Id,
                  'geoLevel3Code': item.geoLevel3Code,
                  'geoLevel3Name': item.geoLevel3Name,
                  'geoLevel4Id': item.geoLevel4Id,
                  'geoLevel4Code': item.geoLevel4Code,
                  'geoLevel4Name': item.geoLevel4Name,
                  'geoLevel5Id': item.geoLevel5Id,
                  'geoLevel5Code': item.geoLevel5Code,
                  'geoLevel5Name': item.geoLevel5Name,
                  'levelType': item.levelType,
                  'levelFullcode': item.levelFullcode,
                  'siteType': item.siteType,
                  'siteCode': item.siteCode,
                  'siteName':
                      siteName.value != '' ? siteName.value : item.siteName,
                  'workStatus': item.workStatus,
                  'workStartedOn': item.workStartedOn,
                  'workCompleted': item.workCompleted,
                  'siteAddress':
                      address.value != '' ? address.value : item.siteAddress,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'altitudeMtr': item.altitudeMtr,
                  'priority': priorityCode.value,
                  'priorityName': selectedPriority.value,
                  'potentialBeneficiaryCount':
                      potentialBeneficiaries.value != ''
                          ? potentialBeneficiaries.value
                          : item.potentialBeneficiaryCount,
                  'pillarType': selectedPoleType.value,
                  'functionType': selectedSiteType.value,
                  'placeType': selectedPlaceType.value,
                  'powerSource': selectedPowerSource.value,
                  'borderSite': item.borderSite,
                  'distanceFromBorderKm': item.distanceFromBorderKm,
                  'airportSite': item.airportSite,
                  'distanceFromAirportKm': item.distanceFromAirportKm,
                  'tallSite': item.tallSite,
                  'restrictedArea': item.restrictedArea,
                  'custodianUsername': item.custodianUsername,
                  'custodianFullname': custodianName.value != ''
                      ? custodianName.value
                      : item.custodianFullname,
                  'custodianMobile': custodianMobileNo.value != ''
                      ? custodianMobileNo.value
                      : item.custodianMobile,
                  'custodianEmail': custodianEmail.value != ''
                      ? custodianEmail.value
                      : item.custodianEmail,
                  'custodianNid': custodianNIDNo.value != ''
                      ? custodianNIDNo.value
                      : item.custodianNid,
                  'custodianMonthlyRent': item.custodianMonthlyRent,
                  'custodianAddress': custodianAddress.value != ''
                      ? custodianAddress.value
                      : item.custodianAddress
                };
              }).toList()
            : [
                {
                  'agencyId': siteLocations.value!.agencyId,
                  'agencyCode': siteLocations.value!.agencyCode,
                  'agencyName': siteLocations.value!.agencyName,
                  'projectId': selectedProject.value!.id,
                  'projectCode': selectedProject.value!.projectCode,
                  'projectName': selectedProject.value!.projectName,

                  'areaType': siteLocations.value!.areaType,
                  'areaLevel': siteLocations.value!.areaLevel,
                  'countryCode': siteLocations.value!.countryCode,
                  'countryName': siteLocations.value!.countryName,
                  'geoLevel1Id': siteLocations.value!.geoLevel1Id,
                  'geoLevel1Code': siteLocations.value!.geoLevel1Code,
                  'geoLevel1Name': siteLocations.value!.geoLevel1Name,
                  'geoLevel2id': siteLocations.value!.geoLevel2id,
                  'geoLevel2Code': siteLocations.value!.geoLevel2Code,
                  'geoLevel2Name': siteLocations.value!.geoLevel2Name,
                  'geoLevel3Id': siteLocations.value!.geoLevel3Id,
                  'geoLevel3Code': siteLocations.value!.geoLevel3Code,
                  'geoLevel3Name': siteLocations.value!.geoLevel3Name,
                  'geoLevel4Id': siteLocations.value!.geoLevel4Id,
                  'geoLevel4Code': siteLocations.value!.geoLevel4Code,
                  'geoLevel4Name': siteLocations.value!.geoLevel4Name,
                  'geoLevel5Id': siteLocations.value!.geoLevel5Id,
                  'geoLevel5Code': siteLocations.value!.geoLevel5Code,
                  'geoLevel5Name': siteLocations.value!.geoLevel5Name,
                  'levelType': siteLocations.value!.levelType,
                  'levelFullcode': siteLocations.value!.levelFullcode,

                  'siteType': '',
                  'siteCode': '',
                  'siteName': siteName.value,
                  'workStatus': '',
                  'workStartedOn': '',
                  'workCompleted': '',
                  'siteAddress': address.value,
                  'latitude': locationC.currentLatLng!.latitude,
                  'longitude': locationC.currentLatLng!.longitude,
                  'altitudeMtr': 17,
                  // 'altitudeMtr': double.parse(locationC.currentLocation!.altitude.toString()),

                  'priority': priorityCode.value,
                  'priorityName': selectedPriority.value,
                  'potentialBeneficiaryCount': potentialBeneficiaries.value,
                  'pillarType': selectedPoleType.value,
                  'functionType': selectedSiteType.value,
                  'placeType': selectedPlaceType.value,
                  'powerSource': selectedPowerSource.value,
                  'borderSite': false,
                  'distanceFromBorderKm': 0.0,
                  'airportSite': false,
                  'distanceFromAirportKm': 0,
                  'tallSite': false,
                  'restrictedArea': false,
                  'custodianUsername': '',
                  'custodianFullname': custodianName.value,
                  'custodianMobile': custodianMobileNo.value,
                  'custodianEmail': custodianEmail.value,
                  'custodianNid': custodianNIDNo.value,
                  'custodianMonthlyRent': 9.0,
                  'custodianAddress': custodianAddress.value
                }
              ]
      };

      // kLog(jsonEncode(body));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project-site/add',
        body: body,
        authentication: true,
      );
      //// kLog(token);
      // back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        issubmit.value = false;
        if (type == 'edit') {
          elePoleCount.value = 0;
          newPoleCount.value = 0;
          lightPostCount.value = 0;
          telPoleCount.value = 0;
          buildingCount.value = 0;
          wifiApCount.value = 0;
          popCount.value = 0;
          btsCount.value = 0;
          projectSiteUpdateList.clear();
          projectSiteList[
                  projectSiteList.indexWhere((element) => element!.id == id!)]!
              .pillarType = selectedPoleType.value;
          projectSiteList[
                  projectSiteList.indexWhere((element) => element!.id == id!)]!
              .functionType = selectedSiteType.value;
          // ignore: avoid_function_literals_in_foreach_calls
          projectSiteList.forEach((x) {
            if (x!.pillarType == 'Electricity Pole') {
              elePoleCount.value++;
            } else if (x.pillarType == 'New Pole') {
              newPoleCount.value++;
            } else if (x.pillarType == 'Light Post') {
              lightPostCount.value++;
            } else if (x.pillarType == 'Telephone Pole') {
              telPoleCount.value++;
            } else {
              // otherPoleCount.value++;
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
          });
        }
        back();
        // Add new pole
        if (type != 'edit') {
          addProject(LatLng(
            locationC.currentLatLng!.latitude,
            locationC.currentLatLng!.longitude,
          ));
        }

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            // offAll(MainPage());

            back();
          },
        );
      } else {
        issubmit.value = false;
        back();
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
      }
      issubmit.value = false;
    } on DioError catch (e) {
      kLog(e.message);
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
          'ids': [selectedProject.value!.id],
        };

        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrlV2(),
          body: body,
          authentication: true,
        );
        // kLog(res.data);
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

  bool validateAddNewPole() {
    if (selectedProject.value != null &&
        siteLocations.value != null &&
        siteName.value.isNotEmpty &&
        address.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  void disposeData() {
    projectSiteMarkers.clear();
    projectSiteList.clear();
    projectSiteEditMarkers.clear();
    projectSiteDropMarkers.clear();
    allMarkers.clear();
    allSites.clear();
    updateApplianceList.clear();
    projectSiteMarkers2.clear();
    locations.clear();
    siteLocations.value = null;
    pointsForPolygon.clear();
    addMarker.value = false;
    dragMarker.value = false;
    deleteMarker.value = false;
    editMarker.value = false;
    newPoleCount.value = 0;
    elePoleCount.value = 0;
    telPoleCount.value = 0;
    lightPostCount.value = 0;
    buildingCount.value = 0;
    otherPoleCount.value = 0;

    wifiApCount.value = 0;
    popCount.value = 0;
    btsCount.value = 0;

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }

  relocationSite(String status) async {
    final username = Get.put(UserController()).username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'appCode': 'SHOUT',
      'status': status, //'relocate',
      'modelList': status == 'relocate'
          ? newSite.map((item) {
              return {
                'latitudeNew': item.newLat,
                'longitudeNew': item.newLong,
                'siteId': item.siteId
              };
            }).toList()
          : delSite.map((item) {
              return {
                'latitudeNew': item.newLat,
                'longitudeNew': item.newLong,
                'siteId': item.siteId
              };
            }).toList(),
    };

    final res = await postDynamic(
      path: ApiEndpoint.siteRelocateUrl(),
      body: body,
      authentication: true,
    );
    // kLog(res.data);
    if (res.data['status'] != null &&
        res.data['status'].contains('successful') == true) {
      issubmit.value = false;

      DialogHelper.successDialog(
        title: 'Success!',
        msg: res.data['message'][0].toString(),
        color: hexToColor('#00B485'),
        path: 'success-circular',
        onPressed: () {
          // offAll(MainPage());
          newSite.clear();
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
          back();
        },
      );
    }
    // kLog(body);
  }

  updateMarkerDialog({
    required ProjectSites x,
  }) {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Edit Site Information',
      widget: Obx(
        () => Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              KText(
                fontSize: 13,
                text: 'Project',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(height: 5),
              KText(
                fontSize: 14,
                text: '${selectedProject.value!.projectName}',
                color: AppTheme.nTextC,
              ),
              SizedBox(height: 10),
              KText(
                fontSize: 13,
                text: 'Geography',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(
                height: 5,
              ),
              KText(
                fontSize: 14,
                text:
                    '${siteLocations.value!.geoLevel2Name} > ${siteLocations.value!.geoLevel3Name} > ${siteLocations.value!.geoLevel4Name}',
                color: AppTheme.nTextC,
                maxLines: 2,
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
                        text: 'Site Name ',
                        color: AppTheme.nTextLightC,
                        fontSize: 13,
                      ),
                      KText(
                        text: '*',
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ],
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
                  SizedBox(
                    width: 200,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: x.siteName,
                      onChanged: siteName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        hintText: 'Site name ',
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
                  Spacer(),
                  KText(
                    text: x.siteCode,
                    color: AppTheme.nTextC,
                    fontSize: 14,
                    bold: true,
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
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                // height: 25,
                child: CustomTextFieldWithDropdown(
                  suffix: DropdownButton(
                    value: selectedSiteType.value, //selectedSiteType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: siteTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          //   x.functionType = item;
                          selectedSiteType.value = item;
                        },
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 32,
                          ),
                          child: SizedBox(
                            width: Get.width / 1.5,
                            child: KText(
                              text: item,
                              fontSize: 13,
                              maxLines: 3,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      KText(
                        text: 'Pole Type ',
                        color: AppTheme.nTextLightC,
                        fontSize: 13,
                      ),
                      KText(
                        text: '*',
                        color: Colors.red,
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
                      KText(
                        text: '*',
                        color: Colors.red,
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
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPoleType.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: poleTypes.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              // x.pillarType = item;
                              selectedPoleType.value = item;
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
                                  fontSize: 13,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (item) {},
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPowerSource.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: powerSources.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedPowerSource.value = item;
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: 'Place Type ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                  Spacer(),
                  KText(
                    text: 'Place Name ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
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
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPlaceType.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: placeTypes.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedPlaceType.value = item;
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: Get.width / 4.8,
                                child: KText(
                                  text: item,
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
                  Spacer(),
                  SizedBox(
                    width: 100,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: placeName,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'Place Name',
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
                  KText(
                    text: '*',
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,

                // (get text)
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                  initialValue: '',
                  onChanged: address,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Address',
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
                text: 'Lat: ${x.latitude}, Long: ${x.longitude}',
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
                    text: 'Potential Beneficiaries',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  Spacer(),
                  KText(
                    text: 'Priority',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
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
                  SizedBox(
                    width: 150,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: potentialBeneficiaries,
                      decoration: InputDecoration(
                        hintText: '00',
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
                  Spacer(),
                  SizedBox(
                    width: 100,
                    height: 25,
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedPriority.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: priority.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              if (item == 'Silver') {
                                selectedPriority.value = item;
                                priorityCode.value = 3;
                              } else if (item == 'Gold') {
                                priorityCode.value = 2;
                                selectedPriority.value = item;
                              } else {
                                priorityCode.value = 1;
                                selectedPriority.value = item;
                              }
                            },
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: SizedBox(
                                width: 50,
                                child: KText(
                                  text: item,
                                  fontSize: 13,
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
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: custodianName,
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                  Spacer(),
                  SizedBox(
                    width: 120,

                    // (get text)
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: custodianMobileNo,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'Number',
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
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: '',
                      onChanged: custodianNIDNo,
                      decoration: InputDecoration(
                        hintText: '0000',
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
                  Spacer(),
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: '',
                      onChanged: custodianEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                text: 'Custodian Address',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: '',
                  onChanged: custodianAddress,
                  decoration: InputDecoration(
                    hintText: 'Custodian Address',
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  KText(
                    text: 'Captured Images',
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
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
                                        imagefiles.removeAt(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(60),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white.withOpacity(0.5),
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
                      onPressed: () => back(),
                      child: KText(
                        text: 'Cancel',
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
                            validateAddNewPole()
                                ? hexToColor('#007BEC')
                                : hexToColor('#007BEC').withOpacity(.5)),
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
                        // kLog('siteName.value');
                        // kLog(siteName.value);
                        // kLog(selectedPoleType.value);
                        // kLog(selectedSiteType.value);
                        projectSiteUpdateList.add(x);
                        addProjectSite(
                          type: 'edit',
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
          'fileCategory': 'FILE_CATEGORY_SITE_ADD',
          'projectId': projectId,
          'geoLevelId': geoLevelId,
          'siteId': siteId,
          'files': attachments,
        },
      );
      // ignore: unused_local_variable
      final res = await postDynamic(
        path: ApiEndpoint.siteEvedenseSave(),
        body: data,
      );
      // kLog('${data.fields}');
      // kLog(res.data);
      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }
}
