import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/widgets/title_bar.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';

import '../controllers/location_controller.dart';
import '../helpers/global_helper.dart';
import '../models/change_request_model.dart';

class EditChangeRequestPage extends StatefulWidget {
  final ChangeRequest item;
  final locationC = Get.put(LocationController());
  EditChangeRequestPage({super.key, required this.item});

  @override
  State<EditChangeRequestPage> createState() => _EditChangeRequestPageState();
}

class _EditChangeRequestPageState extends State<EditChangeRequestPage>
    with Base {
  @override
  void dispose() {
    changeRequestC.priority.value = 'Low';
    changeRequestC.priorityCode.value = '4';
    changeRequestC.imagefiles.clear();
    changeRequestC.isStatus.value = '';
    changeRequestC.isCheckstatus.value = false;
    changeRequestC.isStatusValue.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeRequestC.getFileCount(widget.item.id!);
    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    changeRequestC.priority.value = widget.item.priority!;
    return Scaffold(
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
                print('nb');
                changeRequestC.editChangeRequest(item: widget.item);
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
                    text: 'Save ',
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
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              CenterTitleBar(title: 'Edit Change Request', percentange: 0.18),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(05),
                    decoration: BoxDecoration(
                      color: hexToColor('#EEF0F6'),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            KText(
                              color: hexToColor('#8E9CA4'),
                              textOverflow: TextOverflow.visible,
                              text: 'Project: ',
                              fontSize: 15,
                            ),
                            KText(
                              color: hexToColor('#41525A'),
                              textOverflow: TextOverflow.visible,
                              text: widget.item.projectName != null
                                  ? '${widget.item.projectName}'
                                  : '',
                              fontSize: 15,
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            KText(
                              color: hexToColor('#8E9CA4'),
                              textOverflow: TextOverflow.visible,
                              text: 'Requested By: ',
                              fontSize: 15,
                            ),
                            KText(
                              color: hexToColor('#41525A'),
                              textOverflow: TextOverflow.visible,
                              text: widget.item.requesterFullname != null
                                  ? '${widget.item.requesterFullname}'
                                  : '',
                              fontSize: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              margin: EdgeInsets.only(
                                right: 5,
                              ),
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
                                    color: Color(0xffF5F5FA),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 33,
                                width: 33,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=23.90560,93.094535&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=zia&appCode=KYC&fileCategory=photo&countryCode=BD',
                                      fit: BoxFit.cover,
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
                ]),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      color: hexToColor('#80939D'),
                      textOverflow: TextOverflow.visible,
                      text: 'CR Number #',
                      fontSize: 13,
                    ),
                    KText(
                      color: hexToColor('#80939D'),
                      textOverflow: TextOverflow.visible,
                      text: 'Requested Date',
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    KText(
                      text: widget.item.requestRefno != null
                          ? '${widget.item.requestRefno}'
                          : '',
                      fontSize: 15,
                      color: hexToColor('#515D64'),
                    ),
                    Spacer(),
                    if (widget.item.requestedOn != null)
                      Container(
                        alignment: Alignment.centerRight,
                        width: Get.width * .4,
                        child: KText(
                          bold: true,
                          color: hexToColor('#80939D'),
                          textOverflow: TextOverflow.visible,
                          text: formatDate(date: widget.item.requestedOn!),
                          fontSize: 15,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * .4,
                      child: Divider(
                        height: 5,
                        thickness: 2,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: Get.width * .4,
                      child: Divider(
                        height: 5,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: KText(
                        bold: true,
                        fontSize: 13,
                        text: 'Request Title',
                        color: hexToColor('#80939D'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue:
                            //  item.requestTitle != null
                            //     ? ''
                            //     :
                            '${widget.item.requestTitle}',
                        onChanged: changeRequestC.requestTitle,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          // hintText: item.requestTitle != null
                          //     ? '${item.requestTitle}'
                          //     : '',
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    searchField(
                      title: 'Geography',
                      placeholder: changeRequestC.selectedGeograpphy.value !=
                              null
                          ? '${changeRequestC.selectedGeograpphy.value!.geoLevel1Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel2Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel3Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel4Name}'
                          : '${widget.item.geoLevel1Name} > ${widget.item.geoLevel2Name} > ${widget.item.geoLevel3Name} > ${widget.item.geoLevel4Name}',
                      onTap: () {
                        changeRequestC.searchLocationBottomSheet();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                left: 5,
                                right: 5,
                              ),
                              child: Obx(
                                () => Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Radio<String>(
                                            visualDensity: VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value:
                                                changeRequestC.priority.value,
                                            onChanged: (v) {
                                              changeRequestC.priority.value =
                                                  'Low';
                                              changeRequestC
                                                  .priorityCode.value = '4';
                                            },
                                            groupValue: 'Low',
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              changeRequestC.priority.value =
                                                  'Low';
                                            },
                                            child: KText(
                                              text: 'Low',
                                              color: AppTheme.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Radio<String>(
                                            visualDensity: VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value:
                                                changeRequestC.priority.value,
                                            onChanged: (v) {
                                              changeRequestC.priority.value =
                                                  'Medium';
                                              changeRequestC
                                                  .priorityCode.value = '3';
                                            },
                                            groupValue: 'Medium',
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              changeRequestC.priority.value =
                                                  'Medium';
                                            },
                                            child: KText(
                                              text: 'Medium',
                                              color: AppTheme.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Radio<String>(
                                            visualDensity: VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value:
                                                changeRequestC.priority.value,
                                            onChanged: (v) {
                                              changeRequestC.priority.value =
                                                  'High';
                                              changeRequestC
                                                  .priorityCode.value = '2';
                                            },
                                            groupValue: 'High',
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              changeRequestC.priority.value =
                                                  'High';
                                            },
                                            child: KText(
                                              text: 'High',
                                              color: AppTheme.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Radio<String>(
                                            visualDensity: VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value:
                                                changeRequestC.priority.value,
                                            onChanged: (v) {
                                              changeRequestC.priority.value =
                                                  'Mandatory';
                                              changeRequestC
                                                  .priorityCode.value = '1';
                                            },
                                            groupValue: 'Mandatory',
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              changeRequestC.priority.value =
                                                  'Mandatory';
                                            },
                                            child: KText(
                                              text: 'Mandatory',
                                              color: AppTheme.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: -12,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              child: Row(
                                children: [
                                  KText(
                                    text: 'Priority ',
                                    fontSize: 13,
                                  ),
                                  KText(
                                    text: '*',
                                    fontSize: 13,
                                    color: Colors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    KText(
                      bold: true,
                      fontSize: 13,
                      text: 'Impact',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.item.changeImpact != null
                            ? '${widget.item.changeImpact}'
                            : '',
                        onChanged: changeRequestC.changeImpact,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          // hintText: item.requestTitle != null
                          //     ? '${item.requestTitle}'
                          //     : '',
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    KText(
                      bold: true,
                      fontSize: 13,
                      text: 'Reason of Change',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.item.changeReason != null
                            ? '${widget.item.changeReason}'
                            : '',
                        onChanged: changeRequestC.changeReason,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    KText(
                      bold: true,
                      fontSize: 13,
                      text: 'Change Description',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.item.changeDescription != null
                            ? '${widget.item.changeDescription}'
                            : '',
                        onChanged: changeRequestC.changeDescription,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    KText(
                      bold: true,
                      fontSize: 13,
                      text: 'Assumptions and Notes',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.item.assumptions != null
                            ? '${widget.item.assumptions}'
                            : '',
                        onChanged: changeRequestC.assumptions,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.item.status == 'Draft' ||
                        widget.item.status == 'Rejected')
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Checkbox(
                              value: changeRequestC.isCheckstatus.value,
                              onChanged: (bool? value) {
                                changeRequestC.isCheckstatus.toggle();
                                if (value == true) {
                                  changeRequestC.isStatus.value = 'Submitted';
                                  changeRequestC.isStatusValue.value = '01';
                                } else {
                                  changeRequestC.isStatus.value = 'Draft';
                                  changeRequestC.isStatusValue.value = '00';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          KText(
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                              text: 'Send for Approved'),
                        ],
                      ),

                    changeRequestC.imageCount.value != 0
                        ? SizedBox(
                            height: 200,
                            width: Get.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: changeRequestC.imageCount.value,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Image.network(
                                      '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=$latLng&username=zia&fileCategory=FILE_CATEGORY_CHANGE_REQUEST&projectId=${widget.item.projectId}&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${widget.item.id}&originalFileNameNeeded=&registrationNo=&status=&flag=${index + 1}'),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: KText(
                              text: 'No Image',
                              fontSize: 15,
                            ),
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                changeRequestC.pickMultiImage();
                              },
                              child: RenderSvg(path: 'icon_add_box')),
                          SizedBox(
                            width: 05,
                          ),
                          KText(
                            text: 'Attachments',
                            fontSize: 13,
                            color: hexToColor('#80939D'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),

                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          changeRequestC.imagefiles.isEmpty
                              ? SizedBox()
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: changeRequestC.imagefiles.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item =
                                        changeRequestC.imagefiles[index];
                                    return Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.file(
                                              File(item.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          left: 0,
                                          bottom: 0,
                                          child: InkWell(
                                            onTap: () {
                                              // changeRequestC.imagefiles
                                              //     .removeAt(index);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(60),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Global.confirmDialog(
                                                    onConfirmed: () {
                                                      changeRequestC.imagefiles
                                                          .removeAt(index);
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),

                    // Obx(
                    //   () => Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //     child: SizedBox(
                    //       width: Get.width,
                    //       child: SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: Row(
                    //             //mainAxisAlignment: MainAxisAlignment.start,
                    //             children: changeRequestC.imagefiles
                    //                 .map(
                    //                   (element) => Container(
                    //                     child: Positioned(
                    //                       top: 0,
                    //                       right: 0,
                    //                       left: 0,
                    //                       bottom: 0,
                    //                       child: InkWell(
                    //                         onTap: () {
                    //                           changeRequestC.imagefiles
                    //                               .remove(element);
                    //                         },
                    //                         child: Container(
                    //                           margin: EdgeInsets.all(60),
                    //                           decoration: BoxDecoration(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(50),
                    //                             color: Colors.white
                    //                                 .withOpacity(0.5),
                    //                           ),
                    //                           child: InkWell(
                    //                             onTap: () {
                    //                               Global.confirmDialog(
                    //                                 onConfirmed: () {
                    //                                   changeRequestC.imagefiles
                    //                                       .remove(element);
                    //                                   Get.back();
                    //                                 },
                    //                               );
                    //                             },
                    //                             child: Icon(
                    //                               Icons.delete,
                    //                               color: Colors.redAccent,
                    //                               size: 30,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     margin: EdgeInsets.only(right: 15),
                    //                     height: 156.2,
                    //                     width: 156.2,
                    //                     decoration: BoxDecoration(
                    //                         image: DecorationImage(
                    //                             fit: BoxFit.cover,
                    //                             image: FileImage(element)),

                    //                         //border: Border.all(color: hexToColor('#80939D')),
                    //                         borderRadius:
                    //                             BorderRadius.circular(5.6)),
                    //                   ),
                    //                 )
                    //                 .toList()),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 15,
                    )
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

Widget searchField({
  required String title,
  required String placeholder,
  void Function()? onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0),
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
          fontSize: 15,
          maxLines: 5,
          color: hexToColor('#41525A'),
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
