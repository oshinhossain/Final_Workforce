// ignore_for_file: unused_import

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';

import 'package:workforce/src/widgets/title_bar.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../controllers/project_dashboard_create_controller.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_svg.dart';

import '../widgets/custom_textfield_projectdashboard.dart';
import '../widgets/custom_textfield_vehicle.dart';

class ProjectDashboardCreateProjectPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // projectDashboardCreateC.getProjectName();

    return Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              CenterTitleBar(title: 'Create Project'),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Project Logo',
                        fontSize: 14,
                        color: hexToColor('#80939D'),
                      ),
                      GestureDetector(
                        onTap: () {
                          authC.selectAvatar();
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppTheme.appbarColor,
                                radius: 50,
                                child: authC.pickedImage.value != null
                                    ? ClipOval(
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(50),
                                            // Image radius
                                            child: authC.pickedImageMemory
                                                        .value !=
                                                    null
                                                ? Image.memory(
                                                    authC.pickedImageMemory
                                                        .value!,
                                                    fit: BoxFit.cover)
                                                : Loading(
                                                    color:
                                                        AppTheme.primaryColor,
                                                  )),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: AppTheme.color4,
                                        radius: 45,
                                        child: SvgPicture.asset(
                                          '${Constants.svgPath}/avatar_placeholder.svg',
                                        ),
                                      ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.color4,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: SvgPicture.asset(
                                      '${Constants.svgPath}/cam.svg',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      KText(
                        text: 'Project Code',
                        fontSize: 13,
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      KText(
                        text: '(Auto)',
                        fontSize: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: hexToColor('#DFE4E8'),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                              text: 'Project Start Date',
                              color: AppTheme.nTextLightC,
                              fontSize: 14),
                          SizedBox(
                            width: 2,
                          ),
                          KText(
                            text: '*',
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => projectDashboardCreateC
                                .selectDate(DateType.start),
                            child: Icon(
                              EvaIcons.calendarOutline,
                              color: AppTheme.primaryColor.withOpacity(.7),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              KText(
                                text: 'Project End Date',
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              KText(
                                text: '*',
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () => projectDashboardCreateC
                                    .selectDate(DateType.end),
                                child: Icon(
                                  EvaIcons.calendarOutline,
                                  color: AppTheme.primaryColor.withOpacity(.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: KText(
                                      text: projectDashboardCreateC
                                              .scheduledStartDate.value.isEmpty
                                          ? '--/--/--'
                                          : formatDate(
                                              date: projectDashboardCreateC
                                                  .scheduledStartDate.value),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: KText(
                                      text: projectDashboardCreateC
                                              .scheduledEndDate.value.isEmpty
                                          ? '--/--/--'
                                          : formatDate(
                                              date: projectDashboardCreateC
                                                  .scheduledEndDate.value),
                                    ),
                                  ),
                                ],
                              ),
                              // Container(
                              //     height: 1,
                              //     width: 100,
                              //     color: AppTheme.nBorderC1,
                              //     child: Divider(
                              //       thickness: .5,
                              //       color: AppTheme.nBorderC1,
                              //     )),
                            ],
                          ),
                        ],
                      ),
                      // Ro
                      Divider(
                        thickness: 1.2,
                        color: AppTheme.nBorderC1,
                      ),
                      Row(
                        children: [
                          KText(
                            text: 'Project Name',
                            color: AppTheme.nTextLightC,
                            fontSize: 14,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          KText(
                            text: '*',
                            color: Colors.red,
                          )
                        ],
                      ),
                      TextFormField(
                        onChanged: projectDashboardCreateC.projectName,
                        decoration: InputDecoration(
                          labelText: 'Project name will be here',
                          labelStyle: TextStyle(
                              color: hexToColor('#D9D9D9'), fontSize: 14),
                        ),
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Obx(
                          () => CustomTextFieldProjectdashboard(
                            title: 'Project Type',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              value: projectDashboardCreateC
                                  .selectAgencyCollobration.value,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectDashboardCreateC.agencyCollobration
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectDashboardCreateC
                                        .selectAgencyCollobration.value = item;
                                  },
                                  value: item,
                                  child: SizedBox(
                                    width: Get.width / 1.2,
                                    child: KText(
                                      text: item,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // projectDashboardCreateC
                                //     .selectAgencyCollobration.value = newValue!;
                              },
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        child: CustomTextFieldProjectdashboard(
                          isTooltipRequired: true,
                          title: 'Agency Collaboration Type',
                          suffix: DropdownButton(
                            value:
                                projectDashboardCreateC.selectProjectType.value,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: projectDashboardCreateC.projecTypecreate
                                .map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: SizedBox(
                                  width: Get.width / 1.2,
                                  child: KText(
                                    text: item,
                                    fontSize: 15,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              projectDashboardCreateC.selectProjectType.value =
                                  newValue!;
                            },
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                              text: 'Output Quantity',
                              color: AppTheme.nTextLightC,
                              fontSize: 14),
                          SizedBox(
                            width: 2,
                          ),
                          KText(
                            text: '*',
                            color: Colors.red,
                          ),
                          Spacer(),
                          KText(
                            text: 'Unit of Measure',
                            color: AppTheme.nTextLightC,
                            fontSize: 14,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          KText(
                            text: '*',
                            color: Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 50,
                                child: TextFormField(
                                  onChanged: projectDashboardCreateC.quntity,
                                  cursorColor: Color(0xFF90A4AE),
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    constraints: BoxConstraints(maxHeight: 40),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF90A4AE),
                                      ),
                                    ),
                                    focusColor: Color(0xFF90A4AE),
                                    labelStyle:
                                        TextStyle(color: Color(0xFF424242)),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 1,
                                  width: 100,
                                  color: AppTheme.nBorderC1,
                                  child: Divider(
                                    thickness: .5,
                                    color: AppTheme.nBorderC1,
                                  )),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 50,
                                child: TextFormField(
                                  onChanged: projectDashboardCreateC.quntity,
                                  cursorColor: Color(0xFF90A4AE),
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    constraints: BoxConstraints(maxHeight: 40),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF90A4AE),
                                      ),
                                    ),
                                    focusColor: Color(0xFF90A4AE),
                                    labelStyle:
                                        TextStyle(color: Color(0xFF424242)),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 1,
                                  width: 100,
                                  color: AppTheme.nBorderC1,
                                  child: Divider(
                                    thickness: .5,
                                    color: AppTheme.nBorderC1,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KText(
                        text: 'Project Manager',
                        color: AppTheme.nTextLightC,
                        fontSize: 14,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          KText(
                              text: projectDashboardCreateC
                                          .projectManager.value !=
                                      null
                                  ? projectDashboardCreateC
                                      .projectManager.value!.fullname
                                  : '',
                              color: AppTheme.nTextC,
                              fontSize: 14),
                          Spacer(),
                          SizedBox(
                            child: IconButton(
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                await projectDashboardCreateC
                                    .searchUserBottomsheet();
                              },
                              icon: RenderSvg(
                                path: 'icon_top_bar_search',
                                width: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.2,
                        color: hexToColor('#BFCAD2'),
                      ),

                      // Stack(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(top: 15, bottom: 6),
                      //       child: Container(
                      //         width: Get.width,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(6),
                      //             border:
                      //                 Border.all(color: Colors.grey.shade400)),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //             left: 5,
                      //             right: 5,
                      //           ),
                      //           child: Column(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     flex: 3,
                      //                     child: Padding(
                      //                       padding: EdgeInsets.all(5),
                      //                       child: CustomTextFieldVegicle(
                      //                         // onChanged: vehicleAndDriverC
                      //                         //     .seatCapacityUnit,
                      //                         title: 'Area Type',
                      //                         hintText: 'Persons',
                      //                         isRequired: false,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 20,
                      //                   ),
                      //                   Expanded(
                      //                     flex: 3,
                      //                     child: Padding(
                      //                       padding: EdgeInsets.all(5),
                      //                       child: CustomTextFieldVegicle(
                      //                         // onChanged: vehicleAndDriverC
                      //                         //     .seatCapacityUnit,
                      //                         title: 'Level',
                      //                         hintText: '4',
                      //                         isRequired: false,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               Row(
                      //                 children: [
                      //                   Checkbox(
                      //                     checkColor: Colors.white,
                      //                     // fillColor: MaterialStateProperty
                      //                     //     .resolveWith(getColor),
                      //                     value: vehicleAndDriverC
                      //                         .seatCapacityApplicable.value,
                      //                     onChanged: (bool? value) {
                      //                       vehicleAndDriverC
                      //                           .seatCapacityApplicable
                      //                           .toggle();
                      //                     },
                      //                   ),
                      //                   KText(
                      //                     text:
                      //                         'Is work location restricted to geography ?  ',
                      //                     fontSize: 13,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       left: 30,
                      //       top: -25,
                      //       child: Container(
                      //         color: Colors.white,
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Checkbox(
                      //                 checkColor: Colors.white,
                      //                 // fillColor: MaterialStateProperty
                      //                 //     .resolveWith(getColor),
                      //                 value: vehicleAndDriverC
                      //                     .seatCapacityApplicable.value,
                      //                 onChanged: (bool? value) {
                      //                   vehicleAndDriverC.seatCapacityApplicable
                      //                       .toggle();
                      //                 },
                      //               ),
                      //               KText(
                      //                 text: 'Is spread over geographies ?  ',
                      //                 fontSize: 13,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     // Row(
                      //     //   children: [
                      //     //     SizedBox(
                      //     //       height: 20,
                      //     //     ),
                      //     //     CustomTextFieldVegicle(
                      //     //       title: "Passport Exp Date",
                      //     //     ),
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Stack(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(top: 15, bottom: 6),
                      //       child: Container(
                      //         width: Get.width,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(6),
                      //             border:
                      //                 Border.all(color: Colors.grey.shade400)),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //             left: 5,
                      //             right: 5,
                      //           ),
                      //           child: Column(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   Checkbox(
                      //                     checkColor: Colors.white,
                      //                     // fillColor: MaterialStateProperty
                      //                     //     .resolveWith(getColor),
                      //                     value: vehicleAndDriverC
                      //                         .seatCapacityApplicable.value,
                      //                     onChanged: (bool? value) {
                      //                       vehicleAndDriverC
                      //                           .seatCapacityApplicable
                      //                           .toggle();
                      //                     },
                      //                   ),
                      //                   KText(
                      //                     text:
                      //                         'Is work location restricted to geography ?  ',
                      //                     fontSize: 13,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       left: 30,
                      //       top: -25,
                      //       child: Container(
                      //         color: Colors.white,
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Checkbox(
                      //                 checkColor: Colors.white,

                      //                 // fillColor: MaterialStateProperty
                      //                 //     .resolveWith(getColor),
                      //                 value: vehicleAndDriverC
                      //                     .seatCapacityApplicable.value,
                      //                 onChanged: (bool? value) {
                      //                   vehicleAndDriverC.seatCapacityApplicable
                      //                       .toggle();
                      //                 },
                      //               ),
                      //               KText(
                      //                 text:
                      //                     'Is test needed on the project output ?  ',
                      //                 fontSize: 13,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     // Row(
                      //     //   children: [
                      //     //     SizedBox(
                      //     //       height: 20,
                      //     //     ),
                      //     //     CustomTextFieldVegicle(
                      //     //       title: "Passport Exp Date",
                      //     //     ),
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),

                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.check_box,
                      //       color: hexToColor('#84BEF3'),
                      //     ),
                      //     SizedBox(width: 8),
                      //     KText(
                      //       text: 'Include Completed Geographies',
                      //       fontSize: 15,
                      //     ),
                      //   ],
                      // ),
                      // //
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Stack(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(top: 15, bottom: 6),
                      //       child: Container(
                      //         width: Get.width,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(6),
                      //             border:
                      //                 Border.all(color: Colors.grey.shade400)),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //             left: 5,
                      //             right: 5,
                      //           ),
                      //           child: Column(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   SizedBox(
                      //                     child: IconButton(
                      //                       constraints: BoxConstraints(),
                      //                       padding: EdgeInsets.all(0),
                      //                       onPressed: () async {
                      //                         await projectDashboardCreateC
                      //                             .searchUserBottomsheet();
                      //                       },
                      //                       icon: RenderSvg(
                      //                         path: 'icon_top_bar_search',
                      //                         width: 16,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 8,
                      //                   ),
                      //                   KText(text: 'BTCL Haor-Ba...'),
                      //                   SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                   RenderSvg(
                      //                     path: 'icon_forward',
                      //                     height: 12,
                      //                   ),
                      //                   SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                   KText(text: 'Pole'),
                      //                   SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                   RenderSvg(
                      //                     path: 'icon_forward',
                      //                     height: 12,
                      //                   ),
                      //                   KText(
                      //                     text: ' Group',
                      //                   ),
                      //                   SizedBox(
                      //                     width: 5,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       left: 30,
                      //       top: -25,
                      //       child: Container(
                      //         color: Colors.white,
                      //         child: Padding(
                      //           padding: EdgeInsets.only(
                      //             top: 10,
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Checkbox(
                      //                 checkColor: Colors.white,

                      //                 // fillColor: MaterialStateProperty
                      //                 //     .resolveWith(getColor),
                      //                 value: false,
                      //                 onChanged: (bool? value) {
                      //                   // vehicleAndDriverC
                      //                   //     .seatCapacityApplicable
                      //                   //     .toggle();
                      //                 },
                      //               ),
                      //               KText(
                      //                 text:
                      //                     'Is test needed on the project output ?  ',
                      //                 fontSize: 13,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),

                      //     // Row(
                      //     //   children: [
                      //     //     SizedBox(
                      //     //       height: 20,
                      //     //     ),
                      //     //     CustomTextFieldVegicle(
                      //     //       title: "Passport Exp Date",
                      //     //     ),
                      //     //   ],
                      //     // ),
                      //   ],
                      // ),

                      // SizedBox(
                      //   height: 20,
                      // ),

                      // KText(
                      //     text: 'Description',
                      //     color: AppTheme.nTextLightC,
                      //     fontSize: 14),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   initialValue:
                      //       projectDashboardCreateC.description.value == ''
                      //           ? ''
                      //           : projectDashboardCreateC.description.value,
                      //   onChanged: projectDashboardCreateC.description,
                      //   decoration: InputDecoration(
                      //     labelText: 'Write advice here',
                      //     labelStyle: TextStyle(
                      //         color: hexToColor('#D9D9D9'), fontSize: 14),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 34,
                      //       width: 116,
                      //       decoration: BoxDecoration(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(8)),
                      //           color: hexToColor('#9BA9B3')),
                      //       child: Center(
                      //         child: KText(
                      //           text: 'Cancel',
                      //           fontSize: 16,
                      //           color: Colors.white,
                      //           bold: true,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         projectDashboardCreateC.postCreateProjectAdd();
                      //       },
                      //       child: Container(
                      //         height: 34,
                      //         width: 116,
                      //         decoration: BoxDecoration(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(8)),
                      //             color: hexToColor('#449EF1')),
                      //         child: Center(
                      //           child: KText(
                      //             text: 'Create',
                      //             fontSize: 16,
                      //             color: Colors.white,
                      //             bold: true,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 100,
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    print(s);
  }
}
