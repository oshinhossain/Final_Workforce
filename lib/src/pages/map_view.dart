import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/config/base.dart';

class MapView extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapViewC.kMapController,
      options: MapOptions(
        center: LatLng(23.777176, 90.412521),
        zoom: 15.0,
        minZoom: 1.0,
        maxZoom: 90,
      ),
      children: [
        TileLayer(
          userAgentPackageName: 'com.ctrendssoftware.workforce',
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          // subdomains: ['a', 'b', 'c'],
        ),
        CircleLayer(circles: [
          CircleMarker(
            point: LatLng(23.7779, 90.4100),
            radius: 6,
            color: Colors.white,
            borderStrokeWidth: 4,
            borderColor: AppTheme.primaryColor,
          ),
          CircleMarker(
            point: LatLng(23.7779, 90.4135),
            radius: 6,
            color: Colors.white,
            borderStrokeWidth: 4,
            borderColor: AppTheme.color2,
          ),
          CircleMarker(
            point: LatLng(23.7779, 90.4120),
            radius: 6,
            color: Colors.white,
            borderStrokeWidth: 4,
            borderColor: AppTheme.color2,
          ),
          CircleMarker(
            point: LatLng(23.7774, 90.4149),
            radius: 6,
            color: Colors.white,
            borderStrokeWidth: 4,
            borderColor: AppTheme.color2,
          ),
          CircleMarker(
            point: LatLng(23.7760, 90.4159),
            radius: 6,
            color: Colors.white,
            borderStrokeWidth: 4,
            borderColor: AppTheme.delivrdColor,
          ),
        ]),
        MarkerLayer(markers: [
          Marker(
            //marker
            width: 30.0,
            height: 30.0,
            builder: (context) {
              return GestureDetector(
                  onTap: () {},
                  child: RenderImg(
                    path: 'loc.png',
                    height: 30,
                    width: 30,
                  ));
            },
            point: LatLng(23.7760, 90.4135),
          ),
        ]),
      ],
    );
  }
}
