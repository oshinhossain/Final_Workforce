import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/pages/project_activity_board_page.dart';
import 'package:workforce/src/pages/project_activity_group_board_page.dart';
import 'package:workforce/src/pages/project_task_board_page.dart';
import 'package:workforce/src/widgets/custom_textfield_projectdashboard.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/project _planning_board_model.dart';

// ignore: must_be_immutable
class ProjectScopeBucketWBSBoardPage extends StatelessWidget with Base {
  String getColor(double value) {
    if (value < 50) {
      return '#FF7373';
    } else if (value < 75) {
      return '#55ADFE';
    } else {
      return '#00D8A0';
    }
  }

  final ProjectPlanningBoard item;

  ProjectScopeBucketWBSBoardPage({required this.item});
  final RefreshController _refreshController = RefreshController();
  Future<void> _onRefresh() async {
    projectPlanningBoardC.projectScopeBucketBoardGet(item.id!);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
//    projectPlanningBoardC.projectScopeBucketBoardGet(item.id!);
    return WillPopScope(
      onWillPop: () {
        projectPlanningBoardC.projectScopeBucketBoard.clear();
        return Future(
          () {
            return true;
          },
        );
      },
      child: Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
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
                            projectPlanningBoardC.projectScopeBucketBoard
                                .clear();
                            back();
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: KText(
                            text: 'Project Scope Bucket (WBS) Board',
                            fontSize: 16,
                            maxLines: 2,
                            color: hexToColor('#41525A'),
                            bold: true,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Container(
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
                                  '${projectPlanningBoardC.projectScopeBucketBoard.length}',
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
                      color: hexToColor('#EEF0F6'),
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
                          KText(text: 'Project Name'),
                          KText(
                            text: item.projectName != null
                                ? '${item.projectName}'
                                : '',
                            fontSize: 14,
                          ),
                        ]),
                  ),
                  projectPlanningBoardC.projectScopeBucketBoard.isEmpty
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
                          itemCount: projectPlanningBoardC
                              .projectScopeBucketBoard.length,
                          itemBuilder: (context, index) {
                            final item = projectPlanningBoardC
                                .projectScopeBucketBoard[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  width: 360,
                                  decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    border:
                                        Border.all(color: AppTheme.nBorderC1),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10.0,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: KText(
                                                      text:
                                                          '${item!.bucketName} ',
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                      fontSize: 16,
                                                      bold: true,
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: hexToColor(
                                                            '#DBECFB'),
                                                      ),
                                                      height: 22,
                                                      width: 80,
                                                      child: Center(
                                                        child: KText(
                                                          text: item.status !=
                                                                  null
                                                              ? '${item.status}'
                                                              : '',
                                                          fontSize: 14,
                                                          //  bold: true,
                                                          color: hexToColor(
                                                              '#007BEC'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 100,
                                                  // ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Icon(Icons
                                                          .more_vert_outlined))
                                                ],
                                              ),
                                            ),
                                            KText(
                                              text:
                                                  '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(0)}%',
                                              fontSize: 13,
                                              bold: true,
                                              color: hexToColor('#515D64'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            double.parse(item.outputProgress
                                                        .toString()) <=
                                                    1.01
                                                ? LinearPercentIndicator(
                                                    barRadius:
                                                        Radius.circular(10),
                                                    animation: true,
                                                    lineHeight: 9.0,
                                                    animationDuration: 5000,
                                                    percent:
                                                        item.outputProgress!,
                                                    progressColor: hexToColor(
                                                      getColor(double.parse(item
                                                              .outputProgress
                                                              .toString()) *
                                                          100),
                                                    ),
                                                  )
                                                : LinearPercentIndicator(
                                                    barRadius:
                                                        Radius.circular(10),
                                                    animation: true,
                                                    lineHeight: 9.0,
                                                    animationDuration: 5000,
                                                    percent: 1.00,
                                                    progressColor:
                                                        Colors.green.shade400,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
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
                                                    KText(
                                                      text: item.fullname !=
                                                              null
                                                          ? '${item.fullname}'
                                                          : '',
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    // projectDashbordC
                                                    //             .userImage.value !=
                                                    //         null
                                                    //     ? Container(
                                                    //         height: 32,
                                                    //         width: 32,
                                                    //         padding:
                                                    //             EdgeInsets.all(2),
                                                    //         decoration:
                                                    //             BoxDecoration(
                                                    //                 color: Colors
                                                    //                     .white,
                                                    //                 shape: BoxShape
                                                    //                     .circle,
                                                    //                 boxShadow: [
                                                    //               BoxShadow(
                                                    //                 color:
                                                    //                     Colors.grey,
                                                    //                 offset: Offset(
                                                    //                     0, 0),
                                                    //                 blurRadius: 8.0,
                                                    //               ),
                                                    //             ]),
                                                    //         child: ClipRRect(
                                                    //           borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(50),
                                                    //           child: Image.memory(
                                                    //             projectDashbordC
                                                    //                 .userImage
                                                    //                 .value!,
                                                    //             fit: BoxFit.cover,
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    //     : GestureDetector(
                                                    //         onTap: () {
                                                    //           projectDashbordC
                                                    //               .getImageByUserName(
                                                    //                   username: item
                                                    //                       .username!);
                                                    //         },
                                                    //         child: CircleAvatar(
                                                    //           backgroundColor:
                                                    //               AppTheme.color4,
                                                    //           radius: 15,
                                                    //           child: RenderSvg(
                                                    //               path:
                                                    //                   'avatar_placeholder'),
                                                    //         ),
                                                    //       ),
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
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      item.mobile != null
                                          ? InkWell(
                                              onTap: () {
                                                FlutterPhoneDirectCaller
                                                    .callNumber(
                                                        '${item.mobile}');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
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
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Bucket ID',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            KText(
                                              text: item.bucketCode != null
                                                  ? '${item.bucketCode}'
                                                  : '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Output',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            KText(
                                              text: item.outputTarget != null
                                                  ? '${item.outputTarget}'
                                                  : '',
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            KText(
                                              text: item.outputDescr != null
                                                  ? '${item.outputDescr}'
                                                  : '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Achieved',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            KText(
                                              text: item.outputAchieved != null
                                                  ? '${item.outputAchieved}'
                                                  : '',
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            KText(
                                              text: item.outputDescr != null
                                                  ? '${item.outputDescr}'
                                                  : '',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Weight',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            KText(
                                              text: item.weightPct != null
                                                  ? '${item.weightPct}'
                                                  : '',
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            KText(
                                              text: ' %',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Deadline',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),

                                            //  KText(
                                            //   text: 'Deadline',
                                            //   color: hexToColor('#80939D'),
                                            // ),
                                            // Spacer(),
                                            KText(
                                              text: item.scheduledEndDate !=
                                                      null
                                                  ? formatDate(
                                                      date: item
                                                          .scheduledEndDate!)
                                                  : '',
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
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
                                              text: item.bucketDescr != null
                                                  ? '${item.bucketDescr}'
                                                  : '',
                                              fontSize: 13,
                                              maxLines: 2,
                                              color: hexToColor('#80939D'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Obx(
                                        () => projectPlanningBoardC
                                                    .projectCountForBucket
                                                    .length !=
                                                projectPlanningBoardC
                                                    .projectScopeBucketBoard
                                                    .length
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
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
                                                        GestureDetector(
                                                          onTap: (() {
                                                            push(
                                                              ProjectActivityGroupBoardPage(
                                                                  projectId: item
                                                                      .projectId!,
                                                                  bucketId:
                                                                      item.id!),
                                                            );
                                                          }),
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#FFF8B9'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#FFFCE1'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'G',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#E2BE02'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#E2BE02'),
                                                                  radius: 10,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: projectPlanningBoardC
                                                                          .projectCountForBucket[
                                                                              index]!
                                                                          .groups!,
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
                                                        GestureDetector(
                                                          onTap: (() async {
                                                            //     await projectActivityGroupBoardC
                                                            // await projectActivityGroupBoardC
                                                            //     .getActivityName(
                                                            //         item.projectId!,
                                                            //         item.id!);
                                                            // await showDialog(
                                                            //     context: context,
                                                            //     builder: (context) {
                                                            //       return BucketToAcitityDialog(
                                                            //         projectId: item
                                                            //             .projectId!,
                                                            //         projectName: item
                                                            //             .projectName!,
                                                            //         bucketId:
                                                            //             item.id,
                                                            //       );
                                                            //     });
                                                          }),
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#D0E8FD'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#E7F3FE'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'A',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#007BEC'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#007BEC'),
                                                                  radius: 10,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: projectPlanningBoardC.projectCountForBucket[index]!.activities! !=
                                                                              null
                                                                          ? projectPlanningBoardC
                                                                              .projectCountForBucket[index]!
                                                                              .activities!
                                                                          : '0',
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

                                                        // GestureDetector(
                                                        //   onTap: (() async {
                                                        //     await projectActivityGroupBoardC
                                                        //         .getActivityName(
                                                        //             item.projectId!,
                                                        //             item.id!);
                                                        //     await showDialog(
                                                        //         context: context,
                                                        //         builder: (context) {
                                                        //           return BucketToAcitityDialog(
                                                        //             projectId: item
                                                        //                 .projectId!,
                                                        //             projectName: item
                                                        //                 .projectName!,
                                                        //             bucketId:
                                                        //                 item.id,
                                                        //           );
                                                        //         });
                                                        //   }),
                                                        //   child: Stack(
                                                        //     children: [
                                                        //       Padding(
                                                        //         padding:
                                                        //             EdgeInsets.only(
                                                        //                 right: 8),
                                                        //         child: CircleAvatar(
                                                        //           radius: 22,
                                                        //           backgroundColor:
                                                        //               hexToColor(
                                                        //                   '#CFE8FF'),
                                                        //           child:
                                                        //               GestureDetector(
                                                        //             onTap: (() {
                                                        //               //   push(
                                                        //               //       ProjectActivityBoardPage());
                                                        //             }),
                                                        //             child:
                                                        //                 CircleAvatar(
                                                        //               backgroundColor:
                                                        //                   hexToColor(
                                                        //                       '#E7F3FF'),
                                                        //               radius: 21,
                                                        //               child: KText(
                                                        //                 text: 'A',
                                                        //                 fontSize:
                                                        //                     16,
                                                        //                 bold: true,
                                                        //                 color: hexToColor(
                                                        //                     '#007BEC'),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       Positioned(
                                                        //         left: 30,
                                                        //         child: Container(
                                                        //           width: 22,
                                                        //           height: 15,
                                                        //           decoration:
                                                        //               BoxDecoration(
                                                        //             color: hexToColor(
                                                        //                 '#007BEC'),
                                                        //             borderRadius:
                                                        //                 BorderRadius
                                                        //                     .circular(
                                                        //                         10),
                                                        //           ),
                                                        //           // backgroundColor: hexToColor('#FFA133'),
                                                        //           // radius: 10,
                                                        //           child: Center(
                                                        //             child: KText(
                                                        //               text: projectPlanningBoardC
                                                        //                           .projectCountForBucket[
                                                        //                               index]!
                                                        //                           .activities! !=
                                                        //                       null
                                                        //                   ? projectPlanningBoardC
                                                        //                       .projectCountForBucket[
                                                        //                           index]!
                                                        //                       .activities!
                                                        //                   : '0',
                                                        //               fontSize: 11,
                                                        //               bold: true,
                                                        //               color: Colors
                                                        //                   .white,
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),

                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Stack(
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
                                                                  radius: 21,
                                                                  child: KText(
                                                                    text: 'T',
                                                                    fontSize:
                                                                        16,
                                                                    bold: true,
                                                                    color: hexToColor(
                                                                        '#FFA133'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 30,
                                                              child: Container(
                                                                width: 28,
                                                                height: 16,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: hexToColor(
                                                                      '#FFA133'),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                // backgroundColor: hexToColor('#FFA133'),
                                                                // radius: 10,
                                                                child: Center(
                                                                  child: KText(
                                                                    text: projectPlanningBoardC.projectCountForBucket[index]!.tasks! !=
                                                                            null
                                                                        ? projectPlanningBoardC
                                                                            .projectCountForBucket[index]!
                                                                            .tasks!
                                                                        : '0',
                                                                    // projectActivityGroupBoardC
                                                                    //     // .projectCount[
                                                                    //     //     index]!
                                                                    //     .activities,
                                                                    fontSize:
                                                                        11,
                                                                    bold: true,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    PopupMenuButton(
                                                      color:
                                                          Colors.grey.shade100,
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
                                                          PopupMenuItem(
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundColor:
                                                                              hexToColor('#FFE8E8'),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                hexToColor('#FFFCE1'),
                                                                            radius:
                                                                                23,
                                                                            child:
                                                                                KText(
                                                                              text: 'G',
                                                                              fontSize: 16,
                                                                              bold: true,
                                                                              color: hexToColor('#E2BE02'),
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
                                                                          color:
                                                                              hexToColor('#E2BE02'),
                                                                        ),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'Groups',
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
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem(
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              25,
                                                                          backgroundColor:
                                                                              hexToColor('#CFE8FF'),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                hexToColor('#E7F3FF'),
                                                                            radius:
                                                                                23,
                                                                            child:
                                                                                KText(
                                                                              text: 'A',
                                                                              fontSize: 16,
                                                                              bold: true,
                                                                              color: hexToColor('#007BEC'),
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
                                                                          color:
                                                                              hexToColor('#007BEC'),
                                                                        ),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'Activities',
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
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                              ],
                                                            ),
                                                            value: () {},
                                                          ),
                                                          PopupMenuItem(
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius:
                                                                          25,
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#FFF4E8'),
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
                                                                  width: 123.0,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8)),
                                                                      color: hexToColor(
                                                                          '#FFA133'),
                                                                    ),
                                                                    height: 30,
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
                                                                        color: hexToColor(
                                                                            '#FFFFFF'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ];
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),

                                        // Padding(
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 10),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment
                                        //               .spaceBetween,
                                        //       children: [
                                        //         Row(
                                        //           // mainAxisAlignment:
                                        //           //     MainAxisAlignment
                                        //           //         .spaceEvenly,
                                        //           children: [
                                        //             GestureDetector(
                                        //               onTap: () {
                                        //                 showDialog(
                                        //                     context:
                                        //                         context,
                                        //                     builder:
                                        //                         (context) {
                                        //                       return PlanningBoardDialog();
                                        //                     });
                                        //               },
                                        //               // onTap: () {
                                        //               //   ProjectPlanningDialogHelper
                                        //               //       .aleartDialog('');
                                        //               // },
                                        //               // onTap: (() {
                                        //               //   Global.confirmDialog(
                                        //               //       onConfirmed: () {});
                                        //               // }),
                                        //               child: Stack(
                                        //                 children: [],
                                        //               ),
                                        //             ),
                                        //             InkWell(
                                        //               onTap: () {
                                        //                 // showDialog(
                                        //                 //     context:
                                        //                 //         context,
                                        //                 //     builder:
                                        //                 //         (context) {
                                        //                 //       return PlanningBoardDialog();
                                        //                 //     });
                                        //                 // push(
                                        //                 //   ProjectScopeBucketWBSBoardPage(
                                        //                 //     id: projectPlanningBoardC
                                        //                 //         .projectPlanningBoard[
                                        //                 //             index]!
                                        //                 //         .id!,
                                        //                 //     projectName: projectPlanningBoardC
                                        //                 //         .projectPlanningBoard[
                                        //                 //             index]!
                                        //                 //         .projectName
                                        //                 //         .toString(),
                                        //                 //   ),
                                        //                 //   //projectPlanningBoardC.projectScopeBucketBoardGet()
                                        //                 // );
                                        //                 // projectPlanningBoardC
                                        //                 //     .projectScopeBucketBoardGet(
                                        //                 //         projectPlanningBoardC
                                        //                 //             .projectPlanningBoard[
                                        //                 //                 index]!
                                        //                 //             .id!);
                                        //               },
                                        //               child: Stack(
                                        //                 children: [],
                                        //               ),
                                        //             ),
                                        //             Stack(
                                        //               children: [
                                        //                 Padding(
                                        //                   padding: EdgeInsets
                                        //                       .only(
                                        //                           right: 8),
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     radius: 22,
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#FFF8B9'),
                                        //                     child:
                                        //                         CircleAvatar(
                                        //                       backgroundColor:
                                        //                           hexToColor(
                                        //                               '#FFFCE1'),
                                        //                       radius: 21,
                                        //                       child: KText(
                                        //                         text: 'G',
                                        //                         fontSize:
                                        //                             16,
                                        //                         bold: true,
                                        //                         color: hexToColor(
                                        //                             '#E2BE02'),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Positioned(
                                        //                   left: 30,
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#E2BE02'),
                                        //                     radius: 10,
                                        //                     child:
                                        //                         FittedBox(
                                        //                       child: KText(
                                        //                         text: projectPlanningBoardC
                                        //                             .projectCountForBucket[
                                        //                                 index]!
                                        //                             .groups!,
                                        //                         fontSize:
                                        //                             11,
                                        //                         bold: true,
                                        //                         color: Colors
                                        //                             .white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             Stack(
                                        //               children: [
                                        //                 Padding(
                                        //                   padding: EdgeInsets
                                        //                       .only(
                                        //                           right: 8),
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     radius: 22,
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#CFE8FF'),
                                        //                     child:
                                        //                         CircleAvatar(
                                        //                       backgroundColor:
                                        //                           hexToColor(
                                        //                               '#E7F3FF'),
                                        //                       radius: 21,
                                        //                       child: KText(
                                        //                         text: 'A',
                                        //                         fontSize:
                                        //                             16,
                                        //                         bold: true,
                                        //                         color: hexToColor(
                                        //                             '#007BEC'),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Positioned(
                                        //                   left: 30,
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#007BEC'),
                                        //                     radius: 10,
                                        //                     child:
                                        //                         FittedBox(
                                        //                       child: KText(
                                        //                         text: projectPlanningBoardC
                                        //                             .projectCountForBucket[
                                        //                                 index]!
                                        //                             .activities!,
                                        //                         fontSize:
                                        //                             11,
                                        //                         bold: true,
                                        //                         color: Colors
                                        //                             .white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             Stack(
                                        //               children: [
                                        //                 Padding(
                                        //                   padding: EdgeInsets
                                        //                       .only(
                                        //                           right:
                                        //                               15),
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     radius: 22,
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#FFE9CF'),
                                        //                     child:
                                        //                         CircleAvatar(
                                        //                       backgroundColor:
                                        //                           hexToColor(
                                        //                               '#FFF4E8'),
                                        //                       radius: 21,
                                        //                       child: KText(
                                        //                         text: 'T',
                                        //                         fontSize:
                                        //                             16,
                                        //                         bold: true,
                                        //                         color: hexToColor(
                                        //                             '#FFA133'),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 // Positioned(
                                        //                 //   left: 30,
                                        //                 //   child: Container(
                                        //                 //     width: 25,
                                        //                 //     height: 16,
                                        //                 //     decoration:
                                        //                 //         BoxDecoration(
                                        //                 //       color: hexToColor(
                                        //                 //           '#FFA133'),
                                        //                 //       borderRadius:
                                        //                 //           BorderRadius
                                        //                 //               .circular(
                                        //                 //                   6),
                                        //                 //     ),
                                        //                 //     // backgroundColor: hexToColor('#FFA133'),
                                        //                 //     // radius: 10,
                                        //                 //     child: Center(
                                        //                 //       child: KText(
                                        //                 //         text: projectPlanningBoardC
                                        //                 //             .projectCount[
                                        //                 //                 index]!
                                        //                 //             .tasks!,
                                        //                 //         fontSize:
                                        //                 //             11,
                                        //                 //         bold: true,
                                        //                 //         color: Colors
                                        //                 //             .white,
                                        //                 //       ),
                                        //                 //     ),
                                        //                 //   ),
                                        //                 // ),

                                        //                 Positioned(
                                        //                   left: 30,
                                        //                   child:
                                        //                       CircleAvatar(
                                        //                     backgroundColor:
                                        //                         hexToColor(
                                        //                             '#FFA133'),
                                        //                     radius: 10,
                                        //                     child:
                                        //                         FittedBox(
                                        //                       child: KText(
                                        //                         text: projectPlanningBoardC
                                        //                             .projectCountForBucket[
                                        //                                 index]!
                                        //                             .activities!,
                                        //                         fontSize:
                                        //                             11,
                                        //                         bold: true,
                                        //                         color: Colors
                                        //                             .white,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             Spacer(),
                                        //           ],
                                        //         ),
                                        //         PopupMenuButton(
                                        //           color:
                                        //               Colors.grey.shade100,
                                        //           child: RenderSvg(
                                        //             path: 'info',
                                        //             height: 45,
                                        //           ),
                                        //           onSelected: (value) {
                                        //             ScaffoldMessenger.of(
                                        //                     context)
                                        //                 .showSnackBar(SnackBar(
                                        //                     content: Text(
                                        //                         '$value item pressed')));
                                        //           },
                                        //           itemBuilder: (context) {
                                        //             return [
                                        //               PopupMenuItem(
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Row(
                                        //                       children: [
                                        //                         Stack(
                                        //                           children: [
                                        //                             CircleAvatar(
                                        //                               radius:
                                        //                                   25,
                                        //                               backgroundColor:
                                        //                                   hexToColor('#FFDDDD'),
                                        //                               child:
                                        //                                   CircleAvatar(
                                        //                                 backgroundColor:
                                        //                                     hexToColor('#FFE8E8'),
                                        //                                 radius:
                                        //                                     23,
                                        //                                 child:
                                        //                                     KText(
                                        //                                   text: 'M',
                                        //                                   fontSize: 16,
                                        //                                   bold: true,
                                        //                                   color: hexToColor('#FF3C3C'),
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         RenderSvg(
                                        //                           path:
                                        //                               'arrow_right',
                                        //                           width: 16,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width:
                                        //                               123.0,
                                        //                           child:
                                        //                               Container(
                                        //                             decoration:
                                        //                                 BoxDecoration(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(Radius.circular(8)),
                                        //                               color:
                                        //                                   hexToColor('#FF3C3C'),
                                        //                             ),
                                        //                             height:
                                        //                                 32,
                                        //                             width:
                                        //                                 50,
                                        //                             child:
                                        //                                 Center(
                                        //                               child:
                                        //                                   KText(
                                        //                                 text:
                                        //                                     'Milestones',
                                        //                                 fontSize:
                                        //                                     14,
                                        //                                 //  bold: true,
                                        //                                 color:
                                        //                                     hexToColor('#FFFFFF'),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 15,
                                        //                         ),
                                        //                         RenderSvg(
                                        //                           path:
                                        //                               'cross_icon',
                                        //                           width: 16,
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 8,
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               PopupMenuItem(
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Row(
                                        //                       children: [
                                        //                         Stack(
                                        //                           children: [
                                        //                             CircleAvatar(
                                        //                               radius:
                                        //                                   25,
                                        //                               backgroundColor:
                                        //                                   hexToColor('#C1FFEF'),
                                        //                               child:
                                        //                                   CircleAvatar(
                                        //                                 backgroundColor:
                                        //                                     hexToColor('#DDFFF6'),
                                        //                                 radius:
                                        //                                     23,
                                        //                                 child:
                                        //                                     KText(
                                        //                                   text: 'M',
                                        //                                   fontSize: 16,
                                        //                                   bold: true,
                                        //                                   color: hexToColor('#FFA133'),
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         RenderSvg(
                                        //                           path:
                                        //                               'arrow_right',
                                        //                           width: 16,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width:
                                        //                               123.0,
                                        //                           child:
                                        //                               Container(
                                        //                             decoration:
                                        //                                 BoxDecoration(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(Radius.circular(8)),
                                        //                               color:
                                        //                                   hexToColor('#00D8A0'),
                                        //                             ),
                                        //                             height:
                                        //                                 32,
                                        //                             width:
                                        //                                 50,
                                        //                             child:
                                        //                                 Center(
                                        //                               child:
                                        //                                   KText(
                                        //                                 text:
                                        //                                     'Buckets',
                                        //                                 fontSize:
                                        //                                     14,
                                        //                                 //  bold: true,
                                        //                                 color:
                                        //                                     hexToColor('#FFFFFF'),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 8,
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               PopupMenuItem(
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Row(
                                        //                       children: [
                                        //                         Stack(
                                        //                           children: [
                                        //                             CircleAvatar(
                                        //                               radius:
                                        //                                   25,
                                        //                               backgroundColor:
                                        //                                   hexToColor('#FFE8E8'),
                                        //                               child:
                                        //                                   CircleAvatar(
                                        //                                 backgroundColor:
                                        //                                     hexToColor('#FFFCE1'),
                                        //                                 radius:
                                        //                                     23,
                                        //                                 child:
                                        //                                     KText(
                                        //                                   text: 'G',
                                        //                                   fontSize: 16,
                                        //                                   bold: true,
                                        //                                   color: hexToColor('#E2BE02'),
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         RenderSvg(
                                        //                           path:
                                        //                               'arrow_right',
                                        //                           width: 16,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width:
                                        //                               123.0,
                                        //                           child:
                                        //                               Container(
                                        //                             decoration:
                                        //                                 BoxDecoration(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(Radius.circular(8)),
                                        //                               color:
                                        //                                   hexToColor('#E2BE02'),
                                        //                             ),
                                        //                             height:
                                        //                                 30,
                                        //                             width:
                                        //                                 50,
                                        //                             child:
                                        //                                 Center(
                                        //                               child:
                                        //                                   KText(
                                        //                                 text:
                                        //                                     'Groups',
                                        //                                 fontSize:
                                        //                                     14,
                                        //                                 //  bold: true,
                                        //                                 color:
                                        //                                     hexToColor('#FFFFFF'),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 8,
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               PopupMenuItem(
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Row(
                                        //                       children: [
                                        //                         Stack(
                                        //                           children: [
                                        //                             CircleAvatar(
                                        //                               radius:
                                        //                                   25,
                                        //                               backgroundColor:
                                        //                                   hexToColor('#CFE8FF'),
                                        //                               child:
                                        //                                   CircleAvatar(
                                        //                                 backgroundColor:
                                        //                                     hexToColor('#E7F3FF'),
                                        //                                 radius:
                                        //                                     23,
                                        //                                 child:
                                        //                                     KText(
                                        //                                   text: 'A',
                                        //                                   fontSize: 16,
                                        //                                   bold: true,
                                        //                                   color: hexToColor('#007BEC'),
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         RenderSvg(
                                        //                           path:
                                        //                               'arrow_right',
                                        //                           width: 16,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width: 8,
                                        //                         ),
                                        //                         SizedBox(
                                        //                           width:
                                        //                               123.0,
                                        //                           child:
                                        //                               Container(
                                        //                             decoration:
                                        //                                 BoxDecoration(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(Radius.circular(8)),
                                        //                               color:
                                        //                                   hexToColor('#007BEC'),
                                        //                             ),
                                        //                             height:
                                        //                                 30,
                                        //                             width:
                                        //                                 50,
                                        //                             child:
                                        //                                 Center(
                                        //                               child:
                                        //                                   KText(
                                        //                                 text:
                                        //                                     'Activities',
                                        //                                 fontSize:
                                        //                                     14,
                                        //                                 //  bold: true,
                                        //                                 color:
                                        //                                     hexToColor('#FFFFFF'),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 8,
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               PopupMenuItem(
                                        //                 child: Row(
                                        //                   children: [
                                        //                     Stack(
                                        //                       children: [
                                        //                         CircleAvatar(
                                        //                           radius:
                                        //                               25,
                                        //                           backgroundColor:
                                        //                               hexToColor(
                                        //                                   '#FFF4E8'),
                                        //                           child:
                                        //                               CircleAvatar(
                                        //                             backgroundColor:
                                        //                                 hexToColor('#FFE9CF'),
                                        //                             radius:
                                        //                                 23,
                                        //                             child:
                                        //                                 KText(
                                        //                               text:
                                        //                                   'M',
                                        //                               fontSize:
                                        //                                   16,
                                        //                               bold:
                                        //                                   true,
                                        //                               color:
                                        //                                   hexToColor('#FFA133'),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       width: 8,
                                        //                     ),
                                        //                     RenderSvg(
                                        //                       path:
                                        //                           'arrow_right',
                                        //                       width: 16,
                                        //                     ),
                                        //                     SizedBox(
                                        //                       width: 8,
                                        //                     ),
                                        //                     SizedBox(
                                        //                       width: 123.0,
                                        //                       child:
                                        //                           Container(
                                        //                         decoration:
                                        //                             BoxDecoration(
                                        //                           borderRadius:
                                        //                               BorderRadius.all(
                                        //                                   Radius.circular(8)),
                                        //                           color: hexToColor(
                                        //                               '#FFA133'),
                                        //                         ),
                                        //                         height: 30,
                                        //                         width: 50,
                                        //                         child:
                                        //                             Center(
                                        //                           child:
                                        //                               KText(
                                        //                             text:
                                        //                                 'Tasks',
                                        //                             fontSize:
                                        //                                 14,
                                        //                             //  bold: true,
                                        //                             color: hexToColor(
                                        //                                 '#FFFFFF'),
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ];
                                        //           },
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     projectPlanningBoardC.projectScopeBucketBoardGet(id);
        //     //kLog(projectPlanningBoardC.projectScopeBucketBoardGet(id));
        //   },
        //   shape: StadiumBorder(),
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlanningBoardDialog extends StatelessWidget with Base {
  final ProjectPlanningBoard item;

  PlanningBoardDialog({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: hexToColor('#FFB661'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    border: Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                child: KText(
                  text: 'Go to Group Planning Board',
                  bold: true,
                  fontSize: 18,
                )),
            Container(
              decoration: BoxDecoration(
                color: hexToColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Project Name',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: item.projectName,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => CustomTextFieldProjectdashboard(
                            title: 'Bucket',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                  .selectedBucket.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                  .projectScopeBucketBoard
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectPlanningBoardDropDownC
                                        .selectedBucket.value = item;
                                  },
                                  value: item!.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.bucketName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                projectPlanningBoardDropDownC
                                    .bucketIdNum.value = item!;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                back();
                              },
                              child: Container(
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
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                back();
                                // print(projectPlanningBoardC.bucketIdNum.value);
                                // print(projectId);
                                push(
                                  ProjectActivityGroupBoardPage(
                                    bucketId: projectPlanningBoardDropDownC
                                        .bucketIdNum.value,
                                    projectId: item.id!,
                                  ),
                                );

                                await projectActivityGroupBoardC
                                    .getActivityName(
                                        item.id!,
                                        projectPlanningBoardDropDownC
                                            .bucketIdNum.value);
                                print(projectPlanningBoardDropDownC
                                    .bucketIdNum.value);
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
                                    text: 'Go',
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ActivityBoardDialog extends StatelessWidget with Base {
  // final title;
  // PlanningBoardDialog(this.title);
  String projectId;
  String? projectName;

  ActivityBoardDialog({required this.projectId, this.projectName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: 'Go to Activity Planning Board',
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Project Name',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          KText(
                            text: projectName,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //select bucket
                          CustomTextFieldProjectdashboard(
                            title: 'Bucket',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                  .selectedBucket.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                  .projectScopeBucketBoard
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectPlanningBoardDropDownC
                                        .selectedBucket.value = item;
                                  },
                                  value: item!.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.bucketName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                projectPlanningBoardDropDownC
                                    .bucketIdNum.value = item!;

                                projectPlanningBoardDropDownC.getActivityName(
                                    projectId,
                                    projectPlanningBoardDropDownC
                                        .bucketIdNum.value);

                                //  ProjectActivityGroupBoardPage(bucketId: item!,projectId: projectId,);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFieldProjectdashboard(
                            title: 'Gruop',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                  .selectedGroup.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                  .activityGroupList
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectPlanningBoardDropDownC
                                        .selectedGroup.value = item;
                                  },
                                  value: item.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.groupName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                projectPlanningBoardDropDownC.groupIdNum.value =
                                    item!;
                                //// kLog(projectActivityGroupBoardC
                                //     .groupIdNum.value);
                                projectPlanningBoardC.getActivity(
                                    projectId,
                                    projectPlanningBoardDropDownC
                                        .bucketIdNum.value,
                                    projectPlanningBoardDropDownC
                                        .groupIdNum.value);

                                //  ProjectActivityGroupBoardPage(bucketId: item!,projectId: projectId,);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  back();
                                },
                                child: Container(
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
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  // print('bucket');
                                  // print(
                                  //     projectPlanningBoardC.bucketIdNum.value);
                                  // print('group');
                                  // print(projectActivityGroupBoardC
                                  //     .groupIdNum.value);
                                  // print(projectId);
                                  back();
                                  await projectPlanningBoardC.getActivity(
                                      projectId,
                                      projectPlanningBoardDropDownC
                                          .bucketIdNum.value,
                                      projectPlanningBoardDropDownC
                                          .groupIdNum.value);
                                  print('object');

                                  print(projectId);
                                  print('object');
                                  print(
                                    projectPlanningBoardDropDownC
                                        .bucketIdNum.value,
                                  );
                                  print('object');
                                  print(projectPlanningBoardDropDownC
                                      .groupIdNum.value);

                                  push(
                                    ProjectActivityBoardPage(
                                      id: projectId,
                                      projectName: projectName!,
                                      pBucketId: projectPlanningBoardDropDownC
                                          .bucketIdNum.value,
                                      pGruopId: projectPlanningBoardDropDownC
                                          .groupIdNum.value,
                                    ),
                                  );
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
                                      text: 'Go',
                                      fontSize: 16,
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskBoardDialog extends StatelessWidget with Base {
  // final title;
  // PlanningBoardDialog(this.title);
  String projectId;
  String? projectName;

  TaskBoardDialog({required this.projectId, this.projectName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: 'Go to Activity Planning Board',
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Project Name',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          KText(
                            text: projectName,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //select bucket
                          CustomTextFieldProjectdashboard(
                            title: 'Bucket',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardC
                                  .selectedBucket.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardC
                                  .projectScopeBucketBoard
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectPlanningBoardC.selectedBucket.value =
                                        item;
                                  },
                                  value: item!.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.bucketName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                projectPlanningBoardC.bucketIdNum.value = item!;
                                // kLog(projectPlanningBoardC.bucketIdNum.value);
                                projectActivityGroupBoardC.getActivityName(
                                    projectId,
                                    projectPlanningBoardC.bucketIdNum.value);

                                //  ProjectActivityGroupBoardPage(bucketId: item!,projectId: projectId,);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFieldProjectdashboard(
                            title: 'Gruop',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectActivityGroupBoardC
                                  .selectedGroup.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectActivityGroupBoardC
                                  .activityGroupList
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectActivityGroupBoardC
                                        .selectedGroup.value = item;
                                  },
                                  value: item.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.groupName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                projectActivityGroupBoardC.groupIdNum.value =
                                    item!;
                                //// kLog(projectActivityGroupBoardC
                                //     .groupIdNum.value);
                                projectPlanningBoardC.getActivity(
                                    projectId,
                                    projectPlanningBoardC.bucketIdNum.value,
                                    projectActivityGroupBoardC
                                        .groupIdNum.value);

                                //  ProjectActivityGroupBoardPage(bucketId: item!,projectId: projectId,);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  back();
                                },
                                child: Container(
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
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // print('bucket');
                                  // print(
                                  //     projectPlanningBoardC.bucketIdNum.value);
                                  // print('group');
                                  // print(projectActivityGroupBoardC
                                  //     .groupIdNum.value);
                                  // print(projectId);
                                  back();
                                  push(
                                    ProjectActivityBoardPage(
                                      id: projectId,
                                      projectName: projectName!,
                                      pBucketId: projectPlanningBoardC
                                          .bucketIdNum.value,
                                      pGruopId: projectActivityGroupBoardC
                                          .groupIdNum.value,
                                    ),
                                  );
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
                                      text: 'Go',
                                      fontSize: 16,
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskDialog extends StatefulWidget {
  // final title;
  // PlanningBoardDialog(this.title);
  String projectId;
  String? projectName;

  TaskDialog({required this.projectId, this.projectName});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> with Base {
  @override
  void dispose() {
    projectPlanningBoardDropDownC.projectScopeBucketBoard.clear();
    projectPlanningBoardDropDownC.activityGroupList.clear();
    projectPlanningBoardDropDownC.activityList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: hexToColor('#FFB661'),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      border:
                          Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                  child: KText(
                    text: 'Go to Project Task Board',
                    bold: true,
                    fontSize: 18,
                  )),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Project Name',
                            fontSize: 14,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          KText(
                            text: widget.projectName,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //select bucket
                          CustomTextFieldProjectdashboard(
                            title: 'Bucket',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                  .selectedBucket.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                  .projectScopeBucketBoard
                                  .map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    projectPlanningBoardDropDownC
                                        .selectedBucket.value = item;
                                  },
                                  value: item!.id,
                                  child: SizedBox(
                                    child: KText(
                                      text: item.bucketName,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) async {
                                projectPlanningBoardDropDownC
                                    .bucketIdNum.value = item!;

                                await projectPlanningBoardDropDownC
                                    .getActivityName(
                                        widget.projectId,
                                        projectPlanningBoardDropDownC
                                            .bucketIdNum.value);
                                // await projectPlanningBoardDropDownC.getActivity(
                                //     projectId,
                                //     projectPlanningBoardDropDownC
                                //         .bucketIdNum.value,
                                //     projectPlanningBoardDropDownC
                                //         .groupIdNum.value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          CustomTextFieldProjectdashboard(
                            title: 'Gruop',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                      .selectedGroup.value!.id!.isEmpty
                                  ? ''
                                  : projectPlanningBoardDropDownC
                                      .selectedGroup.value!.id,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                      .activityGroupList.isEmpty
                                  ? [
                                      DropdownMenuItem(
                                        onTap: () {},
                                        value: '',
                                        child: SizedBox(
                                          child: KText(
                                            text: '',
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ]
                                  : projectPlanningBoardDropDownC
                                      .activityGroupList
                                      .map((item) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          projectPlanningBoardDropDownC
                                              .selectedGroup.value = item;
                                        },
                                        value: item.id,
                                        child: SizedBox(
                                          child: KText(
                                            text: item.groupName,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              onChanged: (item) async {
                                projectPlanningBoardDropDownC.groupIdNum.value =
                                    item!;

                                await projectPlanningBoardDropDownC.getActivity(
                                    widget.projectId,
                                    projectPlanningBoardDropDownC
                                        .bucketIdNum.value,
                                    projectPlanningBoardDropDownC
                                        .groupIdNum.value);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // KText(
                          //     text: projectPlanningBoardDropDownC
                          //                 .selectActivities.value ==
                          //             null
                          //         ? ''
                          //         : projectPlanningBoardDropDownC
                          //             .activityList.first.id),

                          CustomTextFieldProjectdashboard(
                            title: 'Activity',
                            isTooltipRequired: false,
                            suffix: DropdownButton(
                              isExpanded: true,
                              value: projectPlanningBoardDropDownC
                                          .selectActivities.value ==
                                      null
                                  ? ''
                                  : '${projectPlanningBoardDropDownC.selectActivities.value!.id}',
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: projectPlanningBoardDropDownC
                                          .selectActivities.value ==
                                      null
                                  ? [
                                      DropdownMenuItem(
                                        onTap: () {},
                                        value: '',
                                        child: SizedBox(
                                          child: KText(
                                            text: '',
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ]
                                  : projectPlanningBoardDropDownC.activityList
                                      .map((item) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          projectPlanningBoardDropDownC
                                              .selectActivities.value = item;
                                        },
                                        value: item.id,
                                        child: SizedBox(
                                          child: KText(
                                            text: item.activityName,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              onChanged: (item) async {
                                projectPlanningBoardDropDownC
                                    .activityIdNum.value = item!;

                                projectPlanningBoardC.getProjectTask(
                                    projectPlanningBoardDropDownC
                                        .activityIdNum.value);

                                //  ProjectActivityGroupBoardPage(bucketId: item!,projectId: projectId,);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  back();
                                },
                                child: Container(
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
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  back();
                                  push(
                                    ProjectTaskBoardPage(
                                      projectId: widget.projectId,
                                      pBucketId: projectPlanningBoardC
                                          .bucketIdNum.value,
                                      pGruopId: projectActivityGroupBoardC
                                          .groupIdNum.value,
                                      pActivityId: projectPlanningBoardC
                                          .activityIdNum.value,
                                    ),
                                  );
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
                                      text: 'Go',
                                      fontSize: 16,
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
