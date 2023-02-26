import 'package:latlong2/latlong.dart';

List<LatLng> convertLineString(List coordinates) {
  List<LatLng> points = [];

  for (final latLngValue in coordinates) {
    final item = LatLng(
      double.parse('${latLngValue[0]}'),
      double.parse('${latLngValue[1]}'),
    );
    points.add(item);
  }
  return points;
}
