import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/helpers/image_compress.dart';

import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/services/validation_service.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';
import '../helpers/hex_color.dart';
import '../helpers/route.dart';
import '../models/confirm_recipient_readiness.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

enum UpdateDropLocationInputType { quantity, remark, foundItOkay }

class InspectMaterialsAtDropLocationController extends GetxController
    with ApiService, ValidationService {
  final overAllRemarks = RxString('');
  final isLoading = RxBool(false);

  //Basic data Tab

  // final vehicleInfo = Rx<VehicleInfo?>(null);
  // final itemList = RxList<ItemList>([]);
  //--------------------------------
  final vehicleInfo = Rx<ConfirmRecipientReadiness?>(null);
  final itemList = RxList<TransportOrderLoadingModels>([]);

  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

  //====================================================================
  // ******* Load Evidence *******
  //====================================================================
  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(
          source: ImageSource.camera, imageQuality: 10);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        // imagefiles.value = pickedfile;
        pickedImage.value = pickedfile;
        final img = await compressFile(file: File(pickedImage.value!.path));
        imagefiles.add(img);
        // back();
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  //====================================================================
  // ******* Basic Data *******
  //====================================================================

  // Confirm Transport Readiness (by the driver)
  void getInspectMaterialsDropLocation({
    required String transportOrderNo,
    required String vehicleRegistrationNo,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      // ignore: unused_local_variable
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyId': selectedAgency!.agencyId,
        'username': username,
        'toNo': transportOrderNo,
        'userType': 'INSPECTOR',
        'vehicleRegistrationNo': vehicleRegistrationNo
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/load-materials/get',
        queryParameters: params,
      );
      //// kLog(res.data['data']['transportOrderLoadingModels']);

      //Add vehicleInfo
      //----------------------------------------------------------
      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true &&
          res.data['data'] != null) {
        final vehicleInfoData = ConfirmRecipientReadiness.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (vehicleInfoData != null) {
          isLoading.value = false;
          vehicleInfo.value = vehicleInfoData;
        }
        // log('${vehicleInfo.value!.driverFullname}');

        //----------------------------------------------------------
        //Add item list
        //----------------------------------------------------------
        final itemListData = res.data['data']['transportOrderLoadingModels']
                .map((json) => TransportOrderLoadingModels.fromJson(
                    json as Map<String, dynamic>))
                .toList()
                .cast<TransportOrderLoadingModels>()
            as List<TransportOrderLoadingModels>;

        if (itemListData.isNotEmpty) {
          isLoading.value = false;
          itemList.clear();
          itemList.addAll(itemListData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Evidence attachment add *******
  //====================================================================

  // Future<List<MultipartFile>> getImagesByRegId(String regId) async {
  //   final attachments = <MultipartFile>[];
  //   for (var img in imagefiles) {
  //     final fileName = getExt(path: img.path);
  //     attachments.add(await MultipartFile.fromFile(
  //       img.path,
  //       filename: '${getUniqeId()}$fileName',
  //     ));
  //   }
  //   return attachments;
  // }

  void postEvidenceAttachment(
      {required String transportOrderNo,
      required String transportOrderIds,
      required String registrationNo}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      for (var img in imagefiles) {
        //// kLog('image path: ${img.path}');
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // // kLog('attachment length: ${attachments.length}');

      }

      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_INSPECTION_RECEIVED',
          'ids': transportOrderIds,
          'originalFileNameNeeded': false,
          'files': attachments,
          'registrationNo': registrationNo,
        },
      );
      //// kLog(data.fields);

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      // kLog(res);
      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

//=========================================================
//   **********
//=========================================================

  void updateItem(
    TransportOrderLoadingModels currentItem,
    UpdateDropLocationInputType type,
    dynamic value,
  ) {
    final item = itemList.singleWhere((x) => x.id == currentItem.id);

    switch (type) {
      case UpdateDropLocationInputType.quantity:
        item.inspectorFoundQuantityAtDroppingPoint = value as double;

        itemList[itemList.indexOf(item)] = item;
        break;
      case UpdateDropLocationInputType.remark:
        item.inspectorRemarkAtDroppingPoint = value as String;

        itemList[itemList.indexOf(item)] = item;
        break;
      case UpdateDropLocationInputType.foundItOkay:
        item.foundItOkayAtDroppingPoint = value as bool;

        itemList[itemList.indexOf(item)] = item;
        break;
    }
  }

//=========================================================
// Transport Order Inspection Receiving
//=========================================================

  void postInspectMaterialsDropLocationData({
    required String transportOrderNo,
    required String transportOrderId,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final data = {
        'transportOrderId': transportOrderId,
        'transportOrderNo': transportOrderNo,
        // 'transportOrderId': vehicleInfo.value!.orderId,
        // 'transportOrderNo': vehicleInfo.value!.orderNo,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SURVEY',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'orderLoadingrs': itemList.map((item) {
          return {
            'id': item.id,
            // 'vehicleId': vehicleInfo.value!.registrationNo,
            // 'id': 'ec14950f-a801-40ce-804b-79dddbc080cc',
            'vehicleId': '',
            'foundItOkayAtDroppingPoint': item.foundItOkayAtDroppingPoint,
            'inspectorFoundQuantityAtDroppingPoint':
                item.inspectorFoundQuantityAtDroppingPoint,
            'inspectorRemarkAtDroppingPoint':
                item.inspectorRemarkAtDroppingPoint,
          };
        }).toList(),
        // 'orderLoadingrs': [
        //   {
        //     'id': 'ec14950f-a801-40ce-804b-79dddbc080cc',
        //     'vehicleId': '',
        //     'foundItOkayAtDroppingPoint': true,
        //     'inspectorFoundQuantityAtDroppingPoint': '25.6',
        //     'inspectorRemarkAtDroppingPoint': 'Quality good'
        //   }
        // ],
        'overAllRemarks': overAllRemarks.value
      };
      // kLog(data);

      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/inspection/receiving',
        body: data,
      );

      // print(res);
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
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () => back(),
        );
        await 6.delay();
        back();
      }
      isLoading.value = false;
      overAllRemarks.value = '';
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //------------------------------- End --------------------------------
}
