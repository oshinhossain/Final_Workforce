import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import '../services/api_service.dart';
import '../config/api_endpoint.dart';
import '../models/activity_name_model.dart';
import '../models/project_count_model.dart';
import 'agencyController.dart';

class ProjectActivityGroupBoardController extends GetxController
    with ApiService {
  final activityGroupList = RxList<ActivityDropdown>();
  final projectCount = RxList<ProjectCount?>();
  final selectedGroup = Rx<ActivityDropdown?>(null);
  final groupIdNum = RxString('');

  final isLoading = RxBool(false);

//get group
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
        //come from bucket
        //  'projectId': '330c5fea-cd51-4b25-8ed6-ce78486e4886'
        'projectId': projectId,
        'bucketId': bucketId,
      };

      final res = await getDynamic(
        path: ApiEndpoint.getActivityGroup(),
        //  path: ApiEndpoint.getBucketName(),
        queryParameters: params,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ActivityDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ActivityDropdown>() as List<ActivityDropdown>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          activityGroupList.clear();
          activityGroupList.addAll(data);
          selectedGroup.value = activityGroupList[0];
        }
        projectCount.clear();
        for (var element in activityGroupList) {
          await projectCountGet(element.id!);
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

//count
  Future<void> projectCountGet(String id) async {
    print('object hit $id');
    try {
      //  await Future.delayed(Duration(seconds: 2));
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      //kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'id': id,
        'searchType': 'GROUPS',
      };

      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/count');
      print('sdjfgdshg');
      // kLog(res.data['data'][0].toString());
      if (res.data['status'] != null) {
        final data =
            ProjectCount.fromJson(res.data['data'][0] as Map<String, dynamic>);
        print('object');
        // kLog(data);

        isLoading.value = false;
        if (data != null) {
          projectCount.add(data);
        }
      }
      // kLog(projectCount.length);
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
