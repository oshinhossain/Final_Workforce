// pole_installation_summery_controller

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../models/geography_summery_model.dart';
import '../models/pole_installation_summery_model.dart';
import '../services/api_service.dart';

import 'agencyController.dart';
import 'user_controller.dart';

class PoleInstallationSummeryController extends GetxController with ApiService {
  final isLoading = RxBool(false);

  final poleInstallationSummeryModel = Rx<PoleInstallationSummeryModel?>(null);
  final geographySummeryModel = Rx<GeographyInstallationSummeryModel?>(null);

//site Installation
  void getPoleInstallationSummery() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'projectId': '330c5fea-cd51-4b25-8ed6-ce78486e4886',
      };

      final res = await getDynamic(
        queryParameters: params,
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/projectsite/dashboard/pole-summary/get',
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = PoleInstallationSummeryModel.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (data != null) {
          isLoading.value = false;

          poleInstallationSummeryModel.value = data;
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//Geography Summary of Site Installation
  void getGeographySummary() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyId': selectedAgency!.agencyId,
        'username': username,
        'type': 'siteInstaller',
      };

      final res = await getDynamic(
        queryParameters: params,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/geography-summary/get',
      );
      // kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = GeographyInstallationSummeryModel.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (data != null) {
          isLoading.value = false;

          geographySummeryModel.value = data;
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//site installation percentage count
  getTotalSiteSummaryPercentages() {
    num divided = 0.0;
    final data = poleInstallationSummeryModel.value;
    for (var element in data!.totalSummary!) {
      if (double.parse(element.totalCompleted!) != null &&
          double.parse(element.targetSites!) != null) {
        divided = ((double.parse(element.totalCompleted!) /
                double.parse(element.targetSites!)) *
            100);
      } else {
        divided = 0.0;
      }
    }
    return double.parse(divided.toStringAsFixed(2));
    // var actual = (10 / 100) * 1000;
  }

  getGeographySummaryPercentages() {
    num divided = 0.0;
    final data = geographySummeryModel.value;
    for (var element in data!.headerSummaries!) {
      if (element.totalCompleted != null && element.targetGeographies != null) {
        divided =
            ((element.totalCompleted! / element.targetGeographies!) * 100);
      } else {
        divided = 0.0;
      }
    }
    return double.parse(divided.toStringAsFixed(2));
    // var actual = (10 / 100) * 1000;
    //// kLog(actual);
  }
}
