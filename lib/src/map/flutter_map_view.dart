import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';

class FlutterMapView extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: siteCompletionStatusC.kMapControllerSiteLocation,
      options: MapOptions(
        absorbPanEventsOnScrollables: false,
        center: LatLng(locationC.currentLatLng!.latitude,
            locationC.currentLatLng!.longitude),
        zoom: 15,
        maxZoom: 90,
        onTap: (tapPosition, latLng) {
          // kLog(latLng);
        },
      ),
      children: [
        // ---------------google Satellite Map view -------------------
        TileLayer(
          urlTemplate: siteCompletionStatusC.isSateliteViewEnable.value
              ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.ctrendssoftware.workforce',
        ),

        // =========== To show current location on map ===============
        CircleLayer(
          circles: siteCompletionStatusC.currentLocationCircleMarker,
        ),

        //================== Draw area polygon =====================

        PolygonLayer(
          polygonCulling: false,
          polygons: [
            Polygon(
              points: siteCompletionStatusC.pointsForPolygon,
              // color: Colors.blue,
              borderStrokeWidth: 3,
              borderColor: hexToColor('#00D8A0'),
              // color: hexToColor('#e6f2d9').withOpacity(.8),
              // isFilled: true,
            ),
          ],
        ),

        MarkerLayer(markers: siteCompletionStatusC.projectSiteMarkers),
      ],
    );
  }
}
