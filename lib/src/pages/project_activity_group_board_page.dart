import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:workforce/src/pages/project_activity_board_page.dart';

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
class ProjectActivityGroupBoardPage extends StatelessWidget with Base {
  String getColor(double value) {
    if (value < 50) {
      return '#FF7373';
    } else if (value < 75) {
      return '#55ADFE';
    } else {
      return '#00D8A0';
    }
  }

  String projectId;
  String bucketId;
  ProjectActivityGroupBoardPage(
      {required this.projectId, required this.bucketId});

  final RefreshController _refreshController = RefreshController();
  Future<void> _onRefresh() async {
    projectActivityGroupBoardC.getActivityName(bucketId, projectId);
    // projectActivityGroupBoardC.projectCountGet(bucketId);

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    //  projectActivityGroupBoardC.getActivityName(projectId, bucketId);

    return WillPopScope(
      onWillPop: () {
        projectActivityGroupBoardC.activityGroupList.clear();

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
                            projectActivityGroupBoardC.activityGroupList
                                .clear();
                            back();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        KText(
                          text: 'Project Activity Group Board',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        SizedBox(
                          width: 10,
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
                                  '${projectActivityGroupBoardC.activityGroupList.length}',
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
                    height: 70,
                    width: Get.width,
                    padding: EdgeInsets.only(left: 15, top: 10, right: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          projectActivityGroupBoardC.activityGroupList.isEmpty
                              ? projectActivityGroupBoardC.isLoading.value
                                  ? SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Loading(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 40,
                                      child: Center(
                                          child: KText(text: 'No data found')),
                                    )
                              : KText(
                                  text:
                                      '${projectActivityGroupBoardC.activityGroupList[0].projectName} > '
                                      '${projectActivityGroupBoardC.activityGroupList[0].bucketName}',
                                  fontSize: 14,
                                  maxLines: 2,
                                ),
                        ]),
                  ),
                  projectActivityGroupBoardC.activityGroupList.isEmpty
                      ? projectActivityGroupBoardC.isLoading.value
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
                          itemCount: projectActivityGroupBoardC
                              .activityGroupList.length,
                          itemBuilder: (context, index) {
                            final item = projectActivityGroupBoardC
                                .activityGroupList[index];
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
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
                                                flex: 25,
                                                child: KText(
                                                  maxLines: 2,
                                                  text: item.groupName != null
                                                      ? '${item.groupName}'
                                                      : '',
                                                  fontSize: 15,
                                                  bold: true,
                                                  color: hexToColor('#515D64'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  color: hexToColor('#DBECFB'),
                                                ),
                                                height: 25,
                                                width: 70,
                                                child: Center(
                                                  child: KText(
                                                    text: item.status != null
                                                        ? '${item.status}'
                                                        : 'N/A',
                                                    fontSize: 13,
                                                    //  bold: true,
                                                    color:
                                                        hexToColor('#007BEC'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.more_vert_outlined),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: KText(
                                        text: item.outputProgress != null
                                            // ignore: prefer_interpolation_to_compose_strings
                                            ? (double.parse(item.outputProgress!
                                                            .toString()) *
                                                        100)
                                                    .toStringAsFixed(2) +
                                                ' %'
                                            : '',
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
                                                          text: item.assignedFullname !=
                                                                  null
                                                              ? '${item.assignedFullname}'
                                                              : ''),
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
                                    item.assignedMobile != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterPhoneDirectCaller
                                                  .callNumber(
                                                      '${item.assignedMobile}');
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
                                                      text: item.assignedMobile !=
                                                              null
                                                          ? '${item.assignedMobile}'
                                                          : ''),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    item.assignedMobile != null
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
                                                  : ''),
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
                                            text: 'Weight',
                                            color: hexToColor('#80939D'),
                                          ),
                                          Spacer(),
                                          KText(
                                              text: item.weightPct != null
                                                  ? '${item.weightPct} %'
                                                  : '0.0 %'),
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
                                              text: item.scheduledEndDate !=
                                                      null
                                                  ? formatDate(
                                                      date: item
                                                          .scheduledEndDate!)
                                                  : ''),
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
                                          projectActivityGroupBoardC
                                                      .projectCount.length !=
                                                  projectActivityGroupBoardC
                                                      .activityGroupList.length
                                              ? projectActivityGroupBoardC
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
                                                          Stack(
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
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      projectPlanningBoardC.getActivity(
                                                                          item.projectId!,
                                                                          item.bucketId!,
                                                                          item.id!);
                                                                      push(
                                                                        ProjectActivityBoardPage(
                                                                            id: item
                                                                                .projectId!,
                                                                            projectName:
                                                                                item.projectName!,
                                                                            pBucketId: item.bucketId!,
                                                                            pGruopId: item.id!),
                                                                      );

                                                                      // await projectPlanningBoardC
                                                                      //     .getActivity(
                                                                      //         projectPlanningBoardC
                                                                      //             .projectPlanningBoard[
                                                                      //                 index]!
                                                                      //             .id!);

                                                                      // push(
                                                                      //   ProjectActivityBoardPage(
                                                                      //     id: projectPlanningBoardC
                                                                      //         .projectPlanningBoard[
                                                                      //             index]!
                                                                      //         .id!,
                                                                      //     projectName: projectPlanningBoardC
                                                                      //         .projectPlanningBoard[
                                                                      //             index]!
                                                                      //         .projectName
                                                                      //         .toString(),
                                                                      //   ),
                                                                      //   //projectPlanningBoardC.projectScopeBucketBoardGet()
                                                                      // );
                                                                    },
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
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    Container(
                                                                  width: 22,
                                                                  height: 15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: hexToColor(
                                                                        '#007BEC'),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  // backgroundColor: hexToColor('#FFA133'),
                                                                  // radius: 10,
                                                                  child: Center(
                                                                    child:
                                                                        KText(
                                                                      text: projectActivityGroupBoardC.projectCount[index]!.activities! !=
                                                                              null
                                                                          ? projectActivityGroupBoardC
                                                                              .projectCount[index]!
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
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        projectProgressDashboardC
                                                                            .getActivity();
                                                                      },
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
                                                                  child: Center(
                                                                    child:
                                                                        KText(
                                                                      text: projectActivityGroupBoardC.projectCount[index]!.tasks! !=
                                                                              null
                                                                          ? projectActivityGroupBoardC
                                                                              .projectCount[index]!
                                                                              .tasks!
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
                                                                              backgroundColor: hexToColor('#E7F3FF'),
                                                                              radius: 23,
                                                                              child: KText(
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
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      RenderSvg(
                                                                        path:
                                                                            'arrow_right',
                                                                        width:
                                                                            16,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
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
                                                                              text: 'Activities',
                                                                              fontSize: 14,
                                                                              //  bold: true,
                                                                              color: hexToColor('#FFFFFF'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      RenderSvg(
                                                                        path:
                                                                            'cross_icon',
                                                                        width:
                                                                            16,
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
            child: RenderSvg(path: 'floating-button-Chat-user-add')),
      ),
    );
  }
}
