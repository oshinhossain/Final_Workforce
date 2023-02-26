import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

import '../helpers/convert_line_string.dart';
import '../models/travel_path.dart';
import 'user_controller.dart';

class TravelPathController extends GetxController with ApiService {
  final travelPath = Rx<TravelPath?>(null);

  getTravelPath() async {
    try {
      final username = Get.put(UserController()).username;
      final params = {
        'id': '4cbb3eac-3368-4408-84d8-d51aeeff876d',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/travel-path/get',
        queryParameters: params,
      );

      final coordinates =
          jsonDecode(res.data['data']['polygon'] as String)['coordinates']
              as List;

      final travelPathData =
          TravelPath.fromJson(res.data['data'] as Map<String, dynamic>);
      travelPathData.points = convertLineString(coordinates);

      travelPath.value = travelPathData;

      //-------------------------------------------------

    } on DioError catch (e) {
      print(e.message);
    }
  }
}
