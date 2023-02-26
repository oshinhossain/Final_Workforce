import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/models/project_dashboard_model.dart';
import 'package:workforce/src/services/api_service.dart';

import '../models/project_dashboard_materials_requisition_model.dart';
import '../models/project_dashboard_myActivities_model.dart';
import '../models/project_dashboard_myTask_model.dart';

class ProjectDashbordOparationalController extends GetxController
    with ApiService {
  final projectDashbordMyProjectList = RxList<ProjectDashbord?>();
  final projectdashbordMyProjectCheck = RxBool(false);
  final projectDashbordMyActivityList = RxList<ProjectdashboardmyActivities?>();

  final projectDashbordMyTaskList = RxList<ProjectdashboardmyTask?>();

  final projectDashbordMaterialsRequisitionList =
      RxList<Projectdashboardmaterialsrequisition?>();

  final isLoading = RxBool(false);

  void getProjectDashbordMyProjectList() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/dashboard/get',
        queryParameters: params,
      );

      // kLog('${res.data}');
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final projectdashbordMyProjectData = res.data['data']
            .map((json) =>
                ProjectDashbord.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectDashbord>() as List<ProjectDashbord>;

        if (projectdashbordMyProjectData.isNotEmpty) {
          projectDashbordMyProjectList.clear();
          projectDashbordMyProjectList.addAll(projectdashbordMyProjectData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  // my Activity getapi

  void getProjectDashbordMyActivities() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/activity/dashboard/get',
        queryParameters: params,
      );
      // kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final projectdashbordActivitiesData = res.data['data']
                .map((json) => ProjectdashboardmyActivities.fromJson(
                    json as Map<String, dynamic>))
                .toList()
                .cast<ProjectdashboardmyActivities>()
            as List<ProjectdashboardmyActivities>;

        if (projectdashbordActivitiesData.isNotEmpty) {
          projectDashbordMyActivityList.clear();
          projectDashbordMyActivityList.addAll(projectdashbordActivitiesData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void getProjectDashbordMyTasksSupport() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/support/dashboard/get',
        queryParameters: params,
      );
      //// kLog('${res.data}');
      // return;
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final projectdashbordMyTaskData = res.data['data']
            .map((json) =>
                ProjectdashboardmyTask.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectdashboardmyTask>() as List<ProjectdashboardmyTask>;

        if (projectdashbordMyTaskData.isNotEmpty) {
          projectDashbordMyTaskList.clear();
          projectDashbordMyTaskList.addAll(projectdashbordMyTaskData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

//Materials Requisition

  void getProjectDashbordMaterialsRequisition() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/material-requisition/dashboard/get',
        queryParameters: params,
      );
      // kLog('${res.data}');
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final projectdashbordmaterialsrequisition = res.data['data']
                .map((json) => Projectdashboardmaterialsrequisition.fromJson(
                    json as Map<String, dynamic>))
                .toList()
                .cast<Projectdashboardmaterialsrequisition>()
            as List<Projectdashboardmaterialsrequisition>;

        if (projectdashbordmaterialsrequisition.isNotEmpty) {
          projectDashbordMaterialsRequisitionList.clear();

          projectDashbordMaterialsRequisitionList.addAll(
            projectdashbordmaterialsrequisition,
          );
          // // kLog(projectDashbordMaterialsRequisitionList);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
