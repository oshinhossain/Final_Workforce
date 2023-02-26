import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/route.dart';
import '../config/app_theme.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';

class CreatGroupPage extends StatefulWidget {
  @override
  State<CreatGroupPage> createState() => _CreatGroupPageState();
}

class _CreatGroupPageState extends State<CreatGroupPage> with Base {
  @override
  Widget build(BuildContext context) {
    projectDashboardCreateC.getActivityName();
    projectDashboardCreateC.getProjectName();
    projectDashboardCreateC.getBucketName();
    //  projectDashboardCreateController.getprojectname();
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
                    text: 'Create Group',
                    bold: true,
                    fontSize: 18,
                  )),
              SizedBox(
                height: 20,
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
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => KText(
                          text:
                              projectDashboardCreateC.projectName.value.isEmpty
                                  ? ''
                                  : projectDashboardCreateC.projectName.value,
                        ),
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
                        text: 'OFC',
                        color: AppTheme.nTextLightC,
                        fontSize: 14,
                      ),
                      Divider(
                        thickness: 1.2,
                        color: AppTheme.nBorderC1,
                      ),
                      // TextFormField(
                      //   onChanged: projectDashboardCreateC.projectName,
                      //   decoration: InputDecoration(
                      //     labelText: '01',
                      //     labelStyle: TextStyle(
                      //         color: hexToColor('#D9D9D9'), fontSize: 14),
                      //   ),
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      KText(
                        text: 'Group Id',
                        fontSize: 14,
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      KText(
                        text: '02',
                        fontSize: 14,
                        color: hexToColor('#80939D'),
                      ),
                      // Obx(
                      //   () => KText(
                      //     text: projectDashboardCreateC.bucketName.value.isEmpty
                      //         ? ''
                      //         : projectDashboardCreateC.bucketName.value,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1.2,
                        color: AppTheme.nBorderC1,
                      ),

                      KText(
                          text: 'Group Name',
                          color: AppTheme.nTextLightC,
                          fontSize: 14),

                      TextFormField(
                        initialValue:
                            projectDashboardCreateC.description.value == ''
                                ? ''
                                : projectDashboardCreateC.description.value,
                        onChanged: projectDashboardCreateC.description,
                        decoration: InputDecoration(
                          labelText: 'Activity name will be here',
                          labelStyle: TextStyle(
                              color: hexToColor('#D9D9D9'), fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                        text: 'Assign to',
                        color: AppTheme.nTextLightC,
                        fontSize: 14,
                      ),

                      Row(
                        children: [
                          // ClipRRect(
                          //     borderRadius: BorderRadius.circular(50),
                          //     child: RenderImg(
                          //       path: 'man-1.png',
                          //       height: 32,
                          //       width: 32,
                          //     )),

                          Obx(
                            () => KText(
                                text: projectDashboardCreateC.assignTo.isEmpty
                                    ? 'select person'
                                    : projectDashboardCreateC.assignTo.value,
                                color: AppTheme.nTextC,
                                fontSize: 14),
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
                              // print(
                              //     '..........................................................................');
                              // print('dhjwhqd');
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
                        height: 20,
                      ),
                    ],
                  )),
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
