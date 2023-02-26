import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/activity_name_model.dart';
import '../models/bucket_name_model.dart';
import '../models/project _planning_board_model.dart';
import 'agencyController.dart';

class ProjectProgressDashboardController extends GetxController
    with ApiService {
  RxInt changeIndex = 0.obs;

  RxInt changeTab = 0.obs;
  final projectPlanningBoard = RxList<ProjectPlanningBoard?>();
  final bucketNameList = RxList<BucketDropdown>();
  final activityGroupList = RxList<ActivityDropdown>();
  final activityList = RxList<Activities>();

  final isLoading = RxBool(false);

// get project
  void projectGet() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/get');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ProjectPlanningBoard.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectPlanningBoard>() as List<ProjectPlanningBoard>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          projectPlanningBoard.clear();
          projectPlanningBoard.addAll(data);
          getBucketName();
          getActivityName();
          getActivity();
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//get bucket

  void getBucketName() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        // 'projectId': 'd5433254-0dc2-42f6-b7b4-b9a7ad1d9439'
        'projectId': projectPlanningBoard.isNotEmpty
            ? projectPlanningBoard[changeIndex.value]!.id!
            : ''
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/bucket/get',
        //  path: ApiEndpoint.getBucketName(),
        queryParameters: params,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map(
                (json) => BucketDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<BucketDropdown>() as List<BucketDropdown>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          bucketNameList.clear();
          bucketNameList.addAll(data);
        }
        //getActivityName();
      } else {
        bucketNameList.clear();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//get group
  void getActivityName() async {
    // print('bucket id');
    // print(bucketId.value);
    // print(projectId.value);
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      isLoading.value = true;
      final params = {
        // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': projectPlanningBoard.isNotEmpty
            ? projectPlanningBoard[changeIndex.value]!.id!
            : ''
      };

      final res = await getDynamic(
        path: ApiEndpoint.getActivityGroup(),
        //  path: ApiEndpoint.getBucketName(),
        queryParameters: params,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ActivityDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ActivityDropdown>() as List<ActivityDropdown>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          activityGroupList.clear();
          activityGroupList.addAll(data);
        }
      } else {
        activityGroupList.clear();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //get activity
  void getActivity() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      isLoading.value = true;
      final params = {
        // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': projectPlanningBoard.isNotEmpty
            ? projectPlanningBoard[changeIndex.value]!.id!
            : '',
      };

      final res = await getDynamic(
        path: ApiEndpoint.getActivity(),
        queryParameters: params,
      );

      if (res.data['status'] != null) {
        final data = res.data['data']
            .map((json) => Activities.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Activities>() as List<Activities>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          activityList.clear();
          activityList.addAll(data);
        }
      } else {
        activityList.clear();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getActivityProjectedProgress(Activities item) {
    if (item.scheduledStartDate != null &&
        item.scheduledEndDate != null &&
        item.outputTarget != null) {
      final actualDate = getDays(
          startDate: DateTime.now().toString(),
          endDate: item.scheduledStartDate!);
      final scheduledate = getDays(
          startDate: item.scheduledStartDate!, endDate: item.scheduledEndDate!);
      final prjecteedProgress =
          (actualDate / scheduledate) * item.outputTarget!;

      return prjecteedProgress.toStringAsFixed(2);
    } else {
      return 'N/A';
    }
  }
}
