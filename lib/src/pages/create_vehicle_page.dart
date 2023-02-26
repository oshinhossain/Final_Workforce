import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/components/v_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/widgets/custom_textfield_vehicle.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/select_vehicle_type_model.dart';

class CreateVehiclePage extends StatefulWidget {
  @override
  State<CreateVehiclePage> createState() => _CreateVehiclePageState();
}

class _CreateVehiclePageState extends State<CreateVehiclePage> with Base {
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    vehicleAndDriverC.getSelectVehicleType();
    vehicleAndDriverC.selectedBrandItem();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    vehicleAndDriverC.authorityAgencyCode();
  }

  // TextEditingController masters = TextEditingController();

  @override
  void dispose() {
    vehicleAndDriverC.createVehicleDisposeData();
    vehicleAndDriverC.pickedImage.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vehicleAndDriverC.getSelectVehicleType();
    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return Scaffold(
      appBar: VAppbar(
        title: 'Create Vehicle',
        svgPath: InkWell(
          onTap: () => back(),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                back();
              },
            ),
          ),
        ),
      ),
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Obx(
            () => vehicleAndDriverC.selectVehicleType.isEmpty
                ? Center(
                    child: Loading(),
                  )
                : Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 10, top: 3, bottom: 3),
                    child: Column(
                      children: [
                        vehicleAndDriverC.selectVehicleType.isEmpty
                            ? Center(
                                child: Loading(),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: CustomTextFieldVegicle(
                                  title: 'Select Vehicle Type ',
                                  suffix: DropdownButton<SelectVehicleType>(
                                    value: vehicleAndDriverC
                                        .selectedVehicleType.value,
                                    underline: Container(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: hexToColor('#80939D'),
                                    ),
                                    items: vehicleAndDriverC.selectVehicleType
                                        .map((item) {
                                      return DropdownMenuItem<
                                          SelectVehicleType>(
                                        value: item,
                                        child: SizedBox(
                                          width: Get.width - 44,
                                          child: KText(
                                            text: item!.vehicleType,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      vehicleAndDriverC
                                          .selectedVehicleType.value = newValue;
                                      // vehicleAndDriverC.selectedVehicleItem.value = newValue.toString();
                                    },
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: CustomTextFieldVegicle(
                            title: 'Select Brand ',
                            suffix: DropdownButton(
                              value: vehicleAndDriverC.selectedBrandItem.value,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: vehicleAndDriverC.brandItems.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: SizedBox(
                                    width: Get.width - 44,
                                    child: KText(
                                      text: item,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                vehicleAndDriverC.selectedBrandItem.value =
                                    newValue!;
                                // setState(() {
                                //   dropdown = newValue!;
                                // });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: CustomTextFieldVegicle(
                            title: 'Select Model ',
                            suffix: DropdownButton(
                              underline: Container(),
                              value: vehicleAndDriverC.selectedModelItem.value,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: vehicleAndDriverC.modelItems
                                  .map((String itemBarnd) {
                                return DropdownMenuItem(
                                  value: itemBarnd,
                                  child: SizedBox(
                                    width: Get.width - 44,
                                    child: KText(
                                      text: itemBarnd,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                vehicleAndDriverC.selectedModelItem.value =
                                    newValue!;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 2, right: 6, top: 6, bottom: 6),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 3,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(5.0),
                                          //     child: CustomTextFieldVegicle(
                                          //       title: 'Type',
                                          //       hintText: 'Weight',
                                          //       isRequired: false,
                                          //     ),
                                          //   ),
                                          // ),

                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15,
                                                left: 5,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   title!,
                                                  //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                  // ),
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Type',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      // if (isRequired!)
                                                      //   KText(
                                                      //     text: '*',
                                                      //     color: Colors.redAccent,
                                                      //   ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: TextFormField(
                                                      enabled: false,
                                                      cursorColor:
                                                          Color(0xFF90A4AE),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Weight',

                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: 40),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF90A4AE),
                                                          ),
                                                        ),
                                                        // focusColor: hexToColor('#84BEF3'),
                                                        focusColor: Colors.red,
                                                        labelStyle: TextStyle(
                                                            color: Color(
                                                                0xFF424242)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(0),
                                          //     child: Column(
                                          //       children: [
                                          //         KText(
                                          //           text: 'Type',
                                          //           fontSize: 13,
                                          //           color: hexToColor('#80939D'),
                                          //         ),
                                          //         KText(
                                          //           text: 'Weight',
                                          //           fontSize: 13,
                                          //           color: hexToColor('#80939D'),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),

                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   title!,
                                                //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                // ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Quantity',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    // if (isRequired!)
                                                    //   KText(
                                                    //     text: '*',
                                                    //     color: Colors.redAccent,
                                                    //   ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    onChanged: vehicleAndDriverC
                                                        .weightCapacity,
                                                    //controller: controller,
                                                    cursorColor:
                                                        Color(0xFF90A4AE),
                                                    decoration: InputDecoration(
                                                      hintText: '500',

                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF90A4AE),
                                                        ),
                                                      ),
                                                      // focusColor: hexToColor('#84BEF3'),
                                                      focusColor: Colors.red,
                                                      labelStyle: TextStyle(
                                                          color: Color(
                                                              0xFF424242)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CustomTextFieldVegicle(
                                                // onChanged: (x) {
                                                //   vehicleAndDriverC
                                                //       .weightCapacityUnit.value = x!;
                                                // },
                                                onChanged: vehicleAndDriverC
                                                    .weightCapacityUnit,
                                                title: 'Unit',
                                                hintText: 'Ton',
                                                isRequired: false,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(8.0),
                                          //     child: Column(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.start,
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.center,
                                          //       children: [
                                          //         Radio<String>(
                                          //           visualDensity: VisualDensity(
                                          //               horizontal: VisualDensity
                                          //                   .minimumDensity,
                                          //               vertical: VisualDensity
                                          //                   .minimumDensity),
                                          //           materialTapTargetSize:
                                          //               MaterialTapTargetSize
                                          //                   .shrinkWrap,
                                          //           value: authC.gender.value,
                                          //           onChanged: (v) {
                                          //             authC.gender.value = 'male';
                                          //           },
                                          //           groupValue: 'male',
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),

                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: vehicleAndDriverC
                                                    .weightCapacityApplicable
                                                    .value,
                                                onChanged: (bool? value) {
                                                  vehicleAndDriverC
                                                      .weightCapacityApplicable
                                                      .toggle();
                                                  vehicleAndDriverC
                                                      .weightCapacityApplicable
                                                      .value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 3,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(5.0),
                                          //     child: CustomTextFieldVegicle(
                                          //       title: 'Type',
                                          //       hintText: 'Volume',
                                          //       isRequired: false,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15,
                                                left: 5,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   title!,
                                                  //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                  // ),
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Type',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      // if (isRequired!)
                                                      //   KText(
                                                      //     text: '*',
                                                      //     color: Colors.redAccent,
                                                      //   ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: TextFormField(
                                                      enabled: false,
                                                      cursorColor:
                                                          Color(0xFF90A4AE),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Volume',

                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: 40),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF90A4AE),
                                                          ),
                                                        ),
                                                        // focusColor: hexToColor('#84BEF3'),
                                                        focusColor: Colors.red,
                                                        labelStyle: TextStyle(
                                                            color: Color(
                                                                0xFF424242)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   title!,
                                                //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                // ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Quantity',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    // if (isRequired!)
                                                    //   KText(
                                                    //     text: '*',
                                                    //     color: Colors.redAccent,
                                                    //   ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    onChanged: vehicleAndDriverC
                                                        .volumeCapacity,
                                                    //controller: controller,
                                                    cursorColor:
                                                        Color(0xFF90A4AE),
                                                    decoration: InputDecoration(
                                                      hintText: '500',

                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF90A4AE),
                                                        ),
                                                      ),
                                                      // focusColor: hexToColor('#84BEF3'),
                                                      focusColor: Colors.red,
                                                      labelStyle: TextStyle(
                                                          color: Color(
                                                              0xFF424242)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CustomTextFieldVegicle(
                                                onChanged: vehicleAndDriverC
                                                    .volumeCapacityUnit,
                                                title: 'Unit',
                                                hintText: 'Cft',
                                                isRequired: false,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: vehicleAndDriverC
                                                    .volumeCapacityApplicable
                                                    .value,
                                                onChanged: (bool? value) {
                                                  vehicleAndDriverC
                                                      .volumeCapacityApplicable
                                                      .toggle();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 3,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(5.0),
                                          //     child: CustomTextFieldVegicle(
                                          //       title: 'Type',
                                          //       hintText: 'Seat',
                                          //       isRequired: false,
                                          //     ),
                                          //   ),
                                          // ),

                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15,
                                                left: 5,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   title!,
                                                  //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                  // ),
                                                  Row(
                                                    children: [
                                                      KText(
                                                        text: 'Type',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      // if (isRequired!)
                                                      //   KText(
                                                      //     text: '*',
                                                      //     color: Colors.redAccent,
                                                      //   ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: TextFormField(
                                                      enabled: false,
                                                      cursorColor:
                                                          Color(0xFF90A4AE),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Seat',

                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: 40),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF90A4AE),
                                                          ),
                                                        ),
                                                        // focusColor: hexToColor('#84BEF3'),
                                                        focusColor: Colors.red,
                                                        labelStyle: TextStyle(
                                                            color: Color(
                                                                0xFF424242)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Expanded(
                                          //   flex: 3,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(5),
                                          //     child: CustomTextFieldVegicle(
                                          //       title: 'Quantity',
                                          //       hintText: '40',
                                          //       isRequired: false,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   title!,
                                                //   style: TextStyle(fontSize: 16, color: Colors.black54),
                                                // ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Quantity',
                                                      fontSize: 13,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    // if (isRequired!)
                                                    //   KText(
                                                    //     text: '*',
                                                    //     color: Colors.redAccent,
                                                    //   ),
                                                  ],
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    onChanged: vehicleAndDriverC
                                                        .seatCapacity,
                                                    //controller: controller,
                                                    cursorColor:
                                                        Color(0xFF90A4AE),
                                                    decoration: InputDecoration(
                                                      hintText: '40',

                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 40),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF90A4AE),
                                                        ),
                                                      ),
                                                      // focusColor: hexToColor('#84BEF3'),
                                                      focusColor: Colors.red,
                                                      labelStyle: TextStyle(
                                                          color: Color(
                                                              0xFF424242)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CustomTextFieldVegicle(
                                                onChanged: vehicleAndDriverC
                                                    .seatCapacityUnit,
                                                title: 'Unit',
                                                hintText: 'Persons',
                                                isRequired: false,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(8.0),
                                          //     child: Column(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.start,
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.center,
                                          //       children: [
                                          //         Radio<String>(
                                          //           visualDensity: VisualDensity(
                                          //               horizontal: VisualDensity
                                          //                   .minimumDensity,
                                          //               vertical: VisualDensity
                                          //                   .minimumDensity),
                                          //           materialTapTargetSize:
                                          //               MaterialTapTargetSize
                                          //                   .shrinkWrap,
                                          //           value: authC.gender.value,
                                          //           onChanged: (v) {
                                          //             authC.gender.value = 'female';
                                          //           },
                                          //           groupValue: 'female',
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: vehicleAndDriverC
                                                    .seatCapacityApplicable
                                                    .value,
                                                onChanged: (bool? value) {
                                                  vehicleAndDriverC
                                                      .seatCapacityApplicable
                                                      .toggle();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: -12,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      KText(
                                        text: 'Capacity ',
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: '*',
                                        fontSize: 13,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     SizedBox(
                            //       height: 20,
                            //     ),
                            //     CustomTextFieldVegicle(
                            //       title: "Passport Exp Date",
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 10,
                              ),
                              child: vehicleAndDriverC
                                      .registrationDate.value.isEmpty
                                  ? IconButton(
                                      onPressed: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
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
                                          vehicleAndDriverC.registrationDate
                                              .value = formattedDate;
                                        } else {}
                                      },
                                      icon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              KText(
                                                text: 'Registration Date ',
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
                                        DateTime? pickedDate =
                                            await showDatePicker(
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
                                          vehicleAndDriverC.registrationDate
                                              .value = formattedDate;
                                        } else {}
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    .registrationDate.value),
                                            color: AppTheme.appTextColor1,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            Divider(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: CustomTextFieldVegicle(
                            onChanged: vehicleAndDriverC.registrationNo,
                            title: 'Registration Number ',
                            hintText: 'DH LA - 3215487',
                          ),
                        ),
                        Row(
                          children: [
                            KText(
                              text: 'Capture or Upload Vehicle Image ',
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
                              onTap: () => vehicleAndDriverC.vehicleImage(
                                  imageSource: ImageSource.camera,
                                  context: context),
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
                              onTap: () => vehicleAndDriverC.vehicleImage(
                                  imageSource: ImageSource.gallery,
                                  context: context),
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
                            child: vehicleAndDriverC.pickedImage.value != null
                                ? Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    child: vehicleAndDriverC
                                                .pickedImageMemory.value !=
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.memory(
                                              vehicleAndDriverC
                                                  .pickedImageMemory.value!,
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
                                      path: 'image_vehicle',
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
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: vehicleAndDriverC.termsAndCondition.value,
                              onChanged: (bool? value) {
                                vehicleAndDriverC.termsAndCondition.toggle();
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
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => vehicleAndDriverC.selectVehicleType.isEmpty
            ? Center(
                child: Loading(),
              )
            : Container(
                padding: EdgeInsets.all(12),
                // height: 40,
                width: Get.width,

                decoration: BoxDecoration(
                  color: Colors.white,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: vehicleAndDriverC.createVehicleSubmitButtonValid()
                          ? () async {
                              await vehicleAndDriverC.createVehicle();
                              await vehicleAndDriverC.getSelectVehicleType();
                              await vehicleAndDriverC.vehicleImageUplod();
                            }
                          : () {
                              print('No data');
                            },
                      // onTap: () {
                      //   vehicleAndDriverC.vehicleImageUplod();
                      // },
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color:
                              vehicleAndDriverC.createVehicleSubmitButtonValid()
                                  ? hexToColor('#007BEC')
                                  : hexToColor('#007BEC').withOpacity(.5),
                        ),
                        // child: Center(
                        //   child: KText(
                        //     text: 'Create Vehicle',
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
                                  text: 'Create Vehicle',
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
