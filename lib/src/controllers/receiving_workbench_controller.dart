import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/receiving_workbench_model.dart';
import 'agencyController.dart';

class ReceivingWorkbenchController extends GetxController with ApiService {
  final logisticsworkbenchreceiving = RxList<ReceivingWorkbenchModel>();
  final isLoading = RxBool(false);

  void getRecevingWorkbanch() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      // kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'workbenchType': 'receiving',
      };

      final res = await getDynamic(
        queryParameters: params,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/workbench/get',
      );
      //// kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ReceivingWorkbenchModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ReceivingWorkbenchModel>() as List<ReceivingWorkbenchModel>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          logisticsworkbenchreceiving.clear();
          logisticsworkbenchreceiving.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void expendITem(String id) {
    // kLog(id);
    final item = logisticsworkbenchreceiving.singleWhere((x) => x.id == id);

    item.expended = item.expended == true ? false : true;

    logisticsworkbenchreceiving[logisticsworkbenchreceiving.indexOf(item)] =
        item;
  }
}
