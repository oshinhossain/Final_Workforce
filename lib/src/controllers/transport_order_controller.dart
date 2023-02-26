import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/models/transport_order_model.dart';
import 'package:workforce/src/services/api_service.dart';

import 'agencyController.dart';
import 'user_controller.dart';

class TransportOrderController extends GetxController with ApiService {
  final transportOrders = RxList<TransportOrderModel>();

  void getTransportOrders() async {
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
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/home/get',
        queryParameters: params,
      );
      //// kLog('${res.statusCode}');
      if (res.statusCode == 200) {
        final data = res.data['data']
            .map((json) =>
                TransportOrderModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TransportOrderModel>() as List<TransportOrderModel>;
        transportOrders.clear();
        transportOrders.addAll(data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
