import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/models/workbench_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'agencyController.dart';

class LogisticsWorkbenchController extends GetxController with ApiService {
  final logisticsworkbenchassignvehicle = RxList<WorkbenchModel>();
  final isLoading = RxBool(false);

  void getAssignVehicleLogisticWorkbanch() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'workbenchType': 'logistics',
      };
      final res = await getDynamic(
        queryParameters: params,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/workbench/get',
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map(
                (json) => WorkbenchModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<WorkbenchModel>() as List<WorkbenchModel>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          logisticsworkbenchassignvehicle.clear();
          logisticsworkbenchassignvehicle.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void expendITem(String id) {
    // final item = logisticsworkbenchassignvehicle.singleWhere((x) => x.id == id);

    // item.expended = item.expended == true ? false : true;

    // logisticsworkbenchassignvehicle[
    //     logisticsworkbenchassignvehicle.indexOf(item)] = item;
  }
}
