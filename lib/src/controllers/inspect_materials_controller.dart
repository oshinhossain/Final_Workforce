import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/pages/main_page.dart';

import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/services/validation_service.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';

import '../helpers/hex_color.dart';
import '../helpers/image_compress.dart';
import '../helpers/route.dart';
import '../models/inspect_materials_to_transport.dart';
import '../models/transport_order_inspection_send.dart';
import 'agencyController.dart';

enum UpdateInputType { quantity, remark, foundItOkay }

class InspectMaterialsController extends GetxController
    with ApiService, ValidationService {
//checkbox
  // final orderLines1 = RxList<TransportOrderItemList>();

  final ImagePicker _picker = ImagePicker();

  final pickedImageMemory = Rx<Uint8List?>(null);

  final userImage = Rx<Uint8List?>(null);

  final isLoading = RxBool(false);

  //Basic data Tab
  final inspectMaterialsDate = RxString('');

  final transportOrder = Rx<InspectMaterialsTransportOrder?>(null);
  final transportOrderItemList =
      RxList<InspectMaterialsTransportOrderLines>([]);
  final orderLines = RxList<OrderLines>();

  // set setItem(TransportOrder item) => transportOrder.value = item;
  // setItemRaw(TransportOrder item) {
  //   transportOrder.value = item;
  // }

  //-------------------------------------
  //Evidence Tab
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

//Inspection Sending
  // --------------------------------
  final userName = RxString('');
  // final orderLines = RxList([]);
  final overAllRemarks = RxString('');
  final transportOrderId = RxString('');
  final transportOrderNo = RxString('');
  final agencyIds = RxList([]);

  //........................................

  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imagePicker.pickImage(
        source: ImageSource.camera,
      );
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);
      }

      pickedImage.value = File(pickedfile!.path);
      // File image

      // Image compress function
      final img = await compressFile(
        file: pickedImage.value,
      );
      print('image size ...............');
      print(img.readAsBytesSync().lengthInBytes / 1024);

      // Load compress image
      pickedImage.value = img;
      pickedImageMemory.value = await pickedImage.value!.readAsBytes();
      // imagefiles.value = pickedfile;

      imagefiles.add(pickedImage.value!);
      // back();

    } catch (e) {
      print('error while picking file.');
    }
  }

  //====================================================================
  // ******* Basic Data *******
  //====================================================================

  //transport order(get)
  void getTransportOrder(
      {required String transportOrderNo,
      required String transportOrderId}) async {
    try {
      final username = Get.put(UserController()).username;
      // ignore: unused_local_variable
      final params = {
        'transportOrderNo': transportOrderNo,
        // 'transportOrderNo': '221024.00001',
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
        final transportOrderData = InspectMaterialsTransportOrder.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (transportOrderData != null) {
          transportOrder.value = transportOrderData;
        }

        //---------------------------------------------------------------
        // ************ Add Material List **************
        //---------------------------------------------------------------
        final transportOrderLinesData = res.data['data']['transportOrderLines']
                .map((json) {
                  final item = InspectMaterialsTransportOrderLines.fromJson(
                      json as Map<String, dynamic>);

                  item.foundItOkayAtLoadingPoint = false;
                  item.inspectorFoundQuantityAtLoadingPoint = 0.0;
                  item.inspectorRemarkAtLoadingPoint = '';
                  return item;
                })
                .toList()
                .cast<InspectMaterialsTransportOrderLines>()
            as List<InspectMaterialsTransportOrderLines>;

        if (transportOrderLinesData != null) {
          transportOrderItemList.clear();
          transportOrderItemList.addAll(transportOrderLinesData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Materials *******
  //====================================================================

  void getMaterials({required String toNo}) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'toNo': toNo,
        'username': username,
      };

      // ignore: unused_local_variable
      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/item-list-by-transport-order-no/get',
        queryParameters: params,
      );

      // kLog('${res.data}');

      // final transportOrderData =
      //     TransportOrder.fromJson(res.data['data'] as Map<String, dynamic>);

      // if (transportOrderData != null) {
      //   transportOrder.value = transportOrderData;
      // }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Evidence attachment *******
  //====================================================================
  //evidence-attachment(post)
  // void postEvidenceAttachment({required String transportOrderid}) async {
  void postEvidenceAttachment(
      {required String transportOrderNo,
      required String transportOrderIds}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      for (var img in imagefiles) {
        //kLog('image path: ${img.path}');
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        //// kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_INSPECTION_SENDING',
          'ids': transportOrderIds,
          'originalFileNameNeeded': false,
          'files': attachments,
        },
      );

      await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );
      // // kLog(res);

      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

  // Select user avatar image
  void selectAvatar() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image!.path.isNotEmpty) {
      pickedImage.value = File(image.path);
      pickedImageMemory.value = await image.readAsBytes();
    }
  }
//=========================================================
//   **********
//=========================================================

  void updateItem(
    InspectMaterialsTransportOrderLines currentItem,
    UpdateInputType type,
    dynamic value,
  ) {
    final item =
        transportOrderItemList.singleWhere((x) => x.id == currentItem.id);

    switch (type) {
      case UpdateInputType.quantity:
        item.inspectorFoundQuantityAtLoadingPoint = num.parse(value.toString());

        transportOrderItemList[transportOrderItemList.indexOf(item)] = item;
        break;
      case UpdateInputType.remark:
        item.inspectorRemarkAtLoadingPoint = value as String;

        transportOrderItemList[transportOrderItemList.indexOf(item)] = item;
        break;
      case UpdateInputType.foundItOkay:
        item.foundItOkayAtLoadingPoint = value as bool;

        transportOrderItemList[transportOrderItemList.indexOf(item)] = item;

        //----------------------------------------------
        if (item.foundItOkayAtLoadingPoint == true) {
          item.inspectorFoundQuantityAtLoadingPoint = item.baseUomQuantity;

          transportOrderItemList[transportOrderItemList.indexOf(item)] = item;
        } else {
          item.inspectorFoundQuantityAtLoadingPoint = 0;

          transportOrderItemList[transportOrderItemList.indexOf(item)] = item;
        }

        // kLog(item.inspectorFoundQuantityAtLoadingPoint);

        break;
    }
  }

//=========================================================
//
//=========================================================

  void addInspectionSending() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final get = transportOrderItemList.map((element) => element).toList();
      final body = {
        'transportOrderId': get[0].transportOrderId,
        'transportOrderNo': get[0].transportOrderNo,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SURVEY',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'orderLines': transportOrderItemList.map((item) {
          return {
            'id': item.id,
            'foundItOkayAtLoadingPoint': item.foundItOkayAtLoadingPoint,
            'inspectorFoundQuantityAtLoadingPoint':
                item.inspectorFoundQuantityAtLoadingPoint,
            'inspectorRemarkAtLoadingPoint': item.inspectorRemarkAtLoadingPoint
          };
        }).toList(),
        'overAllRemarks': overAllRemarks.value,
      };

      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/inspection/sending',
        body: body,
      );
      // log('${res.data}');

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
        transportOrderItemList.clear();
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
      transportOrderItemList.clear();
      get.clear();
      overAllRemarks.value = '';
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
//