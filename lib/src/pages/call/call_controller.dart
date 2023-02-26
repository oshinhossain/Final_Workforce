import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../background/services/api_service.dart';
import '../home_page.dart';

class CallController extends GetxController with ApiService {
  final currentIndex = RxInt(0);

  set setCurrentIndex(String item) => currentIndex.value = getMenuIndex(item);

  Widget getCurrentPage() {
    switch (currentIndex.value) {
      case 0:
        return HomePage();

      default:
        return Container(
          height: 1000,
          color: Colors.white,
          width: Get.width,
        );
    }
  }

  final bottomMenus = [
    'bottom_1.svg',
    'bottom_2.svg',
    'bottom_3.svg',
    'bottom_4.svg',
    'bottom_5.svg'
  ];

  int getMenuIndex(String item) {
    return bottomMenus.indexOf(item);
  }
}
