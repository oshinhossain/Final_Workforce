import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/route.dart';
import '../widgets/custom_textfield_with_dropdown.dart';

class MyNetworkInstallerWorkbenchPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    assignGeographiesProjectC.getProjectName();
    // assignGeographiesProjectC.assingProjectAreaGet();
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(40.0),
      //     side: BorderSide(
      //       color: hexToColor('#FFFFFF'),
      //     ),
      //   ),
      //   onPressed: () {
      //     push(
      //       SelectGeographyPage(
      //           projectDropdown:
      //               assignGeographiesProjectC.selectedProject.value!),
      //     );
      //   },
      //   child: Icon(Icons.add, color: hexToColor('#FFFFFF')),
      //   //  RenderSvg(
      //   //   path: 'floating-button-Chat-user-add',
      // ),
      appBar: KAppbar(),
      // backgroundColor: hexToColor('#EEF0F6'),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 0, right: 12, top: 3, bottom: 3),
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
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        back();
                      },
                    ),
                    Center(
                      child: KText(
                        text: 'My Network Installer Workbench',
                        fontSize: 16,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),

                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                    color: hexToColor('#EEF0F6'),
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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: KText(
                        text: '  Project Name',
                        fontSize: 14,
                        color: hexToColor('#41525A'),
                      ),
                    ),
                    if (assignGeographiesProjectC.projectNameList.isNotEmpty)
                      SizedBox(
                        width: Get.width,
                        child: CustomTextFieldWithDropdown(
                          suffix: DropdownButton(
                            value: assignGeographiesProjectC
                                .selectedProject.value!.id,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: hexToColor('#80939D'),
                            ),
                            items: assignGeographiesProjectC.projectNameList
                                .map((item) {
                              return DropdownMenuItem(
                                onTap: () async {
                                  assignGeographiesProjectC
                                      .selectedProject.value = item;

                                  await assignGeographiesProjectC
                                      .assingProjectAreaGet();
                                  assignGeographiesProjectC.projectAreaGet
                                      .clear();
                                  await assignGeographiesProjectC
                                      .assingProjectAreaGet();
                                },
                                value: item.id,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    width: Get.width - 80,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: KText(
                                        text: item.projectName,
                                        fontSize: 14,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (item) {
                              //assignGeographiesProjectC.projectNameList.clear();
                              assignGeographiesProjectC.projectId.value = item!;

                              //// kLog(assignGeographiesProjectC.projectId.value);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              // Center(
              //     child: KText(
              //   text: '${assignGeographiesProjectC.projectAreaGet.length}',
              //   fontSize: 20,
              // )),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    width: Get.width,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 8),
                          child: KText(
                            text: 'Geography',
                            fontSize: 13,
                            color: AppTheme.appTextColor1,
                            bold: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 3),
                          child: KText(
                            text: 'Bagerhat > Bagerhat Sadar > Dema',
                            fontSize: 13,
                            color: AppTheme.appTextColor2,
                            bold: true,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 95,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Start',
                                    color: hexToColor('#727272'),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#C7C7C7',
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 35,
                              width: 95,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Complete',
                                    color:
                                        hexToColor('#07B0F3').withOpacity(.5),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#07B0F3',
                                      ).withOpacity(.3),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 20,
                      width: 90,
                      decoration: BoxDecoration(
                        color: hexToColor('#E4E4E4'),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: KText(
                          text: 'Not Started',
                          fontSize: 11,
                          color: hexToColor('#778187'),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    width: Get.width,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 8),
                          child: KText(
                            text: 'Geography',
                            fontSize: 13,
                            color: AppTheme.appTextColor1,
                            bold: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 3),
                          child: KText(
                            text: 'Bagerhat > Bagerhat Sadar > Dema',
                            fontSize: 13,
                            color: AppTheme.appTextColor2,
                            bold: true,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Postpone',
                                    color: hexToColor('#00CA96'),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#00D8A0',
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 35,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Complete',
                                    color: hexToColor('#07B0F3'),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#07B0F3',
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: hexToColor('#CAFDF0'),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: KText(
                          text: 'Open',
                          fontSize: 11,
                          color: hexToColor('#09C594'),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    width: Get.width,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 8),
                          child: KText(
                            text: 'Geography',
                            fontSize: 13,
                            color: AppTheme.appTextColor1,
                            bold: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 3),
                          child: KText(
                            text: 'Bagerhat > Bagerhat Sadar > Dema',
                            fontSize: 13,
                            color: AppTheme.appTextColor2,
                            bold: true,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 95,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Restart',
                                    color: hexToColor('#FFA133'),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#FFA133',
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 35,
                              width: 95,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Complete',
                                    color: hexToColor('#07B0F3'),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#07B0F3',
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: hexToColor('#FFF3E1'),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: KText(
                          text: 'Not Completed',
                          fontSize: 11,
                          color: hexToColor('#FFA133'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    width: Get.width,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.black12,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 8),
                          child: KText(
                            text: 'Geography',
                            fontSize: 13,
                            color: AppTheme.appTextColor1,
                            bold: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 3),
                          child: KText(
                            text: 'Bagerhat > Bagerhat Sadar > Dema',
                            fontSize: 13,
                            color: AppTheme.appTextColor2,
                            bold: true,
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35,
                              width: 95,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Start',
                                    color:
                                        hexToColor('#727272').withOpacity(.5),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#C7C7C7',
                                      ).withOpacity(.3),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 35,
                              child: OutlinedButton(
                                  onPressed: () {
                                    // Add your onPressed code here!
                                  },
                                  child: KText(
                                    text: 'Complete',
                                    color:
                                        hexToColor('#07B0F3').withOpacity(.5),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      width: 2,
                                      color: hexToColor(
                                        '#07B0F3',
                                      ).withOpacity(.3),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 20,
                      width: 90,
                      decoration: BoxDecoration(
                        color: hexToColor('#E4E4E4'),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: KText(
                          text: 'Completed',
                          fontSize: 11,
                          color: hexToColor('#778187'),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // assignGeographiesProjectC.selectedlocations.isNotEmpty
              //     ? ListView.builder(
              //         shrinkWrap: true,
              //         primary: false,
              //         itemCount:
              //             assignGeographiesProjectC.selectedlocations.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           final item =
              //               assignGeographiesProjectC.selectedlocations[index];
              //           return Stack(
              //             children: [
              //               Container(
              //                 margin: EdgeInsets.all(12),
              //                 width: Get.width,
              //                 height: 110,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(6),
              //                     color: Colors.white,
              //                     boxShadow: [
              //                       BoxShadow(
              //                         blurRadius: 10.0,
              //                         color: Colors.black12,
              //                       )
              //                     ]),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: EdgeInsets.only(left: 12, top: 8),
              //                       child: KText(
              //                         text: 'Geography',
              //                         fontSize: 13,
              //                         color: AppTheme.appTextColor1,
              //                         bold: true,
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding:
              //                           EdgeInsets.only(left: 12, bottom: 3),
              //                       child: KText(
              //                         text: item.geoLevel4Name!.isEmpty
              //                             ? ''
              //                             : '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
              //                         fontSize: 13,
              //                         color: AppTheme.appTextColor2,
              //                         bold: true,
              //                       ),
              //                     ),
              //                     Divider(),
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         SizedBox(
              //                           height: 35,
              //                           child: OutlinedButton(
              //                               onPressed: () {
              //                                 // Add your onPressed code here!
              //                               },
              //                               child: KText(
              //                                 text: 'Start',
              //                                 color: hexToColor('#727272'),
              //                               ),
              //                               style: OutlinedButton.styleFrom(
              //                                 side: BorderSide(
              //                                   width: 2,
              //                                   color: hexToColor(
              //                                     '#C7C7C7',
              //                                   ),
              //                                 ),
              //                               )),
              //                         ),
              //                         SizedBox(
              //                           width: 10,
              //                         ),
              //                         SizedBox(
              //                           height: 35,
              //                           child: OutlinedButton(
              //                               onPressed: () {
              //                                 // Add your onPressed code here!
              //                               },
              //                               child: KText(
              //                                 text: 'Complete',
              //                                 color: hexToColor('#07B0F3'),
              //                               ),
              //                               style: OutlinedButton.styleFrom(
              //                                 side: BorderSide(
              //                                   width: 2,
              //                                   color: hexToColor(
              //                                     '#07B0F3',
              //                                   ),
              //                                 ),
              //                               )),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               Positioned(
              //                 right: 30,
              //                 child: Container(
              //                   height: 20,
              //                   width: 90,
              //                   decoration: BoxDecoration(
              //                     color: hexToColor('#E4E4E4'),
              //                     borderRadius: BorderRadius.circular(15),
              //                   ),
              //                   child: Center(
              //                     child: KText(
              //                       text: 'Completed',
              //                       fontSize: 11,
              //                       color: hexToColor('#778187'),
              //                     ),
              //                   ),
              //                 ),
              //               )
              //             ],
              //           );
              //         },
              //       )
              //     : Center(child: KText(text: 'no seleced '))
            ],
          ),
        ),
      ),
    );
  }
}
