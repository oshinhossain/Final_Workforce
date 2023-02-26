import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/helpers/image_compress.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/services/validation_service.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';
import '../helpers/hex_color.dart';
import '../helpers/route.dart';
import '../helpers/uniqe_id.dart';
import '../models/confirm_transport_readiness.dart';
import '../models/travel_path.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class ConfirmTransportReadinessController extends GetxController
    with ApiService, ValidationService {
  final isLoading = RxBool(false);
  final remarks = RxString('');

  //Basic data Tab

  final vehicleInfo = Rx<ConfirmTransportReadinessByDriver?>(null);
  final itemList = RxList<TransportOrderLoadingModels>([]);

  //Travel Path
  final travelPathConfirm = Rx<TravelPath?>(null);

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
      var pickedfile = await imgpicker.pickImage(source: ImageSource.camera);
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
  void getDriverConfirmTransportReadiness(
      {required String transportOrderNo}) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyId': selectedAgency!.agencyId,
        'username': username,
        'toNo': transportOrderNo,
        'userType': 'DRIVER',
        'vehicleRegistrationNo': '',
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/load-materials/get',
        queryParameters: params,
      );
      //// kLog(res.data);

      //Add vehicleInfo
      //----------------------------------------------------------
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final confirmTransportReadinessByDriverData =
            ConfirmTransportReadinessByDriver.fromJson(
                res.data['data'] as Map<String, dynamic>);

        if (confirmTransportReadinessByDriverData != null) {
          isLoading.value = false;
          vehicleInfo.value = confirmTransportReadinessByDriverData;
        }
        // log('${vehicleInfo.value!.driverFullname}');

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
        // log('${itemList.length}');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Evidence attachment add *******
  //====================================================================

  Future<List<MultipartFile>> getImagesByRegId(String regId) async {
    final attachments = <MultipartFile>[];
    for (var img in imagefiles) {
      final fileName = getExt(path: img.path);
      attachments.add(await MultipartFile.fromFile(
        img.path,
        filename: fileName,
      ));
    }
    return attachments;
  }

  void postEvidenceAttachment(
      {required String registrationNo, String? id}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      final username = Get.put(UserController()).username;
      final attachments = <MultipartFile>[];

      for (var img in imagefiles) {
        final fileName = getExt(path: img.path);

        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));
      }

      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_SENDER_READINESS',
          'ids': id,
          'originalFileNameNeeded': false,
          'files': attachments,
          'registrationNo': registrationNo,
        },
      );

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );
      // kLog(res);
      imagefiles.clear();
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ****** Load materials vehicles add ******
  //====================================================================

  void postDriverConfirmTransportReadiness({
    required String transportOrderNo,
    required String registrationNo,
  }) async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final data = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'confirmBy': 'driver',
        'transportOrderNo': transportOrderNo,
        'registrationNo': registrationNo,
        // 'transportOrderNo': '221018.00001',
        // 'registrationNo': 'dhaka metro 95',
        'remarks': remarks.value
      };
      //// kLog(data);

      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/confirm-readiness',
        body: data,
      );

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
      remarks.value = ' ';
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //------------------------------- End --------------------------------
}
