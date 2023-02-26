import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/render_svg.dart';

class MapPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterMap(
        mapController: mapViewC.kMapController,
        options: MapOptions(
          center: LatLng(23.773229395435163, 90.41131542577997),
          zoom: 10,
          maxZoom: 10,
        ),
        nonRotatedChildren: [
          Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColor('#00C290'),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColor('#FD8E47'),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColor('#FF4A4A'),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColor('#007BEC'),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                          color: hexToColor('#B9B9B9'),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(bottom: 22),
                      child: GestureDetector(
                        onTap: () {
                          mapViewC.getCurrentLocation();
                        },
                        child: RenderSvg(
                          path: 'my_present_position',
                          width: 62,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          )
        ],
        // dfff
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
    );
  }
}
