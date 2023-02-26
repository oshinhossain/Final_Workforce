import 'dart:io';
import 'dart:typed_data';
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
import '../models/confirm_material_receipt.dart';
import '../models/confirm_recipient_readiness.dart';
import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class ConfirmMaterialReceiptController extends GetxController
    with ApiService, ValidationService {
  final isLoading = RxBool(false);

  final remarks = RxString('');

  final pickedImageMemory = Rx<Uint8List?>(null);
  final ImagePicker _picker = ImagePicker();
  final userImage = Rx<Uint8List?>(null);
  //-------------------------------------
  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

  final confirmMaterialReceipt = Rx<ConfirmMaterial?>(null);

  final vehicleInfo = Rx<ConfirmRecipientReadiness?>(null);
  final itemList = RxList<TransportOrderLoadingModels>([]);

  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        // imagefiles.value = pickedfile;
        pickedImage.value = File(pickedfile.path);
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
  void receiptMaterialsGet({
    required String transportOrderNo,
    required String vehicleRegistrationNo,
  }) async {
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
        // 'toNo': '221004.00233',
        'userType': 'RECEIVER',
        'vehicleRegistrationNo': vehicleRegistrationNo,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/load-materials/get',
        queryParameters: params,
      );

      //// kLog(res.data);

      //Add vehicleInfo
      //----------------------------------------------------------
      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final vehicleInfoData = ConfirmRecipientReadiness.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (vehicleInfoData != null) {
          isLoading.value = false;
          vehicleInfo.value = vehicleInfoData;
        }

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

      // kLog(vehicleInfo.value!.driverFullname);
      // kLog(itemList.length);
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void addConfirmMaterialData() async {
    try {
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final confirmMaterialData = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'remarks': remarks.value,
        'itemList': itemList.map((item) {
          return {
            'id': item.id,
            'receivedQuantity': item.updateReceivedQuantity,
          };
        }).toList(),
      };

      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/confirm-receipt-materials',
        body: confirmMaterialData,
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
      itemList.clear();
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Evidence attachment *******
  //====================================================================
  //evidence-attachment(post)

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

        // kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'isupply',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_RECEIVED',
          'ids': transportOrderIds,
          'originalFileNameNeeded': false,
          'files': attachments,
          'registrationNo': registrationNo,
        },
      );
      //kLog(data.fields);
      await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      //// kLog(res.data['status']);
      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

  // void postEvidenceAttachment() async {
  //   try {
  //     // isLoading.value = true;

  //     // var attachments = [];
  //     // for (var img in imagefiles) {
  //     //   final fileName = getFileName(path: img.path);
  //     //   attachments.add(await MultipartFile.fromFile(
  //     //     img.path,
  //     //     filename: fileName,
  //     //   ));
  //     // }

  //     // final data = FormData.fromMap(
  //     //   {
  //     //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //     //     'appCode': 'isupply',
  //     //     'countryCode': 'BD',
  //     //     'username': 'kabir2',
  //     //     'fileCategory': 'FILE_CATEGORY_RECEIVED',
  //     //     'ids': 'ce7d3297-d194-49b2-8abb-a7f63fc08199',
  //     //     'originalFileNameNeeded': false,
  //     //     'registrationNo': 'dh-metro 56',
  //     //     'files': attachments,
  //     //   },
  //     // );
  //     //  log('${attachments[0]['path']}');
  //     // log('${attachments[1]}');
  //     // log('${data.fields}');
  //     //  return;
  //     // ignore: unused_local_variable
  //     // final res = await postDynamic(
  //     //  path:  '${dotenv.env['BASE_URL_FSR']}/v1/evidence-attachment/add',
  //     //  body: data,

  //      // );
  //     //  print(res.data);
  //     //  log('${data.files}');
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  // }

  // Select user avatar image
  void selectAvatar() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image!.path.isNotEmpty) {
      pickedImage.value = File(image.path);
      pickedImageMemory.value = await image.readAsBytes();
    }
  }

  //Update dropped Quantity
  updateItem(
    TransportOrderLoadingModels currentItem,
    double value,
  ) {
    final item = itemList.singleWhere((x) => x.id == currentItem.id);

    item.updateReceivedQuantity = value;

    itemList[itemList.indexOf(item)] = item;
  }

  bool validateConfirmButton() {
    bool isValid = false;
    for (final x in itemList) {
      isValid = x.updateReceivedQuantity! > 0 ? true : false;
    }
    return isValid;
  }

  confirmButton() {
    // ignore: unused_local_variable
    bool isValid = false;
    for (final x in itemList) {
      isValid = x.updateReceivedQuantity! > 0 ? true : false;
      // kLog(isValid);
    }
    // kLog(isValid);
  }
}
