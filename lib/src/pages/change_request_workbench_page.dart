import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';

import 'package:workforce/src/pages/edit_change_request_page.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/base.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import 'change_request_page.dart';
import 'create_change_request_page.dart';

class ChangeRequestWorkbenchPage extends StatefulWidget {
  @override
  State<ChangeRequestWorkbenchPage> createState() =>
      _ChangeRequestWorkbenchPageState();
}

class _ChangeRequestWorkbenchPageState extends State<ChangeRequestWorkbenchPage>
    with Base {
  @override
  void dispose() {
    changeRequestC.selectedproject.value = null;

    changeRequestC.changeRequest.clear();

    super.dispose();
  }

  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));

    //  changeRequestC.getChangeRequest();

    _refreshController.refreshCompleted();
  }

  // const ChangeRequestWorkbenchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        resizeToAvoidBottomInset: true,
        floatingActionButton: Obx(
          () => FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(
                color: hexToColor('#FFFFFF'),
              ),
            ),
            onPressed: changeRequestC.selectedproject.value != null
                ? () {
                    push(CreateChangeRequestPage());
                  }
                : null,
            child: Icon(
              Icons.add,
              color: changeRequestC.selectedproject.value != null
                  ? hexToColor('#FFFFFF')
                  : hexToColor('#FFFFFF').withOpacity(.20),
            ),
            //  RenderSvg(
            //   path: 'floating-button-Chat-user-add',
          ),
        ),
        appBar: KAppbar(),
        backgroundColor: hexToColor('#EEF0F6'),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 12, top: 3, bottom: 3),
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
                          text: 'Change Request Workbench',
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
                      Row(
                        children: [
                          KText(
                            text: 'Project Name',
                            fontSize: 13,
                            color: hexToColor('#41525A'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: (() async {
                                await changeRequestC.openProjectNameDialog();
                              }),
                              child: RenderSvg(path: 'icon_search_elements')),
                        ],
                      ),
                      if (changeRequestC.selectedproject.value != null)
                        Row(
                          children: [
                            KText(
                              text: changeRequestC.selectedproject.value != null
                                  ? '${changeRequestC.selectedproject.value!.projectName}'
                                  : '',
                              fontSize: 14,
                              color: hexToColor('#41525A'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (changeRequestC.changeRequest.isEmpty)
                  changeRequestC.isLoading.value
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
                else
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: changeRequestC.changeRequest.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = changeRequestC.changeRequest[index];
                      return Container(
                        margin: EdgeInsets.all(12),
                        width: Get.width,
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
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: Get.width * .8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: KText(
                                            text: item.requestTitle != null
                                                ? '${item.requestTitle}'
                                                : '',
                                            fontSize: 16,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                            textOverflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: item.status == 'Approved'
                                                ? hexToColor('#CAFDF0')
                                                : item.status == 'Draft'
                                                    ? hexToColor('#84BEF3')
                                                    : item.status == 'Rejected'
                                                        ? hexToColor('#FFE5E5')
                                                        : hexToColor('#84BEF3'),
                                          ),
                                          child: Center(
                                            child: KText(
                                              text: item.status != null
                                                  ? item.status
                                                  : '',
                                              fontSize: 11,
                                              //  bold: true,
                                              color: item.status == 'Approved'
                                                  ? hexToColor('#09C594')
                                                  : item.status == 'Draft'
                                                      ? hexToColor('#000000')
                                                      : item.status ==
                                                              'Rejected'
                                                          ? hexToColor(
                                                              '#FF3C3C')
                                                          : hexToColor(
                                                              '#000000'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                PopupMenuButton(
                                  elevation: 20.0,
                                  // shape: BorderSide(
                                  //   color: ,

                                  //   strokeAlign: StrokeAlign.inside),
                                  color: hexToColor('#FFFFFF'),
                                  child: RenderSvg(
                                    path: 'icon_bottom_navigation_map-1',
                                    fit: BoxFit.cover,
                                    width: Get.width * .1,
                                  ),
                                  // onSelected: (value) {
                                  //   // ScaffoldMessenger.of(context).showSnackBar(
                                  //   //     SnackBar(
                                  //   //         content: Text('$value item pressed')));
                                  // },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                back();
                                                if (changeRequestC
                                                        .selectedproject
                                                        .value !=
                                                    null) {
                                                  push(
                                                    ChangeRequestPage(
                                                      item: item,
                                                    ),
                                                  );
                                                } else {
                                                  Get.snackbar(
                                                    'Attention!!',
                                                    'Plese select the project First',
                                                    colorText: AppTheme.black,
                                                    backgroundColor: AppTheme
                                                        .appHomePageColor,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    maxWidth: 190,
                                                  );
                                                }
                                              },
                                              child: RenderSvg(
                                                path: 'view',
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            if (item.status != 'Rejected' &&
                                                item.status != 'Approved')
                                              InkWell(
                                                onTap: () {
                                                  back();
                                                  Global.confirmDialog(
                                                    onConfirmed: () {
                                                      changeRequestC
                                                          .changeRequest
                                                          .removeWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  item.id);
                                                      changeRequestC
                                                          .deleteChangeRequest(
                                                              item.id!);
                                                    },
                                                  );
                                                  // changeRequestC
                                                  //     .deleteChangeRequest(
                                                  //         item.id!);
                                                  //  back();
                                                },
                                                child: RenderSvg(
                                                  path: 'delete',
                                                  width: 40,
                                                ),
                                              ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            if (item.status != 'Approved')
                                              InkWell(
                                                onTap: () {
                                                  back();
                                                  if (changeRequestC
                                                          .selectedproject
                                                          .value !=
                                                      null) {
                                                    push(EditChangeRequestPage(
                                                        item: item));
                                                  } else {
                                                    Get.snackbar(
                                                      'Attention!!',
                                                      'Plese select the project First',
                                                      colorText: AppTheme.black,
                                                      backgroundColor: AppTheme
                                                          .appHomePageColor,
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      maxWidth: 190,
                                                    );
                                                  }
                                                },
                                                child: RenderSvg(
                                                  path: 'edit',
                                                  width: 40,
                                                ),
                                              ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            RenderSvg(path: 'cross_icon'),
                                            SizedBox(
                                              height: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 5,
                              color: Colors.black26,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: KText(
                                    text: 'CR Number#',
                                    fontSize: 13,
                                    color: AppTheme.appTextColor1,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: KText(
                                    text: item.requestRefno != null
                                        ? '${item.requestRefno}'
                                        : '',
                                    fontSize: 13,
                                    bold: true,
                                    color: AppTheme.appTextColor1,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 1, color: Colors.black12),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: KText(
                                    text: 'Request Date',
                                    fontSize: 13,
                                    color: AppTheme.appTextColor1,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                Spacer(),
                                if (item.requestedOn != null)
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: KText(
                                      text: formatDate(date: item.requestedOn!),
                                      fontSize: 13,
                                      bold: true,
                                      color: AppTheme.appTextColor1,
                                      textOverflow: TextOverflow.visible,
                                    ),
                                  )
                              ],
                            ),
                            Divider(height: 1, color: Colors.black12),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: KText(
                                    text: 'Priority',
                                    fontSize: 13,
                                    color: AppTheme.appTextColor1,
                                    textOverflow: TextOverflow.visible,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: KText(
                                    text: item.priority != null
                                        ? '${item.priority}'
                                        : '',
                                    // item.priority == '1'
                                    //     ? 'Mandatory'
                                    //     : item.priority == '2'
                                    //         ? 'High'
                                    //         : item.priority == '3'
                                    //             ? 'Medium'
                                    //             : item.priority == '4'
                                    //                 ? 'Low'
                                    //                 : '',
                                    fontSize: 13,
                                    bold: true,
                                    color: item.priority == 'Mandatory'
                                        ? hexToColor('#EE1818')
                                        : item.priority == 'High'
                                            ? hexToColor('#FF8A00')
                                            : item.priority == 'Medium'
                                                ? hexToColor('#EBC500')
                                                : item.priority == 'Low'
                                                    ? hexToColor('#EBC800')
                                                    : hexToColor('#000000'),
                                    textOverflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 1, color: Colors.black12),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: KText(
                                  text: 'Geography',
                                  fontSize: 13,
                                  color: AppTheme.appTextColor1,
                                  textOverflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: KText(
                                  bold: true,
                                  text:
                                      '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
                                  color: AppTheme.appTextColor1,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
