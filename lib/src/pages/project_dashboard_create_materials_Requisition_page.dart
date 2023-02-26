import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class ProjectDashbordCreateMaterialsRequisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: hexToColor('#9BA9B3'),
            )),
        title: Padding(
          padding: const EdgeInsets.only(right: 150),
          child: KText(
            text: 'MR # A22100501',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    RenderSvg(
                      path: 'icon_5',
                      height: 18,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    KText(
                      text: 'Material List',
                      fontSize: 18,
                      bold: true,
                    ),
                    Spacer(),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: hexToColor('#FFECD6')),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: KText(
                          text: '04',
                          fontSize: 18,
                          bold: true,
                          color: hexToColor('#FFA133'),
                        ),
                      ),
                    ),
                  ],
                ),
                DottedLine(
                  lineThickness: 1,
                  dashColor: hexToColor(
                    '#80939D',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: hexToColor('#DBECFB'), width: 2)),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: 40,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(12),
                            // border: Border.all(),
                            color: hexToColor('#DBECFB')),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            KText(
                              text: 'Material Name 01',
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(text: 'Code'),
                            KText(text: 'Drop Location'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(text: '26345634'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                KText(text: 'Location 01'),
                              ],
                            ),
                          ),
                          Divider(color: hexToColor('#DBECFB')),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(text: 'Quantity'),
                            KText(text: '100 PCs'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
