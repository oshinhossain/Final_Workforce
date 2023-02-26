import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/v_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/route.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';

class SelectVehiclesPage extends StatefulWidget {
  @override
  State<SelectVehiclesPage> createState() => _SelectVehiclesPageState();
}

class _SelectVehiclesPageState extends State<SelectVehiclesPage> with Base {
  @override
  void dispose() {
    vehicleAndDriverC.vehicleType.value = '';
    vehicleAndDriverC.vehicleGet.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VAppbar(
        title: 'Select Vehicles',
        svgPath: InkWell(
          onTap: () => back(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: RenderSvg(
              path: 'icon_cancel',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                  ),
                ),
                child: TextField(
                  onChanged: vehicleAndDriverC.vehicleType,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 15,
                    // color: hexToColor('#CFD7DA'),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                      hintText: 'A',
                      contentPadding: EdgeInsets.only(
                        left: 15,
                      ),
                      // prefixIcon: IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.emoji_emotions_outlined,
                      //     color: Color(0xff9BA9B3),
                      //     size: 30,
                      //   ),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: .1)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: .1)),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SvgPicture.asset(
                          //   'images/chat/icon_search_user.svg',
                          //   height: 30.0,
                          //   width: 30.0,
                          //   color: Color(0xff9BA9B3),
                          //   allowDrawingOutsideViewBox: true,
                          //   //color: Color(0xff007BEC),
                          // ),
                          InkWell(
                            onTap:
                                vehicleAndDriverC.vehicleType.value.isNotEmpty
                                    ? () {
                                        vehicleAndDriverC.getSelectVehicle();
                                      }
                                    : null,
                            child: RenderSvg(
                              path: 'icon_search_user',
                              height: 20.0,
                              width: 20.0,
                              color: hexToColor('#84BEF3'),
                            ),
                          ),

                          SizedBox(
                            width: 13,
                          )
                        ],
                      )),
                ),
              ),
              vehicleAndDriverC.isLoading.value
                  ? SizedBox(
                      height: Get.height / 1.5,
                      child: Center(
                        child: Loading(),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: vehicleAndDriverC.vehicleGet.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = vehicleAndDriverC.vehicleGet[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  width: 1, color: AppTheme.vehicleItemColor),
                              color: hexToColor('#FFFFFF'),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 34,
                                  width: Get.width,
                                  // color: hexToColor('#FFE9CF'),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: AppTheme.vehicleItemColor,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 20,
                                        height: 25,
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: item!.isChecked,
                                          onChanged: (bool? value) {
                                            // kLog(value);
                                            if (value != null) {
                                              vehicleAndDriverC
                                                  .updateVehicleItem(
                                                id: item.id!,
                                                value: value,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 5, left: 10, top: 5),
                                        child: KText(
                                          text: item.registrationNo,
                                          fontSize: 16,
                                          color: hexToColor('#41525A'),
                                          bold: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            KText(
                                              text: 'Type: ',
                                              fontSize: 14,
                                              color: hexToColor('#80939D'),
                                              bold: false,
                                            ),
                                            KText(
                                              text: item.vehicleType,
                                              fontSize: 14,
                                              bold: true,
                                            ),
                                          ],
                                        ),
                                        item.weightCapacityApplicable == true
                                            ? Row(
                                                children: [
                                                  KText(
                                                    text: 'Weight Capacity: ',
                                                    fontSize: 14,
                                                    color:
                                                        hexToColor('#80939D'),
                                                    bold: false,
                                                  ),
                                                  KText(
                                                    text: item.weightCapacity
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
                                        item.volumeCapacityApplicable == true
                                            ? Row(
                                                children: [
                                                  KText(
                                                    text: 'Volume Capacity: ',
                                                    fontSize: 14,
                                                    color:
                                                        hexToColor('#80939D'),
                                                    bold: false,
                                                  ),
                                                  KText(
                                                    text: item.volumeCapacity
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
                                        item.seatCapacityApplicable == true
                                            ? Row(
                                                children: [
                                                  KText(
                                                    text: 'Volume Capacity: ',
                                                    fontSize: 14,
                                                    color:
                                                        hexToColor('#80939D'),
                                                    bold: false,
                                                  ),
                                                  KText(
                                                    text: item.seatCapacity
                                                        .toString(),
                                                    fontSize: 14,
                                                    bold: true,
                                                  ),
                                                  KText(
                                                    text: ' ',
                                                    fontSize: 14,
                                                  ),
                                                  KText(
                                                    text: item.seatCapacityUnit
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
                                              color: hexToColor('#80939D'),
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
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    height: 70,
                                    width: 100,
                                    padding: EdgeInsets.only(
                                        top: 14,
                                        left: 5,
                                        bottom: 16,
                                        right: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1,
                                          color: AppTheme.vehicleItemColor),
                                    ),
                                    child: Image.asset(
                                      '${Constants.imgPath}/truck-2.png',
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => vehicleAndDriverC.vehicleGet.isEmpty
            ? SizedBox()
            : Container(
                padding: EdgeInsets.all(12),
                // height: 40,
                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                  color: Colors.white,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        vehicleAndDriverC.vehicleAgencyAdd();
                        vehicleAndDriverC.getAgencyVehicle();
                      },
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: hexToColor('#007BEC'),
                        ),
                        child: Center(
                          child: vehicleAndDriverC.isLoading.value
                              ? Loading(
                                  color: Colors.white,
                                )
                              : KText(
                                  text: 'Add Vehicles',
                                  color: Colors.white,
                                  bold: true,
                                ),
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
