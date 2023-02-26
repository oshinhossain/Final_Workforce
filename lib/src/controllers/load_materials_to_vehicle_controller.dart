import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:collection/collection.dart' show IterableExtension;

import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/uniqe_id.dart';
import '../models/load_materials_to_vehicle.dart';
import '../services/api_service.dart';
import '../services/validation_service.dart';
import '../helpers/get_file_name.dart';
import '../helpers/route.dart';
import '../models/load_materials_vehicle_items.dart';
import '../models/load_materials_vehicle_items_list.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

enum UpdateLoadMaterialsToVehicleInputType { weight, quantity }

class LoadMaterialsToVehicleController extends GetxController
    with ApiService, ValidationService {
  final remarks = RxString('');
  final pickedImageMemory = Rx<Uint8List?>(null);

  final userImage = Rx<Uint8List?>(null);

  final isDragging = RxBool(false);
  final isLoading = RxBool(false);

  final selectVehicle = RxBool(false);

  //Basic data Tab
  final loadMaterialVehicleDate = RxString('');

  // LoadMaterialsTransportOrder? get transportOrderItem => transportOrder.value;
  // set setItem(TransportOrder item) => transportOrder.value = item;
  // setItemRaw(TransportOrder item) {
  //   transportOrder.value = item;
  // }
  final transportOrder = Rx<LoadMaterialsTransportOrder?>(null);
  final transportOrderVehicle = RxList<LoadMaterialsVehicle>([]);
  final transportOrderItemList = RxList<LoadMaterialsItemList>([]);

  //add list item to vehicle item
  final loadMaterialsVehicleItems = RxList<LoadMaterialsVehicleItems>([]);
  final vehicleItem = RxList<LoadMaterialsItemList>([]);

  final vehicleRegNo = RxString('');
  //-------------------------------------

  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final imagefiles = RxList<XFile>([]);

  final loadMaterialsEvidence = RxList<LoadMaterialsVehicleEvidence>([]);
  //-------------------------------------

  //-------------------------------------
  final data = RxList<int>([1, 2, 3]);
  final data2 = RxList<int?>([]);
  //-------------------------------------

  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        // imagefiles.value = pickedfile;
        pickedImage.value = pickedfile;
        imagefiles.add(pickedfile);
        // back();
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  //====================================================================
  // ******* Load Evidence *******
  //====================================================================

  Future<void> pickEvidenceImageByRegNo({required String regNo}) async {
    try {
      var pickedfile = await imgpicker.pickImage(source: ImageSource.camera);

      if (pickedfile != null) {
        // pickedImage.value = pickedfile;
        // imagefiles.add(pickedfile);
        var id = Uuid().v4();
        //Add local storage
        final fileName = getExt(path: pickedfile.path);
        loadMaterialsEvidence.add(
          LoadMaterialsVehicleEvidence(
            id: id,
            imagePath: pickedfile.path,
            fileName: fileName,
            registrationNo: regNo,
          ),
        );
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  Iterable<LoadMaterialsVehicleEvidence> getEvidenceByRegNo(
      {required String regNo}) {
    final image =
        loadMaterialsEvidence.where((item) => item.registrationNo == regNo);

    return image;
  }

  //====================================================================
  // ******* Basic Data *******
  //====================================================================
  void getTransportOrder({required String transportOrderNo}) async {
    try {
      final username = Get.put(UserController()).username;
      // ignore: unused_local_variable
      final params = {
        'transportOrderNo': transportOrderNo,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/get?transportOrderNo=$transportOrderNo&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&username=$username&status',
        // queryParameters: params,
      );

      //// kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final transportOrderData = LoadMaterialsTransportOrder.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (transportOrderData != null) {
          transportOrder.value = transportOrderData;
        }

        //-------------------------------------------------
        // add transport order lines
        //-------------------------------------------------
        final transportOrderItemListData = res.data['data']
                ['transportOrderLines']
            .map((json) =>
                LoadMaterialsItemList.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<LoadMaterialsItemList>() as List<LoadMaterialsItemList>;

        if (transportOrderItemListData.isNotEmpty) {
          transportOrderItemList.clear();
          transportOrderItemList.addAll(transportOrderItemListData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //Get transport order vehicle
  void getTransportOrderVehicle({required String transportOrderNo}) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'toNo': transportOrderNo,
        'apikey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        //'type': 'ITS'
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order-vehicle/get',
        queryParameters: params,
      );
      // print(res.data);

      final transportOrderVehicleData = res.data['data']
          .map((json) =>
              LoadMaterialsVehicle.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<LoadMaterialsVehicle>() as List<LoadMaterialsVehicle>;

      if (transportOrderVehicleData.isNotEmpty) {
        transportOrderVehicle.clear();

        transportOrderVehicle.addAll(transportOrderVehicleData);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //item list by transport order no
  void getItemListByTransportOrderNo({required String transportOrderNo}) async {
    // try {
    //   final selectedAgency = Get.put(AgencyController()).selectedAgency;
    //   final username = Get.put(UserController()).username;
    //   final params = {
    //     'agencyIds': selectedAgency!.agencyId,
    //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
    //     'appCode': 'WFC',
    //     'toNo': transportOrderNo,
    //     'username': username,
    //   };
    //   print(selectedAgency.agencyId);
    //   print(username);
    //   print(transportOrderNo);

    // final res = await getDynamic(
    //   path:
    //       '${dotenv.env['BASE_URL_WFC']}/v1/item-list-by-transport-order-no/get',
    //   queryParameters: params,
    // );
    //   // print(res.data);
    //   // log('${res.data}');
    //   log('item-list::${res.data['data'].length}');

    //   final transportOrderItemListData = res.data['data']
    //       .map((json) =>
    //           LoadMaterialsItemList.fromJson(json as Map<String, dynamic>))
    //       .toList()
    //       .cast<LoadMaterialsItemList>() as List<LoadMaterialsItemList>;

    //   if (transportOrderItemListData.isNotEmpty) {
    //     transportOrderItemList.clear();
    //     transportOrderItemList.addAll(transportOrderItemListData);
    //   }
    // } on DioError catch (e) {
    //   print(e.message);
    // }
  }

  //====================================================================
  // ****** Load materials item to vehicles vehicle item ******
  //====================================================================

  // Add load material item to vehicle items
  addListItemToVehicle({
    LoadMaterialsItemList? item,
    required String regId,
  }) {
    var id = Uuid().v4();
    final droppedAt = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final vehicle =
        transportOrderVehicle.singleWhere((x) => x.registrationNo == regId);

    loadMaterialsVehicleItems.add(
      LoadMaterialsVehicleItems(
        id: id,
        registrationNo: regId,
        vehicleItems: LoadMaterialsVehicleItemsList(
          orderId: transportOrder.value!.id,
          orderNo: transportOrder.value!.transportOrderNo,
          orderDate: transportOrder.value!.transportOrderDate,
          vehicleType: vehicle.vehicleType,
          vehicleId: vehicle.id,
          capacity: vehicle.capacity,
          model: vehicle.model,
          brand: vehicle.brand,
          registrationNo: vehicle.registrationNo,
          typeOfFuel: 'petrol, octan',
          driverUsername: vehicle.driverUsername,
          driverFullname: vehicle.driverFullname,
          driverMobile: vehicle.driverMobile,
          driverEmail: vehicle.driverEmail,
          productName: item!.productName,
          id: item.id,
          productCode: item.productCode,
          lineNo: item.lineNo,
          productSerial: item.productSerial,
          baseUom: item.baseUom,
          productId: item.productCode,
          weightKg: item.weightKg,
          loaded: true,
          loadedAt: droppedAt,
          loadedQuantity: item.baseUomQuantity,
          distanceKm: item.distanceKm,
        ),
      ),
    );
  }

  checkVehicleCapacity({required String regId}) {
    num sum = 0.0;
    // ignore: unused_local_variable
    num capacity = 350.0;
    final item =
        transportOrderVehicle.singleWhere((x) => x.registrationNo == regId);

    if (loadMaterialsVehicleItems.isNotEmpty && item.weightCapacity! > 0.0) {
      final itemList = loadMaterialsVehicleItems
          .where((element) => element.registrationNo == regId)
          .toList();

      for (var x in itemList) {
        sum += x.vehicleItems!.weightKg!;
      }
      // kLog(item.weightCapacity);
      // kLog(sum);
      final total = item.weightCapacity! - sum;
      // kLog(total);

      if (total > 0.0) {
        // kLog('value');
      } else {
        // kLog('value 3');
      }
    }
    // kLog(item.capacity);
  }

//=========================================================
//   **********
//=========================================================

  void updateItem(
    String id,
    UpdateLoadMaterialsToVehicleInputType type,
    dynamic value,
  ) {
    // ignore: unused_local_variable
    final item = loadMaterialsVehicleItems
        .singleWhere((x) => x.vehicleItems!.orderId == id);
    // kLog(item);

    // switch (type) {
    //   case UpdateLoadMaterialsToVehicleInputType.quantity:
    //     item.vehicleItems!.baseUomQuantity = value as double;

    //     loadMaterialsVehicleItems[loadMaterialsVehicleItems.indexOf(item)] =
    //         item;

    //    // kLog(item.vehicleItems!.baseUomQuantity);
    //     break;
    //   case UpdateLoadMaterialsToVehicleInputType.weight:
    //     item.vehicleItems!.weightKg = value as double;

    //     loadMaterialsVehicleItems[loadMaterialsVehicleItems.indexOf(item)] =
    //         item;

    //    // kLog(item.vehicleItems!.weightKg);
    //     break;
    // }
  }

  //========================================================

  //Vehicle registrationNo is exist or not
  isVehicleRegNoExist(String regNo) {
    final reg = loadMaterialsVehicleItems
        .singleWhereOrNull(((item) => item.registrationNo == regNo));
    return reg != null ? true : false;
  }

  //Get item from Vehicle items
  List<LoadMaterialsVehicleItems> getListItemFormVehicleItemList(
    String regNo,
  ) {
    return loadMaterialsVehicleItems
        .where((element) => element.registrationNo == regNo)
        .toList();
  }

  //====================================================================
  // ******* Evidence attachment add *******
  //====================================================================

  Future<List<MultipartFile>> getImagesByRegId(String regId) async {
    final attachments = <MultipartFile>[];
    for (var i = 0; i < loadMaterialsEvidence.length; i++) {
      if (loadMaterialsEvidence[i].registrationNo == regId) {
        final fileName = getExt(path: loadMaterialsEvidence[i].imagePath!);

        attachments.add(await MultipartFile.fromFile(
          loadMaterialsEvidence[i].imagePath!,
          filename: '${getUniqeId()}$fileName',
        ));
      }
    }
    // // kLog('image length: ${attachments.length}');
    return attachments;
  }

  void postEvidenceAttachment({
    required String registrationNo,
    required String id,
  }) async {
    //// kLog(registrationNo);
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      final username = Get.put(UserController()).username;
      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_LOADING',
          'ids': id,
          'originalFileNameNeeded': false,
          'registrationNo': registrationNo,
          'files': await getImagesByRegId(registrationNo),
        },
      );
      //// kLog(jsonEncode(data));
      // print(data.fields);

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );
      // kLog(res);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ****** Load materials vehicles add ******
  //====================================================================

  void postLoadMaterialsVehicles() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final data = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'modelList': loadMaterialsVehicleItems.map((item) {
          return {
            // {
            //   'lineId': item.vehicleItems!.orderId,
            //   'vehicleId': '0ed65285-f5bf-4c7f-af82-0863aa0f938d',
            //   'vehicleType': 'ad',
            //   'brand': 'corolla',
            //   'capacity': '50 ton',
            //   'model': 'v-model',
            //   'registrationNo': 'dhaka metro 78',
            //   'typeOfFuel': 'petrol,octan',
            //   'driverUsername': 'tushar07',
            //   'driverFullname': 'Tushar',
            //   'driverMobile': '01815028584',
            //   'driverEmail': 'amin@php.com',
            //   'loaded': true,
            //   'loadedAt': '2022-09-21',
            //   'loadedQuantity': '100',
            //   'distanceKm': '50.0'
            // },

            'lineId': item.vehicleItems!.id,
            'vehicleId': item.vehicleItems!.vehicleId,
            'vehicleType': item.vehicleItems!.vehicleType,
            'brand': item.vehicleItems!.brand,
            'capacity': item.vehicleItems!.capacity,
            'model': item.vehicleItems!.model,
            'registrationNo': item.registrationNo,
            'typeOfFuel': item.vehicleItems!.typeOfFuel,
            'driverUsername': item.vehicleItems!.driverUsername,
            'driverFullname': item.vehicleItems!.driverFullname,
            'driverMobile': item.vehicleItems!.driverMobile,
            'driverEmail': item.vehicleItems!.driverEmail,
            'loaded': item.vehicleItems!.loaded,
            'loadedAt': item.vehicleItems!.loadedAt,
            'loadedQuantity': item.vehicleItems!.loadedQuantity,
            'distanceKm': item.vehicleItems!.distanceKm.toString(),
            'weightCapacity': item.vehicleItems!.weightKg,
            // 'weightCapacityUnit':item
          };
        }).toList(),
      };
      // kLog(data);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/load-materials-to-vehicles/add',
        body: data,
      );
      // print(res.data['status']);
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
        loadMaterialsVehicleItems.clear();
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
      loadMaterialsVehicleItems.clear();
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //------------------------------- End --------------------------------
}
