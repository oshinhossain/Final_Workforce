import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import 'package:workforce/src/controllers/user_controller.dart';

import '../config/api_endpoint.dart';
import '../config/app_theme.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../helpers/uniqe_id.dart';
import '../models/assign_vehicle_add.dart';
import '../models/history_image_count_model.dart';
import '../models/vehicle.dart';
import '../services/api_service.dart';
import '../models/assign_vehicle_and_driver.dart';
import '../models/travel_path.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';

class AssignVehicleDriverController extends GetxController with ApiService {
  final srcVehicle = RxString('');
  final isLoading = RxBool(false);
  final tempDriver = RxList<Driver>();

  final search = RxString('');
  final vechileImageCount = RxList<VechicleImageModel>();
  final selectedvechileImageCount = RxList<VechicleImageModel>();
  final tempVehicle = RxList<Vehicle>();

  //---------------------------------------
  final vehicleList = RxList<Vehicle>();

  final driverList = RxList<Driver>();

  //======================================
  final modelList = RxList<AssignVehicleAdd>([]);

  //======================================

  //Travel Path
  final travelPath = Rx<TravelPath?>(null);

  // final driverList = RxList<Driver>();

  final transportOrder = Rx<AssignVehicleTransportOrder?>(null);
  final transportOrderLines = RxList<TransportOrderLines?>([]);

  //=============================================================
  // ************  vehicle Image Get Api ************
  //=============================================================

  // Future<String> checkImageVechile(String reg) async {
  //   final username = Get.put(UserController()).username;
  //   final locationC = Get.put(LocationController());
  //   final selectedAgency = Get.put(AgencyController()).selectedAgency;

  //   var params = {
  //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //     'appCode': 'ITS',
  //     'countryCode': selectedAgency!.countryCode,
  //     'latLng': '${locationC.latLng}',
  //     'username': username,
  //     'fileCategory': 'FILE_CATEGORY_VEHICLE_PHOTO',
  //     'projectId': '',
  //     'geoLevelId': '',
  //     'siteId': '',
  //     'activityId': '',
  //     'supportId': '',
  //     'progressId': '',
  //     'ids': '',
  //     'originalFileNameNeeded': '',
  //     'registrationNo': reg,
  //     'status': '',
  //     'flag': 1,
  //   };

  //   //// kLog(pragma);
  //   final res = await getDynamic(
  //       path:
  //           'http://123.200.22.150:9020/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=&originalFileNameNeeded=&registrationNo=$reg&status=&flag=1'
  //       // path: '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get',
  //       // queryParameters: params,
  //       );

  //  // kLog(res.data['responseCode']);
  //  // kLog(res.statusCode);
  //  // kLog(reg);

  //   return (res.data['responseCode'].toString());
  // }

  getFileCount() async {
    try {
      isLoading.value = true;
      vechileImageCount.clear();
      for (var element in tempVehicle) {
        // kLog(element.id);

        final selectedAgency = Get.put(AgencyController()).selectedAgency;
        final username = Get.put(UserController()).username;
        final params = {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': 'ITS',
          'agencyId': selectedAgency!.agencyId,
          //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
          'username': username,
          'fileCategory': 'FILE_CATEGORY_VEHICLE_PHOTO',
          'fileRefId': '',
          // 'fileRefId': '',
          'fileRefNo': element.registrationNo,

          'fileEntryUsername': ''
        };
        //// kLog(params);
        // return;
        final res = await getDynamic(
          path: ApiEndpoint.getFileCount(),
          queryParameters: params,
        );
        //kLog('**************0 ${res.data['data']['fileCount']}');

        vechileImageCount.add(VechicleImageModel(
          regNo: element.registrationNo!,
          imageCount: res.data['data']['fileCount'].toString(),
        ));

        isLoading.value = false;
      }
      // ignore: unused_local_variable
      for (var element in vechileImageCount) {
        // kLog('image Count');
        // kLog('${element.regNo} ${element.imageCount}');
      }
    } on DioError catch (e) {
      print(e.message);
    }
//get history image
  }

  countImage() {
    // final count = vechileImageCount.where((x) => x.imageCount != 0.toString());
    for (var element in vechileImageCount) {
      if (element.imageCount != '0') {
        // kLog('Image');
      }
    }
  }

//..........................................................................

  //Get Transport Order
  void getTransportOrder({required String transportOrderNo}) async {
    try {
      final username = Get.put(UserController()).username;
      // ignore: unused_local_variable
      final params = {
        'transportOrderNo': transportOrderNo,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'status': null
      };

      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/get?transportOrderNo=$transportOrderNo&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&username=$username&status',
        //  queryParameters: params,
      );

      log('${res.data}');

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final transportOrderData = AssignVehicleTransportOrder.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (transportOrderData != null) {
          transportOrder.value = transportOrderData;
        }

        //---------------------------------------------------------------
        // ************ Add Material List **************
        //---------------------------------------------------------------
        final transportOrderLinesData = res.data['data']['transportOrderLines']
            .map((json) =>
                TransportOrderLines.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TransportOrderLines>() as List<TransportOrderLines>;

        if (transportOrderLinesData != null) {
          transportOrderLines.clear();
          transportOrderLines.addAll(transportOrderLinesData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //Search and add vehicle
  searchVehicle() async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    isLoading.value = true;
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': srcVehicle.value,
      'type': 'ITS',
    };

    //  print(body);

    final res = await postDynamic(
      path: ApiEndpoint.getVehiclesUrl(),
      body: body,
    );
    //// kLog(jsonEncode(res.data));
    final data = res.data['data']
        .map((json) => Vehicle.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<Vehicle>() as List<Vehicle>;
    tempVehicle.clear();
    tempVehicle.addAll(data);
    await getFileCount();

    isLoading.value = false;
  }

  deleteItem(Vehicle item) {
    vehicleList.remove(item);
  }

  searchDriver() async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    isLoading.value = true;
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': search.value,
      'type': 'ITS',
    };

    print(selectedAgency.agencyId);
    print(srcVehicle.value);
    print(username);

    final res = await postDynamic(
      path: ApiEndpoint.getDriverUrl(),
      body: body,
    );

    final data = res.data['data']
        .map((json) => Driver.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<Driver>() as List<Driver>;
    log('$data');

    tempDriver.clear();
    tempDriver.addAll(data);

    isLoading.value = false;
  }

  //=============================================================
  // ************ Add vehicle and update driver ************
  //=============================================================
  addVehicle({
    required Vehicle item,
  }) {
    var id = getUniqeId();
    modelList.add(AssignVehicleAdd(
      transportOrderId: transportOrder.value!.id,
      transportOrderNo: transportOrder.value!.transportOrderNo,
      transportOrderDate: transportOrder.value!.transportOrderDate,
      driverUsername: '',
      driverFullname: '',
      driverEmail: '',
      driverMobile: '',
      id: id,
      brand: item.brand,
      capacity: item.capacity.toString(),
      capacityUnit: item.capacityUnit,
      model: item.model,
      registrationNo: item.registrationNo,
      status: 'positive',
      vehicleType: item.vehicleType,
      weightCapacity: item.weightCapacity,
      weightCapacityUnit: item.weightCapacityUnit,
    ));
    selectedvechileImageCount.add(VechicleImageModel(
        regNo: item.registrationNo!,
        imageCount: vechileImageCount[vechileImageCount
                .indexWhere((element) => element.regNo == item.registrationNo)]
            .imageCount));
    print('seleceted vehicle image count');
    print(selectedvechileImageCount.length);
    // ignore: unused_local_variable
    for (var element in selectedvechileImageCount) {
      // kLog('${element.regNo} and ${element.imageCount}');
    }
  }

  void updateVehicleDriver({
    required Driver driver,
    required String id,
  }) {
    final item = modelList.singleWhere((x) => x.id == id);

    item.driverUsername = driver.driverUsername;
    item.driverFullname = driver.driverFullname;
    item.driverEmail = driver.driverEmail;
    item.driverMobile = driver.driverMobile;
    modelList[modelList.indexOf(item)] = item;
  }

  //------------------------------------------------------------------------------

  void postAssignVehicleDriver() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'modelList': modelList.map((item) {
          return {
            'transportOrderId': item.transportOrderId,
            'transportOrderNo': item.transportOrderNo,
            'transportOrderDate': item.transportOrderDate,
            'driverUsername': item.driverUsername,
            'driverFullname': item.driverFullname,
            'driverEmail': item.driverEmail,
            'driverMobile': item.driverMobile,
            'brand': item.brand,
            'capacity': '${item.capacity} ${item.capacityUnit}',
            'model': item.model,
            'registrationNo': item.registrationNo,
            'status': item.status,
            'vehicleType': item.vehicleType,
          };
        }).toList(),
      };

      //// kLog(body);

      final res = await postDynamic(
        path: ApiEndpoint.assignVehicleDriverAdd(),
        body: body,
      );
      // kLog(res.data['status']);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 6.delay();

        offAll(MainPage());
        modelList.clear();
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
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //------------------------------------------------------------------------------
  // *************** Assign vehicle driver travel path  ****************
  //------------------------------------------------------------------------------
  getAssignVehicleDriverTravelPath() async {
    try {
      final username = Get.put(UserController()).username;
      final params = {
        'id': '4cbb3eac-3368-4408-84d8-d51aeeff876d',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/travel-path/get',
        queryParameters: params,
      );

      final coordinates =
          jsonDecode(res.data['data']['polygon'] as String)['coordinates']
              as List;

      final travelPathData =
          TravelPath.fromJson(res.data['data'] as Map<String, dynamic>);
      travelPathData.points = convertLineString(coordinates);

      travelPath.value = travelPathData;

      //-------------------------------------------------

    } on DioError catch (e) {
      print(e.message);
    }
  }

  List<LatLng> convertLineString(List coordinates) {
    List<LatLng> points = [];

    for (final latLngValue in coordinates) {
      final item = LatLng(
        double.parse('${latLngValue[0]}'),
        double.parse('${latLngValue[1]}'),
      );
      points.add(item);
    }
    return points;
  }
  //------------------------------------------------------------------------------

  addVehicleBottomSheet() async {
    final username = Get.put(UserController()).username;
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
                  TextField(
                    onChanged: srcVehicle,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          searchVehicle();
                          //getFileCount();
                          // await 10.delay();
                          // countImage();
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      tempVehicle.isEmpty
                          ? KText(text: '')
                          : tempVehicle.length != vechileImageCount.length
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 130,
                                    ),
                                    Center(
                                      child: Loading(),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  height: 250,
                                  child: Obx(
                                    () => ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: tempVehicle.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        //// kLog('image length and vehicle length');
                                        //// kLog(tempVehicle.length +
                                        //     vechileImageCount.length);
                                        final item = tempVehicle[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            await addVehicle(
                                              item: item,
                                            );
                                            vehicleList.add(item);
                                            back();
                                            // if (modelList.every((element) =>
                                            //     element.registrationNo !=
                                            //     item.registrationNo)) {
                                            //   await addVehicle(
                                            //     item: item,
                                            //   );
                                            //   back();
                                            // } else {
                                            //   back();
                                            //   Get.snackbar(item.registrationNo!,
                                            //       'Vehicle Already Added');
                                            // }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            child: Container(
                                              width: Get.width,
                                              padding: EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.all(Radius.circular(5)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppTheme
                                                        .vehicleItemColor),
                                                color: hexToColor('#FFFFFF'),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 34,
                                                    width: Get.width,
                                                    // color: hexToColor('#FFE9CF'),
                                                    decoration: BoxDecoration(
                                                      // borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5)),
                                                      color: AppTheme
                                                          .vehicleItemColor,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: KText(
                                                            text: item
                                                                .registrationNo,
                                                            fontSize: 16,
                                                            color: hexToColor(
                                                                '#41525A'),
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors.white),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              KText(
                                                                text: 'Type: ',
                                                                fontSize: 14,
                                                                color: hexToColor(
                                                                    '#80939D'),
                                                                bold: false,
                                                              ),
                                                              KText(
                                                                text: item
                                                                    .vehicleType,
                                                                fontSize: 14,
                                                                bold: true,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              KText(
                                                                text: 'Brand: ',
                                                                fontSize: 14,
                                                                color: hexToColor(
                                                                    '#80939D'),
                                                                bold: false,
                                                              ),
                                                              KText(
                                                                text:
                                                                    item.brand,
                                                                fontSize: 14,
                                                                bold: true,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2,
                                                          top: 2,
                                                          bottom: 2,
                                                          right: 2),
                                                      height: 80,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppTheme
                                                                .vehicleItemColor),
                                                      ),
                                                      child: vechileImageCount
                                                              .isEmpty
                                                          ? Container()
                                                          : Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .white60),
                                                              child: SizedBox(
                                                                height: 100,
                                                                width: 140,
                                                                child: int.parse(vechileImageCount[vechileImageCount.indexWhere((element) =>
                                                                                element.regNo ==
                                                                                item.registrationNo)]
                                                                            .imageCount) >
                                                                        0
                                                                    ? ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        child: Image
                                                                            .network(
                                                                          '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=${locationC.latLng}&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item.id}&originalFileNameNeeded=&registrationNo=${item.registrationNo}&status=&flag=1',

                                                                          // '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              160,
                                                                          width:
                                                                              200,
                                                                        ),
                                                                      )
                                                                    : RenderSvg(
                                                                        path:
                                                                            'image_vehicle',
                                                                      ),
                                                              )),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        search.value = '';
        tempVehicle.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

//////////////
  ///
  addDriverBottomSheet({required String vehicleId}) async {
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
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchDriver();
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isLoading.value
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                ),
                                Center(
                                  child: Loading(),
                                )
                              ],
                            )
                          : tempDriver.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: tempDriver.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = tempDriver[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // driverList.clear();
                                          // driverList.add(item);
                                          updateVehicleDriver(
                                              driver: item, id: vehicleId);

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
                                            text: '${item.driverUsername}',
                                            bold: true,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        search.value = '';
        tempDriver.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }
}
