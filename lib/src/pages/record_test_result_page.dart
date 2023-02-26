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

class RecordTestResultPage extends StatefulWidget {
  @override
  State<RecordTestResultPage> createState() => _RecordTestResultPageState();
}

class _RecordTestResultPageState extends State<RecordTestResultPage> with Base {
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
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Obx(() => SingleChildScrollView(
            child: Container(
              color: hexToColor('#EAEAF3'),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 50,
                    // margin: EdgeInsets.symmetric(vertical: .5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom:
                            BorderSide(width: 2, color: Colors.grey.shade300),
                      ),
                    ),
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
                          text: 'Record Test Result',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        SizedBox()
                      ],
                    ),
                  ),

                  // Others parts

                  singleRecivingPerson(),

                  Container(
                    width: Get.width,
                    color: hexToColor('#EAEAF3'),
                    child: Column(children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          border: Border.all(color: AppTheme.nBorderC1),
                          borderRadius: BorderRadius.circular(5),
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 10.0,
                          //     color: Colors.black12,
                          //   )
                          // ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(8),
                                //   topRight: Radius.circular(8),
                                // ),
                                // border: Border.all(),
                                color: hexToColor('#FFE9CF'),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),

                                  SizedBox(
                                    width: 12,
                                  ),
                                  KText(
                                    text: 'Blue Cable',
                                    bold: true,
                                    fontSize: 14,
                                  ),

                                  // Icon(
                                  //   SvgPicture.asset('${Constants.svgPath}/Vector2.svg'),
                                  //   color: hexToColor('#FF8A00'),
                                  // ),

                                  SizedBox(
                                    width: 12,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                        color: hexToColor('#FFE9CF'),
                                        width: 1)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          KText(
                                            text: 'ID:',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                            text: '101',
                                            color: hexToColor('#41525A'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Acceptance Criteria:',
                                            color: hexToColor('#80939D'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Criteria-1:',
                                            color: hexToColor('#41525A'),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Checkbox(
                                                checkColor: Colors.white,
                                                // fillColor: MaterialStateProperty
                                                //     .resolveWith(getColor),
                                                value: vehicleAndDriverC
                                                    .seatCapacityApplicable
                                                    .value,
                                                onChanged: (bool? value) {
                                                  vehicleAndDriverC
                                                      .seatCapacityApplicable
                                                      .toggle();
                                                },
                                              ),
                                              KText(
                                                text: 'Passed  ',
                                                fontSize: 13,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    KText(
                                                      text:
                                                          'Scenario-1 (WL: 1310 nm)',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Expected Value:',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      children: [
                                                        KText(
                                                            text: 'Test Result',
                                                            color: AppTheme
                                                                .nTextLightC,
                                                            fontSize: 14),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: '12db',
                                                      color:
                                                          hexToColor('#41525A'),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 70,
                                                      child: TextFormField(
                                                        onChanged:
                                                            projectDashboardCreateC
                                                                .quntity,
                                                        cursorColor:
                                                            Color(0xFF90A4AE),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: '11.5 dB',
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxHeight:
                                                                      40),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFF90A4AE),
                                                            ),
                                                          ),
                                                          focusColor:
                                                              Color(0xFF90A4AE),
                                                          labelStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF424242)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          }),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Remarks',
                                                color: hexToColor('#80939D'),
                                              ),

                                              //  Text('Serial Number'),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              // remarks (get text)
                                              TextFormField(
                                                onChanged: (value) {},
                                                maxLines: 5,
                                                minLines: 1,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore fugiat.',
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: .1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                        color: hexToColor('#FFE9CF'),
                                        width: 1)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          KText(
                                            text: 'ID:',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                            text: '101',
                                            color: hexToColor('#41525A'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Acceptance Criteria:',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Checkbox(
                                                checkColor: Colors.white,
                                                // fillColor: MaterialStateProperty
                                                //     .resolveWith(getColor),
                                                value: vehicleAndDriverC
                                                    .seatCapacityApplicable
                                                    .value,
                                                onChanged: (bool? value) {
                                                  vehicleAndDriverC
                                                      .seatCapacityApplicable
                                                      .toggle();
                                                },
                                              ),
                                              KText(
                                                text: 'Passed  ',
                                                fontSize: 13,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Criteria-1:',
                                            color: hexToColor('#41525A'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    KText(
                                                      text:
                                                          'Scenario-1 (WL: 1310 nm)',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Expected Value:',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      children: [
                                                        KText(
                                                            text: 'Test Result',
                                                            color: AppTheme
                                                                .nTextLightC,
                                                            fontSize: 14),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: '12db',
                                                      color:
                                                          hexToColor('#41525A'),
                                                    ),
                                                    Spacer(),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 70,
                                                      child: TextFormField(
                                                        onChanged:
                                                            projectDashboardCreateC
                                                                .quntity,
                                                        cursorColor:
                                                            Color(0xFF90A4AE),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: '11.5 dB',
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxHeight:
                                                                      40),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFF90A4AE),
                                                            ),
                                                          ),
                                                          focusColor:
                                                              Color(0xFF90A4AE),
                                                          labelStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF424242)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            );
                                          }),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Remarks',
                                                color: hexToColor('#80939D'),
                                              ),

                                              //  Text('Serial Number'),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              // remarks (get text)
                                              TextFormField(
                                                onChanged: (value) {},
                                                maxLines: 5,
                                                minLines: 1,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore fugiat.',
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: .1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  )
                  // Container(
                  //   // height: 148,
                  //   // width: double.infinity,
                  //   margin: EdgeInsets.only(bottom: 15),
                  //   decoration: BoxDecoration(
                  //     // borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     color: hexToColor('#FFFFFF'),
                  //     border: Border.all(
                  //       width: 1,
                  //       color: hexToColor('#FFE9CF'),
                  //     ),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         height: 34,
                  //         width: double.infinity,
                  //         // color: hexToColor('#FFE9CF'),
                  //         decoration: BoxDecoration(
                  //           // borderRadius: BorderRadius.all(Radius.circular(5)),
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(5),
                  //             topRight: Radius.circular(5),
                  //           ),
                  //           color: hexToColor('#FFE9CF'),
                  //         ),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   EdgeInsets.only(bottom: 5, left: 15, top: 5),
                  //               child: KText(
                  //                 text: 'hjh',
                  //                 fontSize: 16,
                  //                 color: hexToColor('#41525A'),
                  //                 bold: true,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       KText(
                  //                         text: 'Type: ',
                  //                         fontSize: 14,
                  //                         color: hexToColor('#80939D'),
                  //                         bold: false,
                  //                       ),
                  //                       Expanded(
                  //                         child: KText(
                  //                           text: 'vfsdfgs',
                  //                           fontSize: 14,
                  //                           color: hexToColor('#41525A'),
                  //                           bold: false,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(height: 2),
                  //                   Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       KText(
                  //                         text: 'Capacity: ',
                  //                         fontSize: 14,
                  //                         color: hexToColor('#80939D'),
                  //                         bold: false,
                  //                         maxLines: 2,
                  //                       ),
                  //                       Expanded(
                  //                         child: Row(
                  //                           children: [],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(height: 2),
                  //                   Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       KText(
                  //                         text: 'Brand: ',
                  //                         fontSize: 14,
                  //                         color: hexToColor('#80939D'),
                  //                         bold: false,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   SizedBox(height: 2),
                  //                   Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       KText(
                  //                         text: 'Driver: ',
                  //                         fontSize: 14,
                  //                         color: hexToColor('#80939D'),
                  //                         bold: false,
                  //                       ),
                  //                       Expanded(
                  //                         child: KText(
                  //                           text: 'fgdf',
                  //                           fontSize: 14,
                  //                           color: hexToColor('#41525A'),
                  //                           bold: false,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Container(
                  //               padding: EdgeInsets.only(
                  //                   top: 14, left: 5, bottom: 12, right: 16),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   color: Colors.white60),
                  //               child: Image.asset(
                  //                 '${Constants.imgPath}/truck.png',
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          )),

      // bottomNavigationBar: Obx(
      //   () => Container(
      //     padding: EdgeInsets.all(12),
      //     // height: 40,
      //     width: Get.width,
      //     // margin: EdgeInsets.symmetric(vertical: .5),

      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //     ),

      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         InkWell(
      //           onTap: createTrasnportOrderC.validateTrasnportOrder()
      //               ? () {
      //                   push(CreateTransportLineItemsPage());
      //                 }
      //               : () {
      //                   Get.snackbar(
      //                     'Status',
      //                     'Please enter data for all required fields',
      //                     colorText: AppTheme.black,
      //                     backgroundColor: AppTheme.appHomePageColor,
      //                     snackPosition: SnackPosition.BOTTOM,
      //                   );
      //                 },
      //           child: Container(
      //             height: 40,
      //             width: 100,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(6),
      //               color: createTrasnportOrderC.validateTrasnportOrder()
      //                   ? hexToColor('#007BEC')
      //                   : hexToColor('#007BEC').withOpacity(.5),
      //             ),
      //             child: Center(
      //               child: KText(
      //                 text: 'Next',
      //                 color: Colors.white,
      //                 bold: true,
      //                 fontSize: 15,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget singleRecivingPerson() {
    return Container(
      height: 70,
      width: Get.width,
      color: hexToColor('#F7F7FC'),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      KText(
                        maxLines: 2,
                        text: 'Test Type',
                        color: hexToColor('#80939D'),
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  child: GestureDetector(
                    onTap: () {
                      createTrasnportOrderC
                          .searchUserBottomsheet('Single Receiving Person');
                    },
                    child: RenderSvg(
                      path: 'icon_search_elements',
                      width: 26,
                      color: hexToColor('#66A1D9'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                KText(
                  text: createTrasnportOrderC.getSingleRecivingPerson() == null
                      ? 'Single Receving Party'
                      : createTrasnportOrderC.getSingleRecivingPerson(),
                  fontSize: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
