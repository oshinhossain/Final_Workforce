import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MapViewController extends GetxController {
  final kMapController = MapController();
  // ignore: unused_field
  static LocationData? _currentPosition;
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
