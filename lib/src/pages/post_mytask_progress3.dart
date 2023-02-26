import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/dialogHelper.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/pages/main_page.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../widgets/title_bar.dart';

// ignore: must_be_immutable
class PostMyTaskProgress3 extends StatelessWidget with Base {
  final String? id;
  final String? title;
  final String? statusCode;
  final String? activityName;
  final String? projectName;
  final String? bluckName;
  final String? date;
  final double? outputQuantity;
  final String? unit;
  final String? supportType;
  final String? projectId;
  final String? geoLevelId;
  final String? siteId;
  final String? supportId;
  final String? progressId;
  PostMyTaskProgress3(
      {this.id,
      required this.outputQuantity,
      this.statusCode,
      this.title,
      this.activityName,
      required this.date,
      this.projectName,
      this.bluckName,
      this.projectId,
      this.geoLevelId,
      this.siteId,
      this.supportId,
      this.progressId,
      this.unit,
      this.supportType});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _textController = TextEditingController(
        text: taskDetailC.taskDetails.value!.statusCode == '03'
            ? 'Started the Work'
            : '');

    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _valueController = TextEditingController(
        text: taskDetailC.taskDetails.value!.statusCode == '03' ? '0' : '');
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.searchColor;
    }

    return WillPopScope(
      onWillPop: () {
        postTaskC.quantity.value = '';
        return Future(
          () => false,
        );
      },
      child: Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        appBar: KAppbar(),
        body: SingleChildScrollView(
            child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CenterTitleBar(title: 'Post My Task Progress', percentange: 0.20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hexToColor('#EEF0F6'),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: EdgeInsets.only(bottom: 10, top: 0),
                child: KText(
                  maxLines: 3,
                  textOverflow: TextOverflow.visible,
                  text: '$projectName > $bluckName > $activityName',
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: title,
                      fontSize: 14,
                      color: AppTheme.oColor1,
                      bold: true,
                    ),
                    Divider(
                      thickness: 1,
                      color: hexToColor('#D9D9D9'),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 90,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: supportType == 'S'
                                ? hexToColor('#FF9191')
                                : supportType == 'C'
                                    ? hexToColor('#49CDAB')
                                    : hexToColor('#75B7F3'),
                          ),
                          child: Center(
                            child: KText(
                              text: supportType == 'S'
                                  ? 'Support'
                                  : supportType == 'C'
                                      ? 'Consulted'
                                      : 'Accountable',
                              color: hexToColor('#FFFFFF'),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Spacer(),
                        // GestureDetector(
                        //   onTap: () {
                        //     postTaskC.selectDate();
                        //   },
                        //   child:
                        Row(
                          children: [
                            KText(
                              text: 'Date: ',
                              fontSize: 13,
                            ),
                            KText(
                              text:
                                  //  postTaskC.selectedDate.value == ''
                                  //     ?
                                  formatDate(date: DateTime.now().toString()),
                              // : postTaskC.selectedDate.value,
                              fontSize: 13,
                              bold: true,
                            ),
                          ],
                        ),
                        //  )
                      ],
                    ),
                    Row(
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Output Quantity ',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              //fontFamily: bold! ? 'Manrope Bold' : 'Manrope Regular',
                              color: hexToColor('#80939D'),
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 13,
                              //fontFamily: bold! ? 'Manrope Bold' : 'Manrope Regular',
                              color: Colors.red,
                            ),
                          ),
                        ])),
                        Spacer(),
                        KText(
                          text: 'Unit of Mesure',
                          color: hexToColor('#80939D'),
                          fontSize: 13,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            controller: _valueController,
                            enabled:
                                taskDetailC.taskDetails.value!.statusCode !=
                                    '03',
                            onChanged: postTaskC.quantity,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.0',
                              contentPadding: EdgeInsets.all(0),
                              isDense: true,
                              labelStyle:
                                  TextStyle(color: hexToColor('#FF0000')),
                              enabledBorder:
                                  taskDetailC.taskDetails.value!.statusCode !=
                                          '03'
                                      ? UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: hexToColor('#DBECFB'),
                                          ),
                                        )
                                      : InputBorder.none,
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: KText(
                              text: unit,
                              color: hexToColor('#515D64'),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: KText(
                        text: 'Geography',
                        fontSize: 13,
                        color: hexToColor('#80939D'),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: KText(
                                // ignore: unrelated_type_equality_checks
                                text: areaSearchC.district != ''
                                    ? '${areaSearchC.district} > ${areaSearchC.subDisctrict} > ${areaSearchC.venue}'
                                    : ''),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: areaSearchC.searchLocationBottomSheet,
                              child: RenderSvg(
                                path: 'icon_search_user',
                                height: 20.0,
                                width: 20.0,
                                color: Color(0xff9BA9B3),
                              ),
                            ),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: KText(
                        text: 'Remarks',
                        fontSize: 13,
                        color: hexToColor('#80939D'),
                      ),
                    ),
                    TextFormField(
                      controller: _textController,
                      enabled:
                          taskDetailC.taskDetails.value!.statusCode != '03',
                      //  initialValue: '1 advice give to Mr. Sazzad on truck selection',
                      onChanged: postTaskC.remarks,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        labelStyle: TextStyle(color: hexToColor('#FF0000')),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: hexToColor('#DBECFB')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Evidence',
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                              KText(
                                text: 'Capture Photo',
                                fontSize: 14,
                                color: hexToColor('#B3B6C6'),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              postTaskC.imagefiles.length < 8
                                  ? await postTaskC.pickMultiImage()
                                  : Get.snackbar('Image Quantity Exceded',
                                      'You can upload upto 9 picture');
                            },
                            child: RenderSvg(
                              path: 'camera',
                              color: hexToColor('#80939D'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: hexToColor('#449EF1'),
                    ),
                    Obx(
                      () => postTaskC.imagefiles.isNotEmpty
                          ? SizedBox(
                              height: 130,
                              child: ListView.builder(
                                  itemCount: postTaskC.imagefiles.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final image = postTaskC.imagefiles[index];
                                    return InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                onTap: () {
                                                  postTaskC.imagefiles
                                                      .removeAt(index);
                                                  Get.back();
                                                },
                                                checker: 0,
                                                imagePath: postTaskC
                                                    .imagefiles[index].path,
                                              );
                                            });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(
                                              File(image.path),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RenderSvg(
                                    path: 'image_vehicle',
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                Expanded(
                                  child: RenderSvg(
                                    path: 'image_vehicle',
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: postTaskC.isChecked.value,
                                onChanged: (_) {
                                  postTaskC.isChecked.toggle();
                                }),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: KText(
                              text:
                                  'Close Task (if checked, this task will disappear from the task list. however, from the reporting facility, it will be available.)',
                              fontSize: 14,
                              color: hexToColor('#515D64'),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: taskDetailC.taskDetails.value!.statusCode == '03'
                            ? () async {
                                Get.dialog(AlertDialog(
                                  content: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ));

                                final res = await postTaskC.postMyTask(
                                  id!,
                                  postTaskC.quantity.value != ''
                                      ? postTaskC.quantity.value
                                      : taskDetailC.taskDetails.value!
                                                  .statusCode ==
                                              '03'
                                          ? '0'
                                          : '1',
                                  statusCode,
                                  areaSearchC.levelFullCode.toString(),
                                );
                                areaSearchC.siteLocationsV2.value = null;
                                areaSearchC.district.value = '';
                                areaSearchC.subDisctrict.value = '';
                                areaSearchC.venue.value = '';
                                print(
                                    'values: ${areaSearchC.district.value}${areaSearchC.subDisctrict.value}${areaSearchC.venue.value}'); //  Get.back();
                                // kLog(res);
                                if (res.data['data'] != null &&
                                    postTaskC.imagefiles.isNotEmpty) {
                                  areaSearchC.levelFullCode.value = '';

                                  await postTaskC.postEvidenceAttachment(
                                      activityId: res.data['data']['activityId']
                                          .toString(),
                                      progressId:
                                          res.data['data']['id'].toString(),
                                      projectId: res.data['data']['projectId']
                                          .toString(),
                                      status: postTaskC.isChecked.value
                                          ? 'Completed'
                                          : 'Started',
                                      supportId: res.data['data']['supportId']
                                          .toString());
                                }
                                postTaskC.isChecked.value = false;

                                postTaskC.isChecked.value = false;
                                await taskDetailC
                                    .getaskDetail(postTaskC.taskId.value);
                                await taskDetailC
                                    .getaskHistory(postTaskC.taskId.value);

                                postTaskC.quantity.value = '';
                                Get.back();

                                DialogHelper.successDialog(
                                  title: 'Save Task Successfully',
                                  msg: res.data['message'][0].toString(),
                                  color: hexToColor('#00B485'),
                                  path: 'success-circular',
                                  onPressed: () {
                                    offAll(MainPage());
                                  },
                                );
                              }
                            : postTaskC.quantity.value == ''
                                ? () {
                                    Get.snackbar(
                                      'Status',
                                      'Please enter data for all required fields',
                                      colorText: AppTheme.black,
                                      backgroundColor:
                                          AppTheme.appHomePageColor,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                : () async {
                                    print('status $statusCode');
                                    Get.dialog(AlertDialog(
                                      content: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ));
                                    areaSearchC.siteLocationsV2.value = null;
                                    areaSearchC.district.value = '';
                                    areaSearchC.subDisctrict.value = '';
                                    areaSearchC.venue.value = '';
                                    final res = await postTaskC.postMyTask(
                                        id!,
                                        postTaskC.quantity.value != ''
                                            ? postTaskC.quantity.value
                                            : taskDetailC.taskDetails.value!
                                                        .statusCode ==
                                                    '03'
                                                ? '0'
                                                : '1',
                                        statusCode,
                                        areaSearchC.levelFullCode.toString());
                                    //  Get.back();
                                    // kLog(res);
                                    // if (res.data['status'] != null &&
                                    //     res.data['status']
                                    //             .contains('successful') ==
                                    //         true) {
                                    if (res.data['data'] != null &&
                                        postTaskC.imagefiles.isNotEmpty) {
                                      await postTaskC.postEvidenceAttachment(
                                          activityId: res.data['data']
                                                  ['activityId']
                                              .toString(),
                                          progressId:
                                              res.data['data']['id'].toString(),
                                          projectId: res.data['data']
                                                  ['projectId']
                                              .toString(),
                                          status: postTaskC.isChecked.value
                                              ? 'Completed'
                                              : 'Started',
                                          supportId: res.data['data']
                                                  ['supportId']
                                              .toString());
                                    }
                                    postTaskC.isChecked.value = false;
                                    postTaskC.quantity.value = '';
                                    await taskDetailC
                                        .getaskDetail(postTaskC.taskId.value);
                                    await taskDetailC
                                        .getaskHistory(postTaskC.taskId.value);
                                    Get.back();

                                    DialogHelper.successDialog(
                                      title: 'Save Task Successfully',
                                      msg: res.data['message'][0].toString(),
                                      color: hexToColor('#00B485'),
                                      path: 'success-circular',
                                      onPressed: () {
                                        offAll(MainPage());
                                      },
                                    );
                                  },
                        child: Container(
                          height: 34,
                          width: 116,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: taskDetailC.taskDetails.value!.statusCode ==
                                    '03'
                                ? hexToColor('#449EF1')
                                : postTaskC.quantity.value != ''
                                    ? hexToColor('#449EF1')
                                    : hexToColor('#449EF1').withOpacity(0.4),
                          ),
                          child: Center(
                            child: KText(
                              text: 'Save',
                              fontSize: 16,
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

// ignore: must_be_immutable

class SimpleDialog extends StatelessWidget {
  final String imagePath;
  final int i;
  final int checker;
  final VoidCallback onTap;
  SimpleDialog({
    this.imagePath = '',
    this.i = 1,
    required this.onTap,
    required this.checker,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: SizedBox(
        height: 500,
        width: 400,
        // color: Colors.amber,
        child: checker == 1
            ? Image.asset(
                '${Constants.imgPath}/truck.png',
                fit: BoxFit.cover,
              )
            : i != 1
                ? PhotoView(imageProvider: NetworkImage(imagePath))
                : Image.file(File(imagePath)),
      ),
      actions: [
        i == 1
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 34,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                    onTap: onTap,
                    child: Container(
                      height: 34,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: hexToColor('#FE0101')),
                      child: Center(
                        child: KText(
                          text: 'Delete',
                          fontSize: 16,
                          color: Colors.white,
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 34,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.green),
                  child: Center(
                    child: KText(
                      text: 'OK',
                      fontSize: 16,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
