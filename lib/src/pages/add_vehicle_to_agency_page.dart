import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/v_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/pages/select_vehicles_page.dart';

import '../helpers/global_helper.dart';
import '../helpers/log.dart';

class AddVehicleToAgencyPage extends StatefulWidget {
  @override
  State<AddVehicleToAgencyPage> createState() => _AddVehicleToAgencyPageState();
}

class _AddVehicleToAgencyPageState extends State<AddVehicleToAgencyPage>
    with Base {
  // @override
  // void initState() {
  //   vehicleAndDriverC.getAgencyVehicle();
  //   super.initState();
  // }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    await Future.delayed(Duration(milliseconds: 100));
    vehicleAndDriverC.getAgencyVehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VAppbar(
          title: 'Add Vehicle to Agency',
          // svgPath: InkWell(
          //   onTap: () => back(),
          //   child: RenderSvg(
          //     path: 'icon_back',
          //   ),
          // ),
          svgPath: InkWell(
            onTap: () => push(MainPage()),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: RenderSvg(
                path: 'icon_back',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(children: [
                Row(
                  children: [
                    RenderSvg(path: 'trucklogo'),
                    SizedBox(
                      width: 8,
                    ),
                    KText(
                      text: 'Vehicle',
                      fontSize: 18,
                      bold: true,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => push(SelectVehiclesPage()),
                      child: RenderSvg(path: 'icon_add_box'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DottedLine(dashLength: 0.5),
                SizedBox(
                  height: 10,
                ),
                // !vehicleAndDriverC.isLoading.value
                //     ? SizedBox(
                //         height: Get.height / 1.5,
                //         child: Center(
                //           child: Loading(),
                //         ),
                //       )

                vehicleAndDriverC.agencyVehicleGetModel.isEmpty
                    ? vehicleAndDriverC.isLoading.value
                        ? SizedBox(
                            height: Get.height / 2.2,
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : SizedBox(
                            height: Get.height / 1.5,
                            child: Center(child: KText(text: 'No data')),
                          )
                    : SizedBox(
                        height: Get.height * .8,
                        child: ListView(
                          // shrinkWrap: true,
                          children: vehicleAndDriverC
                              // ignore: invalid_use_of_protected_member
                              .agencyVehicleGetModelname
                              .map((element) {
                            // kLog('print ');
                            kLog(element!);

                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: RenderSvg(
                                          path: 'trucklogo',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      KText(
                                        text: element,
                                        fontSize: 18,
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                  DottedLine(dashLength: 0.5),
                                  SizedBox(height: 10),
                                  ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: vehicleAndDriverC
                                        .getAgencyByVehicleType(type: element)
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = vehicleAndDriverC
                                          .getAgencyByVehicleType(
                                              type: element)[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                width: 1,
                                                color:
                                                    AppTheme.vehicleItemColor),
                                            color: hexToColor('#FFFFFF'),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 34,
                                                width: Get.width,
                                                // color: hexToColor('#FFE9CF'),
                                                decoration: BoxDecoration(
                                                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5)),
                                                  color:
                                                      AppTheme.vehicleItemColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: KText(
                                                          text: item!
                                                              .registrationNo,
                                                          fontSize: 16,
                                                          color: hexToColor(
                                                              '#41525A'),
                                                          bold: true,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      // RenderSvg(path: 'icon_delete'),
                                                      ClipOval(
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .grey
                                                                .withOpacity(
                                                                    .2),
                                                            onTap: () {
                                                              Global
                                                                  .confirmDialog(
                                                                onConfirmed:
                                                                    () {
                                                                  vehicleAndDriverC.deleteVehicleAgency(
                                                                      id: item
                                                                          .id!,
                                                                      vehicleType:
                                                                          item
                                                                              .vehicleType!,
                                                                      item:
                                                                          item);
                                                                  vehicleAndDriverC
                                                                      .agencyDriverModel
                                                                      .removeWhere((element) =>
                                                                          element!
                                                                              .id ==
                                                                          item.id);
                                                                },
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child: RenderSvg(
                                                                  path:
                                                                      'icon_delete'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.white),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          KText(
                                                            text: 'Type: ',
                                                            fontSize: 14,
                                                            color: hexToColor(
                                                                '#80939D'),
                                                            bold: false,
                                                          ),
                                                          KText(
                                                            text: item
                                                                .vehicleType,
                                                            fontSize: 14,
                                                            bold: true,
                                                          ),
                                                        ],
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     KText(
                                                      //       text: 'Capacity: ',
                                                      //       fontSize: 14,
                                                      //       color: hexToColor(
                                                      //           '#80939D'),
                                                      //       bold: false,
                                                      //     ),
                                                      //     KText(
                                                      //       text: item
                                                      //           .weightCapacity
                                                      //           .toString(),
                                                      //       fontSize: 14,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      item.weightCapacityApplicable ==
                                                              true
                                                          ? Row(
                                                              children: [
                                                                KText(
                                                                  text:
                                                                      'Weight Capacity: ',
                                                                  fontSize: 14,
                                                                  color: hexToColor(
                                                                      '#80939D'),
                                                                  bold: false,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .weightCapacity
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                                KText(
                                                                  text: ' ',
                                                                  fontSize: 14,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .weightCapacityUnit
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(),
                                                      item.volumeCapacityApplicable ==
                                                              true
                                                          ? Row(
                                                              children: [
                                                                KText(
                                                                  text:
                                                                      'Volume Capacity: ',
                                                                  fontSize: 14,
                                                                  color: hexToColor(
                                                                      '#80939D'),
                                                                  bold: false,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .volumeCapacity
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                                KText(
                                                                  text: ' ',
                                                                  fontSize: 14,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .volumeCapacityUnit
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(),
                                                      item.seatCapacityApplicable ==
                                                              true
                                                          ? Row(
                                                              children: [
                                                                KText(
                                                                  text:
                                                                      'Volume Capacity: ',
                                                                  fontSize: 14,
                                                                  color: hexToColor(
                                                                      '#80939D'),
                                                                  bold: false,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .seatCapacity
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                                KText(
                                                                  text: ' ',
                                                                  fontSize: 14,
                                                                ),
                                                                KText(
                                                                  text: item
                                                                      .seatCapacityUnit
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(),
                                                      Row(
                                                        children: [
                                                          KText(
                                                            text: 'Brand: ',
                                                            fontSize: 14,
                                                            color: hexToColor(
                                                                '#80939D'),
                                                            bold: false,
                                                          ),
                                                          KText(
                                                            text: item.brand,
                                                            fontSize: 14,
                                                            bold: true,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: 70,
                                                  width: 90,
                                                  padding: EdgeInsets.only(
                                                      top: 14,
                                                      left: 5,
                                                      bottom: 16,
                                                      right: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppTheme
                                                            .vehicleItemColor),
                                                  ),
                                                  child: Image.asset(
                                                    '${Constants.imgPath}/truck-heavy-2.png',
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ]),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ]),
            ),
          ),
        ));
  }
}
