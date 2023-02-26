import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../services/api_service.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/map_data.dart';
import 'package:workforce/src/models/material_delivery_location.dart';
import 'package:workforce/src/models/material_location_planning.dart';

import '../models/project_dropdown.dart';

class MaterialsDeliveryLocationPlanningController extends GetxController
    with ApiService {
  final projectNameList = RxList<ProjectDropdown>();
  final projectName = RxString('');
  final projectId = RxString('');
  final projectCode = RxString('');
  final isLoading = RxBool(false);
  final isChecked = RxBool(true);
//delivary location
  final srcLoccation = RxString('');
  final delivaryLocName = RxString('');
  final delivaryLocId = RxString('');
  final delivaryLat = RxDouble(0.0);
  final delivaryLong = RxDouble(0.0);
  final locations = RxList();
  final geoList = RxList();
  final deliverylocations = RxList<MaterialDeliveryLoc>();

  final locationType = Rx<LocationDelivary>(LocationDelivary.known);

  final kMapController = MapController();

  final pickLocation = Rx<MapData?>(null);

  //====================================================

  final itemList = RxList<MaterialLocationPlanning>();

  //====================================================

  final isEdit = RxBool(false);

  final area = RxString('');

  final geographyList = RxList<Geograpphy>();

  final geograpphies = RxList<Geograpphy>();

  final isLoadding = RxBool(false);

  final srcGeography = RxString('');

//Material BottomSheet
  geographiesBottomSheet({required String id}) async {
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
                    onChanged: srcGeography,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          addGeography();
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: hexToColor('#9BA9B3'),
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
                      : geograpphies.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: RenderSvg(
                                  path: 'search_list',
                                  width: 60,
                                  color: hexToColor('#9BA9B3'),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: geograpphies.length,
                                  itemBuilder: (context, index) {
                                    final item = geograpphies[index];
                                    return GestureDetector(
                                      onTap: () {
                                        //  geographyList.add(item);
                                        updateGeophaphyList(id: id, x: item);
                                        //levelCode.add(item.levelFullcode);
                                        back();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 30,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: AppTheme.bdrColor))),
                                        child: KText(text: item.geoLevel4Name),
                                      ),
                                    );
                                  }),
                            ),

                  //   if (geograpphies.value != null)
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        srcGeography.value = '';
        geograpphies.clear();
        isLoadding.value = false;
      });
    } catch (e) {
      print(e);
    }
  }

  addGeography() async {
    isLoadding.value = true;
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'searchText': srcGeography.value
    };

    final res = await postDynamic(
      path: ApiEndpoint.addGeographiesUrl(),
      body: body,
      authentication: true,
    );

    print(res.statusCode);

    // final data = jsonEncode(res.data['data']);
    final data = res.data['data']
        .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<Geograpphy>() as List<Geograpphy>;
    // final data = Geograpphy.fromJson(res.data['data'] as Map<String, dynamic>);
    print(data);
    // geographyList.value = data;

    geograpphies.clear();
    geograpphies.addAll(data);
    isLoadding.value = false;
  }

  projectNameDropdown() async {
    await Get.defaultDialog(
        title: '',
        backgroundColor: Colors.transparent,
        content: Obx(
          () => Container(
            color: Colors.white,
            //  margin: EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: projectNameList.length,
                itemBuilder: (context, index) {
                  final item = projectNameList[index];
                  return GestureDetector(
                    onTap: () {
                      projectName.value = item.projectName as String;
                      projectId.value = item.id as String;
                      projectCode.value = item.projectCode as String;
                      getDeliveryLocation();
                      back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.textColor,
                            width: .2,
                          ),
                        ),
                      ),
                      child: Center(child: KText(text: '${item.projectName}')),
                    ),
                  );
                }),
          ),
        ));
  }

  locationBottomSheet(
    String id,
  ) async {
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

    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 500,
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
                  // SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: KText(
                      text: 'Location Type: ',
                      fontSize: 14,
                      bold: true,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationDelivary.known;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.known,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Text(
                                'Known Location',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationDelivary.map;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.map,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Text(
                                'Map',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationDelivary.warehouse;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.warehouse,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                              ),
                              child: Text(
                                'Warehouse',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: hexToColor('#515D64'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  locationType.value == LocationDelivary.known
                      ? KText(
                          text: 'Search Delivery Location',
                          bold: true,
                        )
                      : locationType.value == LocationDelivary.map
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: 'Give it a Name ',
                                  bold: true,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 10,
                                      child: Checkbox(
                                          checkColor: Colors.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                          value: isChecked.value,
                                          onChanged: (_) {
                                            isChecked.toggle();
                                          }),
                                    ),
                                    KText(
                                      text: 'Save it',
                                      bold: true,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                  locationType.value == LocationDelivary.known
                      ? TextField(
                          onChanged: srcLoccation,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchUserDefinedLoc();
                                print('pressed');
                              },
                              child: RenderSvg(
                                fit: BoxFit.scaleDown,
                                path: 'icon_search_elements',
                                width: 5,
                                color: hexToColor('#9BA9B3'),
                              ),
                            ),
                            // focusedBorder: InputBorder.none,
                            hintText: 'Search here...',
                          ),
                        )
                      : locationType.value == LocationDelivary.map
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: KText(
                                      text: delivaryLocName.value == null
                                          ? ''
                                          : delivaryLocName.value),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 200,
                                  child: FutureBuilder<LocationData?>(
                                      future: currentLocation(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapchat) {
                                        if (snapchat.hasData) {
                                          final LocationData currentLocation =
                                              snapchat.data as LocationData;
                                          print(currentLocation.latitude);
                                          // ignore: unused_local_variable
                                          final position = LatLng(
                                              currentLocation.latitude!,
                                              currentLocation.latitude!);
                                          return Stack(children: [
                                            FlutterMap(
                                              mapController: kMapController,
                                              options: MapOptions(
                                                // center: position,
                                                center: LatLng(
                                                    23.773229395435163,
                                                    90.41131542577997),
                                                zoom: 15,
                                                maxZoom: 20,
                                              ),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.ctrendssoftware.workforce',
                                                ),
                                                MarkerLayer(
                                                  markers: [],
                                                ),
                                              ],
                                            ),
                                            Positioned.fill(
                                                child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  pickData();
                                                  delivaryLocName.value =
                                                      pickLocation.value!
                                                              .displayName
                                                          as String;
                                                  delivaryLocId.value =
                                                      pickLocation.value!.osmId
                                                          as String;
                                                  delivaryLat.value =
                                                      pickLocation.value!.lat
                                                          as double;
                                                  delivaryLong.value =
                                                      pickLocation.value!.lon
                                                          as double;
                                                },
                                                child: Icon(
                                                  Icons.location_pin,
                                                  size: 50,
                                                  color: AppTheme.color2,
                                                ),
                                              ),
                                            )),
                                          ]);
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      pickData();
                                      delivaryLocName.value = pickLocation
                                          .value!.displayName as String;
                                      delivaryLocId.value =
                                          pickLocation.value!.osmId as String;
                                      delivaryLat.value =
                                          pickLocation.value!.lat as double;
                                      delivaryLong.value =
                                          pickLocation.value!.lon as double;
                                      back();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 34,
                                      width: 150,
                                      // ignore: sort_child_properties_last
                                      child: Center(
                                        child: KText(
                                          text: 'Select',
                                          color: Colors.white,
                                          bold: true,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: hexToColor('#007BEC'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                  if (locationType.value == LocationDelivary.known)
                    isLoading.value
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
                                          delivaryLocName.value =
                                              item['locationName'] as String;
                                          updateLocation(
                                              id: id,
                                              locationName:
                                                  delivaryLocName.value);

                                          // delivaryLocId.value = item['id'] as String;
                                          // delivaryLat.value = item['latitude'] as double;
                                          // delivaryLong.value = item['longitude'] as double;

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
                                            text: '${item['locationName']}',
                                            bold: true,
                                            fontSize: 15,
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
        srcLoccation.value = '';
        locations.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

//get Project Name  Api Integrate
  void getProjectName() async {
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

    // kLog(res.data);
    final pojectInfo = res.data['data']
        .map((json) {
          final item = ProjectDropdown.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<ProjectDropdown>() as List<ProjectDropdown>;
    projectNameList.clear();
    projectNameList.addAll(pojectInfo);
  }

  getDeliveryLocation() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;

    final params = {
      'username': username,
      'agencyIds': selectedAgency!.agencyId,
      'projectId': projectId.value,
      'projectCode': 'BDAWIFI', // projectCode.value,
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
    };

    final res = await getDynamic(
        path: ApiEndpoint.getmaterialDeliveryLocUrl(), queryParameters: params);

    final data = res.data['data']
        .map((json) {
          final item =
              MaterialLocationPlanning.fromJson(json as Map<String, dynamic>);
          item.id = getUniqeId();
          item.geograpphy = [];
          return item;
        })
        .toList()
        .cast<MaterialLocationPlanning>() as List<MaterialLocationPlanning>;

    itemList.clear();
    itemList.addAll(data);
    isLoading.value = false;
  }

  getDeliveryGeographyLocation({
    required String levelFullCode,
    required String id,
  }) async {
    isLoadding.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final params = {
      'agencyId': selectedAgency!.agencyId,
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'projectId': projectId.value,
      'projectCode': 'BDAWIFI', // projectCode.value,
      'levelFullcode': levelFullCode,
    };
    final res = await getDynamic(
        path: ApiEndpoint.getDeliveryGeographyLocUrl(),
        queryParameters: params);

    //  final data = res.data['data'] as List;

    final data = res.data['data']
        .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<Geograpphy>() as List<Geograpphy>;

    // kLog(res.data);
    if (data.isNotEmpty) {
      // geoList.clear();
      // geoList.addAll(data);

      final item = itemList.singleWhere((x) => x.id == id);

      item.geograpphy!.addAll(data);

      itemList[itemList.indexOf(item)] = item;
    }
    isLoadding.value = false;
  }

//Known Location Api Integrate
  searchUserDefinedLoc() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': srcLoccation.value,
      'uiCodes': ['122011'],
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SHOUT'
    };
    final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_GIS']}/search_user_defined_location',
        body: body);

    final data = res.data['data'] as List;

    if (data.isNotEmpty) {
      locations.clear();
      locations.addAll(data);
    }
    isLoading.value = false;
  }

  pickData() async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${kMapController.center.latitude}&lon=${kMapController.center.longitude}&zoom=18&addressdetails=1';

    final res = await postDynamic(
      path: url,
    );

    final mapData = MapData.fromJson(res.data as Map<String, dynamic>);
    pickLocation.value = mapData;
  }

  Future<LocationData?> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  updateLocationCount({
    required String id,
  }) {
    final item = itemList.singleWhere((x) => x.id == id);

    item.dropLocationCount = getGeograpphyDataById(id: id)!.length;

    itemList[itemList.indexOf(item)] = item;
  }

  updateLocation({
    required String id,
    required String locationName,
  }) {
    final item = itemList.singleWhere((x) => x.id == id);

    item.dropLocName = locationName;

    itemList[itemList.indexOf(item)] = item;
  }

  updateGeophaphyList({
    required String id,
    required Geograpphy x,
  }) {
    final item = itemList.singleWhere((x) => x.id == id);

    item.geograpphy!.add(x);

    itemList[itemList.indexOf(item)] = item;

    // kLog(id);
  }

  deleteupdateGeophaphyList({
    required String id,
    required Geograpphy x,
  }) {
    final item = itemList.singleWhere((x) => x.id == id);

    item.geograpphy!.remove(x);

    itemList[itemList.indexOf(item)] = item;

    // kLog(id);
  }

  List<Geograpphy>? getGeograpphyDataById({required String id}) {
    final item = itemList.singleWhere((x) => x.id == id);

    return item.geograpphy;
  }
}
