import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/base.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class ProjectPlanningCreatBucketPage extends StatefulWidget {
  @override
  State<ProjectPlanningCreatBucketPage> createState() =>
      _ProjectPlanningCreatBucketPageState();
}

class _ProjectPlanningCreatBucketPageState
    extends State<ProjectPlanningCreatBucketPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppbar(),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            height: 55,
            width: Get.width,
            // margin: EdgeInsets.symmetric(vertical: .5),

            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: Colors.black12,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black12,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => back(),
                  child: RenderSvg(
                    path: 'icon_back',
                    width: 13.0,
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                KText(
                  text: 'Create Bucket',
                  fontSize: 16,
                  color: hexToColor('#41525A'),
                  bold: true,
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 30,

                  //  padding: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      color: hexToColor('#FFF4E8'),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(width: 1, color: hexToColor('#FFA133'))),
                  child: Center(
                    child: KText(
                      text: '03',
                      bold: true,
                      color: hexToColor('#FFA133'),
                    ),
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: hexToColor('#CFD7DD'),
              border: Border.all(color: AppTheme.nBorderC1),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: hexToColor('#EEF0F6'),
                )
              ],
            ),
            height: 60,
            width: Get.width,
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(text: 'Project Name:'),
                  SizedBox(
                    width: 8,
                  ),
                  KText(
                    text: 'BTCL Haor-Baor Project',
                    bold: true,
                    fontSize: 14,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: 'Bucket ID',
                  color: AppTheme.nTextLightC,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   width: 2,
                // ),
                KText(
                  text: '02',
                  color: AppTheme.nTextC,
                  fontSize: 14,
                ),
                Divider(
                  thickness: 1.2,
                  color: AppTheme.nBorderC1,
                ),
                SizedBox(
                  height: 10,
                ),
                KText(
                  text: 'Bucket Name',
                  fontSize: 14,
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 10,
                ),
                KText(
                  text: 'Bucket name 1 ',
                  fontSize: 14,
                  color: AppTheme.nTextC,
                ),
                SizedBox(
                  height: 10,
                ),

                Divider(
                  thickness: 1.2,
                  color: AppTheme.nBorderC1,
                ),
                KText(
                  text: 'Deadline',
                  color: AppTheme.nTextLightC,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                        text: '26-Sec-2022',
                        color: AppTheme.nTextC,
                        fontSize: 14),
                    Spacer(),
                    Icon(Icons.calendar_today_sharp),
                  ],
                ),
                Divider(
                  thickness: 1.2,
                  color: AppTheme.nBorderC1,
                ),
                SizedBox(
                  height: 10,
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
                              labelStyle: TextStyle(color: Color(0xFF424242)),
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
                        KText(
                          text: 'Wifi Network',
                          color: AppTheme.nTextC,
                          fontSize: 14,
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
                  height: 20,
                ),
                KText(
                  text: 'Assign to',
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
                        text:
                            projectDashboardCreateC.projectManager.value != null
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
                          await projectDashboardCreateC.searchUserBottomsheet();
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
                KText(
                    text: 'Description',
                    color: AppTheme.nTextLightC,
                    fontSize: 14),

                TextFormField(
                  initialValue: projectDashboardCreateC.description.value == ''
                      ? ''
                      : projectDashboardCreateC.description.value,
                  onChanged: projectDashboardCreateC.description,
                  decoration: InputDecoration(
                    labelText: 'Write advice here',
                    labelStyle:
                        TextStyle(color: hexToColor('#D9D9D9'), fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 34,
                      width: 116,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        projectDashboardCreateC.postCreateProjectActivityAdd();
                        // print(
                        //     '..........................................................................');
                        // print('dhjwhqd');
                      },
                      child: Container(
                        height: 34,
                        width: 116,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
      )),
    );
  }
}
