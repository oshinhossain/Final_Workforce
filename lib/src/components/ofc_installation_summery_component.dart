import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';

class OfcInstallationSummeryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RenderSvg(path: 'ofc'),
              SizedBox(
                width: 8,
              ),
              KText(
                text: 'OFC Installation Summery',
                fontSize: 16,
                bold: true,
              ),
              SizedBox(
                width: 12,
              ),
              Spacer(),
              KText(
                text: 'Dashboard',
                fontSize: 14,
                // bold: true,
              ),
              SizedBox(
                width: 8,
              ),
              RenderSvg(
                path: 'icon_forward',
                height: 16,
              ),
              SizedBox(
                width: 2,
              ),
            ],
          ),
          SizedBox(height: 8),
          DottedLine(
            lineThickness: 1,
            dashLength: 1.5,
            dashGapLength: 2,
            dashColor: hexToColor(
              '#80939D',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 150,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.0,
                    // assign the color to the border color
                    color: hexToColor('#83C4FF'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: 'Total OFC',
                      bold: true,
                      fontSize: 16,
                      color: hexToColor('#007BEC'),
                    ),
                    KText(
                      text: 'Installed',
                      fontSize: 16,
                      color: hexToColor('#007BEC'),
                    ),
                    Divider(
                      endIndent: 15,
                      indent: 15,
                      color: hexToColor('#007BEC'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'WIP'),
                          KText(text: '1025'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Postpone'),
                          KText(text: '100'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Completed'),
                          KText(text: '925'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 150,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.0,
                    // assign the color to the border color
                    color: hexToColor('#FFC683'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: 'Today Pole',
                      bold: true,
                      fontSize: 16,
                      color: hexToColor('#F88600'),
                    ),
                    KText(
                      text: 'Installed',
                      fontSize: 16,
                      color: hexToColor('#F88600'),
                    ),
                    Divider(
                      endIndent: 15,
                      indent: 15,
                      color: hexToColor('#007BEC'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'WIP'),
                          KText(text: '1025'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Postpone'),
                          KText(text: '100'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: 'Completed'),
                          KText(text: '925'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.0,
                    // assign the color to the border color
                    color: hexToColor('#6DFFD9'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: 'Total OFC',
                      bold: true,
                      fontSize: 16,
                      color: hexToColor('#00C793'),
                    ),
                    KText(
                      text: 'Used',
                      fontSize: 16,
                      color: hexToColor('#00C793'),
                    ),
                    Divider(
                      endIndent: 15,
                      indent: 15,
                      color: hexToColor('#00C793'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: '4-Core'),
                          KText(text: '8 Km'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: '8-Core'),
                          KText(text: '16 Km'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: '12-Core'),
                          KText(text: '24 Km'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(text: '24-Core'),
                          KText(text: '48 Km'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
