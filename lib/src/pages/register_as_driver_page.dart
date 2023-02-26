import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/widgets/custom_textfield_vehicle.dart';
import '../components/v_appbar.dart';
import '../helpers/loading.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RegisterAsDriverPage extends StatefulWidget {
  @override
  State<RegisterAsDriverPage> createState() => _RegisterAsDriverPageState();
}

class _RegisterAsDriverPageState extends State<RegisterAsDriverPage> with Base {
  @override
  void dispose() {
    vehicleAndDriverC.licenseNo.value = '';
    vehicleAndDriverC.selectedlicenseType.value = 'Professional';
    vehicleAndDriverC.issuanceDate.value = '';
    vehicleAndDriverC.expirtyDate.value = '';
    vehicleAndDriverC.registerDriverDisposeData();
    super.dispose();
  }

  // diss() async {
  //   await vehicleAndDriverC.registerDriverDisposeData();
  // }
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    vehicleAndDriverC.getSelectedVehicleClassList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    // vehicleAndDriverC.registerDriverDisposeData();

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.searchColor;
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppTheme.appbarColor,
      //   centerTitle: true,
      //   title: Text('Register as a Driver'),
      // ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   vehicleAndDriverC.drivinLicenseImageUplodFront();
      //   vehicleAndDriverC.drivinLicenseImageUplodBack();
      // }),
      appBar: VAppbar(
        title: 'Register as a Driver',
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

      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: CustomTextFieldVegicle(
                    title: 'License No.',
                    onChanged: vehicleAndDriverC.licenseNo,
                  ),
                ),

                CustomTextFieldVegicle(
                  title: 'License Type ',
                  suffix: DropdownButton(
                    value: vehicleAndDriverC.selectedlicenseType.value,
                    underline: Container(),
                    icon: Flexible(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: hexToColor('#80939D'),
                      ),
                    ),
                    items: vehicleAndDriverC.licenseType.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: SizedBox(
                          width: Get.width - 44,
                          child: KText(
                            text: item,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      vehicleAndDriverC.selectedlicenseType.value = newValue!;
                      // setState(() {
                      //   dropdown = newValue!;
                      // });
                    },
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //   left: 8,
                      //   right: 8,
                      //   top: 10,
                      // ),
                      child: vehicleAndDriverC.issuanceDate.value.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  vehicleAndDriverC.issuanceDate.value =
                                      formattedDate;
                                } else {}
                              },
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'License Issue Date ',
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: '*',
                                        fontSize: 13,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppTheme.primaryColor,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  vehicleAndDriverC.issuanceDate.value =
                                      formattedDate;
                                } else {}
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'License Issue Date',
                                    color: AppTheme.appTextColor1,
                                    fontSize: 13,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  KText(
                                    fontSize: 13,
                                    text: formatDate(
                                        date: vehicleAndDriverC
                                            .issuanceDate.value),
                                    color: AppTheme.appTextColor1,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                    Container(
                      // margin: EdgeInsets.only(
                      //   left: 8,
                      //   right: 8,
                      //   top: 10,
                      // ),
                      child: vehicleAndDriverC.expirtyDate.value.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2050),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  vehicleAndDriverC.expirtyDate.value =
                                      formattedDate;
                                } else {}
                              },
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'License Expire Date ',
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: '*',
                                        fontSize: 13,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppTheme.primaryColor,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  //firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2050),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  vehicleAndDriverC.expirtyDate.value =
                                      formattedDate;
                                } else {}
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Registration Date',
                                    color: AppTheme.appTextColor1,
                                    fontSize: 13,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  KText(
                                    fontSize: 13,
                                    text: formatDate(
                                        date: vehicleAndDriverC
                                            .expirtyDate.value),
                                    color: AppTheme.appTextColor1,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: CustomTextFieldVegicle(
                    title: 'License Authority ',
                    onChanged: vehicleAndDriverC.licenseAuthority,
                  ),
                ),

                // CustomTextField(
                //   title: 'Driving License (Front Side)',
                //   suffix: Container(
                //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //     margin: EdgeInsets.symmetric(
                //       vertical: 15,
                //     ),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         border:
                //             Border.all(width: 2, color: AppTheme.textfieldColor)),
                //     child: RenderSvg(
                //       path: 'driving_license',
                //       height: 130,
                //       width: 120,
                //     ),
                //   ),
                // ),
                Row(
                  children: [
                    KText(
                      text: 'Driving License (Front Side) ',
                      color: AppTheme.textfieldColor,
                      fontSize: 13,
                    ),
                    KText(
                      text: '*',
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => vehicleAndDriverC.licenseFontImage(
                          imageSource: ImageSource.camera),
                      child: RenderSvg(
                        path: 'icon_camera',
                        width: 25.0,
                        color: AppTheme.skyBuluColor,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () => vehicleAndDriverC.licenseFontImage(
                          imageSource: ImageSource.gallery),
                      child: RenderSvg(
                        path: 'icon_image',
                        width: 25.0,
                        color: AppTheme.skyBuluColor,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: vehicleAndDriverC.pickedImageFont.value != null
                        ? Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child:
                                vehicleAndDriverC.pickedImageMemoryFont.value !=
                                        null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          vehicleAndDriverC
                                              .pickedImageMemoryFont.value!,
                                          fit: BoxFit.cover,
                                          width: Get.width,
                                          height: 195,
                                        ),
                                      )
                                    : Loading(
                                        color: Colors.green,
                                      ),
                          )
                        : Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: RenderSvg(
                              path: 'image_license_front',
                              width: Get.width,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    KText(
                      text: 'Driving License (Back Side) ',
                      color: AppTheme.textfieldColor,
                      fontSize: 13,
                    ),
                    KText(
                      text: '*',
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => vehicleAndDriverC.licenseBackImage(
                          imageSource: ImageSource.camera),
                      child: RenderSvg(
                        path: 'icon_camera',
                        width: 25.0,
                        color: AppTheme.skyBuluColor,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () => vehicleAndDriverC.licenseBackImage(
                          imageSource: ImageSource.gallery),
                      child: RenderSvg(
                        path: 'icon_image',
                        width: 25.0,
                        color: AppTheme.skyBuluColor,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: vehicleAndDriverC.pickedImageBack.value != null
                        ? Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child:
                                vehicleAndDriverC.pickedImageMemoryBack.value !=
                                        null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          vehicleAndDriverC
                                              .pickedImageMemoryBack.value!,
                                          fit: BoxFit.cover,
                                          width: Get.width,
                                          height: 195,
                                        ),
                                      )
                                    : Loading(
                                        color: Colors.green,
                                      ),
                          )
                        : Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: RenderSvg(
                              path: 'image_license_back',
                              width: Get.width,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: vehicleAndDriverC.isDriver.isTrue,
                        onChanged: (bool? value) {
                          vehicleAndDriverC.isDriver.isTrue;
                        },
                      ),
                    ),
                    Text(
                      'Vehicle Class',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppTheme.textfieldColor),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.heavy.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.heavy.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Heavy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.motorcycle.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.motorcycle.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Motorcycle',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.other.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.other.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Others',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.medium.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.medium.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Medium',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.three.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.three.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Three Wheelers',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.light.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.light.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'Light',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: vehicleAndDriverC.psv.value,
                                  onChanged: (bool? value) {
                                    vehicleAndDriverC.psv.toggle();
                                  },
                                ),
                              ),
                              Text(
                                'PSV',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppTheme.textfieldColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: vehicleAndDriverC.termsAndConditionsDriver.value,
                      onChanged: (bool? value) {
                        vehicleAndDriverC.termsAndConditionsDriver.toggle();
                      },
                    ),
                    KText(
                      text: 'I agree with the',
                      fontSize: 14,
                    ),
                    KText(
                      text: ' Terms and conditions',
                      fontSize: 14,
                      bold: true,
                      color: AppTheme.yellowColor,
                    ),
                  ],
                ),
                // SizedBox(height: ,),
                GestureDetector(
                  //onTap: () => vehicleAndDriverC.creatDriver(),
                  onTap: vehicleAndDriverC.createDriverSubmitButtonValid()
                      ? () {
                          vehicleAndDriverC.createDriver();
                          vehicleAndDriverC.getAgencyDriver();
                          vehicleAndDriverC.drivinLicenseImageUplodFront();
                          vehicleAndDriverC.drivinLicenseImageUplodBack();
                        }
                      : () {
                          print('No data');
                        },

                  // onTap: () {
                  //   vehicleAndDriverC.drivinLicenseImageUplodFront();
                  //   vehicleAndDriverC.drivinLicenseImageUplodBack();
                  // },
                  child: Container(
                    height: 34,
                    width: 109,
                    decoration: BoxDecoration(
                        color: vehicleAndDriverC.createDriverSubmitButtonValid()
                            ? hexToColor('#007BEC')
                            : hexToColor('#007BEC').withOpacity(.5),
                        borderRadius: BorderRadius.circular(5)),
                    // child: Center(
                    //   child: Text(
                    //     'Confirm',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 16,
                    //         color: Colors.white),
                    //   ),
                    // ),
                    child: Center(
                      child: vehicleAndDriverC.isLoading.value
                          ? Loading(
                              color: Colors.white,
                            )
                          : KText(
                              text: 'Confirm',
                              color: Colors.white,
                              bold: true,
                            ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
