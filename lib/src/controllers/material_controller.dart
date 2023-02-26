import 'package:get/get.dart';

class MaterialController extends GetxController {
  final isExpanded = RxBool(false);

  final selected = 'Jessore Sadar, Jessore'.obs;

  void setSelected(String value) {
    selected.value = value;
  }
}
