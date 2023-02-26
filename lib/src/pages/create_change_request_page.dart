import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/loading.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class CreateChangeRequestPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    changeRequestC.requestTitle.value = '';
    changeRequestC.assumptions.value = '';
    changeRequestC.changeImpact.value = '';
    changeRequestC.changeDescription.value = '';
    changeRequestC.assumptions.value = '';
    return WillPopScope(
      onWillPop: () {
        changeRequestC.imagefiles.clear();

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
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 12, top: 3, bottom: 3),
                  height: 50,
                  width: Get.width,
                  // margin: EdgeInsets.symmetric(vertical: .5),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 2, color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          back();
                          changeRequestC.imagefiles.clear();
                        },
                      ),
                      Center(
                        child: KText(
                          text: 'Create Change Request',
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
                  height: 50,
                  width: Get.width,
                  color: hexToColor('#EBEBEC'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Transport Order',
                              fontSize: 12,
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: '(Auto)',
                              bold: true,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 12,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Date',
                              fontSize: 14,
                            ),
                            KText(
                              text: formatDate(date: DateTime.now().toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Request Title',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: changeRequestC.requestTitle.value == ''
                              ? ''
                              : changeRequestC.requestTitle.value,
                          onChanged: changeRequestC.requestTitle,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: searchField(
                    title: 'Geography',
                    placeholder: changeRequestC.selectedGeograpphy.value != null
                        ? '${changeRequestC.selectedGeograpphy.value!.geoLevel1Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel2Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel3Name} > ${changeRequestC.selectedGeograpphy.value!.geoLevel4Name}'
                        : '',
                    onTap: () {
                      changeRequestC.searchLocationBottomSheet();
                    },
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 5,
                            right: 5,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Radio<String>(
                                      visualDensity: VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: changeRequestC.priority.value,
                                      onChanged: (v) {
                                        changeRequestC.priority.value = 'Low';
                                        changeRequestC.priorityCode.value = '4';
                                      },
                                      groupValue: 'Low',
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        changeRequestC.priority.value = 'Low';
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
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: changeRequestC.priority.value,
                                      onChanged: (v) {
                                        changeRequestC.priority.value =
                                            'Medium';
                                        changeRequestC.priorityCode.value = '3';
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
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: changeRequestC.priority.value,
                                      onChanged: (v) {
                                        changeRequestC.priority.value = 'High';
                                        changeRequestC.priorityCode.value = '2';
                                      },
                                      groupValue: 'High',
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        changeRequestC.priority.value = 'High';
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
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: changeRequestC.priority.value,
                                      onChanged: (v) {
                                        changeRequestC.priority.value =
                                            'Mandatory';
                                        changeRequestC.priorityCode.value = '1';
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Impact',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: changeRequestC.changeImpact.value == ''
                              ? ''
                              : changeRequestC.changeImpact.value,
                          onChanged: changeRequestC.changeImpact,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Reason of Change',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: changeRequestC.changeReason.value == ''
                              ? ''
                              : changeRequestC.changeReason.value,
                          onChanged: changeRequestC.changeReason,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Change Description',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue:
                              changeRequestC.changeDescription.value == ''
                                  ? ''
                                  : changeRequestC.changeDescription.value,
                          onChanged: changeRequestC.changeDescription,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Assumptions and Notes',
                        color: hexToColor('#80939D'),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: changeRequestC.assumptions.value == ''
                              ? ''
                              : changeRequestC.assumptions.value,
                          onChanged: changeRequestC.assumptions,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Write here...',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            changeRequestC.pickMultiImage();
                          },
                          child: RenderSvg(path: 'icon_add_box')),
                      SizedBox(
                        width: 5,
                      ),
                      KText(
                        text: 'Attachments',
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
                              itemBuilder: (BuildContext context, int index) {
                                final item = changeRequestC.imagefiles[index];
                                return Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
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
                                            color:
                                                Colors.white.withOpacity(0.5),
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

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child: ListView(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       Row(
                //           //mainAxisAlignment: MainAxisAlignment.start,
                //           children: changeRequestC.imagefiles
                //               .map(
                //                 (element) => Container(
                //                   child: Positioned(
                //                     top: 0,
                //                     right: 0,
                //                     left: 0,
                //                     bottom: 0,
                //                     child: InkWell(
                //                       onTap: () {
                //                         changeRequestC.imagefiles.remove(element);
                //                       },
                //                       child: Container(
                //                         margin: EdgeInsets.all(60),
                //                         decoration: BoxDecoration(
                //                           borderRadius: BorderRadius.circular(50),
                //                           color: Colors.white.withOpacity(0.5),
                //                         ),
                //                         child: InkWell(
                //                           onTap: () {
                //                             Global.confirmDialog(
                //                               onConfirmed: () {
                //                                 changeRequestC.imagefiles
                //                                     .remove(element);
                //                                 Get.back();
                //                               },
                //                             );
                //                           },
                //                           child: Icon(
                //                             Icons.delete,
                //                             color: Colors.redAccent,
                //                             size: 30,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   margin: EdgeInsets.only(right: 15),
                //                   height: 156.2,
                //                   width: 156.2,
                //                   decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                           fit: BoxFit.cover,
                //                           image: FileImage(element)),

                //                       //border: Border.all(color: hexToColor('#80939D')),
                //                       borderRadius: BorderRadius.circular(5.6)),
                //                 ),
                //               )
                //               .toList()),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
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
                  onTap: changeRequestC.selectedGeograpphy.value != null
                      ? () {
                          changeRequestC.createChangeRequest();
                        }
                      : null,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: changeRequestC.selectedGeograpphy.value != null
                          ? hexToColor('#007BEC')
                          : hexToColor('#007BEC').withOpacity(.5),
                    ),
                    child: Center(
                      child: changeRequestC.isLoading.value
                          ? Loading(
                              color: Colors.white,
                            )
                          : KText(
                              text: 'Submit',
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
