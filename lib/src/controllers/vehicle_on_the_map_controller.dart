import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class VehicleOnTheMapController extends GetxController {
  final kVehicleOnTheMapController = MapController();
  final isPlotingEnable = RxBool(false);
  final isPop = RxBool(false);
  final addDriver = RxBool(false);

  void getCurrentLocation() async {
    try {
      // final location = await getLocation();
      // print('Location: ${location.latitude}, ${location.longitude}');
      // kMapController.move(
      //     LatLng(
      //       location.latitude!,
      //       location.longitude!,
      //     ),
      //     10);
    } catch (e) {
      print(e);
    }
  }
}
