import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/pages/task_details_page.dart';
import 'package:workforce/src/widgets/title_bar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../helpers/route.dart';

class PostMyTaskProgress extends StatelessWidget with Base {
  final RefreshController _refreshController = RefreshController();
  Future<void> _onRefresh() async {
    postTaskC.getProjectItem();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    postTaskC.getProjectItem();
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
            child: Column(
          children: [
            CenterTitleBar(title: 'Post My Task Progress', percentange: 0.18),
            SizedBox(
              height: 22,
            ),
            Obx(
              () => postTaskC.taskItemList.isEmpty
                  ? postTaskC.isLoading.value
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
                  : Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: postTaskC.taskItemList.length,
                        itemBuilder: (context, index) {
                          final item = postTaskC.taskItemList[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: hexToColor('#EEF0F6'),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5, top: 5),
                                  child: KText(
                                    textOverflow: TextOverflow.visible,
                                    text:
                                        '${item.projectName} > ${item.bucketName} > ${item.groupName} > ${item.activityName}',
                                    fontSize: 13,
                                    bold: true,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  postTaskC.taskId.value = item.id!;
                                  print('task id${postTaskC.taskId.value}');

                                  await taskDetailC.getaskDetail(item.id!);
                                  //   await  taskDetailC.getaskHistory(item.id!);
                                  push(TaskDetailsPage());
                                },
                                child: Container(
                                  height: 60,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: Radius.circular(12),
                                    //   topRight: Radius.circular(12),
                                    // ),
                                    color: AppTheme.oColor3,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: KText(
                                            maxLines: 2,
                                            text: '${item.supportName!} ',
                                            fontSize: 14,
                                            color: AppTheme.oColor1,
                                            bold: true,
                                            textOverflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: RenderSvg(
                                              path: 'icon_forward',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 120,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                      width: 1, color: AppTheme.oColor3),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: item.supportType == 'S'
                                                  ? hexToColor('#FF9191')
                                                  : item.supportType == 'C'
                                                      ? hexToColor('#49CDAB')
                                                      : hexToColor('#75B7F3'),
                                            ),
                                            child: Center(
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
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              KText(
                                                text: 'Task ID :',
                                                fontSize: 13,
                                              ),
                                              KText(
                                                text: item.supportNo,
                                                fontSize: 13,
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: KText(
                                              text: 'Task Status',
                                              fontSize: 13,
                                            ),
                                          ),
                                          Spacer(),
                                          KText(
                                            text: 'Progress',
                                            fontSize: 13,
                                          ),
                                          Spacer(),
                                          Visibility(
                                            visible: item.status != 'Completed',
                                            child: KText(
                                              text: 'Remaining',
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                color: item.status == 'STARTED'
                                                    ? hexToColor('#00D8A0')
                                                    : hexToColor('#FFA133'),
                                              ),
                                            ),
                                            child: Center(
                                              child: KText(
                                                text: item.status,
                                                color: item.status == 'STARTED'
                                                    ? hexToColor('#00D8A0')
                                                    : hexToColor('#FFA133'),
                                                fontSize: 13,
                                                bold: true,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 22,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                  color: hexToColor('#00D8A0')),
                                            ),
                                            child: Center(
                                              child: FittedBox(
                                                child: KText(
                                                  textOverflow:
                                                      TextOverflow.visible,
                                                  text:
                                                      '${(item.outputProgress! * 100).toStringAsFixed(2)}%',
                                                  color: hexToColor('#00D8A0'),
                                                  fontSize: 12,
                                                  bold: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Visibility(
                                            visible: item.status != 'Completed',
                                            child: Container(
                                              height: 22,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                border: Border.all(
                                                    color:
                                                        hexToColor('#FF3C3C')),
                                              ),
                                              child: Center(
                                                child: KText(
                                                  text:
                                                      '${item.remainingDays} Days',
                                                  bold: true,
                                                  color: hexToColor('#FF3C3C'),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
            ),
          ],
        )),
      ),
    );
  }
}
