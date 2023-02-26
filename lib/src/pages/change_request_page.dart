import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:workforce/src/components/k_appbar.dart';

import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/widgets/title_bar.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../controllers/location_controller.dart';

import '../models/change_request_model.dart';

class ChangeRequestPage extends StatelessWidget with Base {
  final ChangeRequest item;
  // ignore: annotate_overrides, overridden_fields
  final locationC = Get.put(LocationController());

  ChangeRequestPage({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    changeRequestC.getFileCount(item.id!);
    // changeRequestC.getImageChangeRequest(item.id!);

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CenterTitleBar(title: 'Change Request', percentange: 0.18),
              // RichText(
              //   selectionColor: Colors.amber,
              //   text: TextSpan(
              //       text: 'stream up\n',
              //       style: TextStyle(
              //         fontSize: 18,
              //         color: hexToColor('#41525A'),
              //       ),
              //       children: [TextSpan(text: 'check out your favourite')]),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: KText(
                    fontSize: 18,
                    maxLines: 3,
                    text: item.requestTitle != null
                        ? '${item.requestTitle}'
                        : ''),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: item.status == 'Approved'
                        ? hexToColor('#CAFDF0')
                        : item.status == 'Draft'
                            ? hexToColor('#84BEF3')
                            : hexToColor('#84BEF3'),
                  ),
                  height: 22,
                  child: Center(
                    child: KText(
                      text: item.status,
                      fontSize: 15,

                      //  bold: true,
                      color: item.status == 'Approved'
                          ? hexToColor('#09C594')
                          : item.status == 'Draft'
                              ? hexToColor('#000000')
                              : hexToColor('#000000'),
                    ),
                  ),
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
                    KText(
                      bold: true,
                      fontSize: 13,
                      text: 'Request Title',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      fontSize: 15,
                      maxLines: 3,
                      text:
                          item.projectName != null ? '${item.projectName}' : '',
                      color: hexToColor('#515D64'),
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Requested By',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          fontSize: 15,
                          text: item.requesterFullname != null
                              ? '${item.requesterFullname}'
                              : '',
                          bold: true,
                          color: hexToColor('#636363'),
                        ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'CR Number#',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          fontSize: 15,
                          text: item.requestRefno != null
                              ? '${item.requestRefno}'
                              : '',
                          bold: true,
                          color: hexToColor('#636363'),
                        ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          fontSize: 13,
                          text: 'Request Date',
                          color: hexToColor('#80939D'),
                        ),
                        if (item.requestedOn != null)
                          KText(
                            fontSize: 15,
                            text: formatDate(date: item.requestedOn!),
                            bold: true,
                            color: hexToColor('#636363'),
                          ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Priority',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          fontSize: 15,
                          text: item.priority != null ? '${item.priority}' : '',
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
                        ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text: 'Geography',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      text:
                          '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name} ',
                      fontSize: 15,
                      maxLines: 5,
                      color: hexToColor('#636363'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text: 'Impact',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      text: item.changeImpact != null
                          ? '${item.changeImpact}'
                          : '',
                      fontSize: 15,
                      maxLines: 5,
                      color: hexToColor('#636363'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text: 'Reason of Change',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      text: item.changeReason != null
                          ? '${item.changeReason}'
                          : '',
                      fontSize: 15,
                      maxLines: 5,
                      color: hexToColor('#636363'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text: 'Change Description',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      text: item.changeReason != null
                          ? '${item.changeDescription}'
                          : '',
                      fontSize: 15,
                      maxLines: 5,
                      color: hexToColor('#636363'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text: 'Assumptions and Notes',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      bold: true,
                      text:
                          item.assumptions != null ? '${item.assumptions}' : '',
                      fontSize: 15,
                      maxLines: 5,
                      color: hexToColor('#636363'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: hexToColor('#EEF0F7'),
                      thickness: 1,
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
                                      '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=$latLng&username=zia&fileCategory=FILE_CATEGORY_CHANGE_REQUEST&projectId=${item.projectId}&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item.id}&originalFileNameNeeded=&registrationNo=&status=&flag=${index + 1}'),
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
