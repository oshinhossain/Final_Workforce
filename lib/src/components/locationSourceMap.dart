import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

class LocationSourceMap extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: FlutterMap(
            mapController: mapViewC.kMapController,
            options: MapOptions(
              center: LatLng(51.5, -0.09),
              zoom: 5,
            ),
            // nonRotatedChildren: [
            //   Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           // mapViewC.changeMap();
            //           // mapViewC.getLoc();
            //         },
            //         icon: Icon(Icons.control_point_sharp),
            //       )
            //     ],
            //   )
            // ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.ctrendssoftware.workforce',
              ),
              MarkerLayer(
                markers: [],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          height: 40,
          width: Get.width,
          // margin: EdgeInsets.symmetric(vertical: .5),

          decoration: BoxDecoration(
            color: Colors.white,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: hexToColor('#007BEC'),
                ),
                child: Center(
                  child: KText(
                    text: 'Select',
                    color: Colors.white,
                    bold: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
