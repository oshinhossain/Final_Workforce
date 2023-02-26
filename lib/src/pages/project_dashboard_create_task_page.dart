import 'package:dropdown_search/dropdown_search.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/route.dart';
import '../config/app_theme.dart';
import '../controllers/project_dashboard_create_controller.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';

class ProjectDashboardCreatTaskPage extends StatefulWidget {
  @override
  State<ProjectDashboardCreatTaskPage> createState() =>
      _ProjectDashboardCreatTaskPageState();
}

class _ProjectDashboardCreatTaskPageState
    extends State<ProjectDashboardCreatTaskPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: hexToColor('#9BA9B3'),
              )),
          title: KText(
            text: 'Project Dashboard',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#FFB661'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: KText(
                    text: 'Create Task',
                    bold: true,
                    fontSize: 18,
                  )),
              ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: hexToColor('#EEF0F6'),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Obx(
                                () => KText(
                                  text: myActivityDashboardCreateActivityC
                                          .projectName.value.isEmpty
                                      ? ''
                                      : myActivityDashboardCreateActivityC
                                          .projectName.value,
                                ),
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 18,
                                width: 18,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              KText(
                                text: 'Pole',
                                fontSize: 13,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              RenderSvg(
                                path: 'icon_forward',
                                height: 18,
                                width: 18,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              KText(
                                text: 'Pole Delivery',
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                    text: 'Task ID',
                                    color: AppTheme.nTextLightC,
                                    fontSize: 14),
                                Spacer(),
                                Row(
                                  children: [
                                    KText(
                                      text: 'Delivery Date',
                                      fontSize: 14,
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () => projectDashboardCreateC
                                          .selectDate(DateType.delivery),
                                      child: Icon(
                                        EvaIcons.calendarOutline,
                                        color: AppTheme.primaryColor
                                            .withOpacity(.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //  Obx(
                            //                     () => Row(
                            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                       children: [
                            //                         KText(
                            //                           text: projectDashboardCreateC
                            //                                   .deliveryDate.value.isNotEmpty
                            //                               ? formatDate(
                            //                                   date: projectDashboardCreateC
                            //                                       .deliveryDate.value)
                            //                               : 'Select Date',
                            //                         ),
                            //                         Spacer(),
                            //                         GestureDetector(
                            //                             onTap: () => projectDashboardCreateC
                            //                                 .selectDate(DateType.delivery),
                            //                             child: Icon(Icons.calendar_today_sharp)),
                            //                       ],
                            //                     ),
                            //                   ),

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
                                        onChanged:
                                            myActivityDashboardCreateActivityC
                                                .taskId,
                                        cursorColor: Color(0xFF90A4AE),
                                        decoration: InputDecoration(
                                          constraints:
                                              BoxConstraints(maxHeight: 40),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF90A4AE),
                                            ),
                                          ),
                                          focusColor: Color(0xFF90A4AE),
                                          labelStyle: TextStyle(
                                              color: Color(0xFF424242)),
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
                                Obx(
                                  (() => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: KText(
                                                  text: projectDashboardCreateC
                                                          .deliveryDate
                                                          .value
                                                          .isNotEmpty
                                                      ? formatDate(
                                                          date:
                                                              projectDashboardCreateC
                                                                  .deliveryDate
                                                                  .value)
                                                      : 'Select Date',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            // Row(

                            SizedBox(
                              height: 10,
                            ),
                            KText(
                              text: 'Task Name',
                              color: AppTheme.nTextLightC,
                              fontSize: 14,
                            ),
                            TextFormField(
                              onChanged:
                                  myActivityDashboardCreateActivityC.taskName,
                              decoration: InputDecoration(
                                  labelText: 'Task name will be here',
                                  labelStyle: TextStyle(
                                      color: hexToColor('#D9D9D9'),
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              showSelectedItems: true,

                              items: [
                                'Responsible',
                                'Support',
                                'Informed',
                              ],
                              showClearButton: true,

                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'Task Role',
                                labelStyle: TextStyle(
                                  color: hexToColor('#80939D'),
                                ),
                              ),
                              popupItemDisabled: isItemDisabled,
                              onChanged: (v) {
                                myActivityDashboardCreateActivityC
                                    .taskRole.value = v![0];
                              },
                              //selectedItem: "",
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  cursorColor: Colors.blue,
                                  decoration: InputDecoration(
                                      //   labelText: 'sfdfvde',
                                      suffixIcon: Icon(Icons.search))),
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
                                Obx(
                                  () => KText(
                                      text: myActivityDashboardCreateActivityC
                                              .assignTo.isEmpty
                                          ? 'select person'
                                          : myActivityDashboardCreateActivityC
                                              .assignTo.value,
                                      color: AppTheme.nTextC,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                SizedBox(
                                  child: IconButton(
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () async {
                                      await myActivityDashboardCreateActivityC
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
                              color: AppTheme.nBorderC1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                    text: 'Output Quantity',
                                    color: AppTheme.nTextLightC,
                                    fontSize: 14),
                                Spacer(),
                                KText(
                                  text: 'Unit of Measure',
                                  color: AppTheme.nTextLightC,
                                  fontSize: 14,
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
                                        onChanged:
                                            myActivityDashboardCreateActivityC
                                                .quntity,
                                        cursorColor: Color(0xFF90A4AE),
                                        decoration: InputDecoration(
                                          hintText: '0',
                                          constraints:
                                              BoxConstraints(maxHeight: 40),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF90A4AE),
                                            ),
                                          ),
                                          focusColor: Color(0xFF90A4AE),
                                          labelStyle: TextStyle(
                                              color: Color(0xFF424242)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 50,
                                      child: TextFormField(
                                        onChanged:
                                            myActivityDashboardCreateActivityC
                                                .unitOfMeasure,
                                        cursorColor: Color(0xFF90A4AE),
                                        decoration: InputDecoration(
                                          constraints:
                                              BoxConstraints(maxHeight: 40),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF90A4AE),
                                            ),
                                          ),
                                          focusColor: Color(0xFF90A4AE),
                                          labelStyle: TextStyle(
                                              color: Color(0xFF424242)),
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
                                text: 'Description',
                                color: AppTheme.nTextLightC,
                                fontSize: 14),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: myActivityDashboardCreateActivityC
                                          .description.value ==
                                      ''
                                  ? ''
                                  : myActivityDashboardCreateActivityC
                                      .description.value,
                              onChanged: myActivityDashboardCreateActivityC
                                  .description,
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
                                    myActivityDashboardCreateActivityC
                                        .postCreateTaskProjectSupportAdd();
                                    print(
                                        '..........................................................................');
                                    print('oshin');
                                  },
                                  child: Container(
                                    height: 34,
                                    width: 116,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
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
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
