import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/convert_map_data.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/log.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/area_polygon.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';
import 'package:workforce/src/services/api_service.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/global_dialog.dart';
import '../models/appliances.dart';
import '../models/links.dart';
import '../models/project_dropdown.dart';
import '../widgets/custom_textfield_with_dropdown.dart';
import 'agencyController.dart';
import 'maintain_test_type_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class NetworkTopologyController extends GetxController with ApiService {
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);
  // final locationC = Get.put(LocationController());
  final maintainTestTypeCreateC = Get.put(MaintainTestTypeController());
  final isPlotingEnable = RxBool(true);
  final isPop = RxBool(false);
  final isWifi = RxBool(false);
  final isnewPole = RxBool(false);
  final isEPole = RxBool(false);
  final islightPost = RxBool(false);
  final isTelPole = RxBool(false);
  final isBts = RxBool(false);
  final isBuilding = RxBool(false);
  final isOther = RxBool(false);
  final isFootPrint = RxBool(false);
  final isLoading = RxBool(false);
  final isLoadding = RxBool(false);
  final issubmit = RxBool(false);

  //  final siteLocations = Rx<SiteLocation?>(null);
  final siteLocationsV2 = Rx<SiteLocationV2?>(null);
  final siteLocations = Rx<ProjectSites?>(null);
  final areaPolygon = Rx<AreaPolygon?>(null);
  final markerList = RxList<ProjectSites>();

  final locationList = RxList<SiteLocation>();

  final newPoleList = RxList<NewPole>();
  final ePoleList = RxList<ElectricityPole>();
  final noPoleList = RxList<NoPole>();
  final onBuildingList = RxList<OnBuilding>();
  final lightPostList = RxList<LightPost>();

  final projectSiteMarkers = RxList<Marker>();
  final linkPolylines = RxList<Polyline>();

  final newPoleCount = RxInt(0);
  final elePoleCount = RxInt(0);
  final telPoleCount = RxInt(0);
  final cableTvCount = RxInt(0);
  final localIspCount = RxInt(0);
  final lightPostCount = RxInt(0);
  final buildingCount = RxInt(0);
  final otherPoleCount = RxInt(0);

  final wifiApCount = RxInt(0);
  final popCount = RxInt(0);
  final btsCount = RxInt(0);

  final ofcLength = RxDouble(0);
  final ofcCore4 = RxDouble(0);
  final ofcCore8 = RxDouble(0);
  final ofcCore12 = RxDouble(0);
  final ofcCore24 = RxDouble(0);
  final ofcCoreOthers = RxDouble(0);

  final locations = RxList<Geograpphy>();

  final search = RxString('');
  final levelFullCode = RxString('');
  final geol4Id = RxString('');

  final lat = RxDouble(0.0);
  final long = RxDouble(0.0);

  final siteID = RxString('');
  final siteName = RxString('');
  final deviceCode = RxString('');
  final deviceTypeName = RxString('');
  final ipAddress = RxString('');
  final macAddress = RxString('');
  final os = RxString('');
  final model = RxString('');
  final standard = RxString('');
  final tagNo = RxString('');
  final capacity = RxNum(0);
  final condition = RxString('');
  final powerSource = RxString('');
  final dAddress = RxString('');
  final installed = RxString('');
  final vendor = RxString('');
  final onAir = RxString('');
  final integration = RxString('');
  final fq1 = RxString('');
  final fq2 = RxString('');
  final radius = RxString('');
  final height = RxString('');
  final name = RxString('');
  final mobile = RxString('');
  final email = RxString('');

  final projectSiteEditMarkers = RxList<Marker>();
  // Google map
  //------------------------------------------
  final isGoogleMap = RxBool(true);
  final editMarker = RxBool(false);
  gmap.GoogleMapController? mapController;
  final googleMapMarkers = RxList<gmap.Marker>();
  final googleMapProjectSiteMarkers = RxList<gmap.Marker>();
  final googleMapPolygone = RxList<gmap.Polygon>();
  final googleMapLinkPolylines = RxList<gmap.Polyline>();
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);

  final projectSiteList = RxList<ProjectSites?>([]);
  final applianceList = RxList<Appliances?>([]);
  final linkList = RxList<Links?>([]);
  final updateApplianceList = RxList<Appliances?>([]);

  final cameraTarget = Rx<gmap.LatLng>(gmap.LatLng(0.0, 0.0));

  final placementType = RxList([
    '',
    'Overhead',
    'Underground',
    'Submarine',
  ]);
  final selectedPlacementType = RxString('');

  final mediaType = RxList([
    '',
    'Optical Fiber',
    'Copper',
    'Microwave',
  ]);
  final selectedMediaType = RxString('');

  final deviceType = RxList([
    'Wifi Router',
    'POP',
    'BTS',
    'Local ISP',
    'Other',
  ]);
  final selectedDeviceType = RxString('Wifi Router');
  final osType = RxList([
    'Android',
    'iOS',
    'Windows',
    'Linux',
    'Others',
  ]);
  final selectedOS = RxString('Android');

  final linkName = RxString('');
  final site1Address = RxString('');
  final site2Address = RxString('');
  final totalCapGbps = RxString('');
  final usedCapGbps = RxString('');
  final totalOfcCores = RxString('');
  final usedOfcCores = RxString('');
  final ductNo = RxString('');
  final installationParty = RxString('');
  final contactPerson = RxString('');
  final contactNo = RxString('');

  //------------------------------------------

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);
  final selectProjectName = RxString('Constraction');

  // =============== To draw ploygon on map =============

  final pointsForPolygon = RxList<LatLng>([]);

  // =============== To change view of map =============

  final isSateliteViewEnable = RxBool(false);

  final projectId = RxString('');
  //====================== get geo area =================================

  DateTime? onAirDate;
  DateTime? installDate;
//date picker
  void selectDate(String type) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      if (type == 'onAir')
        // ignore: curly_braces_in_flow_control_structures
        onAir.value = formatDate(date: pickedDate.toString());
      if (type == 'installed')
        // ignore: curly_braces_in_flow_control_structures
        installed.value = formatDate(date: pickedDate.toString());
      if (type == 'onAir') onAirDate = pickedDate;
      if (type == 'installed') installDate = pickedDate;
      //  updateonAir(item, '');
    } else {}
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

      kLog(jsonEncode(res.data));
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
    pointsForGmapPolygon.clear();
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
    pointsForGmapPolygon.value =
        ConvertMaPData().convertPointsForGmapPolygon(coordinates);
    googleMapPolygone.add(gmap.Polygon(
      fillColor: Colors.transparent,
      points: pointsForGmapPolygon,
      polygonId: gmap.PolygonId('1'),
      strokeColor: hexToColor('#00D8A0'),
      strokeWidth: 3,
    ));
    // kMapControllerSiteLocation.move(
    //     LatLng(pointsForPolygon[0].latitude, pointsForPolygon[0].longitude),
    //     15);
  }

  void siteSearchV2() async {
    if (editMarker.value) {
      kLog(editMarker.value);

      projectSiteMarkers.clear();
      projectSiteMarkers.clear();
      projectSiteEditMarkers.clear();
      // newSite.clear();
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

      //================== Appliance Markers =================

      if (applianceList.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        applianceList.forEach((x) async {
          projectSiteEditMarkers.add(
            Marker(
              point: LatLng(x!.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    updateDeviceDialog(x: x);
                    //  DialogHelper.showNetworkTopologyDeviceInfo(x: x);
                  },
                  child: Icon(
                    Icons.edit_location,
                    color: x.deviceTypeName == 'Wifi Router'
                        ? Colors.green
                        : x.deviceTypeName == 'POP'
                            ? Colors.red
                            : x.deviceTypeName == 'BTS'
                                ? Colors.blueAccent
                                : Colors.black,
                    size: 40,
                  ),
                );
              },
            ),
          );
          // bounds.extend(LatLng(x.latitude!, x.longitude!));

          getMarkerImg(deviceTypeName) {
            switch (deviceTypeName) {
              case 'Wifi Router':
                return 'assets/img/wifi.png';
              case 'POP':
                return 'assets/img/pop.png';
              case 'BTS':
                return 'assets/img/bts_device.png';

              default:
                return 'assets/img/others.png';
            }
          }

          final Uint8List markerIcon = await ConvertMaPData()
              // ignore: unnecessary_string_interpolations
              .getBytesFromAsset('${getMarkerImg(x.deviceTypeName)}', 50);

          googleMapProjectSiteMarkers.add(
            gmap.Marker(
              position: gmap.LatLng(x.latitude!, x.longitude!),
              markerId: gmap.MarkerId(x.id!),
              flat: true,
              icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
              onTap: () {
                updateDeviceDialog(x: x);
              },
            ),
          );
        });
      }

      //================== Project Sites Circles =================

      siteLocations.value = null;
      siteLocations.value = projectSiteList.first;

      if (projectSiteList.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        projectSiteList.forEach((x) async {
          if (x!.pillarType == 'Electricity Pole') {
            elePoleCount.value++;
          } else if (x.pillarType == 'New Pole') {
            newPoleCount.value++;
          }
          // else if (x.pillarType == 'Building/House' ||
          //     x.pillarType == 'On Building') {
          //   buildingCount.value++;
          // }
          else if (x.pillarType == 'Light Post') {
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

                // onLongPress: (p0) {
                //   Get.dialog(Container(
                //     height: 150,
                //   ));
                // },
                builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      //  updateMarkerDialog(x: x);
                      //  DialogHelper.showNetworkTopologyDetails(x: x);
                    },
                    child: Icon(
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
                      size: 20,
                    ),
                  );
                }),
          );
          bounds.extend(LatLng(x.latitude!, x.longitude!));
        });
      }
    } else {
      isLoading.value = true;
      newPoleCount.value = 0;
      elePoleCount.value = 0;
      telPoleCount.value = 0;
      cableTvCount.value = 0;
      localIspCount.value = 0;
      lightPostCount.value = 0;
      buildingCount.value = 0;
      otherPoleCount.value = 0;
      wifiApCount.value = 0;
      popCount.value = 0;
      btsCount.value = 0;

      final bounds = LatLngBounds();

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

      // kLog(levelFullCode.value);

      //  kLog(params);

      final res = await getDynamic(
        path: ApiEndpoint.getNmsNetworkLinkPointsUrl(),
        queryParameters: params,
        authentication: true,
      );

      //kLog(jsonEncode(res.data));

      // newPoleCount.value = 0;
      // elePoleCount.value = 0;
      // telPoleCount.value = 0;
      // cableTvCount.value = 0;
      // localIspCount.value = 0;
      // lightPostCount.value = 0;
      // buildingCount.value = 0;
      // otherPoleCount.value = 0;
      // wifiApCount.value = 0;
      // popCount.value = 0;
      // btsCount.value = 0;

      // final bounds = LatLngBounds();

      //Project Sites List
      final projectSiteListData = res.data['data']['projectSites']
          .map((json) => ProjectSites.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<ProjectSites>() as List<ProjectSites>;

      //App liances list
      final applianceListData = res.data['data']['appliances']
          .map((json) => Appliances.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<Appliances>() as List<Appliances>;

      //================== ProjectSites Circles =================
      if (projectSiteListData.isNotEmpty) {
        siteLocations.value = null;
        siteLocations.value = projectSiteListData.first;
        projectSiteList.clear();
        //Add project site
        projectSiteList.addAll(projectSiteListData);
        kLog('projectSiteListData.length');
        kLog(applianceListData.length);
        // ignore: avoid_function_literals_in_foreach_calls
        projectSiteListData.forEach(
          (x) async {
            if (x.workStatus != 'New') {
              if (x.pillarType == 'Electricity Pole') {
                elePoleCount.value++;
              } else if (x.pillarType == 'New Pole') {
                newPoleCount.value++;
              }
              // else if (x.pillarType == 'Building/House' ||
              //     x.pillarType == 'On Building') {
              //   buildingCount.value++;
              // }
              else if (x.pillarType == 'Light Post') {
                lightPostCount.value++;
              } else if (x.pillarType == 'Telephone Pole') {
                telPoleCount.value++;
              } else {
                // otherPoleCount.value++;
                buildingCount.value++;
              }
            }

            if (x.functionType == 'Wifi Router') {
              wifiApCount.value++;
            }

            if (x.functionType == 'Cable TV Operator') {
              cableTvCount.value++;
            }
            if (x.functionType == 'Local ISP') {
              localIspCount.value++;
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
                      //   DialogHelper.showNetworkTopologyDetails(x: x);
                    },
                    child: Icon(
                      Icons.circle,
                      color: x.pillarType == 'Electricity Pole'
                          ? Colors.red
                          : x.pillarType == 'New Pole'
                              ? Colors.orange

                              // : x.pillarType == 'Building/House' ||
                              //         x.pillarType == 'On Building'
                              //     ? Colors.black

                              : x.pillarType == 'Light Post'
                                  ? hexToColor('#A533FF')
                                  : x.pillarType == 'Telephone Pole'
                                      ? hexToColor('#3379FF')
                                      : Colors.black,
                      size: 10,
                    ),
                  );
                },
              ),
            );

            // Add animate camera position
            bounds.extend(LatLng(x.latitude!, x.longitude!));
            cameraTarget.value = gmap.LatLng(x.latitude!, x.longitude!);
            //-----------------------------------------
            // ****** Google map marker ******
            //-----------------------------------------
            getMarkerImg(pillerType) {
              switch (pillerType) {
                case 'Electricity Pole':
                  return 'assets/img/pole.png';
                case 'New Pole':
                  return 'assets/img/new_pole.png';
                case 'Light Post':
                  return 'assets/img/light_post.png';
                case 'Telephone Pole':
                  return 'assets/img/tel.png';
                default:
                  return 'assets/img/building.png';

                // : pillerType ==
                //     ?
                //     : pillerType ==
                //         ?
                //         : ;
                // case 'Wifi Router':
                //   return 'assets/img/wifi.png';
                // case 'POP':
                //   return 'assets/img/pop.png';
              }
            }

            final Uint8List markerIcon = await ConvertMaPData()
                // ignore: unnecessary_string_interpolations
                .getBytesFromAsset('${getMarkerImg(x.pillarType)}', 50);

            googleMapProjectSiteMarkers.add(
              gmap.Marker(
                position: gmap.LatLng(x.latitude!, x.longitude!),
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                flat: true,
                onTap: () {
                  siteCompletionDialog(x: x);
                },
              ),
            );
            //-----------------------------------------
            // ****** Google map marker end ******
            //-----------------------------------------

            // if (isGoogleMap.value) {
            //   mapController?.animateCamera(
            //     gmap.CameraUpdate.newCameraPosition(
            //       gmap.CameraPosition(
            //         bearing: 270.0,
            //         target: gmap.LatLng(x.latitude!, x.longitude!),
            //         tilt: 30.0,
            //         zoom: 14.0,
            //       ),
            //     ),
            //   );
            // }
          },
        );
      }

      // kLog(cameraTarget.value);

      //================== Appliance Markers =================
      if (applianceListData.isNotEmpty) {
        //Add app liance
        applianceList.addAll(applianceListData);

        // ignore: avoid_function_literals_in_foreach_calls
        applianceListData.forEach((x) async {
          projectSiteMarkers.add(
            Marker(
              point: LatLng(x.latitude!, x.longitude!),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    DialogHelper.showNetworkTopologyDeviceInfo(x: x);
                  },
                  child: Icon(
                    Icons.location_on,
                    color: x.deviceTypeName == 'Wifi Router'
                        ? Colors.green
                        : x.deviceTypeName == 'Local ISP'
                            ? Colors.yellow
                            : x.deviceTypeName == 'Cable TV Operator'
                                ? Color.fromARGB(255, 8, 81, 141)
                                : x.deviceTypeName == 'POP'
                                    ? Colors.red
                                    : x.deviceTypeName == 'BTS'
                                        ? Colors.blueAccent
                                        : Colors.black,
                    size: 40,
                  ),
                );
              },
            ),
          );

          // Add animate camera position
          bounds.extend(LatLng(x.latitude!, x.longitude!));

          getMarkerImg(deviceTypeName) {
            switch (deviceTypeName) {
              case 'Wifi Router':
                return 'assets/img/wifi.png';
              case 'POP':
                return 'assets/img/pop.png';
              case 'BTS':
                return 'assets/img/bts_device.png';

              default:
                return 'assets/img/others.png';
            }
          }

          final Uint8List markerIcon = await ConvertMaPData()
              // ignore: unnecessary_string_interpolations
              .getBytesFromAsset('${getMarkerImg(x.deviceTypeName)}', 50);

          googleMapProjectSiteMarkers.add(
            gmap.Marker(
              position: gmap.LatLng(x.latitude!, x.longitude!),
              markerId: gmap.MarkerId(x.id!),
              flat: true,
              icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
              anchor: Offset(0, 0),
              onTap: () {
                /// siteCompletionDialog(x: x);
              },
            ),
          );
          cameraTarget.value = gmap.LatLng(x.latitude!, x.longitude!);

          //-----------------------------------------
          // ****** Google map project site markers ******
          //-----------------------------------------
        });
      }

      //================== Links Polylines =================
      //Links List
      final LinkListData = res.data['data']['links']
          .map((json) => Links.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<Links>() as List<Links>;
      if (LinkListData.isNotEmpty) {
        linkList.clear();
        linkList.addAll(LinkListData);
        ofcLength.value = 0;
        ofcCore4.value = 0;
        ofcCore8.value = 0;
        ofcCore12.value = 0;
        ofcCore24.value = 0;
        ofcCoreOthers.value = 0;

        // ignore: avoid_function_literals_in_foreach_calls
        LinkListData.forEach(
          (x) {
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

            // --------------------------------------------------
            // ***** Flutter map linkPoints *****
            // --------------------------------------------------
            List<LatLng> points = [];

            // ignore: avoid_function_literals_in_foreach_calls
            x.linkPoints!.forEach((element) {
              points.add(LatLng(element.latitude!, element.longitude!));
            });

            linkPolylines.add(
              Polyline(
                points: points,
                color: x.totalOfcCores == 4
                    ? Colors.blue
                    : x.totalOfcCores == 8
                        ? Colors.purple
                        : x.totalOfcCores == 12
                            ? Colors.green
                            : x.totalOfcCores == 24
                                ? Colors.red
                                : Colors.orange,
                strokeWidth: 5,
              ),
            );

            // --------------------------------------------------
            // ***** Google map linkPoints *****
            // --------------------------------------------------
            List<gmap.LatLng> googleMapPoints = [];

            // ignore: avoid_function_literals_in_foreach_calls
            x.linkPoints!.forEach((element) {
              googleMapPoints
                  .add(gmap.LatLng(element.latitude!, element.longitude!));
            });

            //Google Map
            googleMapLinkPolylines.add(
              gmap.Polyline(
                polylineId: gmap.PolylineId(x.id!),
                consumeTapEvents: true,
                points: googleMapPoints,
                jointType: gmap.JointType.round,
                width: 5,
                onTap: () {
                  linkPropertiesDialog(x: x);
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
            // --------------------------------------------------
            // ***** Google map linkPoints end *****
            // --------------------------------------------------
          },
        );
      }

      if (isGoogleMap.value && bounds.isValid) {
        isLoading.value = false;
        kMapControllerSiteLocation.fitBounds(
          bounds,
          options: const FitBoundsOptions(
            padding: EdgeInsets.all(30),
          ),
        );
      } else {
        await animateCameraPosition(
          latitude: cameraTarget.value.latitude,
          longitude: cameraTarget.value.longitude,
        );
      }
      isLoading.value = false;
      kLog(bounds.isValid);
    }
  }

  siteCompletionDialog({
    required ProjectSites x,
  }) {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Network Completion Status',
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
                  // DialogHelper.showNetworkTopologyDetails(x: x);
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
                    text: '${x.siteName}',
                    color: AppTheme.nTextC,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                KText(
                  text: '${x.siteCode}',
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
                    // text: 'jj',
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
                  //  text: 'ddd',
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
                  //  text: 'SS',
                  text: x.custodianNid != 'null' && x.custodianNid != null
                      ? '${x.custodianNid}'
                      : '',
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                Spacer(),
                KText(
                  //  text: 'AAA',
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
              //  text: 'ssss',
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
              // text: 'jjj',
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
              //text: 'WWWW',
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

  linkPropertiesDialog({
    required Links x,
  }) {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Edit Link Properties',
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
                  Expanded(
                    flex: 3,
                    child: KText(
                      text: 'Link ID',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: KText(
                      text: '${x.linkCode}',
                      color: AppTheme.nTextC,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: KText(
                      text: 'Link Name',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: Get.width,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        initialValue:
                            x.linkName!.isNotEmpty ? '${x.linkName}' : '',
                        onChanged: linkName,
                        decoration: InputDecoration(
                          hintText: '',
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          labelStyle: TextStyle(
                            color: hexToColor('#515D64'),
                            fontSize: 14,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: hexToColor('#DBECFB')),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: KText(
                      text: 'Media Type',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      // width: 130,
                      height: 25,
                      child: CustomTextFieldWithDropdown(
                        suffix: DropdownButton(
                          value: selectedMediaType.value,
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: hexToColor('#80939D'),
                          ),
                          items: mediaType.map((item) {
                            return DropdownMenuItem(
                              onTap: () {
                                selectedMediaType.value = item;
                              },
                              value: item,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: Get.width / 3.0,
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
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: KText(
                      text: 'Placement Type',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      // width: 130,
                      height: 25,
                      child: CustomTextFieldWithDropdown(
                        suffix: DropdownButton(
                          value: selectedPlacementType.value,
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: hexToColor('#80939D'),
                          ),
                          items: placementType.map((item) {
                            return DropdownMenuItem(
                              onTap: () {
                                selectedPlacementType.value = item;
                              },
                              value: item,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 20,
                                ),
                                child: SizedBox(
                                  width: Get.width / 3.0,
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
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: KText(
                      text: 'Length',
                      color: AppTheme.nTextLightC,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 4,
                    child: KText(
                      text:
                          x.linkLengthKm != null ? '${x.linkLengthKm} km' : '',
                      color: AppTheme.nTextC,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 8),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       flex: 3,
              //       child: KText(
              //         text: 'Condition',
              //         color: AppTheme.nTextLightC,
              //         fontSize: 13,
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       flex: 4,
              //       child: KText(
              //         text: 'Planned',
              //         color: AppTheme.nTextC,
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),
              Divider(
                color: hexToColor('#D9D9D9'),
                height: 1,
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.black87,
                // margin: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  // height: 200,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 1),
                  padding: EdgeInsets.only(left: 15),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -1,
                        left: -21.5,
                        child: RenderSvg(
                          path: 'pop-icon',
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        left: -21.5,
                        child: RenderSvg(
                          path: 'pop-icon',
                          color: Colors.green,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: '${x.site1Name} (Site ID: ${x.site1Code})',
                            bold: true,
                            maxLines: 2,
                          ),
                          SizedBox(height: 3),
                          KText(
                            text: 'Address ',
                            color: AppTheme.nTextLightC,
                            fontSize: 13,
                          ),
                          SizedBox(
                            width: Get.width,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue: '${x.site1Address}',
                              onChanged: site1Address,
                              decoration: InputDecoration(
                                hintText: '',
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          KText(
                            text: 'Geography Point',
                            color: AppTheme.nTextLightC,
                            fontSize: 13,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              KText(
                                text: 'Lat: , ',
                                color: AppTheme.nTextC,
                                bold: true,
                              ),
                              KText(
                                text: '${x.site1Latitude}',
                                color: AppTheme.nTextC,
                              ),
                            ],
                          ),
                          // SizedBox(height: 5),
                          Row(
                            children: [
                              KText(
                                //  text: 'Long: ${locationC.currentLatLng!.longitude},',
                                text: 'Long: ',
                                color: AppTheme.nTextC,
                                bold: true,
                              ),
                              KText(
                                //  text: 'Long: ${locationC.currentLatLng!.longitude},',
                                text: '${x.site1Longitude}',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          KText(
                            text: '${x.site2Name} (Site ID: ${x.site2Code})',
                            bold: true,
                            maxLines: 2,
                          ),
                          SizedBox(height: 3),
                          KText(
                            text: 'Address ',
                            color: AppTheme.nTextLightC,
                            fontSize: 13,
                          ),

                          SizedBox(
                            width: Get.width,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue: '${x.site2Address}',
                              onChanged: site2Address,
                              decoration: InputDecoration(
                                hintText: '',
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 12,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          KText(
                            text: 'Geography Point',
                            color: AppTheme.nTextLightC,
                            fontSize: 13,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              KText(
                                text: 'Lat: , ',
                                color: AppTheme.nTextC,
                                bold: true,
                              ),
                              KText(
                                text: '${x.site2Latitude}',
                                color: AppTheme.nTextC,
                              ),
                            ],
                          ),
                          // SizedBox(height: 5),
                          Row(
                            children: [
                              KText(
                                //  text: 'Long: ${locationC.currentLatLng!.longitude},',
                                text: 'Long: ',
                                color: AppTheme.nTextC,
                                bold: true,
                              ),
                              KText(
                                //  text: 'Long: ${locationC.currentLatLng!.longitude},',
                                text: '${x.site2Longitude}',
                                color: AppTheme.nTextC,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: hexToColor('#D9D9D9'),
                height: 1,
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Total BW (Gbps)',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue: '${x.totalCapGbps}',
                            onChanged: totalCapGbps,
                            decoration: InputDecoration(
                              hintText: 'remarks',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Used  BW (Gbps)',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.name,
                            initialValue: '${x.usedCapGbps}',
                            onChanged: usedCapGbps,
                            decoration: InputDecoration(
                              hintText: 'remarks',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'No. of Core',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue: '${x.totalOfcCores}',
                            onChanged: totalOfcCores,
                            decoration: InputDecoration(
                              hintText: 'remarks',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        KText(
                          text: 'No. of Used Core',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.name,
                            initialValue: '${x.usedOfcCores}',
                            onChanged: usedOfcCores,
                            decoration: InputDecoration(
                              hintText: 'remarks',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              SizedBox(height: 10),

              KText(
                fontSize: 13,
                text: 'Duct No.',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(height: 5),
              SizedBox(
                width: Get.width / 2.5,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  initialValue: '${x.ductNo}',
                  onChanged: ductNo,
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
              SizedBox(height: 20),
              Divider(
                color: hexToColor('#D9D9D9'),
                height: 1,
              ),

              SizedBox(height: 10),

              KText(
                fontSize: 13,
                text: 'Installation Party',
                color: AppTheme.nTextLightC,
              ),
              SizedBox(height: 5),
              SizedBox(
                width: Get.width / 2.5,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  initialValue: '',
                  onChanged: installationParty,
                  decoration: InputDecoration(
                    hintText: 'Party name',
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

              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Contact Person',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            initialValue: '',
                            onChanged: contactPerson,
                            decoration: InputDecoration(
                              hintText: 'name',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Contact No.',
                          color: AppTheme.nTextLightC,
                          fontSize: 13,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextFormField(
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.name,
                            initialValue: '',
                            onChanged: contactNo,
                            decoration: InputDecoration(
                              hintText: '+8801',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle: TextStyle(
                                color: hexToColor('#515D64'),
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: hexToColor('#DBECFB')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
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
                        updateNetworkLink(x: x);
                      },
                      child: isLoadding.value
                          ? Center(
                              child: Loading(
                              color: Colors.white,
                            ))
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
                      if (search.value.isNotEmpty) {
                        addGeography();
                      }
                    },
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
                                        // child: Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Expanded(
                                        //       child: KText(
                                        //         textOverflow:
                                        //             TextOverflow.ellipsis,
                                        //         text: item.geoLevel2Name != null
                                        //             ? '${item.geoLevel2Name}>'
                                        //             : '',
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       child: KText(
                                        //         textOverflow:
                                        //             TextOverflow.ellipsis,
                                        //         text: item.geoLevel3Name != null
                                        //             ? '${item.geoLevel3Name}>'
                                        //             : '',
                                        //       ),
                                        //     ),
                                        //     Expanded(
                                        //       child: KText(
                                        //         textOverflow:
                                        //             TextOverflow.ellipsis,
                                        //         text: item.geoLevel4Name != null
                                        //             ? '${item.geoLevel4Name}'
                                        //             : '',
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        child: KText(
                                          maxLines: 3,
                                          text: item.geoLevel4Name!.isEmpty
                                              ? ''
                                              : '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
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
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  addGeography() async {
    try {
      if (search.value.isNotEmpty) {
        isLoadding.value = true;
        kLog('Habib');
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

        final data = res.data['data']
            .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Geograpphy>() as List<Geograpphy>;

        // kLog(data[0].toJson());

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
      kLog(e.toString());
    }
    // }
  }

  Future<void> animateCameraPosition({
    required double latitude,
    required double longitude,
  }) async {
    await mapController?.animateCamera(
      gmap.CameraUpdate.newCameraPosition(
        gmap.CameraPosition(
          bearing: 170.0,
          // bearing: 270.0,
          target: gmap.LatLng(latitude, longitude),
          tilt: 50.0,
          zoom: 12.0,
        ),
      ),
    );
  }

  void disposeData() {
    projectSiteMarkers.clear();
    markerList.clear();
    googleMapPolygone.clear();
    googleMapLinkPolylines.clear();
    googleMapProjectSiteMarkers.clear();
    editMarker.value = false;
    locations.clear();
    siteLocations.value = null;
    applianceList.clear();
    newPoleCount.value = 0;
    elePoleCount.value = 0;
    telPoleCount.value = 0;
    lightPostCount.value = 0;
    buildingCount.value = 0;
    otherPoleCount.value = 0;

    wifiApCount.value = 0;
    popCount.value = 0;
    btsCount.value = 0;

    ofcLength.value = 0.0;
    ofcCore4.value = 0.0;
    ofcCore8.value = 0.0;
    ofcCore12.value = 0.0;
    ofcCore24.value = 0.0;
    ofcCoreOthers.value = 0.0;

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';

    lat.value = 0.0;
    long.value = 0.0;
  }

  updateDeviceDialog({
    required Appliances x,
  }) {
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Edit Device Information',
      widget: Obx(
        () => SizedBox(
          height: Get.height * .9,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Site ID',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: x.siteCode != null ? x.siteCode : '',
                            fontSize: 14,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Site Name',
                            color: hexToColor('#80939D'),
                          ),
                          Flexible(
                            child: KText(
                              text: x.siteName != null ? x.siteName : '',
                              fontSize: 14,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Device Code',
                            color: hexToColor('#80939D'),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  x.deviceCode != null ? x.deviceCode : '',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: value,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: '',
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: 'Device Code ',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Device Type',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 130,
                            height: 25,
                            child: CustomTextFieldWithDropdown(
                              suffix: DropdownButton(
                                value: selectedDeviceType.value,
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: hexToColor('#80939D'),
                                ),
                                items: deviceType.map((item) {
                                  return DropdownMenuItem(
                                    onTap: () {
                                      selectedDeviceType.value = item;
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'IP Address',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  x.deviceIp != null ? x.deviceIp : '',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: value,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: '',
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: 'Device Ip',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'MAC Address',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  x.deviceMac != null ? x.deviceMac : '',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: value,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: '',
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: 'Device Mac Address ',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'OS',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 130,
                            height: 25,
                            child: CustomTextFieldWithDropdown(
                              suffix: DropdownButton(
                                value: selectedOS.value,
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: hexToColor('#80939D'),
                                ),
                                items: osType.map((item) {
                                  return DropdownMenuItem(
                                    onTap: () {
                                      selectedOS.value = item;
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Model',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  x.deviceModel != null ? x.deviceModel : '',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: value,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: '',
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: 'Device Model ',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Standard',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue: x.technologyStandard != null
                                  ? x.technologyStandard
                                  : '',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: value,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: '',
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: '',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Tag No',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Capacity',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${x.connectionCapacity == 0 ? '' : x.connectionCapacity}',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: int.parse(value),
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: 0,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: ' ',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Condition',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                              text: x.deviceCondition != null
                                  ? x.deviceCondition
                                  : ''),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Power Source',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                              text: x.powerSource != null ? x.powerSource : ''),
                        ],
                      ),
                      Divider(),
                      KText(
                        text: 'Address',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        width: Get.width,

                        // (get text)
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          initialValue:
                              x.siteAddress != null ? x.siteAddress : '',
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              updateValues(
                                currentItem: x,
                                code: x.deviceCode,
                                ipAddress: x.deviceIp,
                                macAddress: x.deviceMac,
                                model: x.deviceModel,
                                standard: x.technologyStandard,
                                address: value,
                                capacity: x.connectionCapacity,
                                fqr1: x.frequencyGhz,
                                fqr2: x.frequencyGhz2,
                                radius: x.coverageRadiusMtr,
                                height: x.equipmentHeightFt,
                              );
                            } else {
                              updateValues(
                                currentItem: x,
                                code: x.deviceCode,
                                ipAddress: x.deviceIp,
                                macAddress: x.deviceMac,
                                model: x.deviceModel,
                                standard: x.technologyStandard,
                                address: '',
                                capacity: x.connectionCapacity,
                                fqr1: x.frequencyGhz,
                                fqr2: x.frequencyGhz2,
                                radius: x.coverageRadiusMtr,
                                height: x.equipmentHeightFt,
                              );
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            hintText: 'Address ',
                            labelStyle: TextStyle(
                              color: hexToColor('#515D64'),
                              fontSize: 14,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: hexToColor('#DBECFB')),
                            ),
                          ),
                        ),
                      ),
                      KText(
                        text: 'Geography Point',
                        color: hexToColor('#80939D'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text:
                                'Lat: ${x.latitude != null ? x.latitude : ''},',
                            fontSize: 14,
                          ),
                          KText(
                            text:
                                'Long: ${x.longitude != null ? x.longitude : ''}',
                            fontSize: 14,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Installed',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: formatDate(date: x.installedOn!)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Vendor',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: ''),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'On-Aired',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: formatDate(date: x.onairDate!)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Integration',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                              text: x.integrationMethod != null
                                  ? x.integrationMethod
                                  : ''),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Frequency-1',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 160,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  '${x.frequencyGhz == 0 ? '' : x.frequencyGhz}',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: double.parse(value),
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: 0,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: '',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                          KText(text: ' GHz')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Frequency-2',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 160,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${x.frequencyGhz2 == 0 ? '' : x.frequencyGhz2}',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: double.parse(value),
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: 0,
                                    radius: x.coverageRadiusMtr,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: '',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                          KText(text: ' GHz'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Radius(M)',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${x.coverageRadiusMtr != null ? x.coverageRadiusMtr : ''}',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: double.parse(value),
                                    height: x.equipmentHeightFt,
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: 0,
                                    height: x.equipmentHeightFt,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: '',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Height(ft)',
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 190,

                            // (get text)
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue:
                                  '${x.equipmentHeightFt != null ? x.equipmentHeightFt : ''}',
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: double.parse(value),
                                  );
                                } else {
                                  updateValues(
                                    currentItem: x,
                                    code: x.deviceCode,
                                    ipAddress: x.deviceIp,
                                    macAddress: x.deviceMac,
                                    model: x.deviceModel,
                                    standard: x.technologyStandard,
                                    address: x.siteAddress,
                                    capacity: x.connectionCapacity,
                                    fqr1: x.frequencyGhz,
                                    fqr2: x.frequencyGhz2,
                                    radius: x.coverageRadiusMtr,
                                    height: 0,
                                  );
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                isDense: true,
                                hintText: '',
                                labelStyle: TextStyle(
                                  color: hexToColor('#515D64'),
                                  fontSize: 14,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: hexToColor('#DBECFB')),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Contact',
                            color: hexToColor('#80939D'),
                          ),
                          Row(
                            children: [
                              if (x.custodianFullname!.isNotEmpty)
                                CircleAvatar(
                                  radius: 10,
                                ),
                              SizedBox(
                                width: 6,
                              ),
                              KText(
                                  text: x.custodianFullname!.isNotEmpty
                                      ? x.custodianFullname
                                      : ''),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Mobile',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                              text: x.custodianMobile != null
                                  ? x.custodianMobile
                                  : ''),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: 'Email',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                              text: x.custodianEmail != null
                                  ? x.custodianEmail
                                  : ''),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              back();
                            },
                            child: Container(
                              height: 34,
                              width: 109,
                              margin: EdgeInsets.symmetric(vertical: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: hexToColor('#FFA133')),
                              child: Center(
                                child: KText(
                                  text: 'Cancel',
                                  bold: true,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              updateApplianceList.add(x);

                              updateDevice();
                            },
                            child: Container(
                              height: 34,
                              width: 109,
                              margin: EdgeInsets.symmetric(vertical: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: hexToColor('#449EF1')),
                              child: Center(
                                child: KText(
                                  text: 'Submit',
                                  bold: true,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateDevice() async {
    try {
      issubmit.value = true;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'SHOUT',
        'modelList': updateApplianceList.map((item) {
          return {
            'id': item!.id,
            'agencyId': selectedAgency.agencyId,
            'agencyCode': selectedAgency.agencyCode,
            'agencyName': selectedAgency.agencyName,
            'projectId': selectedProject.value!.id,
            'projectCode': selectedProject.value!.projectCode,
            'projectName': selectedProject.value!.projectName,
            'deviceCode': item.deviceCode,
            'deviceName': item.deviceName,
            'deviceIp': item.deviceIp,
            'deviceMac': item.deviceMac,
            'deviceSerial': item.deviceSerial,
            'deviceTypeCode': item.deviceTypeCode,
            'deviceTypeName': item.deviceTypeName,
            'deviceModel': item.deviceModel,
            'operatingSystem': item.operatingSystem,
            'equipmentHeightFt': item.equipmentHeightFt,
            'equipmentAzimuthDeg': item.equipmentAzimuthDeg,
            'equipmentTiltDeg': item.equipmentTiltDeg,
            'coverageRadiusMtr': item.coverageRadiusMtr,
            'frequencyGhz': item.frequencyGhz,
            'frequencyGhz2': item.frequencyGhz2,
            'connectionCapacity': item.connectionCapacity,
            'capacityDescr': item.capacityDescr,
            'technologyStandard': item.technologyStandard,
            'sfpPorts': item.sfpPorts,
            'ethPorts': item.ethPorts,
            'poePorts': item.poePorts,
            'casingSpec': item.casingSpec,
            'casingCount': item.casingCount,
            'cableUnpackerSpec': item.cableUnpackerSpec,
            'cableUnpackerCount': item.cableUnpackerCount,
            'mcSpec': item.mcSpec,
            'mcCount': item.mcCount,
            'ethPatchCordSpec': item.ethPatchCordSpec,
            'ethPatchCordCount': item.ethPatchCordCount,
            'fiberPatchSpec': item.fiberPatchSpec,
            'fiberPatchCount': item.fiberPatchCount,
            'fiberJpSpec': item.fiberJpSpec,
            'fiberJpCount': item.fiberJpCount,
            'pigtailSpec': item.pigtailSpec,
            'pigtailCount': item.pigtailCount,
            'clampSpec': item.clampSpec,
            'clampCount': item.clampCount,
            'remarks': item.remarks,
            'supplierAgencyId': item.supplierAgencyId,
            'supplierAgencyCode': item.supplierAgencyCode,
            'supplierAgencyName': item.supplierAgencyName,
            'installedOn': DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(item.installedOn!)),
            'onairDate': DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(item.onairDate!)),
            'deviceCondition': item.deviceCondition,
            'areaType': item.areaType,
            'areaLevel': item.areaLevel,
            'countryCode': item.countryCode,
            'countryName': item.agencyName,
            'geoLevel1Id': item.geoLevel1Id,
            'geoLevel1Code': item.geoLevel1Code,
            'geoLevel1Name': item.geoLevel1Name,
            'geoLevel2id': item.geoLevel2Id,
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
            'siteName': item.siteName,
            'siteAddress': item.siteAddress,
            'latitude': item.latitude,
            'longitude': item.longitude,
            'altitudeMtr': item.altitudeMtr,
            'linkId': item.linkId,
            'linkCode': item.linkCode,
            'linkName': item.linkName,
            'linkType': item.linkType,
            'connectedLinkPoint': item.connectedLinkPoint,
            'connectedLinkPointName': item.connectedLinkPointName,
            'upstreamDeviceId': item.upstreamDeviceId,
            'upstreamDeviceCode': item.upstreamDeviceCode,
            'upstreamDeviceIp': item.upstreamDeviceIp,
            'upstreamDeviceType': item.upstreamDeviceType,
            'upstreamLinkMbps': item.upstreamLinkMbps,
            'upstreamLinkType': item.upstreamLinkType,
            'upstreamLinkProvider': item.upstreamLinkProvider,
            'integrationMethod': item.integrationMethod,
            'externalSystem': item.externalSystem,
            'externalSystemId': item.externalSystemId,
            'externalSystemCode': item.externalSystemCode,
            'externalSystemName': item.externalSystemName,
            'externalSystemIp': item.externalSystemIp,
            'externalSystemType': item.externalSystemType,
            'externalSystemOs': item.externalSystemOs,
            'apiEnabled': item.apiEnabled,
            'extSysIntegrationMethod': item.extSysIntegrationMethod,
            'extSysWebApiCreateUserString': item.extSysWebApiCreateUserString,
            'extSysWebApiRemoveUserString': item.extSysWebApiRemoveUserString,
            'extSysWebApiCreatePermissionString':
                item.extSysWebApiCreatePermissionString,
            'extSysWebApiRemovePermissionString':
                item.extSysWebApiRemovePermissionString,
            'extSysSshServerUser': item.extSysSshServerUser,
            'extSysSshServerPwd': item.extSysSshServerPwd,
            'extSysSshCommandCreateUser': item.extSysSshCommandCreateUser,
            'extSysSshCommandRemoveUser': item.extSysSshCommandRemoveUser,
            'extSysSshCommandGrantPermission':
                item.extSysSshCommandGrantPermission,
            'extSysSshCommandRemovePermission':
                item.extSysSshCommandRemovePermission,
            'extSysWebApiCreateUserSuccessStrVariable':
                item.extSysWebApiCreateUserSuccessStrVariable,
            'extSysWebApiCreateUserSuccessStrValue':
                item.extSysWebApiCreateUserSuccessStrValue,
            'extSysWebApiRemoveUserSuccessStrVariable':
                item.extSysWebApiRemoveUserSuccessStrVariable,
            'extSysWebApiRemoveUserSuccessStrValue':
                item.extSysWebApiRemoveUserSuccessStrValue,
            'extSysWebApiGrantUserPermissionSuccessStrVariable':
                item.extSysWebApiGrantUserPermissionSuccessStrVariable,
            'extSysWebApiGrantUserPermissionSuccessStrValue':
                item.extSysWebApiGrantUserPermissionSuccessStrValue,
            'extSysWebApiRemoveUserPermissionSuccessStrVariable':
                item.extSysWebApiRemoveUserPermissionSuccessStrVariable,
            'extSysWebApiRemoveUserPermissionSuccessStrValue':
                item.extSysWebApiRemoveUserPermissionSuccessStrValue,
            'snmpVersion': item.snmpVersion,
            'snmpUdpPort': item.snmpUdpPort,
            'snmpCommunityStringAdmin': item.snmpCommunityStringAdmin,
            'snmpCommunityStringReadonly': item.snmpCommunityStringReadonly,
            'snmpSecurityLevel': item.snmpSecurityLevel,
            'snmpAuth': item.snmpAuth,
            'snmpEncryption': item.snmpEncryption,
            'snmpUsername': item.snmpUsername,
            'snmpGroup': item.snmpGroup,
            'snmpPassword': item.snmpPassword,
            'snmpConnectStyle': item.snmpConnectStyle,
            'oidBatteryCapacityPct': item.oidBatteryCapacityPct,
            'oidBatteryTemperature': item.oidBatteryTemperature,
            'oidBatteryRemainingMin': item.oidBatteryRemainingMin,
            'oidBatterySupplyType': item.oidBatterySupplyType,
            'batteryOnlineStatusValue': item.batteryOnlineStatusValue,
            'batteryOfflineStatusValue': item.batteryOfflineStatusValue,
            'oidBatteryReplacementNeeded': item.oidBatteryReplacementNeeded,
            'batteryReplacementValue': item.batteryReplacementValue,
            'oidOutputPower': item.oidOutputPower,
            'oidOutputVoltage': item.oidOutputVoltage,
            'oidOutputCurrent': item.oidOutputCurrent,
            'oidOutputFreq': item.oidOutputFreq,
            'oidOutputLoad': item.oidOutputLoad,
            'oidInputPower': item.oidInputPower,
            'oidInputVoltage': item.oidInputVoltage,
            'oidInputCurrent': item.oidInputCurrent,
            'oidInputFreq': item.oidInputFreq,
            'processorName': item.processorName,
            'processorClockGhz': item.processorClockGhz,
            'processors': item.processors,
            'processorCores': item.processorCores,
            'processorCacheGb': item.processorCacheGb,
            'oidProcessorName': item.oidProcessorName,
            'oidProcessorClockGhz': item.oidProcessorClockGhz,
            'oidProcessors': item.oidProcessors,
            'oidProcessorCores': item.oidProcessorCores,
            'oidProcessorCacheGb': item.oidProcessorCacheGb,
            'inputPowerRating': item.inputPowerRating,
            'inputPowerVoltage': item.inputPowerVoltage,
            'inputPowerCurrent': item.inputPowerCurrent,
            'inputPowerFreq': item.inputPowerFreq,
            'oidInputPowerRating': item.oidInputPowerRating,
            'oidInputPowerVoltage': item.oidInputPowerVoltage,
            'oidInputPowerCurrent': item.oidInputPowerCurrent,
            'oidInputPowerFreq': item.oidInputPowerFreq,
            'memoryRamType': item.memoryRamType,
            'memoryRamSizeGb': item.memoryRamSizeGb,
            'memoryHddType': item.memoryHddType,
            'memoryHddSizeTb': item.memoryHddSizeTb,
            'oidMemoryRamType': item.oidMemoryRamType,
            'oidMemoryRamSize': item.oidMemoryRamSize,
            'oidMemoryHddType': item.oidMemoryHddType,
            'oidMemoryHddSize': item.oidMemoryHddSize,
            'powerOutputRating': item.powerOutputRating,
            'oidPowerOutputRating': item.oidPowerOutputRating,
            'poleType': item.poleType,
            'placeType': item.placeType,
            'powerSource': item.powerSource,
            'custodian_username': item.custodianUsername,
            'custodian_fullname': item.custodianFullname,
            'custodian_mobile': item.custodianMobile,
            'custodian_email': item.custodianEmail,
            'custodian_nid': item.custodianEmail,
            'custodian_monthly_rent': item.custodianNid,
            'custodian_address': item.custodianAddress,
          };
        }).toList(),
      };
      kLog(jsonEncode(body));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/nms-appliance/update',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        issubmit.value = false;
        updateApplianceList.clear();

        back();
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

        // offAll(MainPage());
      } else {
        issubmit.value = false;
        updateApplianceList.clear();
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

  updateNetworkLink({required Links x}) async {
    try {
      isLoadding.value = true;
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': ApiEndpoint.SHOUT_APP_CODE,
        'actionType': 'work',
        'modelList': linkList.map((item) {
          return {
            'id': item!.id,
            'agencyId': item.agencyId,
            'agencyCode': item.agencyCode,
            'agencyName': item.agencyName,
            'projectId': selectedProject.value!.id,
            'projectCode': selectedProject.value!.projectCode,
            'projectName': selectedProject.value!.projectName,
            'linkCode': item.linkCode,
            'linkName':
                linkName.value.isNotEmpty ? linkName.value : item.linkName,
            'linkType': item.linkType,
            'site1Code': item.site1Code,
            'site1Name': item.site1Name,
            'site1Latitude': item.site1Latitude,
            'site1Longitude': item.site1Longitude,
            'site1Address': site1Address.value.isNotEmpty
                ? site1Address.value
                : item.site1Address,
            'site2Code': item.site2Code,
            'site2Name': item.site2Name,
            'site2Latitude': item.site2Latitude,
            'site2Longitude': item.site2Longitude,
            'site2Address': site2Address.value.isNotEmpty
                ? site2Address.value
                : item.site2Address,
            'linkLengthKm': item.linkLengthKm,
            'linkCondition': item.linkCondition,
            'workStatusCode': item.workStatusCode,
            'workStatus': item.workStatus,
            'workStartDate': item.workStartDate,
            'onairDate': item.onairDate,
            'lifeLengthYrs': item.lifeLengthYrs,
            'eol': item.eol,
            'mediaType': selectedMediaType.value.isNotEmpty
                ? selectedMediaType.value
                : item.mediaType,
            'placementType': selectedPlacementType.value.isNotEmpty
                ? selectedPlacementType.value
                : item.placementType,
            'ductNo': ductNo.value.isNotEmpty ? ductNo.value : item.ductNo,
            // 'totalCapGbps': '',
            // 'usedCapGbps': '',
            // 'totalOfcCores': '',
            // 'usedOfcCores': '',
            'totalCapGbps': totalCapGbps.value.isNotEmpty
                ? num.parse(totalCapGbps.value)
                : item.totalCapGbps,
            'usedCapGbps': usedCapGbps.value.isNotEmpty
                ? num.parse(usedCapGbps.value)
                : item.usedCapGbps,
            'availableCapGbps': item.availableCapGbps,
            'totalOfcCores': totalOfcCores.value.isNotEmpty
                ? num.parse(totalOfcCores.value)
                : item.totalOfcCores,
            'usedOfcCores': usedOfcCores.value.isNotEmpty
                ? num.parse(usedOfcCores.value)
                : item.usedOfcCores,
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
            'providerAgencyName': installationParty.value.isNotEmpty
                ? installationParty.value
                : item.providerAgencyName,
            'monthlyRent': item.monthlyRent,
            'contactPerson': contactPerson.value.isNotEmpty
                ? contactPerson.value
                : item.contactPerson,
            'contactNumbers': contactNo.value.isNotEmpty
                ? contactNo.value
                : item.contactNumbers,
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
            'verificationResult': item.verificationResult,
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

      // kLog(jsonEncode(body));

      final res = await postDynamic(
        path: ApiEndpoint.linkUpdateUrl(),
        body: body,
        authentication: true,
      );

      // kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoadding.value = false;
        final item = linkList.singleWhere((element) => element!.id == x.id!);

        item!.placementType = selectedPlacementType.value;
        item.mediaType = selectedMediaType.value;
        item.linkName = linkName.value;
        item.site1Address = site1Address.value;
        item.site2Address = site2Address.value;
        item.totalCapGbps = num.parse(totalCapGbps.value);
        item.usedCapGbps = num.parse(usedCapGbps.value);
        item.totalOfcCores = num.parse(totalOfcCores.value);
        item.usedOfcCores = num.parse(usedOfcCores.value);
        item.ductNo = ductNo.value;
        item.providerAgencyName = installationParty.value;
        item.contactPerson = contactPerson.value;
        item.contactNumbers = contactNo.value;

        linkList[linkList.indexOf(item)] = item;

        back();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
      } else {
        isLoadding.value = false;
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
      isLoadding.value = false;
    } catch (e) {
      print(e);
    }
  }

  updateValues({
    Appliances? currentItem,
    String? code,
    String? ipAddress,
    String? macAddress,
    String? model,
    String? standard,
    String? address,
    num? capacity,
    num? fqr1,
    num? fqr2,
    num? radius,
    num? height,
  }) {
    final item = applianceList.singleWhere((x) => x!.id == currentItem!.id);
    item!.deviceCode = code;
    item.deviceIp = ipAddress;
    item.deviceMac = macAddress;
    item.deviceModel = model;
    item.technologyStandard = standard;
    item.siteAddress = address;
    item.connectionCapacity = capacity;
    item.frequencyGhz = fqr1;
    item.frequencyGhz2 = fqr2;
    item.coverageRadiusMtr = radius;
    item.equipmentHeightFt = height;
    applianceList[applianceList.indexOf(item)] = item;
  }
}
