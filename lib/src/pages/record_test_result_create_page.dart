import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class RecordTestResultCreatePage extends StatefulWidget with Base {
  @override
  State<RecordTestResultCreatePage> createState() =>
      _RecordTestResultCreatePageState();
}

class _RecordTestResultCreatePageState
    extends State<RecordTestResultCreatePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      resizeToAvoidBottomInset: true,
      appBar: KAppbar(),
      backgroundColor: hexToColor('#EEF0F6'),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
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
                        text: 'Record Test Result',
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
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 85,
                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                    color: hexToColor('#F7F7FC'),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        KText(
                          text: 'Test Type',
                          fontSize: 14,
                          bold: true,
                          color: hexToColor('#41525A'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.recordTestResultC.searchProjectBottomSheet();
                          },
                          child: RenderSvg(path: 'icon_search_elements'),
                        ),
                      ],
                    ),
                    KText(
                      text: widget.networkTopologyC.selectedProject.value !=
                                  null &&
                              widget.recordTestResultC.selectedTestType.value !=
                                  null
                          ? '${widget.networkTopologyC.selectedProject.value!.projectName}>${widget.recordTestResultC.selectedTestType.value!.testTypeName}'
                          : '',
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      maxLines: 3,
                      color: hexToColor('#41525A'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 85,
                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                    color: hexToColor('#F7F7FC'),
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
                          text: 'Geography',
                          fontSize: 14,
                          bold: true,
                          color: hexToColor('#41525A'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () async {
                              widget.areaSearchC.searchLocationBottomSheet();
                            },
                            child: RenderSvg(path: 'icon_search_elements')),
                      ],
                    ),
                    KText(
                        textOverflow: TextOverflow.visible,
                        // ignore: unrelated_type_equality_checks
                        text: widget.areaSearchC.district != ''
                            ? '${widget.areaSearchC.district} > ${widget.areaSearchC.subDisctrict} > ${widget.areaSearchC.venue}'
                            : ''),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              KText(
                                text: 'Test No.',
                                color: hexToColor('#80939D'),
                                fontSize: 13,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  widget.recordTestResultC.testSearchList
                                      .clear();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return TestNoListDailog();
                                      });
                                },
                                child: RenderSvg(
                                  path: 'icon_search_elements',
                                  width: 26,
                                  color: hexToColor('#66A1D9'),
                                ),
                              ),
                            ],
                          ),
                          KText(
                            textOverflow: TextOverflow.visible,
                            text: widget.recordTestResultC.selectedTestItem
                                        .value !=
                                    null
                                ? widget.recordTestResultC.selectedTestItem
                                    .value!.testNo
                                : '',
                            fontSize: 13,
                          ),
                          Divider(
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: KText(
                        text: '',
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              KText(
                                text: 'Date',
                                color: hexToColor('#80939D'),
                                fontSize: 13,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          KText(
                            text: '25-11-2022',
                            fontSize: 13,
                          ),
                          Divider(
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Obx(
                  () => widget.recordTestResultC.criteriaGroupList.isEmpty
                      ? Text('No Group Available')
                      : Obx(
                          () => widget.recordTestResultC.selectedTestType
                                      .value ==
                                  null
                              ? Text('data')
                              : SizedBox(
                                  width: Get.width - 20,
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    value: widget
                                        .recordTestResultC
                                        .criteriaGroupList[widget
                                            .recordTestResultC.criteriaGroupList
                                            .indexWhere((element) =>
                                                element.testTypeId ==
                                                widget
                                                    .recordTestResultC
                                                    .selectedTestType
                                                    .value!
                                                    .id)]
                                        .id,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: hexToColor('#80939D'),
                                    ),
                                    items: widget
                                        .recordTestResultC.criteriaGroupList
                                        .map((item) {
                                      return DropdownMenuItem(
                                        onTap: () async {
                                          widget
                                              .recordTestResultC
                                              .selectedCriteriaGroup
                                              .value = item;
                                          widget.recordTestResultC.imagefiles
                                              .clear();
                                          await widget.recordTestResultC
                                              .getCriteriaList(widget
                                                  .recordTestResultC
                                                  .selectedTestItem
                                                  .value!
                                                  .testTypeId!);

                                          await widget.recordTestResultC
                                              .getScenarioList(widget
                                                  .recordTestResultC
                                                  .selectedTestItem
                                                  .value!
                                                  .testTypeId!);
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
                                      // maintainTestTypeCreateC.selectedIndex.value =
                                      //     item!.indexOf(item);
                                      // kLog(maintainTestTypeCreateC.selectedIndex.value);
                                    },
                                  ),
                                ),
                        ),
                ),
              ),
              widget.recordTestResultC.criteriaList.isNotEmpty
                  ? widget.recordTestResultC.scenarioList.isNotEmpty
                      ? widget.recordTestResultC.criteriaList.length ==
                                  widget.recordTestResultC.testResultPostList
                                      .length &&
                              widget.recordTestResultC.criteriaList.length ==
                                  widget.recordTestResultC.imagefiles.length
                          ? ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  widget.recordTestResultC.criteriaList.length,
                              itemBuilder: (BuildContext context, int ii) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(0),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.all(10),
                                        height: 50,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: hexToColor('#FFE9CF'),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: widget
                                                  .recordTestResultC
                                                  .criteriaList[ii]
                                                  .criterionName,
                                              fontSize: 14,
                                              bold: true,
                                            ),
                                            Spacer(),
                                            KText(
                                              text: widget
                                                  .recordTestResultC
                                                  .criteriaList[ii]
                                                  .criterionCode,
                                              fontSize: 14,
                                              bold: true,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Expected Result',
                                                  color: hexToColor('#80939D'),
                                                  fontSize: 13,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: KText(
                                                text: widget
                                                    .recordTestResultC
                                                    .criteriaList[ii]
                                                    .expectedResult,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            DottedLine(
                                              lineThickness: 1,
                                              dashLength: 1.5,
                                              dashGapLength: 2,
                                              dashColor: hexToColor(
                                                '#FFB661',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: widget.recordTestResultC
                                            .scenarioList.length,
                                        itemBuilder: (context, i) => Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      KText(
                                                        text:
                                                            'Scenario : ${widget.recordTestResultC.scenarioList[i].scenarioCode}',
                                                        color: hexToColor(
                                                            '#80939D'),
                                                        fontSize: 13,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: KText(
                                                      text:
                                                          'WL: ${widget.recordTestResultC.scenarioList[i].scenarioName}',
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: 'Test Result',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: 1,
                                                        minLines: 1,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Write here',
                                                          contentPadding:
                                                              EdgeInsets.all(5),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: .1),
                                                          ),
                                                        ),
                                                        onChanged: (value) {
                                                          widget.recordTestResultC.updatescenarioTestResult(
                                                              criteriaid: widget
                                                                  .recordTestResultC
                                                                  .criteriaList[
                                                                      ii]
                                                                  .id!,
                                                              scenarioid: widget
                                                                  .recordTestResultC
                                                                  .scenarioList[
                                                                      i]
                                                                  .id!,
                                                              value: value);

                                                          // kLog(recordTestResultC
                                                          //     .testResultPostList[recordTestResultC
                                                          //         .testResultPostList
                                                          //         .indexWhere((element) =>
                                                          //             element.criterionId ==
                                                          //             recordTestResultC
                                                          //                 .criteriaList[
                                                          //                     ii]
                                                          //                 .id!)]
                                                          //     .testResultScenarios![recordTestResultC
                                                          //         .testResultPostList[recordTestResultC
                                                          //             .testResultPostList
                                                          //             .indexWhere((element) =>
                                                          //                 element
                                                          //                     .criterionId ==
                                                          //                 recordTestResultC
                                                          //                     .criteriaList[ii]
                                                          //                     .id!)]
                                                          //         .testResultScenarios!
                                                          //         .indexWhere((element) => element.scenarioId == recordTestResultC.scenarioList[i].id)]
                                                          //     .testResult);
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Remarks',
                                              color: hexToColor('#80939D'),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: TextField(
                                                onChanged: (value) {
                                                  widget.recordTestResultC
                                                      .updateCriteriaremarks(
                                                          remarks: value,
                                                          id: widget
                                                              .recordTestResultC
                                                              .criteriaList[ii]
                                                              .id!);
                                                },
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 3,
                                                minLines: 1,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  hintText: 'Write here',
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: .1)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () async {
                                                  final img = await widget
                                                      .recordTestResultC
                                                      .pickMultiImage();
                                                  setState(() {
                                                    widget
                                                        .recordTestResultC
                                                        .imagefiles[widget
                                                            .recordTestResultC
                                                            .imagefiles
                                                            .indexWhere((element) =>
                                                                element
                                                                    .criteriaId ==
                                                                widget
                                                                    .recordTestResultC
                                                                    .criteriaList[
                                                                        ii]
                                                                    .id!)]
                                                        .images
                                                        .add(img! as File);
                                                  });
                                                },
                                                child: RenderSvg(
                                                    path: 'icon_add_box')),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            KText(
                                              text: 'Evidence',
                                              color: AppTheme.appTextColor1,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: SizedBox(
                                            width: Get.width,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: widget
                                                      .recordTestResultC
                                                      .imagefiles[widget
                                                          .recordTestResultC
                                                          .imagefiles
                                                          .indexWhere((element) =>
                                                              element
                                                                  .criteriaId ==
                                                              widget
                                                                  .recordTestResultC
                                                                  .criteriaList[
                                                                      ii]
                                                                  .id)]
                                                      .images
                                                      .isNotEmpty
                                                  ? SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                          //mainAxisAlignment: MainAxisAlignment.start,
                                                          children: widget
                                                              .recordTestResultC
                                                              .imagefiles[widget
                                                                  .recordTestResultC
                                                                  .imagefiles
                                                                  .indexWhere((element) =>
                                                                      element
                                                                          .criteriaId ==
                                                                      widget
                                                                          .recordTestResultC
                                                                          .criteriaList[
                                                                              ii]
                                                                          .id)]
                                                              .images
                                                              .map(
                                                                (element) =>
                                                                    Container(
                                                                  child:
                                                                      Positioned(
                                                                    top: 0,
                                                                    right: 0,
                                                                    left: 0,
                                                                    bottom: 0,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // changeRequestC.imagefiles
                                                                        //     .remove(element);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            EdgeInsets.all(60),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Global.confirmDialog(
                                                                              onConfirmed: () {
                                                                                setState(() {
                                                                                  widget.recordTestResultC.imagefiles[widget.recordTestResultC.imagefiles.indexWhere((element) => element.criteriaId == widget.recordTestResultC.criteriaList[ii].id)].images.remove(element);
                                                                                });
                                                                                // ignore: list_remove_unrelated_type
                                                                                Get.back();
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.redAccent,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              15),
                                                                  height: 156.2,
                                                                  width: 156.2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: FileImage(element)),

                                                                          //border: Border.all(color: hexToColor('#80939D')),
                                                                          borderRadius: BorderRadius.circular(5.6)),
                                                                ),
                                                              )
                                                              .toList()),
                                                    )
                                                  : Text(''),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : SizedBox(
                              child: KText(text: 'No Data Available'),
                              height: 80,
                            )
                      : SizedBox(
                          child: KText(text: 'No Data Available'),
                          height: 80,
                        )
                  : SizedBox(
                      height: 400,
                      width: Get.width,
                      child: Center(
                        child: KText(text: 'No Criteria Group Selected'),
                      ),
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        // height: 40,
        width: Get.width,
        // margin: EdgeInsets.symmetric(vertical: .5),

        decoration: BoxDecoration(
          color: Colors.white,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                widget.recordTestResultC.testResultSave();
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: hexToColor('#007BEC'),
                ),
                child: Center(
                  child: KText(
                    text: 'Save',
                    color: Colors.white,
                    bold: true,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField({
    required String title,
    required String placeholder,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              KText(
                text: title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: onTap,
                child: RenderSvg(
                  path: 'icon_search_elements',
                  width: 26,
                  color: hexToColor('#66A1D9'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          KText(
            text: placeholder,
            fontSize: 13,
          ),
          Divider(
            color: Colors.black12,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TestNoListDailog extends StatelessWidget with Base {
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
                  text: 'Test No.',
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
              padding: EdgeInsets.only(left: 5, right: 1, top: 5, bottom: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Test No.',
                          fontSize: 14,
                          color: hexToColor('#80939D'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: TextFormField(
                                onChanged: (value) {
                                  // ignore: unrelated_type_equality_checks
                                  recordTestResultC.onChangedTestNo.value =
                                      value;
                                },
                                maxLines: 2,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                recordTestResultC.testSearch(
                                    searchText: recordTestResultC
                                        .onChangedTestNo.value);
                              },
                              child: RenderSvg(path: 'icon_search_elements'),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black45,
                        ),
                        Obx(() => recordTestResultC.testSearchList.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  children: recordTestResultC.testSearchList
                                      .map(
                                        (element) => GestureDetector(
                                          onTap: () async {
                                            recordTestResultC.criteriaGroupList
                                                .clear();
                                            recordTestResultC.criteriaList
                                                .clear();
                                            recordTestResultC.scenarioList
                                                .clear();
                                            recordTestResultC.criteriaGroupList
                                                .clear();
                                            await recordTestResultC
                                                .getCriteriaGroupList(
                                                    recordTestResultC
                                                        .selectedTestType
                                                        .value!
                                                        .id!);

                                            recordTestResultC.selectedTestItem
                                                .value = element;

                                            await recordTestResultC
                                                .getCriteriaList(
                                                    element.testTypeId!);

                                            await recordTestResultC
                                                .getScenarioList(
                                                    element.testTypeId!);
                                            Get.back();
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: element.testTypeCode,
                                                    maxLines: 2,
                                                    fontSize: 11,
                                                  ),
                                                  KText(
                                                    text: element.testDate,
                                                    maxLines: 2,
                                                    fontSize: 11,
                                                  ),
                                                  KText(
                                                    text: element.testTypeName,
                                                    maxLines: 2,
                                                    fontSize: 11,
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.black45,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            : Center(
                                child: Text('No Test Selected'),
                              )),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
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
                                  color: hexToColor('#449EF1'),
                                ),
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
                              },
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: hexToColor('#449EF1')),
                                child: Center(
                                    child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return TestNoAddDailog();
                                      },
                                    );
                                  },
                                  color: Colors.green,
                                )),
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
class TestNoAddDailog extends StatelessWidget with Base {
  // ignore: prefer_final_fields
  TextEditingController _textEditingController = TextEditingController();
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
                  border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
                ),
                child: KText(
                  text: 'Test No.',
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
              padding: EdgeInsets.only(left: 5, right: 1, top: 5, bottom: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Create New Test No.',
                          fontSize: 15,
                          bold: true,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        KText(
                                          text: 'Test No.',
                                          color: hexToColor('#80939D'),
                                          fontSize: 13,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                      ],
                                    ),
                                    KText(
                                      text: 'AUTO',
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: KText(
                                text: '',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        KText(
                                          text: 'Date',
                                          color: hexToColor('#80939D'),
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () async {
                                          await recordTestResultC.selectDate();
                                        },
                                        child: KText(
                                          text: recordTestResultC
                                                      .selectedDate.value !=
                                                  ''
                                              ? recordTestResultC
                                                  .selectedDate.value
                                              : DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(DateTime.now()
                                                      .toString())),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Description',
                                color: hexToColor('#80939D'),
                              ),
                              SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: _textEditingController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 1,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Write here',
                                    contentPadding: EdgeInsets.all(5),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: .1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      recordTestResultC.testAdd(
                                          testDescription:
                                              _textEditingController.text);
                                      // back();
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 34,
                                        width: 116,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: hexToColor('#449EF1'),
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
                                  GestureDetector(
                                    onTap: () {
                                      back();
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 34,
                                        width: 116,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.grey,
                                        ),
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
          ],
        ),
      ),
    );
  }
}
