import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

class SelectDriverPage extends StatefulWidget {
  @override
  State<SelectDriverPage> createState() => _SelectDriverPageState();
}

class _SelectDriverPageState extends State<SelectDriverPage> with Base {
  @override
  void dispose() {
    vehicleAndDriverC.driverName.value = '';
    vehicleAndDriverC.slectDriverModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appbarColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            back();
          },
        ),
        title: Text('Select Driver'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: vehicleAndDriverC.driverName,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: 'A',
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.bdrColor, width: 1),
                      ),
                      suffixIcon: IconButton(
                        onPressed: vehicleAndDriverC.driverName.value.isNotEmpty
                            ? () {
                                vehicleAndDriverC.getSelectDriver();
                              }
                            : null,
                        icon: RenderSvg(
                          path: 'icon_search_user',
                          height: 20.0,
                          width: 20.0,
                          color: hexToColor('#84BEF3'),
                        ),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: size.height * .7,
                child: vehicleAndDriverC.isLoading.value
                    ? Center(
                        child: Loading(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: vehicleAndDriverC.slectDriverModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              vehicleAndDriverC.slectDriverModel[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppTheme.borderColor, width: 1),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 4,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.10),
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              child: ClipRRect(
                                                child: RenderImg(
                                                  path: 'bill.jpeg',
                                                  height: 55,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 22,
                                            width: 47.5,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6),
                                            decoration: BoxDecoration(
                                              color: AppTheme.rattingColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              item!.userRating.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          RenderSvg(
                                            path: 'done',
                                            color: AppTheme.rateColor,
                                            height: 22,
                                            width: 22,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                // SizedBox(
                                                //   height: 25,
                                                //   width: 25,
                                                //   child: Checkbox(
                                                //     checkColor: Colors.white,
                                                //     fillColor:
                                                //         MaterialStateProperty
                                                //             .resolveWith(
                                                //                 getColor),
                                                //     value: vehicleAndDriverC
                                                //         .isselectIsDriver.value,
                                                //     onChanged: (bool? value) {
                                                //       vehicleAndDriverC
                                                //           .isselectIsDriver
                                                //           .toggle();
                                                //     },
                                                //   ),
                                                // ),

                                                SizedBox(
                                                  width: 20,
                                                  height: 25,
                                                  child: Checkbox(
                                                    checkColor: Colors.white,
                                                    value: item.isChecked,
                                                    onChanged: (bool? value) {
                                                      // kLog(value);
                                                      if (value != null) {
                                                        vehicleAndDriverC
                                                            .updateDriverItem(
                                                          id: item.id!,
                                                          value: value,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                KText(
                                                  text: item.driverFullname,
                                                  fontSize: 14,
                                                  bold: true,
                                                ),
                                                Spacer(),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: item.licenseType ==
                                                            'Professional'
                                                        ? hexToColor('#61ADF2')
                                                        : hexToColor('#FF9191'),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: KText(
                                                    text: item.licenseType,
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    bold: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                KText(text: 'City: '),
                                                KText(
                                                  text: item.preferredCity,
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                KText(text: 'Preferable Time:'),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      KText(
                                                        text: item
                                                            .preferredTimeFrom,
                                                        bold: true,
                                                      ),
                                                      KText(
                                                        text: ' - ',
                                                        bold: true,
                                                      ),
                                                      KText(
                                                        text: item
                                                            .preferredTimeTo,
                                                        bold: true,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                KText(
                                                    text: 'Completed Rides: '),
                                                Expanded(
                                                  child: KText(
                                                    text: item.ridesCount
                                                        .toString(),
                                                    bold: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                KText(text: 'Vehicle Type: '),
                                                Expanded(
                                                  child: KText(
                                                    text: item.vehicleClass,
                                                    bold: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => vehicleAndDriverC.slectDriverModel.isEmpty
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
                        // vehicleAndDriverC.getAgencyDriver();
                        vehicleAndDriverC.driverAgencyAdd();
                      },
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: hexToColor('#007BEC'),
                        ),
                        // child: Center(
                        //   child: KText(
                        //     text: 'Add Driver',
                        //     color: Colors.white,
                        //     bold: true,
                        //   ),
                        // ),
                        child: Center(
                          child: vehicleAndDriverC.isLoading.value
                              ? Loading(
                                  color: Colors.white,
                                )
                              : KText(
                                  text: 'Add Driver',
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
