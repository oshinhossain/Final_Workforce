import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import '../config/api_endpoint.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/models/site_location.dart';
import 'package:workforce/src/models/site_location_v2.dart';
import 'package:workforce/src/services/api_service.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/log.dart';
import '../helpers/route.dart';
import '../map/dragmarker.dart';
import '../models/geo_list_select_molel.dart';
import '../models/project_area_add_model.dart';
import '../models/project_area_get_model.dart';
import '../models/project_dropdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

import '../models/search_area_geograpphy_model.dart';

class AssignGeographiesProjectController extends GetxController
    with ApiService {
  final isSelectAll = RxBool(false);
  final isChecked = RxBool(false);
  final isChecked2 = RxBool(false);
  final isChecked3 = RxBool(false);

  final kMapControllerSiteLocation = MapController();
  final currentLocationCircleMarker = RxList<CircleMarker>([]);

  gmap.GoogleMapController? mapController;

  final isPlotingEnable = RxBool(true);

  final isLoading = RxBool(false);
  final issubmit = RxBool(false);

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

  // final newPoleCount = RxInt(0);
  // final elePoleCount = RxInt(0);
  // final telPoleCount = RxInt(0);
  // final lightPostCount = RxInt(0);
  // final buildingCount = RxInt(0);
  // final otherPoleCount = RxInt(0);

  // final cableTvCount = RxInt(0);
  // // final localIspCount = RxInt(0);

  // final wifiApCount = RxInt(0);
  // final popCount = RxInt(0);
  // final btsCount = RxInt(0);

  // final completeCount = RxInt(0);
  // final abortedCount = RxInt(0);
  // final wsrCount = RxInt(0);

  // final locations = RxList<Geograpphy>();
  // final selectedlocations = RxList<Geograpphy>();

  //............New model geograpphy srch ......................
  final locationsGeo = RxList<SearchAreaGeograpphy>();
  final selectedlocationsGeo = RxList<SearchAreaGeograpphy>();
//...........................................................
  final search = RxString('');

  final levelFullCode = RxString('');
  final geol4Id = RxString('');

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

// Get project list
  final projectNameList = RxList<ProjectDropdown>();

  final selectedProject = Rx<ProjectDropdown?>(null);
  final selectProjectName = RxString('Constraction');
  final projectId = RxString('');

//new
  final gioSelect = RxList<GioSelect>();
  final projectAreaGet = RxList<ProjectAreaGet>();

  final projectAreaAdd = RxList<ProjectAreaAdd?>([]);

  ///.................................................
  assingProjectAreaGet() async {
    try {
      isLoading.value = true;
      //// kLog('zillur ');
      //// kLog(isLoading.value);

      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);

      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': projectId.value,
      };
      // kLog(params);
      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/area/get');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map(
                (json) => ProjectAreaGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectAreaGet>() as List<ProjectAreaGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          projectAreaGet.clear();
          projectAreaGet.addAll(data);
          // projectAreaGet
          //     .addAll(data.where((element) => element.pmUsername == username));
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
  //-------------------------------------

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

      //kLog(jsonEncode(res.data));
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

  //..........................................
  // Driver Agency Delete
  //..........................................

  void deleteDriverAgency({required String id}) async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'WFC',
        'ids': [id]
      };

      // kLog(body);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/area/delete',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        back();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            // offAll(AddDriverToAgencyPage());
            back();
          },
        );
        await 1.delay();

        back();

        // slectDriverModel.clear();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
        await 6.delay();
        back();
      }

      isLoading.value = false;
      // slectDriverModel.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }
  //............................................................
  ////........................................................

  // void getAreaByIds() async {
  //   // isLoading.value = true;
  //   final username = Get.put(UserController()).username;

  //   final body = {
  //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //     'appCode': 'SURVEY',
  //     'username': username,
  //     'areaType': 'COUNTRY UNIT',
  //     'areaLevel': 4,
  //     'polygonNeeded': true,
  //     'geoAreaIds': [geol4Id.value],
  //     'countryCode': 'BD'
  //   };
  //   pointsForPolygon.clear();
  //   final res = await postDynamic(
  //     path: ApiEndpoint.getAreaByIdsUrl(),
  //     body: body,
  //     authentication: true,
  //   );

  //   final coordinates = jsonDecode(
  //           res.data['data'][0]['areaPolygonJSON'] as String)['coordinates']
  //       as List;

  //   pointsForPolygon.value =
  //       ConvertMaPData().convertPointsForPolygon(coordinates);
  //   pointsForGmapPolygon.value =
  //       ConvertMaPData().convertPointsForGmapPolygon(coordinates);
  //   polygone.add(gmap.Polygon(
  //     fillColor: Colors.transparent,
  //     points: pointsForGmapPolygon,
  //     polygonId: gmap.PolygonId('1'),
  //     strokeColor: hexToColor('#00D8A0'),
  //     strokeWidth: 3,
  //   ));
  // }

  // addGeographyPast() async {
  //   try {
  //     if (search.value.isNotEmpty) {
  //       isLoading.value = true;

  //       final body = {
  //         'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //         'appCode': 'SURVEY',
  //         'uiCodes': ['0000'],
  //         'areaLevel': 4,
  //         'areaType': 'COUNTRY UNIT',
  //         'countryCode': 'BD',
  //         'searchText': search.value
  //       };

  //       final res = await postDynamic(
  //         path: ApiEndpoint.addGeographiesUrl(),
  //         body: body,
  //         authentication: true,
  //       );

  //       final data = res.data['data']
  //           .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
  //           .toList()
  //           .cast<Geograpphy>() as List<Geograpphy>;
  //       isLoading.value = false;
  //       locations.clear();
  //       locations.addAll(data);

  //       gioSelect.clear();
  //       for (var element in locations) {
  //         gioSelect.add(GioSelect(id: element.id, isSelect: false));
  //       }
  //      // kLog('ami.............................................');
  //      // kLog(gioSelect.length);
  //     }
  //     isLoading.value = false;
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  // }

  //..................................................

  // Search Area Geography
  ///..........................................................
  addGeography() async {
    try {
      if (search.value.isNotEmpty) {
        isLoading.value = true;

        final body = {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'SURVEY',
          'uiCodes': ['0000'],
          'areaLevel': 4,
          'areaType': 'COUNTRY UNIT',
          'countryCode': 'BD',
          'searchText': search.value
        };

        final res = await postDynamic(
          path: ApiEndpoint.geographiesSearchUrl(),
          body: body,
          authentication: true,
        );

        final data = res.data['data']
            .map((json) =>
                SearchAreaGeograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<SearchAreaGeograpphy>() as List<SearchAreaGeograpphy>;
        isLoading.value = false;
        locationsGeo.clear();
        locationsGeo.addAll(data);

        gioSelect.clear();
        for (var element in locationsGeo) {
          gioSelect.add(GioSelect(id: element.id, isSelect: false));
        }
        //kLog('ami.............................................');
        // kLog(gioSelect.length);
        // kLog(gioSelect.length);

        // kLog(data);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  projectAreaAddCreate() async {
    try {
      issubmit.value = true;
      // ignore: unused_local_variable
      String? id;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'WFC',
        'modelList': projectAreaAdd,
      };
      //kLog('+++++++++');
      // kLog(jsonEncode(body));
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/area/add',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // kLog('kaj hoiche ');
        issubmit.value = false;
        projectAreaAdd.clear();

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
        projectAreaAdd.clear();
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

  //.......................................................................

  void disposeData() {
    projectSiteMarkers.clear();

    locationsGeo.clear();
    projectAreaGet.clear();
    siteLocations.value = null;

    // newPoleCount.value = 0;
    // elePoleCount.value = 0;
    // telPoleCount.value = 0;
    // lightPostCount.value = 0;
    // buildingCount.value = 0;
    // otherPoleCount.value = 0;

    // wifiApCount.value = 0;
    // popCount.value = 0;
    // btsCount.value = 0;

    search.value = '';
    levelFullCode.value = '';
    geol4Id.value = '';
  }

  //--------------------------------------
}
