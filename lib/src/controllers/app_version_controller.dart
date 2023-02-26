import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/config/app_theme.dart';

import 'package:workforce/src/models/app_version_model.dart';

import '../helpers/global_dialog.dart';

import '../helpers/route.dart';

class VersionController extends GetxController with ApiService {
  final appVersion = RxList<AppVersion>();
  final isLoading = RxBool(false);

  final currentAppVersion = RxString(AppTheme.appVersion);

  getAppVersion() async {
    try {
      // final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': '',
        'appCode': 'WFC',
      };

      final res = await getDynamic(
        queryParameters: params,
        path: '${dotenv.env['BASE_URL_KYC']}/v1/app-sync-indicator/get',
      );

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final data = res.data['data']
            .map((json) => AppVersion.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<AppVersion>() as List<AppVersion>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          appVersion.clear();
          appVersion.addAll(data);
          currentAppVersion.value = appVersion[0].appVersion!;
          // currentAppVersion.value = '1.0.1';
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  bool checkAppVersion() {
    if (AppTheme.appVersion == currentAppVersion.value) {
      return true;
    } else {
      return false;
    }
  }

  appVersionDialog() {
    GlobalDialog.statusDialog(
      title: 'App Version',
      msg: 'Please update the app version ${currentAppVersion.value}',
      onPressed: () {
        getAppVersion();
        back();
      },
    );
  }
}
