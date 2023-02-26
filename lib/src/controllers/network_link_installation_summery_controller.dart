// pole_installation_summery_controller

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../models/geography_summery_model.dart';
import '../models/network_link_installation_summery_model.dart';

import '../services/api_service.dart';

import 'agencyController.dart';
import 'user_controller.dart';

class NetworkLinkInstallationSummeryController extends GetxController
    with ApiService {
  final isLoading = RxBool(false);

  final networkLinkInstallationSummeryModel =
      Rx<NetworkLinkInstallationSummeryModel?>(null);
  final geographySummeryModel = Rx<GeographyInstallationSummeryModel?>(null);

  void getNetworkLinkInstallationSummery() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'WFC',
        'ids': ['330c5fea-cd51-4b25-8ed6-ce78486e4886']
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/nms-network-link/summary',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = NetworkLinkInstallationSummeryModel.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (data != null) {
          isLoading.value = false;

          networkLinkInstallationSummeryModel.value = data;
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  double getTotalCore() {
    double percent = 0.0;
    final data = networkLinkInstallationSummeryModel.value;

    // for (var element in data!.totalCoreSummary!) {
    //   sum += element.lengthkm!;
    // }
    if (data!.totalCoreSummary!.totalInstalled != null &&
        data.totalCoreSummary!.totalTarget != null) {
      percent = (data.totalCoreSummary!.totalInstalled! /
              data.totalCoreSummary!.totalTarget!) *
          100;
    } else {
      percent = 0.0;
    }

    return double.parse(percent.toStringAsFixed(2));
  }

  double getDailyTotalCore() {
    double percent = 0.0;
    final data = networkLinkInstallationSummeryModel.value;

    // for (var element in data!.totalCoreSummary!) {
    //   sum += element.lengthkm!;
    // }
    if (data!.dailyCoreSummary!.totalInstalled != null &&
        data.dailyCoreSummary!.totalTarget != null) {
      percent = (data.dailyCoreSummary!.totalInstalled! /
              data.dailyCoreSummary!.totalTarget!) *
          100;
    } else {
      percent = 0.0;
    }

    return double.parse(percent.toStringAsFixed(2));
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
        'type': 'networkInstaller',
      };

      final res = await getDynamic(
        queryParameters: params,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/geography-summary/get',
      );

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

      print('value');
    }
    return double.parse(divided.toStringAsFixed(2));
    // var actual = (10 / 100) * 1000;
    // kLog(actual);
  }
}
