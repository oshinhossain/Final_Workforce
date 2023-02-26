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

class ProjectPlanningCreatMilestonePage extends StatefulWidget {
  @override
  State<ProjectPlanningCreatMilestonePage> createState() =>
      _ProjectPlanningCreatMilestonePageState();
}

class _ProjectPlanningCreatMilestonePageState
    extends State<ProjectPlanningCreatMilestonePage> with Base {
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
                  text: 'Create Milestone',
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
                  text: 'Milestone ID',
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
                  color: AppTheme.nTextLightC,
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
                  text: 'Milestone Name',
                  fontSize: 14,
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 10,
                ),
                KText(
                  text: 'Milestone Name 1 ',
                  fontSize: 14,
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.2,
                  color: AppTheme.nBorderC1,
                ),
                SizedBox(
                  height: 10,
                ),
                KText(
                  text: 'Weight Percentage',
                  fontSize: 14,
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 10,
                ),
                KText(
                  text: '20 ',
                  fontSize: 14,
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.2,
                  color: AppTheme.nBorderC1,
                ),
                KText(
                  text: 'Delivery Date',
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
                KText(
                    text: 'Description',
                    color: AppTheme.nTextLightC,
                    fontSize: 14),
                SizedBox(
                  height: 10,
                ),
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
