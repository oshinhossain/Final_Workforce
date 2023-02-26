import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/widgets/title_bar.dart';

class TransportationDashboardOrdererPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBar(title: 'Transportation Dashboard'),
            SizedBox(
              height: 22,
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_bill'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Transportation Orders I Placed',
                        fontSize: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () => uiC.isExpanded.toggle(),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: uiC.isExpanded.value ? 210 : 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(
                                        color: hexToColor('#DBECFB'),
                                        width: 1)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(),
                                        color: hexToColor('#DBECFB'),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            uiC.isExpanded.value
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          KText(
                                            text: 'Transport Order No.',
                                            bold: true,
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'A21345D6',
                                            bold: true,
                                            fontSize: 14,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding:   EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            color: AppTheme.nTextLightC,
                                          ),
                                          KText(
                                            text: 'ETD',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    uiC.isExpanded.value
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(text: '06 Sep 2022'),
                                                    KText(text: '07 Sep 2022'),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text: 'Pending',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(width: 15,),
                                                    KText(
                                                        text: '06 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                    KText(
                                                        text: '07 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC1,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text: 'Pending',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () => uiC.isExpanded.toggle(),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: uiC.isExpanded.value ? 340 : 330,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.nBorderC3,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  // border: Border.all(
                                  //     color: AppTheme.nBorderC3, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(),
                                        color: hexToColor('#98F2DB'),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            uiC.isExpanded.value
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          KText(
                                            text: 'Transport Order No.',
                                            bold: true,
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'A21345D6',
                                            bold: true,
                                            fontSize: 14,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            color: AppTheme.nTextLightC,
                                          ),
                                          KText(
                                            text: 'ETD',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    uiC.isExpanded.value
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(text: '06 Sep 2022'),
                                                    KText(text: '07 Sep 2022'),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Source',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Gazipur Sadar, Gazipur',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text:
                                                            'Transportation Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Dalta Transport Services',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, bottom: 5),
                                                child: KText(
                                                  text: 'Remarks',
                                                  color: AppTheme.nTextLightC,
                                                ),
                                              ),
                                            
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, bottom: 5),
                                                child: KText(
                                                    text:
                                                        'RCC Poles from BMTF',
                                                    color: AppTheme.nTextC),
                                              ),
                                             
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text:
                                                          'Inspect and Accpted',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(width: 15,),
                                                    KText(
                                                        text: '06 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                    KText(
                                                        text: '07 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Source',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Gazipur Sadar, Gazipur',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text:
                                                            'Transportation Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Dalta Transport Services',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, bottom: 5),
                                                child: KText(
                                                  text: 'Remarks',
                                                  color: AppTheme.nTextLightC,
                                                ),
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, bottom: 5),
                                                child: KText(
                                                    text:
                                                        'Jessore Trade Agency',
                                                    color: AppTheme.nTextC),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC3,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text:
                                                          'Inspect and Accpted',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () => uiC.isExpanded.toggle(),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                height: uiC.isExpanded.value ? 210 : 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(
                                        color: AppTheme.nBorderC4, width: 1)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        // border: Border.all(),
                                        color: AppTheme.nTONColor3,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            uiC.isExpanded.value
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          KText(
                                            text: 'Transport Order No.',
                                            bold: true,
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'A21345D6',
                                            bold: true,
                                            fontSize: 14,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding:   EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            color: AppTheme.nTextLightC,
                                          ),
                                          KText(
                                            text: 'ETD',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    uiC.isExpanded.value
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(text: '06 Sep 2022'),
                                                    KText(text: '07 Sep 2022'),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text:
                                                          'Inspected and Rejeceted',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(width: 15,),
                                                    KText(
                                                        text: '06 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                    KText(
                                                        text: '07 Sep 2022',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Destination',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Sadar, Jessore',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                        text: 'Receiving Party',
                                                        color: AppTheme
                                                            .nTextLightC),
                                                    KText(
                                                        text:
                                                            'Jessore Trade Agency',
                                                        color: AppTheme.nTextC),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                color: AppTheme.nBorderC4,
                                                thickness: 1.2,
                                              ),
                                              Padding(
                                                padding:   EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Status',
                                                      color:
                                                          AppTheme.nTextLightC,
                                                    ),
                                                    KText(
                                                      text:
                                                          'Inspected and Rejeceted',
                                                      bold: true,
                                                      color: AppTheme.nTextC,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
