import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/services/validation_service.dart';
import '../config/api_endpoint.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/route.dart';
import '../models/confirm_transport_readiness.dart';

import 'package:get/get.dart';

import '../pages/main_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class StartJourneyController extends GetxController
    with ApiService, ValidationService {
  // Sign Up Phase
  //final _dio = Dio();

  // final startJourney = RxList<StartJourneyDriver>();

  final startJourney = Rx<ConfirmTransportReadinessByDriver?>(null);
  // final startJourney = Rx<StartJourneyDriver?>(null);
  final isLoading = RxBool(false);

  final driverRemarks = RxString('');

  //====================================================================
  // ******* Get Start Journy *******
  //====================================================================
  void getstartjourney({required String transportOrderNo}) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      print(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyId': selectedAgency.agencyId,
        'username': username,
        'toNo': transportOrderNo,
        'userType': 'DRIVER',
        'vehicleRegistrationNo': '',
      };

      final res = await getDynamic(
        path: ApiEndpoint.getUnloadMaterial(),
        queryParameters: params,
      );
      // kLog(res.data);
      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final startJourneyData = ConfirmTransportReadinessByDriver.fromJson(
            res.data['data'] as Map<String, dynamic>);
        if (startJourneyData != null) {
          startJourney.value = startJourneyData;
        }
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* Post Start Journy *******
  //====================================================================
  void postStartJourny({
    required String registrationNo,
    required String transportOrderNo,
  }) async {
    try {
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final data = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'confirmBy': 'driver',
        'transportOrderNo': transportOrderNo,
        'registrationNo': registrationNo,
        // 'transportOrderNo': '221018.00001',
        // 'registrationNo': 'dhaka metro 95',
        'remarks': driverRemarks.value,
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/start-journey',
        body: data,
      );
      log('${res.data}');
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 6.delay();

        offAll(MainPage());
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () => back(),
        );
        await 6.delay();
        back();
      }

      isLoading.value = false;
      driverRemarks.value = '';
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
