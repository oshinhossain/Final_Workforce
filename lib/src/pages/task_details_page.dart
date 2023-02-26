import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/pages/post_mytask_progress3.dart' as d;

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../controllers/user_controller.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../widgets/title_bar.dart';

class TaskDetailsPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    taskDetailC.getaskDetail(postTaskC.taskId.value);
    taskDetailC.getaskHistory(postTaskC.taskId.value);
    final username = Get.put(UserController()).username;
    int step = 0;
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Obx(
          () => taskDetailC.taskDetails.value == null
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height / 2,
                      ),
                      Loading(),
                    ],
                  ),
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CenterTitleBar(
                      title: 'Task Details',
                      percentange: 0.3,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: hexToColor('#EEF0F6'),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      margin: EdgeInsets.only(bottom: 10, top: 0),
                      child: KText(
                        maxLines: 3,
                        textOverflow: TextOverflow.visible,
                        text:
                            '${taskDetailC.taskDetails.value!.projectName} > ${taskDetailC.taskDetails.value!.bucketName} > ${taskDetailC.taskDetails.value!.activityName}',
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            textOverflow: TextOverflow.visible,
                            text: taskDetailC.taskDetails.value!.supportName,
                            fontSize: 14,
                            color: AppTheme.oColor1,
                            bold: true,
                          ),
                          Divider(
                            thickness: 1,
                            color: hexToColor('#D9D9D9'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                        color: taskDetailC.taskDetails.value!
                                                    .supportType ==
                                                'S'
                                            ? hexToColor('#FF9191')
                                            : taskDetailC.taskDetails.value!
                                                        .supportType ==
                                                    'C'
                                                ? hexToColor('#49CDAB')
                                                : hexToColor('#75B7F3'),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: taskDetailC.taskDetails.value!
                                                      .supportType ==
                                                  'R'
                                              ? 'Responsible'
                                              : taskDetailC.taskDetails.value!
                                                          .supportType ==
                                                      'A'
                                                  ? 'Accountable'
                                                  : taskDetailC
                                                              .taskDetails
                                                              .value!
                                                              .supportType ==
                                                          'S'
                                                      ? 'Support'
                                                      : taskDetailC
                                                                  .taskDetails
                                                                  .value!
                                                                  .supportType ==
                                                              'C'
                                                          ? 'Consulted'
                                                          : taskDetailC
                                                                      .taskDetails
                                                                      .value!
                                                                      .supportType ==
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
                                          text: taskDetailC
                                              .taskDetails.value!.supportNo,
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
                                      visible: taskDetailC
                                              .taskDetails.value!.status !=
                                          'Completed',
                                      child: KText(
                                        text: 'Remaning',
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
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                          color: taskDetailC.taskDetails.value!
                                                      .status ==
                                                  'STARTED'
                                              ? hexToColor('#00D8A0')
                                              : hexToColor('#FFA133'),
                                        ),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text: taskDetailC
                                              .taskDetails.value!.status,
                                          color: taskDetailC.taskDetails.value!
                                                      .status ==
                                                  'STARTED'
                                              ? hexToColor('#00D8A0')
                                              : hexToColor('#FFA133'),
                                          fontSize: 13,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: hexToColor('#00D8A0')),
                                      ),
                                      child: Center(
                                        child: KText(
                                          text:
                                              '${(taskDetailC.taskDetails.value!.outputProgress! * 100).toStringAsFixed(2)}%',
                                          color: hexToColor('#00D8A0'),
                                          fontSize: 13,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: taskDetailC
                                              .taskDetails.value!.status !=
                                          'Completed',
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: hexToColor('#FF3C3C')),
                                        ),
                                        child: Center(
                                          child: KText(
                                            text:
                                                '${taskDetailC.taskDetails.value!.remainingDays} Days',
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
                          Row(
                            children: [
                              Container(
                                height: 64,
                                width: 64,
                                margin: EdgeInsets.only(right: 5, top: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F5FA),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 230, 230, 233),
                                    style: BorderStyle.solid,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffF5F5FA).withOpacity(0.6),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=23.90560,93.094535&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$username&appCode=KYC&fileCategory=photo&countryCode=BD',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Assigned to',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(
                                    text: taskDetailC.taskDetails.value!
                                                .assignedFullname !=
                                            null
                                        ? taskDetailC
                                            .taskDetails.value!.assignedFullname
                                        : 'Name Not Found',
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: KText(
                                      text: 'Plan Start Date',
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
                                    ),
                                  ),
                                  KText(
                                    text: formatDate(
                                        date: taskDetailC.taskDetails.value!
                                            .scheduledStartDate!),
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              height: 140,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * .3,
                                        child: KText(
                                          text: 'Quantity',
                                          fontSize: 13,
                                          color: hexToColor('#80939D'),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .3,
                                          child: KText(
                                            text: 'Remaining. Qty.',
                                            fontSize: 13,
                                            color: hexToColor('#80939D'),
                                          )),
                                      SizedBox(
                                        width: Get.width * .3,
                                        child: KText(
                                          text: 'Delivery Deadline',
                                          fontSize: 13,
                                          color: hexToColor('#80939D'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      // width: Get.width * .3,
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: Get.width * .3,
                                        child: KText(
                                          textOverflow: TextOverflow.visible,
                                          text:
                                              '${taskDetailC.taskDetails.value!.outputAchieved!.toStringAsFixed(0)} ${taskDetailC.taskDetails.value!.outputDescr}',
                                          fontSize: 14,
                                          color: hexToColor('#515D64'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * .28,
                                        child: KText(
                                          textOverflow: TextOverflow.visible,
                                          text:
                                              '${taskDetailC.taskDetails.value!.remainingQty!.toStringAsFixed(0)} ${taskDetailC.taskDetails.value!.outputDescr}',
                                          fontSize: 14,
                                          color: hexToColor('#515D64'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * .3,
                                        child: KText(
                                          textOverflow: TextOverflow.visible,
                                          text: formatDate(
                                              date: taskDetailC.taskDetails
                                                  .value!.scheduledEndDate!),
                                          fontSize: 14,
                                          color: hexToColor('#515D64'),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                          KText(
                            bold: true,
                            text: 'Requested Support Description:',
                            fontSize: 14,
                            color: hexToColor('#515D64'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          KText(
                            text: taskDetailC.taskDetails.value!.supportDescr,
                            fontSize: 14,
                            color: hexToColor('#515D64'),
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible:
                                taskDetailC.taskDetails.value!.statusCode !=
                                    '08',
                            child: GestureDetector(
                              onTap: () {
                                print(
                                    taskDetailC.taskDetails.value!.statusCode);
                                Get.to(
                                  () => d.PostMyTaskProgress3(
                                    outputQuantity: taskDetailC
                                        .taskDetails.value!.outputTarget!,
                                    date: taskDetailC
                                        .taskDetails.value!.scheduledStartDate,
                                    id: taskDetailC.taskDetails.value!.id,
                                    title: taskDetailC
                                        .taskDetails.value!.supportName,
                                    activityName: taskDetailC
                                        .taskDetails.value!.activityName,
                                    projectName: taskDetailC
                                        .taskDetails.value!.projectName,
                                    bluckName: taskDetailC
                                        .taskDetails.value!.bucketName,
                                    unit: taskDetailC
                                        .taskDetails.value!.outputDescr,
                                    supportType: taskDetailC
                                        .taskDetails.value!.supportType,
                                    statusCode: taskDetailC
                                        .taskDetails.value!.statusCode,

                                    //                        projectId:taskDetailC.taskHistoryList[0].projectId ,
                                    //                        progressId: taskDetailC.taskHistoryList[0].pr,
                                    // required String? geoLevelId,
                                    // required String? siteId,
                                    // required String? supportId,
                                    // required String? progressId
                                  ),
                                );
                              },
                              child: Center(
                                child: Container(
                                  height: 34,
                                  width: 116,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: hexToColor('#449EF1')),
                                  child: Center(
                                    child: KText(
                                      text: taskDetailC.taskDetails.value!
                                                  .statusCode ==
                                              '03'
                                          ? 'Start Task'
                                          : 'Update',
                                      fontSize: 16,
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 1,
                              color: hexToColor('#D9D9D9'),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: KText(
                                text: 'Task Progress History',
                                fontSize: 16,
                                color: hexToColor('#41525A'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 1,
                              color: hexToColor('#D9D9D9'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    taskDetailC.taskHistoryList.isEmpty
                        ? taskDetailC.isLoading.value
                            ? SizedBox(
                                height: 50,
                                width: Get.width,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : SizedBox(
                                height: 50,
                                width: Get.width,
                                child: Center(
                                  child: KText(
                                    text: 'No History Found',
                                    bold: true,
                                  ),
                                ),
                              )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            reverse: true,
                            itemCount: taskDetailC.taskHistoryList.length,
                            itemBuilder: (context, index) {
                              step = index + 1;
                              // step =
                              //     (taskDetailC.taskHistoryList.length) - index;

                              final item = taskDetailC.taskHistoryList[index];

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: hexToColor('#84BEF3'),
                                        radius: 15,
                                        child: Center(
                                          child: KText(
                                            text: step.toString(),
                                            fontSize: 14,
                                            color: hexToColor('#FFFFFF'),
                                          ),
                                        ),
                                      ),
                                      if (step != 1)
                                        Container(
                                          height: 200,
                                          width: 2,
                                          color: hexToColor('#84BEF3'),
                                        )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: DateFormat('d MMM y')
                                                    .format(DateTime.parse(
                                                        item.outputDate!)),
                                                fontSize: 14,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              KText(
                                                text: formatDate(
                                                  date: item.outputDatetime!,
                                                  format: 'hh:mm:ss a',
                                                ),
                                                fontSize: 14,
                                                color: hexToColor('#515D64'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Quantity',
                                                fontSize: 14,
                                                color: hexToColor('#515D64'),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 70,
                                                child: KText(
                                                  text:
                                                      '${item.outputAchieved!.toStringAsFixed(2)} ${item.outputDescr}',
                                                  fontSize: 14,
                                                  color: hexToColor('#515D64'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 6),
                                                child: KText(
                                                  text: 'Progress',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border: Border.all(
                                                    color:
                                                        hexToColor('#00D8A0'),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: KText(
                                                    text:
                                                        '${(item.outputProgress! * 100).toStringAsFixed(2)} %',
                                                    color:
                                                        hexToColor('#00D8A0'),
                                                    fontSize: 13,
                                                    bold: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: Get.width * .8,
                                        child: Obx(
                                          () => taskDetailC
                                                      .taskHistoryList.length ==
                                                  taskDetailC
                                                      .historyImageCount.length
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Remarks',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#515D64'),
                                                    ),
                                                    Row(
                                                      children: [
                                                        KText(
                                                          bold: true,
                                                          text: taskDetailC
                                                              .historyImageCount[taskDetailC
                                                                  .historyImageCount
                                                                  .indexWhere((element) =>
                                                                      element
                                                                          .progressId ==
                                                                      item.id)]
                                                              .imageCount,
                                                          fontSize: 14,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                        KText(
                                                          text: ' images',
                                                          fontSize: 14,
                                                          color: hexToColor(
                                                              '#515D64'),
                                                        ),
                                                      ],
                                                    )
                                                    //
                                                    // )
                                                  ],
                                                )
                                              : Text('images'),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      KText(
                                        text: item.outputRemarks,
                                        fontSize: 14,
                                        color: hexToColor('#515D64'),
                                      ),

                                      SizedBox(
                                        height: 80,
                                        width: Get.width * .8,
                                        child: Obx(() =>
                                                taskDetailC.taskHistoryList.length !=
                                                        taskDetailC
                                                            .historyImageCount
                                                            .length
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 50,
                                                        child: Text('Loading'))
                                                    : int.parse(taskDetailC
                                                                .historyImageCount[taskDetailC.historyImageCount.indexWhere((element) =>
                                                                    element.progressId ==
                                                                    item.id)]
                                                                .imageCount) ==
                                                            0
                                                        ? Container(
                                                            alignment: Alignment.center,
                                                            width: Get.width * .8,
                                                            height: 20,
                                                            child: Text('No Image Found'))
                                                        :
                                                        //  int.parse(taskDetailC.historyImageCount[taskDetailC.historyImageCount.indexWhere((element) => element.id == item.id)].imageCount) ==
                                                        //         taskDetailC
                                                        //             .historyImages[taskDetailC.historyImages.indexWhere((e) => e.id == item.id)]
                                                        //             .images
                                                        //             .length
                                                        //     ?
                                                        ListView(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: taskDetailC
                                                                .historyImages[taskDetailC
                                                                    .historyImages
                                                                    .indexWhere((e) =>
                                                                        e.progressId ==
                                                                        item
                                                                            .id)]
                                                                .images
                                                                .map((e) =>
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return Dialog(
                                                                                backgroundColor: Colors.transparent,
                                                                                child: Center(
                                                                                  //padding: const EdgeInsets.all(8.0),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: Alignment.topRight,
                                                                                        child: GestureDetector(
                                                                                            onTap: () {
                                                                                              Get.back();
                                                                                            },
                                                                                            child: Icon(
                                                                                              Icons.close,
                                                                                              color: Colors.white,
                                                                                              size: 45,
                                                                                            )),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: Get.height * .8,
                                                                                        width: Get.width * .7,
                                                                                        child:
                                                                                            // GestureDetector(
                                                                                            //     onTap: () {
                                                                                            //       Get.back();
                                                                                            //     },
                                                                                            //     child: Icon(Icons.close)),
                                                                                            PhotoView(backgroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10)), imageProvider: NetworkImage(e)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                        // showDialog(
                                                                        //     context:
                                                                        //         context,
                                                                        //     builder:
                                                                        //         (BuildContext context) {
                                                                        //       return d.SimpleDialog(
                                                                        //         onTap: () {
                                                                        //           postTaskC.imagefiles.removeAt(index);
                                                                        //           Get.back();
                                                                        //         },
                                                                        //         checker: 0,
                                                                        //         i: 0,
                                                                        //         imagePath: e,
                                                                        //       );
                                                                        //     });
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 4.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              45,
                                                                          width:
                                                                              80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(e),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                          )
                                            // : Text('data'),
                                            ),
                                      )
                                      // Obx(() => taskDetailC
                                      //             .historyImages.length !=
                                      //         taskDetailC
                                      //             .historyImageCount.length
                                      //     ? CircularProgressIndicator()
                                      //     : taskDetailC
                                      //             .historyImages[taskDetailC
                                      //                 .historyImages
                                      //                 .indexWhere((element) =>
                                      //                     element.id ==
                                      //                     item.id)]
                                      //             .images
                                      //             .isNotEmpty
                                      //         ? SizedBox(
                                      //             height: 100,
                                      //             width: Get.width * .8,
                                      //             child: ListView.builder(
                                      //               shrinkWrap: true,
                                      //               scrollDirection:
                                      //                   Axis.horizontal,
                                      //               itemCount: taskDetailC
                                      //                   .historyImages[taskDetailC
                                      //                       .historyImages
                                      //                       .indexWhere(
                                      //                           (element) =>
                                      //                               element
                                      //                                   .id ==
                                      //                               item.id)]
                                      //                   .images
                                      //                   .length,
                                      //               itemBuilder:
                                      //                   (context, index) =>
                                      //                       Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.all(
                                      //                         4.0),
                                      //                 child: Container(
                                      //                   width: 150,
                                      //                   decoration:
                                      //                       BoxDecoration(
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .circular(20),
                                      //                     image:
                                      //                         DecorationImage(
                                      //                       fit: BoxFit.cover,
                                      //                       image: NetworkImage(
                                      //                         taskDetailC
                                      //                             .historyImages[taskDetailC
                                      //                                 .historyImages
                                      //                                 .indexWhere((element) =>
                                      //                                     element
                                      //                                         .id ==
                                      //                                     item.id)]
                                      //                             .images[index]
                                      //                             .toString(),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         : Container(
                                      //             width: Get.width * .8,
                                      //             alignment: Alignment.center,
                                      //             child: KText(
                                      //                 bold: true,
                                      //                 text: 'Image not found'),
                                      //           )),
                                    ],
                                  ),
                                ],
                              );
                            })
                  ],
                ),
        ),
      ),
    );
  }
}
