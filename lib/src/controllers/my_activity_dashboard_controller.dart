import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../config/api_endpoint.dart';
import '../models/project_dashboard_myTask_model.dart';
import '../services/api_service.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class MyAcitivityDashboardController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  final myActivityDashboardModel = RxList<ProjectdashboardmyTask?>();
  final isExpanded = RxBool(false);

  void getMyActivitydashboard() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
      };

      final res = await getDynamic(
        path: ApiEndpoint.getMyProjectDashboard(),
        queryParameters: params,
      );

      //  // kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final myActivityDashboardModelData = res.data['data']
            .map((json) =>
                ProjectdashboardmyTask.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectdashboardmyTask>() as List<ProjectdashboardmyTask>;

        if (myActivityDashboardModelData.isNotEmpty) {
          myActivityDashboardModel.clear();
          myActivityDashboardModel.addAll(myActivityDashboardModelData);
        }
        // kLog(myActivityDashboardModel.length);
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
