import 'package:get/state_manager.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workforce/src/config/base.dart';
import 'package:flutter/material.dart';

class GoogleMapView extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GoogleMap(
        // controller: gMapC.kMapController,
        myLocationEnabled: true,
        trafficEnabled: true,
        buildingsEnabled: true,
        mapToolbarEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        myLocationButtonEnabled: true,
        rotateGesturesEnabled: true,
        // indoorViewEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: siteCompletionStatusC.allMarkers.isEmpty
              ? LatLng(locationC.currentLatLng!.latitude,
                  locationC.currentLatLng!.longitude)
              : siteCompletionStatusC.allMarkers.first.position,
          zoom: 18,
        ),
        markers: Set<Marker>.of(siteCompletionStatusC.allMarkers),
        // onCameraMoveStarted: ,
        // onCameraMove: (position) => CameraPosition(
        //   target: siteCompletionStatusC.allMarkers.first.position,
        //   zoom: 18,
        // ),
        onMapCreated: (GoogleMapController controller) {
          siteCompletionStatusC.mapController = controller;
        },
        polygons: Set<Polygon>.of(siteCompletionStatusC.polygone),
        //  polylines: siteCompletionStatusC.polyline,
      ),
    );
  }
}
