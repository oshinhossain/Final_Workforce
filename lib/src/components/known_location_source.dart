import 'package:flutter/material.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

class KnownLocationSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 2,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: KText(
              text: 'Savar, Dhaka',
              fontSize: 15,
              bold: true,
              color: hexToColor('#515D64'),
            ),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 15,
            left: 10,
          ),
          child: KText(
            text: 'Sungai, Manikganj',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 15,
            left: 10,
          ),
          child: KText(
            text: 'Sokhipur, Tangail',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 15,
            left: 10,
          ),
          child: KText(
            text: 'Sonargao, Narayangonj',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 15,
            left: 10,
          ),
          child: KText(
            text: 'Sripur, Gazipur',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            top: 15,
            left: 10,
          ),
          child: KText(
            text: 'Shibpur, Narshingdi',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
        Divider(
          color: hexToColor('#DBECFB'),
          height: 2,
        ),
      ],
    );
  }
}
