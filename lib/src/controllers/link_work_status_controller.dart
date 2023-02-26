import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
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
import 'package:workforce/src/models/appliances.dart';
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

import '../models/links.dart';
import '../models/project_dropdown.dart';
import '../widgets/custom_textfield_with_dropdown.dart';
import 'agencyController.dart';

class LinkWorkStatusController extends GetxController with ApiService {
  //final locationC = Get.put(LocationController());
  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);
  final isGoogleMap = RxBool(true);
  final isPlotingEnable = RxBool(true);

  final isLoading = RxBool(false);
  final issubmit = RxBool(false);
  final isLoadding = RxBool(false);

  final siteLocations = Rx<ProjectSites?>(null);
  final projectSiteList = RxList<ProjectSites?>([]);

  final linkList = RxList<Links?>([]);
  final linkUpdateList = RxList<Links?>([]);
  final areaPolygon = Rx<AreaPolygon?>(null);

  final markerList = RxList<ProjectSites>();
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

  final completeCount = RxInt(0);
  final abortedCount = RxInt(0);
  final wsrCount = RxInt(0);
  final ofcLength = RxDouble(0);
  final ofcCore4 = RxDouble(0);
  final ofcCore8 = RxDouble(0);
  final ofcCore12 = RxDouble(0);
  final ofcCore24 = RxDouble(0);

  final linkLenght = RxDouble(0);
  final notStartedWork = RxDouble(0);
  final startedWork = RxDouble(0);
  final wipWork = RxDouble(0);
  final abortedWork = RxDouble(0);
  final restartedWork = RxDouble(0);
  final completeWork = RxDouble(0);

  final ofcCoreOthers = RxDouble(0);
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

  final allMarkers = RxSet<gmap.Marker>();
  final polygone = RxList<gmap.Polygon>();
  final pointsForGmapPolygon = RxList<gmap.LatLng>([]);
  gmap.GoogleMapController? mapController;
  final googleMapLinkPolylines = RxSet<gmap.Polyline>();
  final cameraTarget = Rx<gmap.LatLng>(gmap.LatLng(0.0, 0.0));
  //final googleMapProjectSiteMarkers = RxList<gmap.Marker>();
  //====================== get geo area =================================

  final siteName = RxString('');

  final powerSources = RxList([
    'Electricity',
    'Solar',
    'New Solar Panel Needed',
    'Generator',
  ]);
  final selectedPowerSource = RxString('Electricity');

  final status = RxList([
    'WIP',
    'Aborted',
    'Restarted',
    'Completed',
  ]);
  final selectedStatus = RxString('WIP');
  final statusCode = RxString('05');
  final currentStatus = RxString('Started');
  final placeName = RxString('');
  final address = RxString('');
  final potentialBeneficiaries = RxString('');

  final custodianName = RxString('');
  final custodianMobileNo = RxString('');
  final custodianNIDNo = RxString('');
  final custodianEmail = RxString('');
  final custodianAddress = RxString('');
  final userNameWF = RxString('');

  final selectedDate = RxString('');

  //-------------------------------------
  //Evidence
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------
  final applianceList = RxList<Appliances?>([]);
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
      //  'geoAreaIds': ['0000825d-b253-42d0-9971-8b0354c1dfa9'],
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

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'areaLevelFullCode': levelFullCode.value,
        'projectId': selectedProject.value!.id,
      };

      final res = await getDynamic(
          path: ApiEndpoint.getNmsNetworkLinkPointsUrl(),
          queryParameters: params,
          authentication: true);

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

      //==================alldata=================//

      //   LinkListData111.forEach(
      //     (x) {
      //       ofcLength.value += x.linkLengthKm!;
      //       if (x.totalOfcCores == 4) {
      //         ofcCore4.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 8) {
      //         ofcCore8.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 12) {
      //         ofcCore12.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 24) {
      //         ofcCore24.value += x.linkLengthKm!;
      //       } else {
      //         ofcCoreOthers.value += x.linkLengthKm!;
      //       }
      //     },
      //   );
      // }

      //================== Links =================

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
        completeWork.value = 0;
        notStartedWork.value = 0;
        startedWork.value = 0;
        wipWork.value = 0;
        abortedWork.value = 0;
        restartedWork.value = 0;
        linkLenght.value = 0;

        // ignore: avoid_function_literals_in_foreach_calls
        LinkListData.forEach(
          (x) {
            ofcLength.value += x.linkLengthKm!;
            linkLenght.value += x.linkLengthKm!;
            if (x.totalOfcCores == 4) {
              ofcCore4.value += x.linkLengthKm!;
            } else if (x.totalOfcCores == 8) {
              ofcCore8.value += x.linkLengthKm!;
            } else if (x.totalOfcCores == 12) {
              ofcCore12.value += x.linkLengthKm!;
            } else if (x.totalOfcCores == 24) {
              ofcCore24.value += x.linkLengthKm!;
            }
            if (x.workStatusCode == '04') {
              startedWork.value += x.linkLengthKm!;
            }
            if (x.workStatusCode == '05') {
              wipWork.value += x.linkLengthKm!;
            }
            if (x.workStatusCode == '06') {
              abortedWork.value += x.linkLengthKm!;
            }
            if (x.workStatusCode == '07') {
              restartedWork.value += x.linkLengthKm!;
            }
            if (x.workStatusCode == '08') {
              completeWork.value += x.linkLengthKm!;
            } else {
              ofcCoreOthers.value += x.linkLengthKm!;
              notStartedWork.value += x.linkLengthKm!;
            }

            // --------------------------------------------------
            // ***** Flutter map linkPoints *****
            // --------------------------------------------------
            List<LatLng> points = [];

            // ignore: avoid_function_literals_in_foreach_calls
            x.linkPoints!.forEach((element) {
              points.add(LatLng(element.latitude!, element.longitude!));
            });

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
                patterns: x.workStatus == 'Completed'
                    ? <gmap.PatternItem>[
                        gmap.PatternItem.dash(10),
                        gmap.PatternItem.gap(0),
                      ]
                    : x.workStatus == 'Aborted'
                        ? <gmap.PatternItem>[
                            gmap.PatternItem.dash(5),
                            gmap.PatternItem.gap(8),
                          ]
                        : x.workStatus == 'Started' ||
                                x.workStatus == 'Restarted' ||
                                x.workStatus == 'WIP'
                            ? <gmap.PatternItem>[
                                gmap.PatternItem.dash(10),
                                gmap.PatternItem.gap(2),
                              ]
                            : <gmap.PatternItem>[
                                gmap.PatternItem.dot,
                                gmap.PatternItem.gap(5),
                              ],
                onTap: () {
                  LinkCompletionDialog(x: x);
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
            // ***** Google map linkPoints end *****
            // --------------------------------------------------
          },
        );
      }

      //----------------------//
      // if (linkData.isNotEmpty) {
      //   //   //Add app liance
      //   linkList.addAll(linkData);

      //   // ignore: avoid_function_literals_in_foreach_calls
      //   linkData.forEach((x) async {
      //     // ***** Google map linkPoints *****
      //     // --------------------------------------------------
      //     List<gmap.LatLng> googleMapPoints = [];

      //     // ignore: avoid_function_literals_in_foreach_calls
      //     x.linkPoints!.forEach((element) {
      //       ofcLength.value += x.linkLengthKm!;
      //       if (x.totalOfcCores == 4) {
      //         ofcCore4.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 8) {
      //         ofcCore8.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 12) {
      //         ofcCore12.value += x.linkLengthKm!;
      //       } else if (x.totalOfcCores == 24) {
      //         ofcCore24.value += x.linkLengthKm!;
      //       } else {
      //         ofcCoreOthers.value += x.linkLengthKm!;
      //       }
      //       googleMapPoints
      //           .add(gmap.LatLng(element.latitude!, element.longitude!));
      //     });

      //     //Google Map
      //     googleMapLinkPolylines.add(
      //       gmap.Polyline(
      //         polylineId: gmap.PolylineId(x.id!),
      //         consumeTapEvents: true,
      //         points: googleMapPoints,
      //         jointType: gmap.JointType.round,
      //         width: 5,
      //         patterns: x.workStatus == 'Completed'
      //             ? <gmap.PatternItem>[
      //                 gmap.PatternItem.dash(10),
      //                 gmap.PatternItem.gap(0),
      //               ]
      //             : x.workStatus == 'Aborted'
      //                 ? <gmap.PatternItem>[
      //                     gmap.PatternItem.dash(5),
      //                     gmap.PatternItem.gap(8),
      //                   ]
      //                 : x.workStatus == 'Started' ||
      //                         x.workStatus == 'Restarted' ||
      //                         x.workStatus == 'WIP'
      //                     ? <gmap.PatternItem>[
      //                         gmap.PatternItem.dash(10),
      //                         gmap.PatternItem.gap(2),
      //                       ]
      //                     : <gmap.PatternItem>[
      //                         gmap.PatternItem.dot,
      //                         gmap.PatternItem.gap(5),
      //                       ],
      //         onTap: () {
      //           LinkCompletionDialog(x: x);
      //         },
      //         color: x.totalOfcCores == 4
      //             ? Colors.blue
      //             : x.totalOfcCores == 8
      //                 ? Colors.purple
      //                 : x.totalOfcCores == 12
      //                     ? Colors.green
      //                     : x.totalOfcCores == 24
      //                         ? Colors.red
      //                         : Colors.orange,
      //       ),
      //     );
      //     // --------------------------------------------------
      //     // ***** Google map linkPoints end *****
      //   });
      // }
      //----------------------//
      //================== Appliance Markers =================

      //App liances list
      final applianceListData = res.data['data']['appliances']
          .map((json) => Appliances.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<Appliances>() as List<Appliances>;
      if (applianceListData.isNotEmpty) {
        //Add app liance
        applianceList.addAll(applianceListData);

        // ignore: avoid_function_literals_in_foreach_calls
        applianceListData.forEach((x) async {
          // projectSiteMarkers.add(
          //   Marker(
          //     point: LatLng(x.latitude!, x.longitude!),
          //     builder: (_) {
          //       return GestureDetector(
          //         onTap: () {
          //           DialogHelper.showNetworkTopologyDeviceInfo(x: x);
          //         },
          //         child: Icon(
          //           Icons.location_on,
          //           color: x.deviceTypeName == 'Wifi Router'
          //               ? Colors.green
          //               : x.deviceTypeName == 'Local ISP'
          //                   ? Colors.yellow
          //                   : x.deviceTypeName == 'Cable TV Operator'
          //                       ? Color.fromARGB(255, 8, 81, 141)
          //                       : x.deviceTypeName == 'POP'
          //                           ? Colors.red
          //                           : x.deviceTypeName == 'BTS'
          //                               ? Colors.blueAccent
          //                               : Colors.black,
          //           size: 40,
          //         ),
          //       );
          //     },
          //   ),
          // );

          // // Add animate camera position
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
              .getBytesFromAsset(getMarkerImg(x.deviceTypeName), 50);

          allMarkers.add(
            gmap.Marker(
              position: gmap.LatLng(x.latitude!, x.longitude!),
              markerId: gmap.MarkerId(x.id!),
              icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
              flat: true,
              onTap: () {
                /// siteCompletionDialog(x: x);
              },
            ),
          );
          //  cameraTarget.value = gmap.LatLng(x.latitude!, x.longitude!);

          //-----------------------------------------
          // ****** Google map project site markers ******
          //-----------------------------------------
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
          if (x.workStatus == 'Completed') {
            // projectSiteList[projectSiteList.indexWhere((element) => element.workStatus==x.workStatus)].
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
            }
          }
          // getMarkerImg( pillerType) {
          //   switch (pillerType) {
          //     case 'Electricity Pole':
          //       return  'assets/img/pole.png';
          //           : pillerType == 'New Pole'
          //               ? 'assets/img/new_pole.png'
          //               : pillerType == 'Light Post'
          //                   ? 'assets/img/light_post.png'
          //                   : pillerType == 'Telephone Pole'
          //                       ? 'assets/img/tel.png'
          //                       : 'assets/img/building.png';
          //     case 'Wifi Router':
          //       return 'assets/img/wifi.png';
          //     case 'POP':
          //       return 'assets/img/pop.png';
          //   }
          // }

          checkMarkerStatus(pillerType, workStatus) {
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
                return getMarkerImg(pillerType);
            }
          }

          final Uint8List markerIcon = await ConvertMaPData().getBytesFromAsset(
              checkMarkerStatus(x.pillarType, x.workStatus), 50);
          allMarkers.add(
            gmap.Marker(
                position: gmap.LatLng(x.latitude!, x.longitude!),
                markerId: gmap.MarkerId(x.id!),
                icon: gmap.BitmapDescriptor.fromBytes(markerIcon),
                flat: true,
                anchor: x.functionType == 'Cable Point'
                    ? Offset(0.5, 0)
                    : Offset(0.5, 1.0),
                onTap: () {
                  //   LinkCompletionDialog(x: x);
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
                          completeCount.value = 0;
                          abortedCount.value = 0;
                          wsrCount.value = 0;
                          ofcLength.value = 0;
                          ofcCore4.value = 0;
                          ofcCore8.value = 0;
                          ofcCore12.value = 0;
                          ofcCore24.value = 0;
                          ofcCoreOthers.value = 0;
                          remarks.value = '';
                          allMarkers.clear();
                          polygone.clear();
                          googleMapLinkPolylines.clear();
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

  LinkCompletionDialog({
    required Links x,
  }) {
    //   getFileCount(id: x.id!, status: x.workStatus);
    locationC.locationListener();
    GlobalDialog.addSiteDialog(
      title: 'Link Work Status',
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
                      bold: true,
                      maxLines: 2,
                    ),
                  ),
                  Spacer(),
                  KText(
                    text: x.linkCode,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: 'Site 1 Address ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                  KText(
                    text: 'Site 2 Address ',
                    color: AppTheme.nTextLightC,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: KText(
                      text: x.site1Address,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: KText(
                      text: x.site2Address,
                      maxLines: 2,
                    ),
                  ),
                ],
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
              KText(
                text: 'Distance',
                color: AppTheme.nTextC,
                fontSize: 14,
              ),
              KText(
                text: x.linkLengthKm.toString(),
                color: AppTheme.nTextC,
                fontSize: 14,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              if (x.workStatus != 'Started' &&
                  x.workStatus != 'WIP' &&
                  x.workStatus != 'Aborted' &&
                  x.workStatus != 'Restarted' &&
                  x.workStatus != 'Completed' &&
                  isStart.value == false)
                GestureDetector(
                  onTap: () {
                    linkUpdateList.add(x);

                    updateLinkStatus(
                      statusCode: '04',
                      workStatus: 'Started',
                    );
                    //  postPogress(status: 'Started', statusCode: '04');
                    isStart.value = true;
                    //  back();
                  },
                  child: Container(
                    height: 30,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: hexToColor('#00D8A0'),
                        )),
                    child: Center(
                      child: KText(
                        text: 'Start',
                        color: hexToColor('#00D8A0'),
                        bold: true,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              if (isStart.value ||
                  x.workStatus == 'Started' ||
                  x.workStatus == 'WIP' ||
                  x.workStatus == 'Aborted' ||
                  x.workStatus == 'Restarted' ||
                  x.workStatus == 'Completed')
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: KText(
                        text: isStart.value
                            ? 'Current Status: Started'
                            : 'Current Status: ${x.workStatus}',
                        color: AppTheme.nTextLightC,
                        bold: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DottedLine(),
                    ),
                    Row(
                      children: [
                        KText(text: 'New Status'),
                        Spacer(),
                        KText(text: 'Date'),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 25,
                          child: CustomTextFieldWithDropdown(
                            suffix: DropdownButton(
                              value: selectedStatus.value,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: status.map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    if (item == 'WIP') {
                                      statusCode.value = '05';
                                      selectedStatus.value = item;
                                      currentStatus.value = item;
                                    } else if (item == 'Aborted') {
                                      statusCode.value = '06';
                                      selectedStatus.value = item;
                                      currentStatus.value = item;
                                    } else if (item == 'Restarted') {
                                      statusCode.value = '07';
                                      selectedStatus.value = item;
                                      currentStatus.value = item;
                                    } else {
                                      statusCode.value = '08';
                                      selectedStatus.value = item;
                                      currentStatus.value = item;
                                    }
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
                        GestureDetector(
                            //    onTap: selectDate,
                            child: KText(
                                text: selectedDate.value.isEmpty
                                    ? formatDate(
                                        date: DateTime.now().toString())
                                    : selectedDate.value))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    KText(text: 'Remarks'),
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
                            borderSide:
                                BorderSide(color: hexToColor('#DBECFB')),
                          ),
                        ),
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
                          ),
                        ),
                      ),
                      onPressed: () {
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
                        isStart.value = false;
                        linkUpdateList.add(x);
                        updateLinkStatus(
                          statusCode: statusCode.value,
                          workStatus: selectedStatus.value,
                        );

                        currentStatus.value = selectedStatus.value;
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

    completeCount.value = 0;
    abortedCount.value = 0;
    wsrCount.value = 0;

    wifiApCount.value = 0;
    popCount.value = 0;
    btsCount.value = 0;

    locations.clear();

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }

  updateLinkStatus({String? statusCode, String? workStatus}) async {
    issubmit.value = true;
    final username = Get.put(UserController()).username;
    String? id;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'appCode': ApiEndpoint.SHOUT_APP_CODE,
      'actionType': 'work',
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
          'workStatusCode': statusCode,
          'workStatus': workStatus,
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
          'totalOfcCores': item.totalOfcCores,
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
          'verificationResult': item.verificationResult,
          'verifiedOn': item.verifiedOn,
          'verifiedAt': item.verifiedAt,
          'verifierUsername': item.verifierUsername,
          'verifierFullname': item.verifierFullname,
          'verifierMobile': item.verifierMobile,
          'verifierEmail': item.verifierEmail,
          'verifierComments':
              statusCode == '04' ? 'Work started' : item.verifierComments,
          'isInspectionCleared': item.inspectionCleared,
        };
      }).toList()
    };
    kLog(body);
    final res = await postDynamic(
      path: ApiEndpoint.linkUpdateUrl(),
      body: body,
      authentication: true,
    );

    if (res.data['status'] != null &&
        res.data['status'].contains('successful') == true) {
      issubmit.value = false;

      linkList[linkList.indexWhere((element) => element!.id == id!)]!
          .workStatus = currentStatus.value;
      remarks.value = '';
      currentStatus.value = 'Started';

      //===========//

      // ignore: avoid_function_literals_in_foreach_calls
      linkList.forEach((x) async {
        List<gmap.LatLng> googleMapPoints = [];
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
        });

        //Google Map
        googleMapLinkPolylines.add(
          gmap.Polyline(
            polylineId: gmap.PolylineId(x.id!),
            consumeTapEvents: true,
            points: googleMapPoints,
            jointType: gmap.JointType.round,
            width: 5,
            patterns: x.workStatus == 'Aborted'
                ? <gmap.PatternItem>[
                    gmap.PatternItem.dash(5),
                    gmap.PatternItem.gap(8),
                  ]
                : x.workStatus == 'Completed'
                    ? <gmap.PatternItem>[
                        gmap.PatternItem.dash(10),
                        gmap.PatternItem.gap(0),
                      ]
                    : x.workStatus == 'Started' ||
                            x.workStatus == 'Restarted' ||
                            x.workStatus == 'WIP'
                        ? <gmap.PatternItem>[
                            gmap.PatternItem.dash(10),
                            gmap.PatternItem.gap(2),
                          ]
                        : <gmap.PatternItem>[
                            gmap.PatternItem.dot,
                            gmap.PatternItem.gap(5),
                          ],
            onTap: () {
              LinkCompletionDialog(x: x);
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
          selectedStatus.value = 'WIP';

          back();
          //  disposeData();
          siteSearchV2();
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
          isStart.value = true;
          linkUpdateList.clear();
          selectedStatus.value = 'WIP';

          back();
          siteSearchV2();
        },
      );
    }
  }

  updateRemarks({
    Links? currentItem,
    String? remarks,
  }) {
    final item = linkList.singleWhere((x) => x!.id == currentItem!.id);
    item!.verifierComments = remarks;

    linkList[linkList.indexOf(item)] = item;
  }
}
