import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../helpers/hex_color.dart';
import '../helpers/route.dart';

class CreateIssuePage extends StatefulWidget {
  @override
  State<CreateIssuePage> createState() => _CreateIssuePageState();
}

class _CreateIssuePageState extends State<CreateIssuePage> with Base {
  @override
  void initState() {
    createTrasnportOrderC.getProjectName();
    super.initState();
  }

  @override
  void dispose() {
    createTrasnportOrderC.resetData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    projectDashboardCreateC.getActivityName();
    projectDashboardCreateC.getProjectName();
    projectDashboardCreateC.getBucketName();
    return Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
        body: Obx(() => SingleChildScrollView(
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
                        KText(
                          text: '     Create Issue',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        SizedBox(
                          width: 80,
                        ),
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
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Row(
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
                        ]),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Bucket',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),
                          KText(
                            text: 'Activity',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole Construction',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
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
                            text: 'Task',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole Erection',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Spacer(),
                              RenderSvg(
                                path: 'dropdown',
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),
                          KText(
                            text: 'Issue Title',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Pole turning into waste dump',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.2,
                            color: AppTheme.nBorderC1,
                          ),
                          SizedBox(
                            height: 20,
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
                              Obx(
                                () => KText(
                                    text:
                                        projectDashboardCreateC.assignTo.isEmpty
                                            ? 'select person'
                                            : projectDashboardCreateC
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
            )));
  }
}


















// import 'package:dotted_line/dotted_line.dart';
// import 'package:get/get.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// import '../components/k_appbar.dart';
// import '../components/left_sidebar_component.dart';
// import '../components/right_sidebar_component.dart';
// import '../config/app_theme.dart';
// import '../config/base.dart';
// import 'package:flutter/material.dart';
// import '../helpers/hex_color.dart';
// import '../helpers/k_text.dart';
// import '../helpers/render_img.dart';
// import '../helpers/render_svg.dart';
// import '../helpers/route.dart';

// class EscalateProjectIssuesPage extends StatelessWidget with Base {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: LeftSidebarComponent(),
//       endDrawer: RightSidebarComponent(),
//       appBar: AppBar(
//         flexibleSpace: KAppbar(),
//         bottom: PreferredSize(
//             preferredSize: Size(Get.width, 50),
//             child: AppBar(
//               title: KText(
//                 text: 'Project Planning Board',
//                 bold: true,
//                 fontSize: 16,
//               ),
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back_ios_sharp),
//                 onPressed: back,
//               ),
//               actions: [],
//             )),
//       ),
//       backgroundColor: hexToColor('#EEF0F6'),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: hexToColor('#CFD7DD'),
//                 border: Border.all(color: AppTheme.nBorderC1),
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10.0,
//                     color: hexToColor('#EEF0F6'),
//                   )
//                 ],
//               ),
//               height: 60,
//               width: Get.width,
//               padding: EdgeInsets.only(left: 15, top: 10),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     KText(text: 'Project Name:'),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     KText(
//                       text: 'BTCL Haor-Baor Project',
//                       bold: true,
//                       fontSize: 14,
//                     ),
//                   ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             // Get.offAll(MainPage());
//                           },
//                           child: RenderSvg(path: 'icon_bill')),
//                       SizedBox(
//                         width: 12,
//                       ),
//                       KText(
//                         text: 'Transportation Orders I Placed',
//                         fontSize: 16,
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 7,
//                   ),
//                   DottedLine(),
//                 ],
//               ),
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 primary: false,
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Center(
//                       child: Container(
//                         width: 360,
//                         height: 520,
//                         decoration: BoxDecoration(
//                           color: AppTheme.white,
//                           border: Border.all(color: AppTheme.nBorderC1),
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 10.0,
//                               color: Colors.black12,
//                             )
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 220),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20)),
//                                         color: hexToColor('#DBECFB'),
//                                       ),
//                                       height: 30,
//                                       width: 80,
//                                       child: Center(
//                                         child: KText(
//                                           text: 'Pending',
//                                           fontSize: 14,
//                                           //  bold: true,
//                                           color: hexToColor('#007BEC'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: [
//                                       KText(
//                                         text: '101',
//                                         fontSize: 16,
//                                         bold: true,
//                                         color: hexToColor('#515D64'),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                         flex: 5,
//                                         child: KText(
//                                           text: 'Pole Dumping Place Crisis',
//                                           fontSize: 16,
//                                           color: hexToColor('#515D64'),
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Expanded(
//                                           flex: 2,
//                                           child: Icon(Icons.more_vert_outlined))
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       KText(
//                                         text: 'Assigned to',
//                                         color: hexToColor('#80939D'),
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           KText(text: 'Ahsan habib'),
//                                           SizedBox(
//                                             width: 12,
//                                           ),
//                                           RenderImg(
//                                             path: 'icon_avatar.png',
//                                             width: 30,
//                                             height: 30,
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   KText(
//                                     text: 'Description',
//                                     fontSize: 13,
//                                     color: hexToColor('#80939D'),
//                                   ),
//                                   KText(
//                                     text:
//                                         'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
//                                     fontSize: 13,
//                                     maxLines: 2,
//                                     color: hexToColor('#80939D'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 })
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         shape: StadiumBorder(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }



