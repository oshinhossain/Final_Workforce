import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';

import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/models/task_detail.dart';
import 'package:workforce/src/models/task_history.dart';

import 'package:workforce/src/services/api_service.dart';

import '../models/history_image_count_model.dart';

class TaskDetailController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  final taskId = RxString('');
  // final _dio = Dio();

  final taskDetails = Rx<TaskDetail?>(null);

  final taskHistoryList = RxList<TaskHistory>();
  final historyImageCount = RxList<HistoryImageModel>();
  final historyImages = RxList<AllImagesModel>();

  getaskDetail(String id) async {
    try {
      print(id);
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'id': id,
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyId': selectedAgency!.agencyId,
        'username': username,
      };
      print('parameter');
      print(params.entries);

      final res = await getDynamic(
        path: ApiEndpoint.gettaskDetailUrl(),
        queryParameters: params,
      );
      // print('the task detail');
      // print(res.data);
      final data =
          TaskDetail.fromJson(res.data['data'] as Map<String, dynamic>);
      taskDetails.value = data;

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getaskHistory(String id) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'id': id,
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyId': selectedAgency!.agencyId,
        //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
        'username': username,
      };

      final res = await getDynamic(
        path: ApiEndpoint.getTaskHistoryUrl(),
        queryParameters: params,
      );

      print('history of task');
      // kLog(res.data);
      final itemListData = res.data['data']
          .map((json) => TaskHistory.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<TaskHistory>() as List<TaskHistory>;

      taskHistoryList.clear();
      taskHistoryList.addAll(itemListData);
      taskHistoryList.sort(
        (a, b) => a.outputDatetime!.compareTo(b.outputDatetime!),
      );
      // ignore: unused_local_variable
      for (var element in taskHistoryList) {
        // kLog('only status: ${element.status}');
      }
      //print('the status: ' + taskHistoryList[0].status.toString());
      await getFileCount();
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //get File Count

  getFileCount() async {
    try {
      isLoading.value = true;
      historyImageCount.clear();
      for (var element in taskHistoryList) {
        // kLog(element.id);

        final selectedAgency = Get.put(AgencyController()).selectedAgency;
        final username = Get.put(UserController()).username;
        final params = {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'agencyId': selectedAgency!.agencyId,
          //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
          'username': username,
          'fileCategory': 'FILE_CATEGORY_TASK_PROGRESS',
          'fileRefId': element.id,
          'fileRefNo': '',

          'fileEntryUsername': ''
        };

        final res = await getDynamic(
          path: ApiEndpoint.getFileCount(),
          queryParameters: params,
        );
        //kLog('**************0 ${res.data['data']['fileCount']}');

        historyImageCount.add(HistoryImageModel(
            progressId: element.id!,
            imageCount: res.data['data']['fileCount'].toString(),
            status: element.status!));

        historyImages.add(AllImagesModel(
            progressId: element.id!, images: [], status: element.status!));

        isLoading.value = false;
      }
      // ignore: unused_local_variable
      for (var element in historyImageCount) {
        print('image Count');
        // kLog('${element.progressId} ${element.imageCount}');
      }

      for (var element in historyImageCount) {
        if (element.imageCount != '0') {
          // kLog(
          //   'status incoming: ${taskHistoryList[historyImageCount.indexWhere((element) => element.progressId == element.progressId)].status!}');
          await getImage(
              status:
                  element.status == 'Completed' ? element.status : 'Started',
              projectId: taskHistoryList[historyImageCount.indexWhere(
                      (element) => element.progressId == element.progressId)]
                  .projectId!,
              fileCount: int.parse(element.imageCount),
              progressId: element.progressId,
              activityId: taskHistoryList[historyImageCount.indexWhere(
                      (element) => element.progressId == element.progressId)]
                  .activityId!,
              supportId: taskHistoryList[historyImageCount.indexWhere(
                      (element) => element.progressId == element.progressId)]
                  .supportId!);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
//get history image
  }

  getImage(
      {required String projectId,
      required int fileCount,
      required String progressId,
      required String activityId,
      required String status,
      required String supportId}) {
    final username = Get.put(UserController()).username;

    historyImages[historyImages.indexWhere((e) => e.progressId == progressId)]
        .images
        .clear();
    for (int i = 0; i < fileCount; i++) {
      // kLog('inner loop $i');

      // for (var element in historyImages) {
      //  // kLog('image link');
      //  // kLog(' ${element.images}');
      // }
      // kLog(status);
      // kLog(
      //   '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_TASK_PROGRESS&projectId=$projectId&geoLevelId=&siteId=&activityId=$activityId&supportId=$supportId&progressId=$progressId&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}');
      // await getHistoryImage();
      historyImages[historyImages.indexWhere((e) => e.progressId == progressId)]
          .images
          .add(
              '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_TASK_PROGRESS&projectId=$projectId&geoLevelId=&siteId=&activityId=$activityId&supportId=$supportId&progressId=$progressId&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}');
    }
  }
}
