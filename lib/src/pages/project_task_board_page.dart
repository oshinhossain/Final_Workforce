import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

// ignore: must_be_immutable
class ProjectTaskBoardPage extends StatelessWidget with Base {
  String projectId;
  String pBucketId;
  String pGruopId;
  String pActivityId;
  ProjectTaskBoardPage({
    required this.projectId,
    required this.pBucketId,
    required this.pGruopId,
    required this.pActivityId,
  });

// Get progress Color
//..............
  String getColor(double value) {
    if (value < 50) {
      return '#FF7373';
    } else if (value < 75) {
      return '#55ADFE';
    } else {
      return '#00D8A0';
    }
  }

  @override
  Widget build(BuildContext context) {
    // projectPlanningBoardC.getProjectTask(
    //     projectId, pActivityId, pBucketId, pGruopId);

    return WillPopScope(
      onWillPop: () {
        //  projectPlanningBoardC.projectTaskGet.clear();

        return Future(
          () {
            return true;
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: KAppbar(),
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        backgroundColor: hexToColor('#FFFFFF'),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 10, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          //   projectPlanningBoardC.projectTaskGet.clear();
                          back();
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      KText(
                        text: 'Project Task Board',
                        fontSize: 16,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      projectPlanningBoardC.projectTaskGet.isEmpty
                          ? projectPlanningBoardC.isLoading.value
                              ? SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                    child: Loading(),
                                  ),
                                )
                              : SizedBox(
                                  height: 30,
                                  child: Container(
                                    height: 30,
                                    width: 30,

                                    //  padding: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        color: hexToColor('#FFF4E8'),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            width: 1,
                                            color: hexToColor('#FFA133'))),
                                    child: Center(
                                      child: KText(
                                        text: '0',
                                        color: hexToColor('#FFA133'),
                                      ),
                                    ),
                                  ),
                                )
                          : Container(
                              height: 30,
                              width: 30,

                              //  padding: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                  color: hexToColor('#FFF4E8'),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      width: 1, color: hexToColor('#FFA133'))),
                              child: Center(
                                child: KText(
                                  text:
                                      '${projectPlanningBoardC.projectTaskGet.length} ',
                                  color: hexToColor('#FFA133'),
                                ),
                              ),
                            ),
                      SizedBox()
                    ],
                  ),
                ),
                projectPlanningBoardC.projectTaskGet.isEmpty
                    ? projectPlanningBoardC.isLoading.value
                        ? SizedBox(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : SizedBox(
                            height: Get.height / 1.5,
                            child: Center(child: KText(text: 'No data found')),
                          )
                    : Container(
                        decoration: BoxDecoration(
                          color: hexToColor('#EEF0F6'),
                          border: Border.all(color: AppTheme.nBorderC1),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: hexToColor('#EEF0F6'),
                            )
                          ],
                        ),
                        height: 100,
                        width: Get.width,
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                textOverflow: TextOverflow.visible,
                                fontSize: 14,
                                maxLines: 5,
                                bold: true,
                                text:
                                    '${projectPlanningBoardC.projectTaskGet[0].projectName} > ${projectPlanningBoardC.projectTaskGet[0].bucketName!} > ${projectPlanningBoardC.projectTaskGet[0].groupName!} > ${projectPlanningBoardC.projectTaskGet[0].activityName}',
                              ),
                            ]),
                      ),
                projectPlanningBoardC.projectTaskGet.isEmpty
                    ? projectPlanningBoardC.isLoading.value
                        ? SizedBox(
                            height: Get.height / 1.5,
                            child: Center(
                              child: Loading(),
                            ),
                          )
                        : SizedBox(
                            height: Get.height / 1.5,
                            child: Center(child: KText(text: 'No data found')),
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: projectPlanningBoardC.projectTaskGet.length,
                        itemBuilder: (context, index) {
                          final item =
                              projectPlanningBoardC.projectTaskGet[index];
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              width: Get.width,
                              // width: 360,
                              //// height: 410,
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                //  border: Border.all(color: AppTheme.nBorderC1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: KText(
                                                text: item.supportName,
                                                fontSize: 15,
                                                textOverflow:
                                                    TextOverflow.visible,
                                                bold: true,
                                                maxLines: 2,
                                                color: hexToColor('#515D64'),
                                              ),
                                            ),
                                            Spacer(),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: hexToColor('#DBECFB'),
                                                ),
                                                height: 25,
                                                width: 90,
                                                child: Center(
                                                  child: FittedBox(
                                                    child: KText(
                                                      text: item.status != null
                                                          ? '${item.status}'
                                                          : '',
                                                      fontSize: 12,

                                                      //  bold: true,
                                                      color:
                                                          hexToColor('#007BEC'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Icon(
                                                  Icons.more_vert_outlined),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: KText(
                                      text:
                                          '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(0)}%',
                                      fontSize: 13,
                                      bold: true,
                                      color: hexToColor('#515D64'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearPercentIndicator(
                                    barRadius: Radius.circular(10),
                                    animation: true,
                                    lineHeight: 9.0,
                                    animationDuration: 5000,
                                    percent: item.outputProgress!,
                                    progressColor: hexToColor(
                                      getColor(double.parse(
                                              item.outputProgress.toString()) *
                                          100),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: 'Assigned to',
                                              color: hexToColor('#80939D'),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: KText(
                                                      text: item.ownerFullname !=
                                                              null
                                                          ? '${item.ownerFullname}'
                                                          : '',
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                // RenderImg(
                                                //   path: 'icon_avatar.png',
                                                //   width: 30,
                                                //   height: 30,
                                                // ),

                                                projectDashbordC
                                                            .userImage.value !=
                                                        null
                                                    ? Container(
                                                        height: 32,
                                                        width: 32,
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 8.0,
                                                              ),
                                                            ]),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          // child: Image.memory(
                                                          //   projectDashbordC
                                                          //       .userImage.value!,
                                                          //   fit: BoxFit.cover,
                                                          // ),
                                                          child: Image.network(
                                                              '${projectDashbordC.userImage}'),
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          projectDashbordC
                                                              .getImageByUserName(
                                                                  username: item
                                                                      .assignedUsername!);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              AppTheme.color4,
                                                          radius: 15,
                                                          child: RenderImg(
                                                            path:
                                                                'icon_avatar.png',
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ),
                                                      ),

                                                // if (item.assignedUsername != null)
                                                //   RenderImg(
                                                //     path: 'icon_avatar.png',
                                                //     width: 30,
                                                //     height: 30,
                                                //   ),

                                                // Container(
                                                //   height: 64,
                                                //   width: 64,
                                                //   margin: EdgeInsets.only(
                                                //       right: 5, top: 5),
                                                //   decoration: BoxDecoration(
                                                //     color: Color(0xffF5F5FA),
                                                //     borderRadius:
                                                //         BorderRadius.circular(50),
                                                //     border: Border.all(
                                                //       color: Color.fromARGB(
                                                //           255, 230, 230, 233),
                                                //       style: BorderStyle.solid,
                                                //       width: 2,
                                                //     ),
                                                //     boxShadow: [
                                                //       BoxShadow(
                                                //         color: Color(0xffF5F5FA)
                                                //             .withOpacity(0.6),
                                                //         spreadRadius: 5,
                                                //         blurRadius: 7,
                                                //         offset: Offset(0,
                                                //             3), // changes position of shadow
                                                //       ),
                                                //     ],
                                                //   ),
                                                //   child: Container(
                                                //     height: 38,
                                                //     width: 38,
                                                //     decoration: BoxDecoration(
                                                //       color: Colors.white,
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               50),
                                                //     ),
                                                //     child: Padding(
                                                //       padding:
                                                //           EdgeInsets.all(1.0),
                                                //       child: ClipRRect(
                                                //         borderRadius:
                                                //             BorderRadius.circular(
                                                //                 50),
                                                //         child: Image.network(
                                                //           '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=23.90560,93.094535&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$username&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                //           fit: BoxFit.cover,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        KText(
                                          text: 'Task ID',
                                          color: hexToColor('#80939D'),
                                        ),
                                        Spacer(),
                                        KText(
                                          text: item.supportNo != null
                                              ? '${item.supportNo}'
                                              : '',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        KText(
                                          text: 'Task Role ',
                                          color: hexToColor('#80939D'),
                                        ),
                                        Spacer(),
                                        // KText(
                                        //   text: item.weightPct != null
                                        //       ? '${item.weightPct} %'
                                        //       : '0.0 %',
                                        // ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: item.supportType == 'R'
                                                ? hexToColor('#49CDAB')
                                                : item.supportType == 'A'
                                                    ? hexToColor('#FF6565')
                                                    : item.supportType == 'S'
                                                        ? hexToColor('#000000')
                                                        : item.supportType ==
                                                                'C'
                                                            ? hexToColor(
                                                                '#9BA9B3')
                                                            : item.supportType ==
                                                                    'I'
                                                                ? hexToColor(
                                                                    '#449EF1')
                                                                : hexToColor(
                                                                    '#FFB661'),
                                          ),
                                          height: 25,
                                          width: 90,
                                          child: Center(
                                            child: FittedBox(
                                              child: KText(
                                                text: item.supportType == 'R'
                                                    ? 'Responsible'
                                                    : item.supportType == 'A'
                                                        ? 'Accountable'
                                                        : item.supportType ==
                                                                'S'
                                                            ? 'Support'
                                                            : item.supportType ==
                                                                    'C'
                                                                ? 'Consulted'
                                                                : item.supportType ==
                                                                        'I'
                                                                    ? 'Information'
                                                                    : 'Accountable',
                                                color: hexToColor('#FFFFFF'),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        KText(
                                          text: 'Output ',
                                          color: hexToColor('#80939D'),
                                        ),
                                        Spacer(),
                                        KText(
                                          text: item.outputTarget != null
                                              ? '${item.outputTarget} '
                                              : '',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Row(
                                      children: [
                                        KText(
                                          text: 'Deadline',
                                          color: hexToColor('#80939D'),
                                        ),
                                        Spacer(),
                                        KText(
                                          text: formatDate(
                                              date: item.scheduledEndDate!),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Column(
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
                                          text: item.supportDescr != null
                                              ? '${item.supportDescr}'
                                              : '',
                                          fontSize: 13,
                                          maxLines: 2,
                                          textOverflow: TextOverflow.visible,
                                          color: hexToColor('#515D64'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: StadiumBorder(),
          child: RenderSvg(path: 'floating-button-Chat-user-add'),
        ),
      ),
    );
  }
}
