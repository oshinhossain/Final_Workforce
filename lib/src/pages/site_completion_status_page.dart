import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/map/flutter_map_view.dart';
import 'package:workforce/src/map/google_map_view.dart';
import '../helpers/loading.dart';

import '../widgets/custom_textfield_with_dropdown.dart';

class SiteCompletionStatusPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    siteCompletionStatusC.getProjectName();

    return WillPopScope(
      onWillPop: () async {
        await 1.delay();
        siteCompletionStatusC.disposeData();
        return Future(
          () => true,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              back();
              siteCompletionStatusC.isGoogleMap.value = false;
              // await 1.delay();
              // siteCompletionStatusC.disposeData();
            },
          ),
          title: KText(
            text: 'Site Completion Status Report',
            bold: true,
            fontSize: 16,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                  top: BorderSide(width: 1.5, color: Colors.grey.shade300),
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(height: 3),
                    if (siteCompletionStatusC.projectNameList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: siteCompletionStatusC
                                .selectedProject.value!.projectName,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: siteCompletionStatusC.projectNameList
                                .map((item) {
                              return DropdownMenuItem(
                                onTap: () {
                                  siteCompletionStatusC.selectedProject.value =
                                      item;
                                },
                                value: item.projectName,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 35,
                                  ),
                                  child: SizedBox(
                                    width: Get.width / 1.3,
                                    child: KText(
                                      text: item.projectName,
                                      fontSize: 13,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (item) {
                              //// kLog('value');
                            },
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  KText(
                                    text: 'Geography',
                                    color: hexToColor('#80939D'),
                                    fontSize: 13,
                                  ),
                                  KText(
                                    text: '*',
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: siteCompletionStatusC
                                    .searchLocationBottomSheet,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: RenderSvg(
                                    path: 'icon_search_user',
                                    height: 20.0,
                                    width: 20.0,
                                    color: Color(0xff9BA9B3),
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (siteCompletionStatusC.siteLocations.value != null)
                            KText(
                              text: siteCompletionStatusC.siteLocations.value ==
                                      null
                                  ? ''
                                  : '${siteCompletionStatusC.siteLocations.value!.geoLevel2Name} > ${siteCompletionStatusC.siteLocations.value!.geoLevel3Name} > ${siteCompletionStatusC.siteLocations.value!.geoLevel4Name}',
                              maxLines: 3,
                            ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              siteCompletionStatusC.isGoogleMap.value
                  ? GoogleMapView()
                  : FlutterMapView(),
              if (siteCompletionStatusC.isLoading.value)
                Positioned(top: 150, right: 150, child: Loading()),
              Positioned(
                top: 15,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteCompletionStatusC.isGoogleMap.toggle();
                    //  siteCompletionStatusC.disposeData();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Container(
                      height: 35, width: 35,
                      //  padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          //  borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle),
                      child: Center(
                        child: KText(
                          text: siteCompletionStatusC.isGoogleMap.value
                              ? 'O'
                              : 'G',
                          fontSize: 18,
                          color: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                right: 10,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // color: AppTheme.siteLocationSelect ,
                        color: hexToColor('#9BA9B3'),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RenderSvg(
                        path: 'filter',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteCompletionStatusC.isPlotingEnable.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: siteCompletionStatusC.isPlotingEnable.value
                            ? AppTheme.siteLocationSelect
                            : hexToColor('#9BA9B3'),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RenderSvg(
                        path: 'info-icon',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                right: 10,
                child: InkWell(
                  onTap: () {
                    // if (siteCompletionStatusC.isGoogleMap.value) gMapC.siteSearchV2();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: RenderSvg(
                        path: 'refresh_icon',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 190,
                right: 10,
                child: InkWell(
                  onTap: () {
                    siteCompletionStatusC.isSateliteViewEnable.toggle();
                    // requestSiteRelocationC.getAreaByIds();
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.map,
                        color: siteCompletionStatusC.isSateliteViewEnable.value
                            ? null
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // bottom: 0,
                top: 230,
                right: 10,
                child: InkWell(
                  onTap: () async {
                    if (siteCompletionStatusC.isGoogleMap.value) {
                      await 3.delay();
                      siteCompletionStatusC.disposeData();
                    } else {
                      siteCompletionStatusC.showCurrentLocationOnMap();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: hexToColor('#9BA9B3'),
                          borderRadius: BorderRadius.circular(50)),
                      child: RenderSvg(
                        path: 'my_place_active',
                      ),
                    ),
                  ),
                ),
              ),
              if (siteCompletionStatusC.isPlotingEnable.value)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    // height: 350,
                    decoration: BoxDecoration(
                      color: hexToColor('#f5f5f5').withOpacity(1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: KText(
                                text: 'Legends:',
                                bold: true,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () => siteCompletionStatusC
                                  .isPlotingEnable
                                  .toggle(),
                              icon: Icon(Icons.close),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DottedLine(
                            dashColor: hexToColor('#D9D9D9'),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Wifi AP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.wifiApCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'wifiap-icon'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Light Post',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.lightPostCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'light-post',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'POP ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.popCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(path: 'pop-icon'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Building',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.buildingCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'building',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'New Pole  ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.newPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'new-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Electricity Pole ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.elePoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'electricity-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Telephone Pole ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      //  text: '(0)',
                                      text:
                                          '(${siteCompletionStatusC.telPoleCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    RenderSvg(
                                      path: 'telephone-pole',
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'Completed ',
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.completeCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2, color: Colors.green)),
                                      child: RenderSvg(
                                        path: 'footprint',
                                        color: Colors.transparent,
                                        height: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: KText(
                                        text: 'Aborted ',
                                        bold: true,
                                        fontSize: 11,
                                      ),
                                    ),
                                    KText(
                                      //  text: '(0)',
                                      text:
                                          '(${siteCompletionStatusC.abortedCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.red,
                                          )),
                                      child: RenderSvg(
                                        path: 'footprint',
                                        color: Colors.transparent,
                                        height: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text: 'WIP/Started/\nRestarted',
                                      bold: true,
                                      fontSize: 11,
                                      maxLines: 3,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    KText(
                                      text:
                                          '(${siteCompletionStatusC.wsrCount})',
                                      color: AppTheme.siteLocationSelect,
                                      bold: true,
                                      fontSize: 11,
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.indigo,
                                          )),
                                      child: RenderSvg(
                                        path: 'footprint',
                                        color: Colors.transparent,
                                        height: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
