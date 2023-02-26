import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:workforce/src/pages/project_scope_bucket_wbs_board_page.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import 'package:workforce/src/helpers/global_helper.dart';

class ProjectPlanningBoardPage extends StatelessWidget with Base {
  final isLoading = RxBool(false);
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    projectPlanningBoardC.projectPlanningBoardGet();

    userC.check();
    projectDashbordC.getDashbordProject();
    taskProgressC.getTaskProgress();
    projectProgressDashboardC.projectGet();

    _refreshController.refreshCompleted();
    projectDashbordC.getDashbordProject();
  }

  @override
  Widget build(BuildContext context) {
    projectPlanningBoardC.projectPlanningBoardGet();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: () {
          //Get.to(ProjectPlanningboardCreateProjectPage());
        },
        child: Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      appBar: KAppbar(),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      backgroundColor: hexToColor('#EEF0F6'),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
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
                          back();
                        },
                      ),
                      KText(
                        text: 'Project Planning Board',
                        fontSize: 16,
                        color: hexToColor('#41525A'),
                        bold: true,
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
                            text: projectPlanningBoardC
                                        .projectPlanningBoard.length !=
                                    null
                                ? '${projectPlanningBoardC.projectPlanningBoard.length}'
                                : '0',
                            bold: true,
                            color: hexToColor('#FFA133'),
                          ),
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
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
                            child: Center(child: KText(text: 'No data found')),
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                            projectPlanningBoardC.projectPlanningBoard.length,
                        itemBuilder: (context, index) {
                          // final item1 = projectPlanningBoardC.projectCountGet(
                          //     projectPlanningBoardC
                          //         .projectPlanningBoard[index]!.id!);
                          final item =
                              projectPlanningBoardC.projectPlanningBoard[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Container(
                                width: 360,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  border: Border.all(color: AppTheme.nBorderC1),
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
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // ClipOval(
                                              //   child: SizedBox.fromSize(
                                              //     size: Size.fromRadius(26),
                                              //     // Image radius
                                              //     child: RenderImg(
                                              //       path: 'service_icon.png',
                                              //       fit: BoxFit.cover,
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                  height: 60.0,
                                                  width: 60.0,
                                                  child:
                                                      SimpleCircularProgressBar(
                                                    valueNotifier: ValueNotifier(
                                                        double.parse(item!
                                                                .outputProgress
                                                                .toString()) *
                                                            100.toInt()),
                                                    onGetText: (double value) {
                                                      TextStyle
                                                          centerTextStyle =
                                                          TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      );

                                                      return Text(
                                                        '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(1)}%',
                                                        style: centerTextStyle,
                                                      );
                                                    },
                                                    maxValue: 100,
                                                    mergeMode: true,
                                                    backStrokeWidth: 8,
                                                    progressStrokeWidth: 8,
                                                    backColor:
                                                        hexToColor('#D9D9D9'),
                                                    progressColors: [
                                                      hexToColor('#00D8A0')
                                                    ],
                                                  ))
                                              // CircularProgressIndicator(
                                              //   valueColor: AlwaysStoppedAnimation<Color>(
                                              //       Colors.orange),
                                              //   strokeWidth: 3,
                                              //   value: .75,
                                              // ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                    child: KText(
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                      text: item.projectName !=
                                                              null
                                                          ? '${item.projectName}'
                                                          : '',
                                                      bold: true,
                                                      fontSize: 14,
                                                      //  bold: true,
                                                    ),
                                                  ),
                                                  item.status != null
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  top: 5),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                              color: hexToColor(
                                                                  '#DBECFB'),
                                                            ),
                                                            height: 20,
                                                            width: 75,
                                                            child: Center(
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
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Row(
                                    //   children: [
                                    //     Padding(
                                    //       padding: EdgeInsets.only(left: 20),
                                    //       child: Row(
                                    //         children: [
                                    //           KText(
                                    //             text:
                                    //                 '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(0)}%',
                                    //             fontSize: 14,
                                    //             bold: true,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              KText(
                                                text: 'Project Director',
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
                                                        textOverflow:
                                                            TextOverflow
                                                                .visible,
                                                        bold: true,
                                                        text: item.pmFullname !=
                                                                null
                                                            ? '${item.pmFullname}'
                                                            : '',
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
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          KText(
                                            text: 'Project ID',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          KText(
                                            text: item.projectCode != null
                                                ? '${item.projectCode}'
                                                : '',
                                          )
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
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Description',
                                            fontSize: 13,
                                            bold: true,
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                            text: item.projectDescr != null
                                                ? '${item.projectDescr}'
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
                                                  .projectCount.length !=
                                              projectPlanningBoardC
                                                  .projectPlanningBoard.length
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      flex: 20,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // showDialog(
                                                              //     context:
                                                              //         context,
                                                              //     builder:
                                                              //         (context) {
                                                              //       return PlanningBoardDialog();
                                                              //     });
                                                            },
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
                                                                            '#FFDDDD'),
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#FFE8E8'),
                                                                      radius:
                                                                          21,
                                                                      child:
                                                                          KText(
                                                                        text:
                                                                            'M',
                                                                        fontSize:
                                                                            16,
                                                                        bold:
                                                                            true,
                                                                        color: hexToColor(
                                                                            '#FF3C3C'),
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
                                                                              '#FF3C3C'),
                                                                      radius:
                                                                          10,
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            KText(
                                                                          text: projectPlanningBoardC.projectCount[index]!.milesstones != null
                                                                              ? projectPlanningBoardC.projectCount[index]!.milesstones
                                                                              : '0',
                                                                          fontSize:
                                                                              11,
                                                                          bold:
                                                                              true,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              push(
                                                                ProjectScopeBucketWBSBoardPage(
                                                                  item: item,
                                                                ),
                                                              );
                                                              projectPlanningBoardC
                                                                  .projectScopeBucketBoardGet(
                                                                      item.id!);
                                                            },
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
                                                                            '#C1FFEF'),
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#DDFFF6'),
                                                                      radius:
                                                                          21,
                                                                      child:
                                                                          KText(
                                                                        text:
                                                                            'B',
                                                                        fontSize:
                                                                            16,
                                                                        bold:
                                                                            true,
                                                                        color: hexToColor(
                                                                            '#09CD9A'),
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
                                                                              '#09CD9A'),
                                                                      radius:
                                                                          10,
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            KText(
                                                                          text: projectPlanningBoardC
                                                                              .projectCount[index]!
                                                                              .buckets!,
                                                                          fontSize:
                                                                              11,
                                                                          bold:
                                                                              true,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              await projectPlanningBoardDropDownC
                                                                  .projectScopeBucketDropDownGet(
                                                                      item.id!);
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return PlanningBoardDialog(
                                                                      item:
                                                                          item,
                                                                    );
                                                                  });
                                                            },
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
                                                                      radius:
                                                                          21,
                                                                      child:
                                                                          KText(
                                                                        text:
                                                                            'G',
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
                                                                            .projectCount[index]!
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
                                                            onTap: () async {
                                                              await projectPlanningBoardDropDownC
                                                                  .projectScopeBucketDropDownGet(
                                                                      item.id!);
                                                              await projectPlanningBoardDropDownC
                                                                  .getActivityName(
                                                                      item.id!,
                                                                      projectPlanningBoardDropDownC
                                                                          .projectScopeBucketBoard[
                                                                              index]!
                                                                          .id!);

                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ActivityBoardDialog(
                                                                      projectId:
                                                                          item.id!,
                                                                      projectName:
                                                                          item.projectName!,
                                                                    );
                                                                  });
                                                            },
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
                                                                            '#CFE8FF'),
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#E7F3FF'),
                                                                      radius:
                                                                          21,
                                                                      child:
                                                                          KText(
                                                                        text:
                                                                            'A',
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
                                                                        text: projectPlanningBoardC
                                                                            .projectCount[index]!
                                                                            .activities!,
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
                                                              await projectPlanningBoardDropDownC
                                                                  .projectScopeBucketDropDownGet(
                                                                      item.id!);

                                                              await projectPlanningBoardDropDownC
                                                                  .getActivityName(
                                                                item.id!,
                                                                projectPlanningBoardDropDownC
                                                                    .projectScopeBucketBoard[
                                                                        index]!
                                                                    .id!,
                                                              );

                                                              // await projectPlanningBoardDropDownC.getActivity(
                                                              //     item.id!,
                                                              //     projectPlanningBoardDropDownC
                                                              //         .projectScopeBucketBoard[
                                                              //             index]!
                                                              //         .id!,
                                                              //     projectPlanningBoardDropDownC
                                                              //         .activityGroupList[
                                                              //             index]
                                                              //         .id!);

                                                              // await projectPlanningBoardC
                                                              //     .getProjectTask(
                                                              //   projectPlanningBoardC
                                                              //       .activityList[
                                                              //           index]
                                                              //       .id!,
                                                              // );

                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return TaskDialog(
                                                                      projectId: projectPlanningBoardC
                                                                          .projectPlanningBoard[
                                                                              index]!
                                                                          .id!,
                                                                      projectName: projectPlanningBoardC
                                                                          .projectPlanningBoard[
                                                                              index]!
                                                                          .projectName!,
                                                                    );
                                                                  });
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
                                                                          KText(
                                                                        text:
                                                                            'T',
                                                                        fontSize:
                                                                            16,
                                                                        bold:
                                                                            true,
                                                                        color: hexToColor(
                                                                            '#FFA133'),
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
                                                                            '#FFA133'),
                                                                    radius: 10,
                                                                    child:
                                                                        FittedBox(
                                                                      child:
                                                                          KText(
                                                                        text: projectPlanningBoardC
                                                                            .projectCount[index]!
                                                                            .tasks,
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
                                                      )
                                                      // : Center(
                                                      //     child:
                                                      //         CircularProgressIndicator())
                                                      ),
                                                  PopupMenuButton(
                                                    color: Colors.grey.shade100,
                                                    child: RenderSvg(
                                                      path: 'info',
                                                      height: 45,
                                                    ),
                                                    onSelected: (value) {
                                                      // ScaffoldMessenger.of(context)
                                                      //     .showSnackBar(SnackBar(
                                                      //         content: Text(
                                                      //             '$value item pressed')));
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
                                                                            hexToColor('#FFDDDD'),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              hexToColor('#FFE8E8'),
                                                                          radius:
                                                                              23,
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'M',
                                                                            fontSize:
                                                                                16,
                                                                            bold:
                                                                                true,
                                                                            color:
                                                                                hexToColor('#FF3C3C'),
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
                                                                            '#FF3C3C'),
                                                                      ),
                                                                      height:
                                                                          32,
                                                                      width: 50,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            KText(
                                                                          text:
                                                                              'Milestones',
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
                                                                    width: 15,
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
                                                              )
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
                                                                            hexToColor('#C1FFEF'),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              hexToColor('#C1FFEF'),
                                                                          radius:
                                                                              23,
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'B',
                                                                            fontSize:
                                                                                16,
                                                                            bold:
                                                                                true,
                                                                            color:
                                                                                hexToColor('#09CD9A'),
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
                                                                            '#00D8A0'),
                                                                      ),
                                                                      height:
                                                                          32,
                                                                      width: 50,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            KText(
                                                                          text:
                                                                              'Buckets',
                                                                          fontSize:
                                                                              14,
                                                                          //  bold: true,
                                                                          color:
                                                                              hexToColor('#FFFFFF'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              )
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
                                                                            hexToColor('#FFE8E8'),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              hexToColor('#FFFCE1'),
                                                                          radius:
                                                                              23,
                                                                          child:
                                                                              KText(
                                                                            text:
                                                                                'G',
                                                                            fontSize:
                                                                                16,
                                                                            bold:
                                                                                true,
                                                                            color:
                                                                                hexToColor('#E2BE02'),
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
                                                                            '#E2BE02'),
                                                                      ),
                                                                      height:
                                                                          30,
                                                                      width: 50,
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
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              )
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
                                                                            text:
                                                                                'A',
                                                                            fontSize:
                                                                                16,
                                                                            bold:
                                                                                true,
                                                                            color:
                                                                                hexToColor('#007BEC'),
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
                                                                            '#007BEC'),
                                                                      ),
                                                                      height:
                                                                          30,
                                                                      width: 50,
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
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          child: Row(
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#FFE9CF'),
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          hexToColor(
                                                                              '#FFF4E8'),
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
                                                                        color: hexToColor(
                                                                            '#FFA133'),
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
                                                                  child: Center(
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
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
