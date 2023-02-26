import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'dart:ui' as ui;

class ConvertMaPData {
  List<LatLng> convertPointsForPolygon(List coordinates) {
    final latLngList = coordinates[0][0];
    // final latLngList2 = latLngList[0];
    List<LatLng> points = [];

    for (final latLngValue in latLngList) {
      final item = LatLng(
        double.parse('${latLngValue[1]}'),
        double.parse('${latLngValue[0]}'),
      );

      points.add(item);
    }
    return points;
  }

  List<gmap.LatLng> convertPointsForGmapPolygon(List coordinates) {
    final latLngList = coordinates[0][0];
    // final latLngList2 = latLngList[0];
    List<gmap.LatLng> points = [];

    for (final latLngValue in latLngList) {
      final item = gmap.LatLng(
        double.parse('${latLngValue[1]}'),
        double.parse('${latLngValue[0]}'),
      );

      points.add(item);
    }
    return points;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return '';
  return '${value[0].toLowerCase()}${value.substring(1).toLowerCase()}';
}
