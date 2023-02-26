import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../config/app_theme.dart';
import '../helpers/render_img.dart';
import 'create_issue_page.dart';

class EscalateProjectIssuesPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    logisticsWorkbenchC.getAssignVehicleLogisticWorkbanch();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: Get.width,
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
                    text: 'Escalate Project Issues',
                    fontSize: 16,
                    color: hexToColor('#41525A'),
                    bold: true,
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
              height: 50,
              width: Get.width,
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(text: 'Project:'),
                    SizedBox(
                      width: 8,
                    ),
                    KText(
                      text: 'BTCL Haor-Baor Project',
                      bold: true,
                      fontSize: 14,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: RenderSvg(
                        path: 'icon_search_elements',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.offAll(MainPage());
                        },
                        child: RenderSvg(
                          path: 'flag',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Issues',
                        fontSize: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  DottedLine(),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 18, top: 18, left: 12, right: 12),
                            padding: EdgeInsets.all(12),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.black12,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: KText(
                                          bold: true,
                                          text: '101',
                                          color: hexToColor('#41525A'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: KText(
                                              textOverflow:
                                                  TextOverflow.visible,
                                              fontSize: 16,
                                              text:
                                                  'Pole Dumping Place Crisis')),
                                      Spacer(),
                                      Icon(Icons.more_vert_outlined),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Task',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Scope Bucket ',
                                            fontSize: 14,
                                            maxLines: 2,
                                            color: hexToColor('#515D64'),
                                          ),
                                          RenderSvg(
                                            path: 'icon_forward',
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          KText(
                                            text: 'Activity 1 ',
                                            fontSize: 14,
                                            maxLines: 2,
                                            color: hexToColor('#515D64'),
                                          ),
                                          RenderSvg(
                                            path: 'icon_forward',
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          KText(
                                            text: 'Task 1',
                                            fontSize: 14,
                                            maxLines: 2,
                                            color: hexToColor('#515D64'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Assigned to',
                                            color: hexToColor('#80939D'),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              KText(text: 'Ahsan habib'),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              RenderImg(
                                                path: 'icon_avatar.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Description',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text:
                                            'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
                                        fontSize: 13,
                                        maxLines: 2,
                                        color: hexToColor('#515D64'),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Issued on',
                                            color: hexToColor('#80939D'),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              KText(text: '06 Sep 2022'),
                                              SizedBox(
                                                width: 12,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              right: 30,
                              top: 4,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: KText(
                                  text: 'Pending',
                                  color: hexToColor('#007BEC'),
                                  fontSize: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: hexToColor('#DBECFB'),
                                ),
                              )),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 90,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(CreateIssuePage());
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}























// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:workforce/src/components/k_appbar.dart';
// import 'package:workforce/src/components/left_sidebar_component.dart';
// import 'package:workforce/src/components/right_sidebar_component.dart';
// import 'package:workforce/src/config/app_theme.dart';
// import 'package:workforce/src/config/base.dart';

// import 'package:workforce/src/helpers/k_text.dart';
// import 'package:workforce/src/helpers/render_img.dart';
// import 'package:workforce/src/helpers/render_svg.dart';

// import '../helpers/hex_color.dart';
// import '../helpers/route.dart';

// class EscalateProjectIssuesPage extends StatefulWidget {
//   @override
//   State<EscalateProjectIssuesPage> createState() =>
//       _EscalateProjectIssuesPageState();
// }

// class _EscalateProjectIssuesPageState extends State<EscalateProjectIssuesPage>
//     with Base {
//   @override
//   void initState() {
//     createTrasnportOrderC.getProjectName();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     createTrasnportOrderC.resetData();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: LeftSidebarComponent(),
//       endDrawer: RightSidebarComponent(),
//       appBar: KAppbar(),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
//               height: 55,
//               width: Get.width,
//               // margin: EdgeInsets.symmetric(vertical: .5),

//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                     bottom: BorderSide(
//                       width: 3,
//                       color: Colors.black12,
//                     ),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10.0,
//                       color: Colors.black12,
//                     )
//                   ]),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () => back(),
//                     child: RenderSvg(
//                       path: 'icon_back',
//                       width: 13.0,
//                     ),
//                   ),
//                   KText(
//                     text: 'Escalate Project Issues',
//                     fontSize: 16,
//                     color: hexToColor('#41525A'),
//                     bold: true,
//                   ),
//                   SizedBox(
//                     width: 80,
//                   ),
//                 ],
//               ),
//             ),
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
//               padding: EdgeInsets.only(left: 15, top: 20),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     KText(text: 'Project:'),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Expanded(
//                       flex: 5,
//                       child: KText(
//                         text: 'BTCL Haor-Baor Project',
//                         bold: true,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: RenderSvg(path: 'icon_top_bar_search'),
//                     )
//                   ]),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             // Get.offAll(MainPage());
//                           },
//                           child: RenderSvg(path: 'icon_escalation')),
//                       SizedBox(
//                         width: 12,
//                       ),
//                       KText(
//                         text: 'Repoted On',
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
//             SizedBox(
//               height: 10,
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 primary: false,
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 15, right: 15),
//                     child: Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         Container(
//                           width: 360,
//                           height: 300,
//                           decoration: BoxDecoration(
//                             color: AppTheme.white,
//                             border: Border.all(color: AppTheme.nBorderC1),
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 10.0,
//                                 color: Colors.black12,
//                               )
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(bottom: 20),
//                                           child: KText(
//                                             text: '101',
//                                             fontSize: 16,
//                                             bold: true,
//                                             color: hexToColor('#515D64'),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         KText(
//                                           text: 'Pole Dumping Place\n Crisis',
//                                           fontSize: 16,
//                                           color: hexToColor('#515D64'),
//                                         ),
//                                         Spacer(),
//                                         Expanded(
//                                             flex: 2,
//                                             child:
//                                                 Icon(Icons.more_vert_outlined))
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         KText(
//                                           text: 'Assigned to',
//                                           color: hexToColor('#80939D'),
//                                         ),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             KText(text: 'Ahsan habib'),
//                                             SizedBox(
//                                               width: 12,
//                                             ),
//                                             RenderImg(
//                                               path: 'icon_avatar.png',
//                                               width: 30,
//                                               height: 30,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     KText(
//                                       text: 'Description',
//                                       fontSize: 13,
//                                       color: hexToColor('#80939D'),
//                                     ),
//                                     KText(
//                                       text:
//                                           'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
//                                       fontSize: 13,
//                                       maxLines: 2,
//                                       color: hexToColor('#80939D'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         KText(
//                                           text: 'Issued on',
//                                           color: hexToColor('#80939D'),
//                                         ),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             KText(text: '06 Sep 2022'),
//                                             SizedBox(
//                                               width: 12,
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                             right: 30,
//                             top: 1,
//                             child: Container(
//                               padding: EdgeInsets.only(
//                                   bottom: 5, top: 5, left: 12, right: 12),
//                               child: KText(
//                                 text: 'Pending',
//                                 color: hexToColor('#007BEC'),
//                                 fontSize: 12,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: hexToColor('#DBECFB'),
//                               ),
//                             )),
//                       ],
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );

//     // floatingActionButton: FloatingActionButton(
//     //   onPressed: () {},
//     //   shape: StadiumBorder(),
//     //   child: Icon(Icons.add),
//     // ),
//   }
// }


















// // import 'package:dotted_line/dotted_line.dart';
// // import 'package:get/get.dart';
// // import 'package:percent_indicator/percent_indicator.dart';

// // import '../components/k_appbar.dart';
// // import '../components/left_sidebar_component.dart';
// // import '../components/right_sidebar_component.dart';
// // import '../config/app_theme.dart';
// // import '../config/base.dart';
// // import 'package:flutter/material.dart';
// // import '../helpers/hex_color.dart';
// // import '../helpers/k_text.dart';
// // import '../helpers/render_img.dart';
// // import '../helpers/render_svg.dart';
// // import '../helpers/route.dart';

// // class EscalateProjectIssuesPage extends StatelessWidget with Base {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       drawer: LeftSidebarComponent(),
// //       endDrawer: RightSidebarComponent(),
// //       appBar: AppBar(
// //         flexibleSpace: KAppbar(),
// //         bottom: PreferredSize(
// //             preferredSize: Size(Get.width, 50),
// //             child: AppBar(
// //               title: KText(
// //                 text: 'Project Planning Board',
// //                 bold: true,
// //                 fontSize: 16,
// //               ),
// //               leading: IconButton(
// //                 icon: Icon(Icons.arrow_back_ios_sharp),
// //                 onPressed: back,
// //               ),
// //               actions: [],
// //             )),
// //       ),
// //       backgroundColor: hexToColor('#EEF0F6'),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: hexToColor('#CFD7DD'),
// //                 border: Border.all(color: AppTheme.nBorderC1),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     blurRadius: 10.0,
// //                     color: hexToColor('#EEF0F6'),
// //                   )
// //                 ],
// //               ),
// //               height: 60,
// //               width: Get.width,
// //               padding: EdgeInsets.only(left: 15, top: 10),
// //               child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     KText(text: 'Project Name:'),
// //                     SizedBox(
// //                       width: 8,
// //                     ),
// //                     KText(
// //                       text: 'BTCL Haor-Baor Project',
// //                       bold: true,
// //                       fontSize: 14,
// //                     ),
// //                   ]),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     children: [
// //                       GestureDetector(
// //                           onTap: () {
// //                             // Get.offAll(MainPage());
// //                           },
// //                           child: RenderSvg(path: 'icon_bill')),
// //                       SizedBox(
// //                         width: 12,
// //                       ),
// //                       KText(
// //                         text: 'Transportation Orders I Placed',
// //                         fontSize: 16,
// //                       )
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 7,
// //                   ),
// //                   DottedLine(),
// //                 ],
// //               ),
// //             ),
// //             ListView.builder(
// //                 shrinkWrap: true,
// //                 primary: false,
// //                 itemCount: 3,
// //                 itemBuilder: (context, index) {
// //                   return Padding(
// //                     padding: const EdgeInsets.only(top: 10),
// //                     child: Center(
// //                       child: Container(
// //                         width: 360,
// //                         height: 520,
// //                         decoration: BoxDecoration(
// //                           color: AppTheme.white,
// //                           border: Border.all(color: AppTheme.nBorderC1),
// //                           borderRadius: BorderRadius.circular(12),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               blurRadius: 10.0,
// //                               color: Colors.black12,
// //                             )
// //                           ],
// //                         ),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           children: [
// //                             Padding(
// //                               padding: EdgeInsets.all(8.0),
// //                               child: Column(
// //                                 children: [
// //                                   Padding(
// //                                     padding: const EdgeInsets.only(left: 220),
// //                                     child: Container(
// //                                       decoration: BoxDecoration(
// //                                         borderRadius: BorderRadius.all(
// //                                             Radius.circular(20)),
// //                                         color: hexToColor('#DBECFB'),
// //                                       ),
// //                                       height: 30,
// //                                       width: 80,
// //                                       child: Center(
// //                                         child: KText(
// //                                           text: 'Pending',
// //                                           fontSize: 14,
// //                                           //  bold: true,
// //                                           color: hexToColor('#007BEC'),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   SizedBox(
// //                                     height: 10,
// //                                   ),
// //                                   Row(
// //                                     children: [
// //                                       KText(
// //                                         text: '101',
// //                                         fontSize: 16,
// //                                         bold: true,
// //                                         color: hexToColor('#515D64'),
// //                                       ),
// //                                       SizedBox(
// //                                         width: 10,
// //                                       ),
// //                                       Expanded(
// //                                         flex: 5,
// //                                         child: KText(
// //                                           text: 'Pole Dumping Place Crisis',
// //                                           fontSize: 16,
// //                                           color: hexToColor('#515D64'),
// //                                         ),
// //                                       ),
// //                                       Spacer(),
// //                                       Expanded(
// //                                           flex: 2,
// //                                           child: Icon(Icons.more_vert_outlined))
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             Divider(
// //                               thickness: 1,
// //                             ),
// //                             Padding(
// //                               padding: EdgeInsets.all(8.0),
// //                               child: Row(
// //                                 children: [
// //                                   Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       KText(
// //                                         text: 'Assigned to',
// //                                         color: hexToColor('#80939D'),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   Spacer(),
// //                                   Column(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       Row(
// //                                         children: [
// //                                           KText(text: 'Ahsan habib'),
// //                                           SizedBox(
// //                                             width: 12,
// //                                           ),
// //                                           RenderImg(
// //                                             path: 'icon_avatar.png',
// //                                             width: 30,
// //                                             height: 30,
// //                                           ),
// //                                         ],
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             Divider(
// //                               thickness: 1,
// //                             ),
// //                             Padding(
// //                               padding: EdgeInsets.symmetric(
// //                                   horizontal: 15, vertical: 10),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   KText(
// //                                     text: 'Description',
// //                                     fontSize: 13,
// //                                     color: hexToColor('#80939D'),
// //                                   ),
// //                                   KText(
// //                                     text:
// //                                         'Duis aute irure dolor in reprehenderit in volupta te velit esse cillum dolore eu fugiat.',
// //                                     fontSize: 13,
// //                                     maxLines: 2,
// //                                     color: hexToColor('#80939D'),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 })
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {},
// //         shape: StadiumBorder(),
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }
