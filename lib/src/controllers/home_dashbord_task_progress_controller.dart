import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

import 'package:workforce/src/models/home_page_taskprogress_model.dart';

import '../services/api_service.dart';
import '../components/chart_component.dart';
import '../helpers/hex_color.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class TaskProgressController extends GetxController with ApiService {
  final taskProgressDashbordHome = RxList<DashbordTaskProgress?>();
  List<ChartSampleData> chartComponent = [
    ChartSampleData(
      x: 'Completed',
      y: 10,
      text: '10%',
      pointColor: hexToColor('#00D8A0'),
    ),
  ];

  final isLoading = RxBool(false);
  RxInt total = 0.obs;

  void getTaskProgress() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': '330c5fea-cd51-4b25-8ed6-ce78486e4886'
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/support/homepage/get');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                DashbordTaskProgress.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashbordTaskProgress>() as List<DashbordTaskProgress>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          taskProgressDashbordHome.clear();
          taskProgressDashbordHome.addAll(data);
        }
        total = 0.obs;
        chartComponent.clear();
        for (var element in taskProgressDashbordHome) {
          total += element!.count!;
        }
        for (var element in taskProgressDashbordHome) {
          // num x = int.parse(
          //     (element.count! / total.value).toString() * 100.toInt());

          //kLog(((int.parse(element.count!.toString()) / total.value) * 100)
          //   .toInt());

          //kLog(y:(element.count! / total.value).toString() * 100);
          chartComponent.add(ChartSampleData(
            x: element!.status,
            y: ((int.parse(element.count!.toString()) / total.value) * 100)
                .toInt(),
            // y: int.parse((element.count! / total.value).toString() * 100)
            //     .toInt(),
            text: '50%',
            pointColor: element.status == 'Accepted'
                ? hexToColor('#786e04')
                : element.status == 'Started'
                    ? hexToColor('#FFA133')
                    : element.status == 'WIP'
                        ? hexToColor('#08E8DE')
                        : element.status == 'Aborted'
                            ? hexToColor('#FF3C3C')
                            : element.status == 'Restarted'
                                ? hexToColor('#6666FF')
                                : element.status == 'Completed'
                                    ? hexToColor('#00D8A0')
                                    : hexToColor('#000000'),
          ));

          // dataLabelSettings:
          //     DataLabelSettings(isVisible: false, color: Colors.white38),

        }
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
