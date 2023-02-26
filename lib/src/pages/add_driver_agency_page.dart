import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/main_page.dart';

import 'package:workforce/src/pages/select_driver_page.dart';

class AddDriverToAgencyPage extends StatefulWidget {
  @override
  State<AddDriverToAgencyPage> createState() => _AddDriverToAgencyPageState();
}

class _AddDriverToAgencyPageState extends State<AddDriverToAgencyPage>
    with Base {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    await Future.delayed(Duration(milliseconds: 100));
    vehicleAndDriverC.getAgencyDriver();
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
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            push(MainPage());
          },
        ),
        title: Text('Add Driver to Agency'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              ListTile(
                leading: RenderSvg(
                  path: 'uuu',
                  height: 24,
                  width: 24,
                ),
                horizontalTitleGap: 5,
                // minVerticalPadding: 0,
                minLeadingWidth: 10,
                title: Text(
                  'Driver',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.colorS1),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    push(SelectDriverPage());
                  },
                  child: RenderSvg(path: 'icon_add_box'),
                ),
              ),
              DottedLine(
                dashGapLength: 1,
                dashColor: AppTheme.textfieldColor,
                lineLength: size.width - 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: size.height * .7,
                child: vehicleAndDriverC.isLoading.value
                    ? vehicleAndDriverC.isLoading.value
                        ? SizedBox(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : SizedBox(
                            height: Get.height / 1.5,
                            child: Center(child: KText(text: 'No data')),
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: vehicleAndDriverC.agencyDriverModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              vehicleAndDriverC.agencyDriverModel[index];
                          return Padding(
                            padding: EdgeInsets.only(
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
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      splashColor: Colors.grey
                                                          .withOpacity(.2),
                                                      onTap: () {
                                                        Global.confirmDialog(
                                                          onConfirmed: () {
                                                            vehicleAndDriverC
                                                                .deleteDriverAgency(
                                                                    id: item
                                                                        .id!);
                                                            vehicleAndDriverC
                                                                .agencyDriverModel
                                                                .removeWhere(
                                                                    (element) =>
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
                                                KText(
                                                  text: item.preferredTimeFrom,
                                                  bold: true,
                                                ),
                                                KText(
                                                  text: ' - ',
                                                  bold: true,
                                                ),
                                                KText(
                                                  text: item.preferredTimeTo,
                                                  bold: true,
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
                                                KText(
                                                  text: item.ridesKm.toString(),
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                KText(text: 'Vehicle Type: '),
                                                KText(
                                                  text: item.vehicleClass,
                                                  bold: true,
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
    );
  }
}
