import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/services/hive_service.dart';

class BackgroundConfigController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();

    await Get.put(HiveService()).onInitForBackground();
  }
}
