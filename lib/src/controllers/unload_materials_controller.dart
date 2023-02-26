// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/helpers/get_file_name.dart';

import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/unload_material.dart';
import 'package:workforce/src/services/api_service.dart';

import '../config/app_theme.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/image_compress.dart';
import '../helpers/route.dart';
import '../models/confirm_transport_readiness.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class UnloadMaterialsController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  final remarks = RxString('');

  //-------------------------------------
  final unloadMaterial = Rx<ConfirmTransportReadinessByDriver?>(null);
  final unloaditemList = RxList<TransportOrderLoadingModels>([]);
  final unloadNewList = RxList<UnloadModel>([]);

  final pickedImageMemory = Rx<Uint8List?>(null);
  final ImagePicker _picker = ImagePicker();
  final userImage = Rx<Uint8List?>(null);
  //-------------------------------------
  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(
        source: ImageSource.camera,
      );
//you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);

// File image

// Image compress function
        final img = await compressFile(
          file: pickedImage.value,
        );

// Load compress image
        pickedImage.value = img;
        pickedImageMemory.value = await pickedImage.value!.readAsBytes();
// imagefiles.value = pickedfile;

        imagefiles.add(pickedImage.value!);
// back();
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  void postEvidenceAttachment(
      {required String transportOrderId,
      required String registrationNo}) async {
    //  final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;

    try {
      isLoading.value = true;

      List<MultipartFile> attachments = [];

      for (var img in imagefiles) {
        final ext = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$ext',
        ));
      }
      //// kLog(attachments.length);

      final data = FormData.fromMap(
        {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_UNLOADING',
          'ids': transportOrderId,
          'originalFileNameNeeded': false,
          'registrationNo': registrationNo,
          'files': attachments,
        },
      );

      //// kLog(data.fields);

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: ApiEndpoint.evedenseSave(),
        body: data,
      );

      // kLog(data);
      // kLog(res.data);
      // kLog(res.data['status']);
      // kLog('${data.fields}');
    } on DioError catch (e) {
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

//Get Unload Material
  void unloadMaterialsGet({required String transportOrderNo}) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;

      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'toNo': transportOrderNo,
        'userType': 'DRIVER',
        'vehicleRegistrationNo': '',
      };

      final res = await getDynamic(
        path: ApiEndpoint.getUnloadMaterial(),
        queryParameters: params,
      );

      // if (res.data['status'] != null &&
      //     res.data['status'].contains('successful') == true) {
      //   final unloadMaterialX =
      //       UnloadMaterial.fromJson(res.data['data'] as Map<String, dynamic>);
      //   unloadMaterial.value = unloadMaterialX;

      //   // Add item list
      //   final itemListData = res.data['data']['itemList']
      //       .map((json) => ItemList.fromJson(json as Map<String, dynamic>))
      //       .toList()
      //       .cast<ItemList>() as List<ItemList>;

      //   unloaditemList.clear();
      //   unloaditemList.addAll(itemListData);
      // }
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final confirmTransportReadinessByDriverData =
            ConfirmTransportReadinessByDriver.fromJson(
                res.data['data'] as Map<String, dynamic>);

        if (confirmTransportReadinessByDriverData != null) {
          isLoading.value = false;
          unloadMaterial.value = confirmTransportReadinessByDriverData;
        }

        //Add item list
        //----------------------------------------------------------
        final itemListData = res.data['data']['transportOrderLoadingModels']
            .map((json) => UnloadModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<UnloadModel>() as List<UnloadModel>;

        // kLog(jsonEncode(itemListData));

        if (itemListData.isNotEmpty) {
          isLoading.value = false;
          unloadNewList.clear();
          unloadNewList.addAll(itemListData);
        }
        // log('${itemList.length}');
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//Confrim Unload Material
  void unloadMaterialsConfirm() async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'remarks': remarks.value,
        'itemList': unloadNewList.map((item) {
          return {
            'id': item.id,
            'droppedQuantity': item.droppedQuantity,
          };
        }).toList(),
      };
      // kLog(body);

      final res = await postDynamic(
        path: ApiEndpoint.confirmUnloadMaterial(),
        body: body,
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
      remarks.value = '';
      unloaditemList.clear();
    } on DioError catch (e) {
      print(e.message);
    }
  }

//Update dropped Quantity
  updateItem(
    UnloadModel currentItem,
    double value,
  ) {
    final item = unloadNewList.singleWhere((x) => x.id == currentItem.id);

    item.droppedQuantity = value;

    unloadNewList[unloadNewList.indexOf(item)] = item;
    // // kLog(jsonEncode(unloaditemList));
  }
}
