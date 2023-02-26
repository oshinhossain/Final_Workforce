import 'dart:io';

// ignore: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _dio;
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/task_detail_controller.dart';

import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/services/api_service.dart';

import '../helpers/get_file_name.dart';
import '../helpers/image_compress.dart';

import '../helpers/log.dart';
import '../helpers/uniqe_id.dart';
import '../models/post_task.dart';

class PostMyTaskController extends GetxController with ApiService {
  final taskDetailsC = Get.put(TaskDetailController());
  final isLoading = RxBool(false);
  final taskItemList = RxList<PostTask>();

  final taskId = RxString('');
  final fff = RxString('');

  final selectedDate = RxString('');
  final ImagePicker imagePicker = ImagePicker();
  final quantity = RxString('');
  final remarks = RxString('');
  // final date = RxString('');
  // final time = RxString('');
  final time1 = RxString('');
  final imagefiles = RxList<File>([]);
  final pickedImage = Rx<File?>(null);

  final isChecked = RxBool(false);

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
      // imagefiles.value = pickedfile;

      imagefiles.add(pickedImage.value!);
      // back();

    } catch (e) {
      print('error while picking file.');
    }
  }

  postEvidenceAttachment(
      {required String? projectId,
      required String? activityId,
      required String? status,
      required String? supportId,
      required String? progressId}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      for (var img in imagefiles) {
        final fileName = getExt(path: img.path);
        attachments.add(await _dio.MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // kLog('attachment length: ${attachments.length}');
      }

      final data = _dio.FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_TASK_PROGRESS',
          //'ids': transportOrderIds,
          'originalFileNameNeeded': false,
          'files': attachments,
          'status': status,
          'projectId': projectId,
          'activityId': activityId,
          'supportId': supportId,
          'progressId': progressId,
        },
      );

      await _dio.Dio().post(
        '${dotenv.env['BASE_URL_WFC']}/v1/project/attachment/add',
        data: data,
        options: _dio.Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'latLng':
                '${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}',
          },
        ),
      );

      imagefiles.clear();
      isLoading.value = false;
    } on _dio.DioError catch (e) {
      isLoading.value = false;
      kLog(e.message);
    }
  }

  getProjectItem() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'type': 'assignedUser',
      };
      // kLog(jsonEncode(body));
      final res = await postDynamic(
        path: ApiEndpoint.getProjectItemUrl(),
        body: body,
      );

      // kLog(res.data);
      final itemListData = res.data['data']
          .map((json) => PostTask.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<PostTask>() as List<PostTask>;

      taskItemList.clear();
      taskItemList.addAll(itemListData
          .where((element) => element.assignedUsername == username));

      isLoading.value = false;
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

//post task
  Future postMyTask(String id, String outPutQuantity, String? statusCode,
      String? levelFullCode) async {
    // print('ore date ${date.value.toString()}');
    // print('out put quantity: ' + outPutQuantity);
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final taskDetailC = Get.put(TaskDetailController());
    final username = Get.put(UserController()).username;
    //   final value1 = Get.put(SiteLocationsController().levelFullCode.value);

    //final taskDetailController = Get.put(TaskDetailController());

    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,

      'agencyIds': [selectedAgency!.agencyId],
      //'agencyIds': [selectedAgency!.agencyId],
      'username': username,
      'supportId': id,
      'outputQty': double.parse(outPutQuantity),
      'progPostDate': DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(DateTime.now().toString())),

      'progPostDatetime': DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse(DateTime.now().toString())),

      'remarks': taskDetailC.taskDetails.value!.statusCode == '03'
          ? 'Started the Work'
          : remarks.value,
      'status': isChecked.value
          ? 'Completed'
          : statusCode == '03'
              ? 'Started'
              : 'WIP',

      'statusCode': isChecked.value
          ? '08'
          : statusCode == '03'
              ? '04'
              : '05',
      'levelFullCode': levelFullCode,
    };

    final res = await postDynamic(
      path: ApiEndpoint.saveTaskUrl(),
      body: body,
    );
    await taskDetailsC.getaskDetail(id);

    selectedDate.value = '';
    levelFullCode = '';
    remarks.value = '';

    // if (int.parse('${res.data['responseCode']}') == 200) {
    //   selectedDate.value = '';
    //   // date.value = '';
    //   // time.value = '';
    //   isChecked.value = false;

    //  // kLog(res);
    // }
    return res;
  }
}
