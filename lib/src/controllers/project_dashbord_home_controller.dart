import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

import '../services/api_service.dart';
import '../models/project _planning_board_model.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class ProjectDashbordController extends GetxController with ApiService {
  final projectDashbordHome = RxList<ProjectPlanningBoard?>();
  final projectDashborCheck = RxBool(false);
  final loading = RxBool(false);
  final _dio = Dio();
  final userImage = Rx<Uint8List?>(null);
  //====================================================================
  // ******* Dashbord home page project *******
  //====================================================================

  void getDashbordProject() async {
    try {
      projectDashborCheck.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/get',
        queryParameters: params,
      );

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final data = res.data['data']
            .map(
              (json) =>
                  ProjectPlanningBoard.fromJson(json as Map<String, dynamic>),
            )
            .toList()
            .cast<ProjectPlanningBoard>() as List<ProjectPlanningBoard>;

        projectDashborCheck.value = false;
        if (data.isNotEmpty) {
          projectDashbordHome.clear();
          projectDashbordHome.addAll(data);
        }
      }
      loading.value = false;
    } on DioError catch (e) {
      loading.value = false;
      print(e.message);
    }
  }

  //====================================================================
  // ******* Grt User Image for Dashbord home page project *******
  //====================================================================

  getImageByUserName({required String username}) async {
    try {
      // ignore: unused_local_variable
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

      // final userBox = Hive.box<UserImage>('user_image');

      // await userBox.put('current_user_image', UserImage(image: res.data));
      // userImage.value = res.data;
    } on DioError catch (e) {
      print(e.message);
    }
  }
  //====================================================================
}
