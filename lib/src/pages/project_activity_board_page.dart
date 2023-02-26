import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/pages/project_task_board_page.dart';
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

//ignore: must_be_immutable
class ProjectActivityBoardPage extends StatelessWidget with Base {
  String id;
  String projectName;
  String pBucketId;
  String pGruopId;
  ProjectActivityBoardPage(
      {required this.id,
      required this.projectName,
      required this.pBucketId,
      required this.pGruopId});

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

  final RefreshController _refreshController = RefreshController();
  Future<void> _onRefresh() async {
    projectPlanningBoardC.getActivity(id, pBucketId, pGruopId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        projectPlanningBoardC.activityList.clear();

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
          () => SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
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
                            projectPlanningBoardC.activityList.clear();
                            back();
                          },
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        KText(
                          text: 'Project Activity Board',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        projectPlanningBoardC.projectPlanningBoard.isEmpty
                            ? projectPlanningBoardC.isLoading.value
                                ? SizedBox(
                                    height: Get.height / 1.5,
                                    child: Center(
                                      child: Loading(),
                                    ),
                                  )
                                : SizedBox(
                                    height: Get.height / 1.5,
                                    child: Center(
                                        child: KText(text: 'No data found')),
                                  )
                            : Container(
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
                                    text:
                                        '${projectPlanningBoardC.activityList.length} ',
                                    color: hexToColor('#FFA133'),
                                  ),
                                ),
                              ),
                        SizedBox()
                      ],
                    ),
                  ),
                  projectPlanningBoardC.activityList.isEmpty
                      ? projectPlanningBoardC.isLoading.value
                          ? SizedBox(
                              height: Get.height / 1.5,
                              child: Center(
                                child: Loading(),
                              ),
                            )
                          : SizedBox(
                              height: Get.height / 1.5,
                              child:
                                  Center(child: KText(text: 'No data found')),
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
                          height: 80,
                          width: Get.width,
                          padding: EdgeInsets.only(left: 15, top: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  textOverflow: TextOverflow.visible,
                                  fontSize: 14,
                                  maxLines: 2,
                                  bold: true,
                                  text:
                                      '$projectName > ${projectPlanningBoardC.activityList[0].bucketName!} > ${projectPlanningBoardC.activityList[0].groupName!} ',
                                ),
                              ]),
                        ),
                  projectPlanningBoardC.activityList.isEmpty
                      ? projectPlanningBoardC.isLoading.value
                          ? SizedBox(
                              height: Get.height / 1.5,
                              child: Center(
                                child: Loading(),
                              ),
                            )
                          : SizedBox(
                              height: Get.height / 1.5,
                              child:
                                  Center(child: KText(text: 'No data found')),
                            )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: projectPlanningBoardC.activityList.length,
                          itemBuilder: (context, index) {
                            final item =
                                projectPlanningBoardC.activityList[index];
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                width: Get.width,
                                // width: 360,
                                // height: 410,
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
                                                  text: item.activityName,
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
                                                            Radius.circular(
                                                                20)),
                                                    color:
                                                        hexToColor('#DBECFB'),
                                                  ),
                                                  height: 25,
                                                  width: 90,
                                                  child: Center(
                                                    child: FittedBox(
                                                      child: KText(
                                                        text: item.status !=
                                                                null
                                                            ? '${item.status}'
                                                            : '',
                                                        fontSize: 12,

                                                        //  bold: true,
                                                        color: hexToColor(
                                                            '#007BEC'),
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
                                    double.parse(item.outputProgress
                                                .toString()) <=
                                            1.01
                                        ? LinearPercentIndicator(
                                            barRadius: Radius.circular(10),
                                            animation: true,
                                            lineHeight: 9.0,
                                            animationDuration: 5000,
                                            percent: item.outputProgress!,
                                            progressColor: hexToColor(
                                              getColor(double.parse(item
                                                      .outputProgress
                                                      .toString()) *
                                                  100),
                                            ),
                                          )
                                        : LinearPercentIndicator(
                                            barRadius: Radius.circular(10),
                                            animation: true,
                                            lineHeight: 9.0,
                                            animationDuration: 5000,
                                            percent: 1.00,
                                            progressColor:
                                                Colors.green.shade400,
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
                                                        text: item.fullname !=
                                                                null
                                                            ? '${item.fullname}'
                                                            : '',
                                                        textOverflow:
                                                            TextOverflow
                                                                .visible,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  RenderImg(
                                                    path: 'icon_avatar.png',
                                                    width: 30,
                                                    height: 30,
                                                  ),
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
                                    item.mobile != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterPhoneDirectCaller
                                                  .callNumber('${item.mobile}');
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 5),
                                              child: Row(
                                                children: [
                                                  KText(
                                                    text: 'Mobile Number',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  Spacer(),
                                                  KText(
                                                    text: item.mobile != null
                                                        ? '${item.mobile}'
                                                        : '',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    item.mobile != null
                                        ? Divider(
                                            thickness: 1,
                                          )
                                        : SizedBox(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Row(
                                        children: [
                                          KText(
                                            text: 'Group ID',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          KText(
                                            text: item.groupCode != null
                                                ? '${item.groupCode}'
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
                                            text: 'Weight ',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          KText(
                                            text: item.weightPct != null
                                                ? '${item.weightPct} %'
                                                : '0.0 %',
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
                                            text: item.activityDescr != null
                                                ? '${item.activityDescr}'
                                                : '',
                                            fontSize: 13,
                                            maxLines: 2,
                                            textOverflow: TextOverflow.visible,
                                            color: hexToColor('#515D64'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Obx(
                                      () =>
                                          projectPlanningBoardC
                                                      .projectActivityCountGet
                                                      .length !=
                                                  projectPlanningBoardC
                                                      .activityList.length
                                              ? projectPlanningBoardC
                                                      .isLoading.value
                                                  ? SizedBox(
                                                      height: 20,
                                                      child: Center(
                                                        child: Loading(),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 20,
                                                      child: Center(
                                                          child: KText(
                                                              text:
                                                                  'No data found')),
                                                    )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 10,
                                                      bottom: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // Stack(
                                                          //   children: [
                                                          //     Padding(
                                                          //       padding:
                                                          //           EdgeInsets.only(
                                                          //               right: 8),
                                                          //       child: CircleAvatar(
                                                          //         radius: 22,
                                                          //         backgroundColor:
                                                          //             hexToColor(
                                                          //                 '#CFE8FF'),
                                                          //         child:
                                                          //             GestureDetector(
                                                          //           onTap: () {
                                                          //             projectPlanningBoardC
                                                          //                 .getActivity();
                                                          //             push(
                                                          //               ProjectActivityBoardPage(
                                                          //                 id: projectPlanningBoardC
                                                          //                     .projectPlanningBoard[
                                                          //                         index]!
                                                          //                     .id!,
                                                          //                 projectName: projectPlanningBoardC
                                                          //                     .projectPlanningBoard[
                                                          //                         index]!
                                                          //                     .projectName
                                                          //                     .toString(),
                                                          //               ),
                                                          //               //projectPlanningBoardC.projectScopeBucketBoardGet()
                                                          //             );
                                                          //           },
                                                          //           child: CircleAvatar(
                                                          //             backgroundColor:
                                                          //                 hexToColor(
                                                          //                     '#E7F3FF'),
                                                          //             radius: 21,
                                                          //             child: KText(
                                                          //               text: 'A',
                                                          //               fontSize: 16,
                                                          //               bold: true,
                                                          //               color: hexToColor(
                                                          //                   '#007BEC'),
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Positioned(
                                                          //       left: 30,
                                                          //       child: Container(
                                                          //         width: 22,
                                                          //         height: 15,
                                                          //         decoration:
                                                          //             BoxDecoration(
                                                          //           color: hexToColor(
                                                          //               '#007BEC'),
                                                          //           borderRadius:
                                                          //               BorderRadius
                                                          //                   .circular(
                                                          //                       10),
                                                          //         ),
                                                          //         // backgroundColor: hexToColor('#FFA133'),
                                                          //         // radius: 10,
                                                          //         child: Center(
                                                          //           child: KText(
                                                          //             text: projectActivityGroupBoardC
                                                          //                         .projectCount[
                                                          //                             index]!
                                                          //                         .activities! !=
                                                          //                     null
                                                          //                 ? projectActivityGroupBoardC
                                                          //                     .projectCount[
                                                          //                         index]!
                                                          //                     .activities!
                                                          //                 : '0',
                                                          //             fontSize: 11,
                                                          //             bold: true,
                                                          //             color:
                                                          //                 Colors.white,
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   width: 5,
                                                          // ),
                                                          GestureDetector(
                                                            onTap: (() async {
                                                              await projectPlanningBoardC
                                                                  .getProjectTask(
                                                                // item.projectId!,
                                                                // item.bucketId!,
                                                                // item.groupId!,
                                                                item.id!,
                                                              );
                                                              push(
                                                                ProjectTaskBoardPage(
                                                                  projectId: item
                                                                      .projectId!,
                                                                  pBucketId: item
                                                                      .bucketId!,
                                                                  pGruopId: item
                                                                      .groupId!,
                                                                  pActivityId:
                                                                      item.id!,
                                                                ),
                                                              );
                                                            }),
                                                            child: Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              15),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 22,
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#FFE9CF'),
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#FFF4E8'),
                                                                      radius:
                                                                          21,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          // projectProgressDashboardC
                                                                          //     .getActivity();
                                                                        },
                                                                        child:
                                                                            KText(
                                                                          text:
                                                                              'T',
                                                                          fontSize:
                                                                              16,
                                                                          bold:
                                                                              true,
                                                                          color:
                                                                              hexToColor('#FFA133'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 30,
                                                                  child:
                                                                      Container(
                                                                    width: 28,
                                                                    height: 16,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: hexToColor(
                                                                          '#FFA133'),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    // backgroundColor: hexToColor('#FFA133'),
                                                                    // radius: 10,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          KText(
                                                                        text: projectPlanningBoardC.projectActivityCountGet[index]!.tasks! !=
                                                                                null
                                                                            ? projectPlanningBoardC.projectActivityCountGet[index]!.tasks!
                                                                            : '0',
                                                                        // projectActivityGroupBoardC
                                                                        //     // .projectCount[
                                                                        //     //     index]!
                                                                        //     .activities,
                                                                        fontSize:
                                                                            11,
                                                                        bold:
                                                                            true,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      PopupMenuButton(
                                                        color: Colors
                                                            .grey.shade100,
                                                        child: RenderSvg(
                                                          path: 'info',
                                                          height: 45,
                                                        ),
                                                        onSelected: (value) {
                                                          // ScaffoldMessenger.of(context).showSnackBar(
                                                          //     SnackBar(
                                                          //         content:
                                                          //             Text('$value item pressed')));
                                                        },
                                                        itemBuilder: (context) {
                                                          return [
                                                            // PopupMenuItem(
                                                            //   child: Column(
                                                            //     children: [
                                                            //       Row(
                                                            //         children: [
                                                            //           Stack(
                                                            //             children: [
                                                            //               CircleAvatar(
                                                            //                 radius: 25,
                                                            //                 backgroundColor:
                                                            //                     hexToColor(
                                                            //                         '#CFE8FF'),
                                                            //                 child:
                                                            //                     CircleAvatar(
                                                            //                   backgroundColor:
                                                            //                       hexToColor(
                                                            //                           '#E7F3FF'),
                                                            //                   radius:
                                                            //                       23,
                                                            //                   child:
                                                            //                       KText(
                                                            //                     text:
                                                            //                         'A',
                                                            //                     fontSize:
                                                            //                         16,
                                                            //                     bold:
                                                            //                         true,
                                                            //                     color: hexToColor(
                                                            //                         '#007BEC'),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //             ],
                                                            //           ),
                                                            //           SizedBox(
                                                            //             width: 8,
                                                            //           ),
                                                            //           RenderSvg(
                                                            //             path:
                                                            //                 'arrow_right',
                                                            //             width: 16,
                                                            //           ),
                                                            //           SizedBox(
                                                            //             width: 8,
                                                            //           ),
                                                            //           SizedBox(
                                                            //             width: 123.0,
                                                            //             child:
                                                            //                 Container(
                                                            //               decoration:
                                                            //                   BoxDecoration(
                                                            //                 borderRadius:
                                                            //                     BorderRadius.all(
                                                            //                         Radius.circular(8)),
                                                            //                 color: hexToColor(
                                                            //                     '#007BEC'),
                                                            //               ),
                                                            //               height: 30,
                                                            //               width: 50,
                                                            //               child: Center(
                                                            //                 child:
                                                            //                     KText(
                                                            //                   text:
                                                            //                       'Activities',
                                                            //                   fontSize:
                                                            //                       14,
                                                            //                   //  bold: true,
                                                            //                   color: hexToColor(
                                                            //                       '#FFFFFF'),
                                                            //                 ),
                                                            //               ),
                                                            //             ),
                                                            //           ),
                                                            //           SizedBox(
                                                            //             width: 20,
                                                            //           ),
                                                            //           RenderSvg(
                                                            //             path:
                                                            //                 'cross_icon',
                                                            //             width: 16,
                                                            //           ),
                                                            //         ],
                                                            //       ),
                                                            //       SizedBox(
                                                            //         height: 8,
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            //   value: () {},
                                                            // ),

                                                            PopupMenuItem(
                                                              child: Row(
                                                                children: [
                                                                  Stack(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            25,
                                                                        backgroundColor:
                                                                            hexToColor('#FFF4E8'),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              hexToColor('#FFE9CF'),
                                                                          radius:
                                                                              23,
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'T',
                                                                            fontSize:
                                                                                16,
                                                                            bold:
                                                                                true,
                                                                            color:
                                                                                hexToColor('#FFA133'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  RenderSvg(
                                                                    path:
                                                                        'arrow_right',
                                                                    width: 16,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        123.0,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(8)),
                                                                        color: hexToColor(
                                                                            '#FFA133'),
                                                                      ),
                                                                      height:
                                                                          30,
                                                                      width: 50,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            KText(
                                                                          text:
                                                                              'Tasks',
                                                                          fontSize:
                                                                              14,
                                                                          //  bold: true,
                                                                          color:
                                                                              hexToColor('#FFFFFF'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  RenderSvg(
                                                                    path:
                                                                        'cross_icon',
                                                                    width: 16,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ];
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                ],
              ),
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
