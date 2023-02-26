import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:workforce/src/services/api_service.dart';

import '../models/transportation_orders_model.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class TransportationController extends GetxController with ApiService {
  final transportationOrders = RxList<TransportationOrderModel>();

  void getTransportationOrders() async {
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
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport/report/get',
        queryParameters: params,
      );

      if (res.statusCode == 200) {
        final data = res.data['data']
            .map((json) =>
                TransportationOrderModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TransportationOrderModel>() as List<TransportationOrderModel>;
        transportationOrders.clear();
        transportationOrders.addAll(data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
