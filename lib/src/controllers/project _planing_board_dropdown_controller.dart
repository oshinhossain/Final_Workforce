import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/models/project_count_model.dart';
import 'package:workforce/src/models/project_scope_bucket_board_model.dart';
import '../services/api_service.dart';
import '../models/activity_name_model.dart';
import '../models/project _planning_board_model.dart';
import '../models/project_task_get_model.dart';

class ProjectPlanningBoardDropDownController extends GetxController
    with ApiService {
  //..........................................
  // Project Planning Board Get
  //..........................................
  RxInt changeIndex = 0.obs;
  final projectPlanningBoard1 = RxList<ProjectPlanningBoard?>();
  final projectCount = RxList<ProjectCount?>();
  final projectCountForBucket = RxList<ProjectCount?>();
  final projectScopeBucketBoard = RxList<ProjectScopeBucketBoard?>();
  final activityList = RxList<Activities>();
  final projectActivityCountGet = RxList<ProjectCount?>();
  final selectedBucket = Rx<ProjectScopeBucketBoard?>(null);
  final bucketIdNum = RxString('');
  final bucketIdName = Rx<ProjectScopeBucketBoard?>(null);
  final selectActivities = Rx<Activities?>(null);
  final activityIdNum = RxString('');
  final projectTaskGet = RxList<ProjectTaskGet>();

  final activityGroupList = RxList<ActivityDropdown>();

  final selectedGroup = Rx<ActivityDropdown?>(null);
  final groupIdNum = RxString('');
  // final selectprojectTaskGet = Rx<ProjectTaskGet?>(null);

  final isLoading = RxBool(false);
  final _dio = Dio();

  //..........................................
  // Project scope bucket board
  //..........................................

  projectScopeBucketDropDownGet(String id) async {
    print('object hit $id');
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': 'WFC',
        'username': username,
        'projectId': id,
      };
      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/bucket/get');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ProjectScopeBucketBoard.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectScopeBucketBoard>() as List<ProjectScopeBucketBoard>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          projectScopeBucketBoard.clear();
          projectScopeBucketBoard.addAll(data);
          selectedBucket.value = projectScopeBucketBoard[0];
        }
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//........................................................................................

  Future<void> getActivityName(String projectId, String bucketId) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      // kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,

        'projectId': projectId,
        'bucketId': bucketId,
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
        // kLog(res.data);
        if (data.isNotEmpty) {
          isLoading.value = false;
          activityGroupList.clear();
          activityGroupList.addAll(data);
          selectedGroup.value = activityGroupList[0];
        }
      }
      //  else {
      //   activityGroupList.clear();
      // }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //get activity
  getActivity(String id, String pbuketId, String pGruopId) async {
    print('bucket id');
    print(pbuketId);
    print(pGruopId);
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': id,
        'bucketId': pbuketId,
        'groupId': pGruopId,
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
          selectActivities.value = activityList.first;
          print('.............activity...........');
          // kLog(selectActivities.value!.id);
          // kLog(selectActivities.value!.activityName);
        }
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Grt User Image for Dashbord home page project *******
  //====================================================================
  final userImage = Rx<Uint8List?>(null);
  getImageByUserName({required String username}) async {
    try {
      print(username);
      final res = await _dio.get<Uint8List>(
        '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$username&appCode=KYC&fileCategory=photo&countryCode=BD',
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
          },
        ),
      );

      userImage.value = res.data;
      // kLog(userImage.value);
    } on DioError catch (e) {
      print(e.message);
    }
  }
  //====================================================================

  //====================================================================
  // ******* Grt Project Task for Project Task Bord Page  *******
  //====================================================================

  Future<void> getProjectTask(String pActivityId) async {
    print('bucket id');
    // print(bucketId.value);
    // print(projectId.value);
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      // kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        // 'bucketId':bucketNameList[ projectPlanningBoard.indexWhere((element) => element.id==)].id,

        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyId': selectedAgency!.agencyId,
        // 'projectId': projectId,
        // 'bucketId': pbucketId,
        // 'groupId': pGruopId,
        'activityId': pActivityId,
      };

      // kLog(params);

      final res = await getDynamic(
        path: ApiEndpoint.getProjectTaskApi(),
        queryParameters: params,
      );
      // kLog(res);

      if (res.data['status'] != null) {
        final data = res.data['data']
            .map(
                (json) => ProjectTaskGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectTaskGet>() as List<ProjectTaskGet>;
        // projectTaskGet.value = data;
        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          projectTaskGet.clear();
          projectTaskGet.addAll(data);
          // selectprojectTaskGet.value = projectTaskGet[0];
        }
      }
      //projectActivityCountGet.clear();
      // for (var element in projectTaskGet) {
      //   await projectActivityBoardGet(element.id!);
      // }
      // else {
      //   activityList.clear();
      // }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
