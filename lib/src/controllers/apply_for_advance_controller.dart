import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/dialogHelper.dart';
import 'package:workforce/src/helpers/get_file_name.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/image_compress.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/apply_for_loan.dart';
import 'package:workforce/src/models/history_image_count_model.dart';
import 'package:workforce/src/models/travel_request_workbench.dart';
import 'package:workforce/src/pages/advance_application_workbench_page.dart';

import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/widgets/custom_textfield_with_dropdown.dart';

import '../helpers/log.dart';

class ApplyForAdvanceController extends GetxController with ApiService {
  final advanceDetails = Rx<ApplyForLoan?>(null);
  final advanceList = RxList<ApplyForLoan?>([]);
  final advanceAddList = RxList<ApplyForLoan?>([]);
  final tRList = RxList<TravelRequestWorkbench?>([]);
  final isLoading = RxBool(false);
  final advanceTypes = RxList([
    'Travel',
    'Office Program',
    'Others',
  ]);
  final isLoadding = RxBool(false);
  final refNo = RxString('');
  final trDate = RxString('');
  final trCost = RxNum(0);
  final tRType = RxString('');
  final search = RxString('');
  final purpose = RxString('');
  final amount = RxString('');
  final selectedAdvanceType = RxString('Travel');
  final selectedDate = RxString('');
  //date picker
  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      selectedDate.value = formatDate(date: pickedDate.toString());
    } else {}
  }

  //Evidence
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  //-------------------------------------

  final evedenceImageCount = RxList<HistoryImageModel>();
  final evedenceImages = RxList<AllImagesModel>();
  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imagePicker.pickImage(source: ImageSource.camera);

      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);

        // Image compress function
        final img = await compressFile(file: pickedImage.value);

        // kLog('image size ...............');
        // kLog(img.readAsBytesSync().lengthInBytes / 1024);

        // Load compress image
        pickedImage.value = img;
        imagefiles.add(pickedImage.value!);
        // kLog(imagefiles.length);
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  advanceGet(String? id) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'category': 'ADVANCE',
        if (id != '') 'ids': [id]
      };
      // kLog(id);
      // kLog(body);

      final res = await postDynamic(path: ApiEndpoint.loanGetUrl(), body: body, authentication: true);

      final advanceListData = res.data['data']
          .map((json) => ApplyForLoan.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<ApplyForLoan>() as List<ApplyForLoan>;
      // kLog(res.data);
      // kLog(advanceListData);
      isLoading.value = false;
      if (advanceListData.isNotEmpty) {
        if (id == '') {
          isLoading.value = false;
          advanceList.clear();
          advanceList.addAll(advanceListData);
        }
        if (id != '') {
          isLoading.value = false;
          advanceDetails.value = null;
          advanceDetails.value = advanceListData.first;
        }
      }
      //  isLoading.value = false;
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  void advanceAdd(String? type) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SHOUT',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'actionType': 'work',
        'modelList': type == 'edit'
            ? advanceAddList.map((item) {
                return {
                  'id': item!.id,
                  'agencyId': item.agencyId,
                  'agencyCode': item.agencyCode,
                  'agencyName': item.agencyName,
                  'fullname': item.fullname,
                  'username': item.username,
                  'email': item.email,
                  'mobile': item.mobile,
                  'category': item.category,
                  'transactionType': selectedAdvanceType.value,
                  'applicationRefno': item.applicationRefno,
                  'applicationDate': item.applicationDate,
                  'description': item.description,
                  'createdAt': item.createdAt,
                  'lastEditedAt': item.lastEditedAt,
                  'amount': item.amount,
                  'currcy': item.currcy,
                  'interestRate': item.interestRate,
                  'interest': item.interest,
                  'intCalcMethod': item.intCalcMethod,
                  'installment': item.installment,
                  'isDisbursed': true,
                  'disbursementDate': item.disbursementDate,
                  'disbursementMethod': item.disbursementMethod,
                  'disbursementRefno': item.disbursementRefno,
                  'disbursementRemarks': item.disbursementRemarks,
                  'dedStartDate': item.dedStartDate,
                  'dedStartMon': item.dedStartMon,
                  'attachmentCount': item.attachmentCount,
                  'statusCode': item.statusCode,
                  'status': item.status,
                  'approverCount': item.approverCount,
                  'approver1Passed': item.approver1Passed,
                  'approvedby1Fullname': item.approvedby1Fullname,
                  'approvedby1Username': item.approvedby1Username,
                  'approvedby1Email': item.approvedby1Email,
                  'approvedby1Mobile': item.approvedby1Mobile,
                  'approved1On': item.approved1On,
                  'approvedby1Remarks': item.approvedby1Remarks,
                  'approver2Passed': item.approver2Passed,
                  'approvedby2Fullname': item.approvedby2Fullname,
                  'approvedby2Username': item.approvedby2Username,
                  'approvedby2Email': item.approvedby2Email,
                  'approvedby2Mobile': item.approvedby2Mobile,
                  'approved2On': item.approved2On,
                  'approvedby2Remarks': item.approvedby2Remarks,
                  'approver3Passed': item.approver3Passed,
                  'approvedby3Fullname': item.approvedby3Fullname,
                  'approvedby3Username': item.approvedby3Username,
                  'approvedby3Email': item.approvedby3Email,
                  'approvedby3Mobile': item.approvedby3Mobile,
                  'approved3On': item.approved3On,
                  'approvedby3Remarks': item.approvedby3Remarks
                };
              }).toList()
            : [
                {
                  'agencyId': selectedAgency.agencyId,
                  'agencyCode': selectedAgency.agencyCode,
                  'agencyName': selectedAgency.agencyName,
                  'category': 'ADVANCE',
                  'transactionType': selectedAdvanceType.value,
                  'applicationRefno': '',
                  'applicationDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  'description': purpose.value,
                  'createdAt': '',
                  'lastEditedAt': '',
                  'amount': amount.value,
                  'currcy': '',
                  'interestRate': '',
                  'interest': '',
                  'intCalcMethod': '',
                  'installment': '',
                  'isDisbursed': true,
                  'disbursementDate': '',
                  'disbursementMethod': '',
                  'disbursementRefno': '',
                  'disbursementRemarks': '',
                  'dedStartDate': '',
                  'dedStartMon': '',
                  'attachmentCount': '',
                  'statusCode': '',
                  'status': '',
                  'approverCount': '',
                  'approver1Passed': '',
                  'approvedby1Fullname': '',
                  'approvedby1Username': '',
                  'approvedby1Email': '',
                  'approvedby1Mobile': '',
                  'approved1On': '',
                  'approvedby1Remarks': '',
                  'approver2Passed': true,
                  'approvedby2Fullname': '',
                  'approvedby2Username': '',
                  'approvedby2Email': '',
                  'approvedby2Mobile': '',
                  'approved2On': '',
                  'approvedby2Remarks': '',
                  'approver3Passed': true,
                  'approvedby3Fullname': '',
                  'approvedby3Username': '',
                  'approvedby3Email': '',
                  'approvedby3Mobile': '',
                  'approved3On': '',
                  'approvedby3Remarks': ''
                }
              ]
      };

      // kLog(body);

      final res = await postDynamic(
        path: ApiEndpoint.loanAddUrl(),
        body: body,
      );
      // kLog(res.data);
      if (res.data['status'] != null && res.data['status'].contains('successful') == true) {
        // kLog('value');
        // kLog(res.data['data']['applicationRefno']);
        if (imagefiles.isNotEmpty) {
          postEvidenceAttachment(refNo: '${res.data['data']['applicationRefno']}');
        }

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            Get.offAll(AdvanceApplicationWorkbenchPage());
          },
        );
      } else {
        //  issubmit.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            //modelList.clear();
            back();
          },
        );
      }
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  postEvidenceAttachment({String? refNo}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      //   isLoading.value = true;
      final username = Get.put(UserController()).username;

      List<MultipartFile> attachments = [];
      for (var img in imagefiles) {
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_ADVANCE',
          'ids': refNo,
          'files': attachments,
        },
      );
      // ignore: unused_local_variable
      final res = await postDynamic(
        path: ApiEndpoint.siteEvedenseSave(),
        body: data,
      );
      // kLog(res.data);
      imagefiles.clear();
      //isLoading.value = false;
    } on DioError catch (e) {
      // isLoading.value = false;
      print(e.message);
    }
  }

  advanceDetailsModal(String? id) async {
    await advanceGet(id);
    await getFileCount(refNo: advanceDetails.value!.applicationRefno);
    await Get.dialog(
      useSafeArea: true,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            child: Obx(
              () => advanceDetails.value == null
                  ? KText(
                      text: 'No Data Found',
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Ref. No.',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(
                              text: ' Date',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: advanceDetails.value!.applicationRefno,
                            ),
                            KText(
                              text: advanceDetails.value!.applicationDate != null
                                  ? formatDate(date: advanceDetails.value!.applicationDate!)
                                  : '',
                            ),
                          ],
                        ),
                        Divider(),
                        KText(
                          text: 'Type',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                        KText(text: advanceDetails.value!.transactionType),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: KText(
                            text: 'Purpose',
                            color: hexToColor('#80939D'),
                            fontSize: 16,
                          ),
                        ),
                        KText(
                          text: advanceDetails.value!.description,
                          maxLines: 3,
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: KText(
                            text: 'Amount (BDT)',
                            color: hexToColor('#80939D'),
                            fontSize: 16,
                          ),
                        ),
                        KText(text: advanceDetails.value!.amount.toString()),
                        Divider(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.only(top: 25, bottom: 20),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: hexToColor('#EEF0F6')),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Ref. No.',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: 'S2SD82001'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    KText(
                                      text: 'Type',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: 'By Air'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Date',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: '12 Dec 2022'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    KText(
                                      text: 'Estimated Cost (BDT)',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: '20,000.00'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              top: 12,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                child: KText(
                                  text: 'Approved TR',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                              ))
                        ]),
                        KText(
                          text: 'Attachments',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: 80,
                          width: Get.width * .8,
                          child: Obx(() => fileCount.value == ''
                                  ? Container(
                                      alignment: Alignment.center, width: Get.width * .8, height: 20, child: Text('No Image Found'))
                                  : fileCount.value == '0'
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: Get.width * .8,
                                          height: 20,
                                          child: Text('No Image Found'))
                                      : ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: evedenceImages[evedenceImages
                                                  .indexWhere((e) => e.progressId == advanceDetails.value!.applicationRefno)]
                                              .images
                                              .map((e) => GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                        barrierDismissible: false,
                                                        // backgroundColor: Colors.transparent,
                                                        // contentPadding: EdgeInsets.zero,
                                                        // content:
                                                        Column(
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
                                                              child: PhotoView(
                                                                  backgroundDecoration:
                                                                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                  imageProvider: NetworkImage(e)),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
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
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                hexToColor('#FFA133'),
                              ),
                              visualDensity: VisualDensity(horizontal: 2),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            onPressed: () {
                              back();
                            },
                            child: KText(
                              text: 'Close',
                              fontSize: 16.0,
                              bold: true,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  advanceDetailsViewModal(String? id) async {
    await advanceGet(id);
    await getFileCount(refNo: advanceDetails.value!.applicationRefno);
    await Get.dialog(
      useSafeArea: true,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.center,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            child: Obx(
              () => advanceDetails.value == null
                  ? KText(
                      text: 'No Data Found',
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Ref. No.',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(
                              text: ' Date',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: advanceDetails.value!.applicationRefno,
                            ),
                            KText(
                              text: advanceDetails.value!.applicationDate != null
                                  ? formatDate(date: advanceDetails.value!.applicationDate!)
                                  : '',
                            ),
                          ],
                        ),
                        Divider(),
                        KText(
                          text: 'Type',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                        KText(text: advanceDetails.value!.transactionType),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: KText(
                            text: 'Purpose',
                            color: hexToColor('#80939D'),
                            fontSize: 16,
                          ),
                        ),
                        KText(
                          text: advanceDetails.value!.description,
                          maxLines: 3,
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: KText(
                            text: 'Amount (BDT)',
                            color: hexToColor('#80939D'),
                            fontSize: 16,
                          ),
                        ),
                        KText(text: advanceDetails.value!.amount.toString()),
                        Divider(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.only(top: 25, bottom: 20),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: hexToColor('#EEF0F6')),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Ref. No.',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: 'S2SD82001'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    KText(
                                      text: 'Type',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: 'By Air'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Date',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: '12 Dec 2022'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    KText(
                                      text: 'Estimated Cost (BDT)',
                                      color: hexToColor('#80939D'),
                                      fontSize: 16,
                                    ),
                                    KText(text: '20,000.00'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              top: 12,
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                child: KText(
                                  text: 'Approved TR',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                              ))
                        ]),
                        KText(
                          text: 'Attachments',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: 80,
                          width: Get.width * .8,
                          child: Obx(() => fileCount.value == ''
                                  ? Container(
                                      alignment: Alignment.center, width: Get.width * .8, height: 20, child: Text('No Image Found'))
                                  : fileCount.value == '0'
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: Get.width * .8,
                                          height: 20,
                                          child: Text('No Image Found'))
                                      : ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: evedenceImages[evedenceImages
                                                  .indexWhere((e) => e.progressId == advanceDetails.value!.applicationRefno)]
                                              .images
                                              .map((e) => GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                        barrierDismissible: false,
                                                        // backgroundColor: Colors.transparent,
                                                        // contentPadding: EdgeInsets.zero,
                                                        // content:
                                                        Column(
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
                                                              child: PhotoView(
                                                                  backgroundDecoration:
                                                                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                                  imageProvider: NetworkImage(e)),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                      child: Container(
                                                        height: 45,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
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
                        ),
                        Center(
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    hexToColor('#FFA133'),
                                  ),
                                  visualDensity: VisualDensity(horizontal: 2),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  back();
                                },
                                child: KText(
                                  text: 'Close',
                                  fontSize: 16.0,
                                  bold: true,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      // hexToColor('#007BEC'),
                                      hexToColor('#007BEC')),
                                  visualDensity: VisualDensity(horizontal: 2),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  advanceDetailsEditModal(id);
                                  // loanC.loanAddList.add(item)
                                  // loanC.loanAdd('add');
                                  //  push(ApplyForLoanPage());
                                },
                                child: KText(
                                  text: 'Edit',
                                  fontSize: 16.0,
                                  bold: true,
                                  color: Colors.white,
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
    );
  }

  advanceDetailsEditModal(String? id) async {
    await advanceGet(id);
    await getFileCount(refNo: advanceDetails.value!.applicationRefno);
    await Get.dialog(
        useSafeArea: true,
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            height: 600,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.center,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Ref. No.',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                        KText(
                          text: ' Date',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: advanceDetails.value!.applicationRefno,
                        ),
                        KText(
                          text: advanceDetails.value!.applicationDate != null
                              ? formatDate(date: advanceDetails.value!.applicationDate!)
                              : '',
                        ),
                      ],
                    ),
                    Divider(),
                    KText(
                      text: 'Type',
                      color: hexToColor('#80939D'),
                      fontSize: 16,
                    ),
                    CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: selectedAdvanceType.value,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: advanceTypes.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              selectedAdvanceType.value = item;
                            },
                            value: item,
                            child: SizedBox(
                              width: Get.width * .8,
                              child: KText(
                                text: item,
                                fontSize: 13,
                                maxLines: 2,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (item) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: KText(
                        text: 'Purpose',
                        color: hexToColor('#80939D'),
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      initialValue: advanceDetails.value!.description != null ? advanceDetails.value!.description : '',
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          updateValues(
                            purpose: value,
                            amount: advanceDetails.value!.amount,
                          );
                        } else {
                          updateValues(
                            purpose: '',
                            amount: advanceDetails.value!.amount,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 40),
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: hexToColor('#EEF0F6'), width: 1),
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black, width: .5),
                        // ),
                        // border: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.black, width: .5),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: KText(
                        text: 'Amount (BDT)',
                        color: hexToColor('#80939D'),
                        fontSize: 16,
                      ),
                    ),
                    TextFormField(
                      initialValue: advanceDetails.value!.amount != null ? advanceDetails.value!.amount.toString() : '',
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          updateValues(
                            purpose: advanceDetails.value!.description,
                            amount: int.parse(value),
                          );
                        } else {
                          updateValues(
                            purpose: advanceDetails.value!.description,
                            amount: 0,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 40),
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: hexToColor('#EEF0F6'), width: 1),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Stack(children: [
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 20),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: hexToColor('#EEF0F6')),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: 'Ref. No.',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                                KText(text: refNo.value),
                                SizedBox(
                                  height: 10,
                                ),
                                KText(
                                  text: 'Type',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                                KText(text: tRType.value),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                KText(
                                  text: 'Date',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                                KText(text: trDate.value),
                                SizedBox(
                                  height: 10,
                                ),
                                KText(
                                  text: 'Estimated Cost (BDT)',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                                KText(text: trCost.value.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 12,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                KText(
                                  text: 'Approved TR',
                                  color: hexToColor('#80939D'),
                                  fontSize: 16,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      approvedTRModal();
                                    },
                                    child: RenderSvg(path: 'icon_search_elements'))
                              ],
                            ),
                          ))
                    ]),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickMultiImage();
                          },
                          child: RenderSvg(
                            path: 'icon_add_box',
                            width: 25.0,
                            color: hexToColor('#FFA133'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        KText(
                          text: 'Attachments',
                          color: hexToColor('#80939D'),
                          fontSize: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      width: Get.width * .8,
                      child: Obx(() => fileCount.value == ''
                              ? Container(
                                  alignment: Alignment.center, width: Get.width * .8, height: 20, child: Text('No Image Found'))
                              : fileCount.value == '0'
                                  ? Container(
                                      alignment: Alignment.center, width: Get.width * .8, height: 20, child: Text('No Image Found'))
                                  : ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: evedenceImages[
                                              evedenceImages.indexWhere((e) => e.progressId == advanceDetails.value!.applicationRefno)]
                                          .images
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  Get.dialog(
                                                    barrierDismissible: false,
                                                    // backgroundColor: Colors.transparent,
                                                    // contentPadding: EdgeInsets.zero,
                                                    // content:
                                                    Column(
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
                                                          child: PhotoView(
                                                              backgroundDecoration:
                                                                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                              imageProvider: NetworkImage(e)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                  child: Container(
                                                    height: 45,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
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
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          imagefiles.isEmpty
                              ? SizedBox()
                              : GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: imagefiles.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = imagefiles[index];
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
                                              Global.confirmDialog(
                                                onConfirmed: () {
                                                  imagefiles.removeAt(index);
                                                  back();
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(60),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.white.withOpacity(0.5),
                                              ),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                                size: 30,
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
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#FFA133'),
                            ),
                            visualDensity: VisualDensity(horizontal: 2),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                // side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {
                            back();
                          },
                          child: KText(
                            text: 'Cancel',
                            fontSize: 16.0,
                            bold: true,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                // hexToColor('#007BEC'),
                                hexToColor('#007BEC')),
                            visualDensity: VisualDensity(horizontal: 2),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                // side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {
                            advanceAddList.add(advanceDetails.value);
                            advanceAdd('edit');
                            // push(ApplyForAdvancePage());
                          },
                          child: KText(
                            text: 'Save',
                            fontSize: 16.0,
                            bold: true,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  updateValues({
    // ApplyForLoan? currentItem,
    String? purpose,
    num? amount,

    //String? repaymentDate,
  }) {
    // final item = loanDetails.value!.singleWhere((x) => x!.id == currentItem!.id);
    advanceDetails.value!.description = purpose;
    advanceDetails.value!.amount = amount;
  }

  trSearch() async {
    try {
      //   if (search.value.isNotEmpty) {
      isLoadding.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SHOUT',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'searchText': search.value
      };

      final res = await postDynamic(
        path: ApiEndpoint.trSearchUrl(),
        body: body,
        authentication: true,
      );

      final data = res.data['data']
          .map((json) => TravelRequestWorkbench.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<TravelRequestWorkbench>() as List<TravelRequestWorkbench>;
      // kLog(res.data);
      tRList.clear();
      tRList.addAll(data);
      isLoadding.value = false;
      // }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  approvedTRModal() async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 420,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Search TR',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          trSearch();
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: search.value.isNotEmpty ? hexToColor('#FFA133') : hexToColor('#9BA9B3'),
                        ),
                      ),
                      // focusedBorder: InputBorder.none,
                      hintText: 'Search here...',
                    ),
                  ),
                  isLoadding.value
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Loading()
                            ],
                          ),
                        )
                      : tRList.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: RenderSvg(
                                  path: 'search_list',
                                  width: 60,
                                  color: hexToColor('#9BA9B3'),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 280,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: tRList.length,
                                  itemBuilder: (context, index) {
                                    final item = tRList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        refNo.value = item.requestRefno as String;
                                        trCost.value = item.estimatedCost!;
                                        trDate.value = item.requestDate as String;
                                        tRType.value = item.vehicleType as String;

                                        back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppTheme.textColor,
                                              width: .2,
                                            ),
                                          ),
                                        ),
                                        child: KText(
                                          text: '${item!.username}',
                                          bold: true,
                                          fontSize: 13,
                                          maxLines: 3,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        search.value = '';
        tRList.clear();

        isLoadding.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  final fileCount = RxString('');
  getFileCount({String? refNo}) async {
    try {
      isLoading.value = true;
      evedenceImageCount.clear();
      //  for (var element in projectSiteList) {
      // kLog(id);

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyId': selectedAgency!.agencyId,
        //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
        'username': username,
        'fileCategory': 'FILE_CATEGORY_ADVANCE',
        'fileRefId': '',
        'fileRefNo': refNo,

        'fileEntryUsername': ''
      };

      final res = await getDynamic(
        path: ApiEndpoint.getFileCount(),
        queryParameters: params,
      );
      fileCount.value = res.data['data']['fileCount'].toString();
      kLog('**************0 ${res.data['data']['fileCount']}');
      kLog(res.data);
      kLog(fileCount.value);
      evedenceImageCount.add(HistoryImageModel(progressId: refNo!, imageCount: res.data['data']['fileCount'].toString(), status: ''));

      evedenceImages.add(AllImagesModel(progressId: refNo, images: [], status: ''));

      isLoading.value = false;
      //  }
      // ignore: unused_local_variable
      for (var element in evedenceImageCount) {
        print('image Count');
        kLog('${element.progressId} ${element.imageCount}');
      }

      for (var element in evedenceImageCount) {
        if (element.imageCount != '0') {
          // kLog(evedenceImageCount.length);
          //// kLog(
          //     'status incoming: ${taskHistoryList[historyImageCount.indexWhere((element) => element.progressId == element.progressId)].status!}');
          await getImage(fileCount: int.parse(element.imageCount), refNo: element.progressId);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
//get history image
  }

  getImage({
    required int fileCount,
    required String refNo,

    // required String supportId
  }) {
    final username = Get.put(UserController()).username;

    evedenceImages[evedenceImages.indexWhere((e) => e.progressId == refNo)].images.clear();
    for (int i = 0; i < fileCount; i++) {
      evedenceImages[evedenceImages.indexWhere((e) => e.progressId == refNo)].images.add(
          '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}&username=$username&fileCategory=FILE_CATEGORY_ADVANCE&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=$refNo&originalFileNameNeeded=&registrationNo=&status=&flag=${i + 1}');
    }
  }
}
