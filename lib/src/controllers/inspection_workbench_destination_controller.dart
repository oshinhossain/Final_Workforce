import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/models/receiving_workbench_model.dart';

import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'agencyController.dart';

class InspectionWorkbenchDestinationController extends GetxController
    with ApiService {
  final transportOrdersWorkbenchDestination = RxList<ReceivingWorkbenchModel>();
  final isLoading = RxBool(false);

  void getInspectOrdersForDestinationWorkbench() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'workbenchType': 'goodsInspectionAtDestination',
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/workbench/get');
      // kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ReceivingWorkbenchModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ReceivingWorkbenchModel>() as List<ReceivingWorkbenchModel>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          transportOrdersWorkbenchDestination.clear();
          transportOrdersWorkbenchDestination.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void expendITem(String id) {
    final item =
        transportOrdersWorkbenchDestination.singleWhere((x) => x.id == id);

    item.expended = item.expended == true ? false : true;

    transportOrdersWorkbenchDestination[
        transportOrdersWorkbenchDestination.indexOf(item)] = item;
  }
}
