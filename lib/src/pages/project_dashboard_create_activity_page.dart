import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/widgets/title_bar.dart';
import '../config/app_theme.dart';
import '../controllers/project_dashboard_create_controller.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../widgets/custom_textfield_vehicle.dart';

class ProjectDashboardCreatActivityPage extends StatefulWidget {
  @override
  State<ProjectDashboardCreatActivityPage> createState() =>
      _ProjectDashboardCreatActivityPageState();
}

class _ProjectDashboardCreatActivityPageState
    extends State<ProjectDashboardCreatActivityPage> with Base {
  @override
  void dispose() {
    projectDashboardCreateC.deliveryDate.value = '';
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  projectDashboardCreateC.getActivityName();
    projectDashboardCreateC.getProjectName();
    // projectDashboardCreateC.getBucketName();
    //  projectDashboardCreateController.getprojectname();
    return Scaffold(
        appBar: KAppbar(),

        //  AppBar(
        //     backgroundColor: Colors.white,
        //     centerTitle: true,
        //     leading: IconButton(
        //         onPressed: () {
        //           back();
        //         },
        //         icon: Icon(
        //           Icons.arrow_back_ios,
        //           size: 30,
        //           color: hexToColor('#9BA9B3'),
        //         )),
        //     title: KText(
        //       text: 'Project Dashboard',
        //       fontSize: 16,
        //       color: hexToColor('#41525A'),
        //       bold: true,
        //     ),
        //   ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                TitleBar(title: 'Create Activity'),

                // Container(
                //     height: 40,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       color: hexToColor('#FFB661'),
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(6),
                //         topRight: Radius.circular(6),
                //       ),
                //     ),
                //     child: KText(
                //       text: 'Create Activity',
                //       bold: true,
                //       fontSize: 18,
                //     )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Project Name',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                            ),
                            GestureDetector(
                              onTap: () {
                                projectDashboardCreateC.openProjectNameDialog();
                              },
                              child: RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            )
                          ],
                        ),
                        KText(
                          text:
                              projectDashboardCreateC.projectName.value.isEmpty
                                  ? ''
                                  : projectDashboardCreateC.projectName.value,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppTheme.nBorderC1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Bucket Name',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                            ),
                            GestureDetector(
                              onTap: () {
                                //   projectDashboardCreateC.getBucketName();

                                projectDashboardCreateC.bucketNameDialog();
                              },
                              child: RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            )
                          ],
                        ),
                        KText(
                          text: projectDashboardCreateC.bucketName.value.isEmpty
                              ? ''
                              : projectDashboardCreateC.bucketName.value,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppTheme.nBorderC1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Group Name',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                            ),
                            GestureDetector(
                              onTap: () {
                                projectDashboardCreateC.activityGroupDialog();
                              },
                              child: RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            )
                          ],
                        ),
                        KText(
                          text:
                              projectDashboardCreateC.categoryName.value.isEmpty
                                  ? ''
                                  : projectDashboardCreateC.categoryName.value,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppTheme.nBorderC1,
                        ),
                        Row(
                          children: [
                            KText(
                              text: 'Activity ID',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                            ),
                          ],
                        ),
                        KText(
                          text: '01',
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppTheme.nBorderC1,
                        ),
                        KText(
                          text: 'Activity Name',
                          color: AppTheme.nTextLightC,
                          fontSize: 14,
                        ),
                        TextFormField(
                          initialValue:
                              projectDashboardCreateC.activityName.value == ''
                                  ? ''
                                  : projectDashboardCreateC.activityName.value,
                          onChanged: projectDashboardCreateC.activityName,
                          decoration: InputDecoration(
                            labelText: 'Activity name will be here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                                text: 'Activity Start Date',
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
                                  text: 'Activity End Date',
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
                                    color:
                                        AppTheme.primaryColor.withOpacity(.7),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: projectDashboardCreateC
                                              .scheduledStartDate.value.isEmpty
                                          ? '--/--/--'
                                          : formatDate(
                                              date: projectDashboardCreateC
                                                  .scheduledStartDate.value),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 150,
                                      color: AppTheme.nBorderC1,
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
                                    KText(
                                      text: projectDashboardCreateC
                                              .scheduledEndDate.value.isEmpty
                                          ? '--/--/--'
                                          : formatDate(
                                              date: projectDashboardCreateC
                                                  .scheduledEndDate.value),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  width: 150,
                                  color: AppTheme.nBorderC1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Milestone ID',
                              fontSize: 14,
                              color: hexToColor('#80939D'),
                            ),
                            GestureDetector(
                              onTap: () {
                                projectDashboardCreateC.bucketNameDialog();
                              },
                              child: RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            )
                          ],
                        ),
                        KText(
                          text: projectDashboardCreateC.bucketName.value.isEmpty
                              ? ''
                              : projectDashboardCreateC.bucketName.value,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppTheme.nBorderC1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KText(
                          text: 'Assign to',
                          color: AppTheme.nTextLightC,
                          fontSize: 14,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: RenderImg(
                                  path: 'man-1.png',
                                  height: 32,
                                  width: 32,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            KText(
                              text: '',
                              // text: projectDashboardCreateC
                              //             .projectManager.value!.fullname ==
                              //         null
                              //     ? 'select person'
                              //     : projectDashboardCreateC
                              //         .projectManager.value!.fullname,
                              color: AppTheme.nTextC,
                              fontSize: 14,
                            ),
                            KText(
                              text: 'select person',
                              color: AppTheme.nTextC,
                              fontSize: 14,
                            ),
                            Spacer(),
                            SizedBox(
                              child: IconButton(
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  await projectDashboardCreateC
                                      .searchUserBottomsheet();
                                  // print('tujtuj');
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
                          color: AppTheme.nBorderC1,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 6),
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
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CustomTextFieldVegicle(
                                                // onChanged: vehicleAndDriverC
                                                //     .seatCapacityUnit,
                                                title: 'Area Type',
                                                hintText: 'Persons',
                                                isRequired: false,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: CustomTextFieldVegicle(
                                                // onChanged: vehicleAndDriverC
                                                //     .seatCapacityUnit,
                                                title: 'Level',
                                                hintText: '4',
                                                isRequired: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            // fillColor: MaterialStateProperty
                                            //     .resolveWith(getColor),
                                            value: vehicleAndDriverC
                                                .seatCapacityApplicable.value,
                                            onChanged: (bool? value) {
                                              vehicleAndDriverC
                                                  .seatCapacityApplicable
                                                  .toggle();
                                            },
                                          ),
                                          KText(
                                            text:
                                                'Is work location restricted to geography??  ',
                                            fontSize: 13,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            // fillColor: MaterialStateProperty
                                            //     .resolveWith(getColor),
                                            value: vehicleAndDriverC
                                                .seatCapacityApplicable.value,
                                            onChanged: (bool? value) {
                                              vehicleAndDriverC
                                                  .seatCapacityApplicable
                                                  .toggle();
                                            },
                                          ),
                                          Flexible(
                                            child: KText(
                                              text:
                                                  'Is project sites spread over each geography??  ',
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: -25,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        // fillColor: MaterialStateProperty
                                        //     .resolveWith(getColor),
                                        value: vehicleAndDriverC
                                            .seatCapacityApplicable.value,
                                        onChanged: (bool? value) {
                                          vehicleAndDriverC
                                              .seatCapacityApplicable
                                              .toggle();
                                        },
                                      ),
                                      KText(
                                        text: 'Is spread over geographies ?  ',
                                        fontSize: 13,
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
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 6),
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
                                          Checkbox(
                                            checkColor: Colors.white,
                                            // fillColor: MaterialStateProperty
                                            //     .resolveWith(getColor),
                                            value: vehicleAndDriverC
                                                .seatCapacityApplicable.value,
                                            onChanged: (bool? value) {
                                              vehicleAndDriverC
                                                  .seatCapacityApplicable
                                                  .toggle();
                                            },
                                          ),
                                          KText(
                                            text:
                                                'Is work location restricted to geography ?  ',
                                            fontSize: 13,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: -25,
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,

                                        // fillColor: MaterialStateProperty
                                        //     .resolveWith(getColor),
                                        value: vehicleAndDriverC
                                            .seatCapacityApplicable.value,
                                        onChanged: (bool? value) {
                                          vehicleAndDriverC
                                              .seatCapacityApplicable
                                              .toggle();
                                        },
                                      ),
                                      KText(
                                        text:
                                            'Is test needed on the project output ?  ',
                                        fontSize: 13,
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
                        SizedBox(
                          height: 10,
                        ),
                        KText(
                            text: 'Description',
                            color: AppTheme.nTextLightC,
                            fontSize: 14),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue:
                              projectDashboardCreateC.description.value == ''
                                  ? ''
                                  : projectDashboardCreateC.description.value,
                          onChanged: projectDashboardCreateC.description,
                          decoration: InputDecoration(
                            labelText: 'Write advice here',
                            labelStyle: TextStyle(
                                color: hexToColor('#D9D9D9'), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 34,
                              width: 116,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: hexToColor('#9BA9B3')),
                              child: Center(
                                child: KText(
                                  text: 'Cancel',
                                  fontSize: 16,
                                  color: Colors.white,
                                  bold: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                projectDashboardCreateC
                                    .postCreateProjectActivityAdd();
                              },
                              child: Container(
                                height: 34,
                                width: 116,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: hexToColor('#449EF1')),
                                child: Center(
                                  child: KText(
                                    text: 'Create',
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        )

        // SafeArea(

        // // ),
        );
  }

  Widget searchField({
    required String title,
    required String placeholder,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              KText(
                text: title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: onTap,
                // child: SvgPicture.asset(
                //   '${Constants.svgPath}/icon_search_elements.svg',
                //   color: hexToColor('#66A1D9'),
                //   width: 20,
                // ),
                child: RenderSvg(
                  path: 'icon_search_elements',
                  width: 26,
                  color: hexToColor('#66A1D9'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          KText(
            text: placeholder,
            fontSize: 15,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
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
