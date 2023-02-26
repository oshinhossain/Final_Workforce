// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/dialogHelper.dart';
import 'package:workforce/src/helpers/get_file_name.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/image_compress.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/apply_for_loan.dart';
import 'package:workforce/src/models/history_image_count_model.dart';
import 'package:workforce/src/pages/loan_application_workbench_page.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/widgets/custom_textfield_with_dropdown.dart';

import '../helpers/log.dart';

class ApplyForLoanController extends GetxController with ApiService {
  final loanTypes = RxList([
    'Staff Loan',
    'Weadding Loan',
    'Education Loan',
    'PF Loan',
    'Car Loan',
    'House Loan',
    'Medical Loan',
    'Others',
  ]);
  final selectedLoanType = RxString('Staff Loan');
  final selectedDate = RxString('');
  final description = RxString('');
  final amount = RxString('');
  final interest = RxString('');
  final totalPayable = RxString('');
  final installment = RxString('');

  final isLoading = RxBool(false);

  //final siteLocations = Rx<ProjectSites?>(null);
  final loanDetails = Rx<ApplyForLoan?>(null);
  final loanList = RxList<ApplyForLoan?>([]);
  final loanAddList = RxList<ApplyForLoan?>([]);

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

  loanGet(String? id) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'category': 'LOAN',
        if (id != '') 'ids': [id]
      };
      // kLog(id);
      // kLog(body);

      final res = await postDynamic(
          path: ApiEndpoint.loanGetUrl(), body: body, authentication: true);

      final loanListData = res.data['data']
          .map((json) => ApplyForLoan.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<ApplyForLoan>() as List<ApplyForLoan>;
      // kLog(res.data);
      // kLog(loanListData);
      isLoading.value = false;
      if (loanListData.isNotEmpty) {
        if (id == '') {
          isLoading.value = false;
          loanList.clear();
          loanList.addAll(loanListData);
        }
        if (id != '') {
          isLoading.value = false;
          loanDetails.value = null;
          loanDetails.value = loanListData.first;
        }
      }
      //  isLoading.value = false;
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  void loanAdd(String? type) async {
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
            ? loanAddList.map((item) {
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
                  'transactionType': selectedLoanType.value,
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
                  'category': 'LOAN',
                  'transactionType': selectedLoanType.value,
                  'applicationRefno': '',
                  'applicationDate':
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  'description': description.value,
                  'createdAt': '',
                  'lastEditedAt': '',
                  'amount': amount.value,
                  'currcy': '',
                  'interestRate': interest.value,
                  'interest': totalPayable.value,
                  'intCalcMethod': '',
                  'installment': installment.value,
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
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        if (imagefiles.isNotEmpty) {
          await postEvidenceAttachment(
              refNo: '${res.data['data']['applicationRefno']}');
        }
        back();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            Get.offAll(LoanApplicationWorkbenchPage());
            // push(LoanApplicationWorkbenchPage());
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
      // final loanListData = res.data['data']
      //     .map((json) => ApplyForLoan.fromJson(json as Map<String, dynamic>))
      //     .toList()
      //     .cast<ApplyForLoan>() as List<ApplyForLoan>;
      //// kLog(loanListData);
      // if (loanListData.isNotEmpty) {
      //   isLoading.value = false;
      //   loanList.clear();
      //   loanList.addAll(loanListData);
      // }
      //  isLoading.value = false;
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
          'fileCategory': 'FILE_CATEGORY_LOAN',
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

  loanDetailsModal(String? id) async {
    await loanGet(id);
    await getFileCount(refNo: loanDetails.value!.applicationRefno);
    await Get.dialog(
        useSafeArea: true,
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Container(
              height: 600,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.center,
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Obx(
                () => loanDetails.value == null
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
                              ),
                              KText(
                                text: ' Date',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: loanDetails.value!.applicationRefno,
                              ),
                              KText(
                                text:
                                    '${loanDetails.value!.applicationDate != null ? formatDate(date: loanDetails.value!.applicationDate!) : ''}',
                              ),
                            ],
                          ),
                          Divider(),
                          KText(text: 'Type'),
                          KText(text: loanDetails.value!.transactionType),
                          Divider(),
                          KText(text: 'Description'),
                          KText(
                            text: loanDetails.value!.description,
                            maxLines: 3,
                          ),
                          Divider(),
                          KText(text: 'Amount (BDT)'),
                          KText(text: loanDetails.value!.amount.toString()),
                          Divider(),
                          KText(text: 'Interest Amount (BDT)'),
                          KText(
                              text: loanDetails.value!.interestRate.toString()),
                          Divider(),
                          KText(text: 'Total Payable (BDT)'),
                          KText(text: loanDetails.value!.interest.toString()),
                          Divider(),
                          KText(text: 'Monthly Installment Amount (BDT)'),
                          KText(
                              text: loanDetails.value!.installment.toString()),
                          Divider(),
                          KText(text: 'Repayment to Start From'),
                          KText(text: loanDetails.value!.disbursementDate),
                          Divider(),
                          KText(text: 'Attachments'),
                          SizedBox(
                            height: 80,
                            width: Get.width * .8,
                            child: Obx(() => fileCount.value == ''
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: Get.width * .8,
                                        height: 20,
                                        child: Text('No Image Found'))
                                    : fileCount.value == '0'
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: Get.width * .8,
                                            height: 20,
                                            child: Text('No Image Found'))
                                        : ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children:
                                                evedenceImages[evedenceImages
                                                        .indexWhere((e) =>
                                                            e.progressId ==
                                                            loanDetails.value!
                                                                .applicationRefno)]
                                                    .images
                                                    .map((e) => GestureDetector(
                                                          onTap: () {
                                                            Get.dialog(
                                                              barrierDismissible:
                                                                  false,
                                                              // backgroundColor: Colors.transparent,
                                                              // contentPadding: EdgeInsets.zero,
                                                              // content:
                                                              Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: GestureDetector(
                                                                        onTap: () {
                                                                          Get.back();
                                                                        },
                                                                        child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              45,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            .8,
                                                                    width:
                                                                        Get.width *
                                                                            .7,
                                                                    child: PhotoView(
                                                                        backgroundDecoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10)),
                                                                        imageProvider:
                                                                            NetworkImage(e)),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Container(
                                                              height: 45,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                          e),
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
                                minimumSize: MaterialStateProperty.all<Size?>(
                                    Size(109, 35)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  hexToColor('#FFA133'),
                                ),
                                visualDensity: VisualDensity(horizontal: 2),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
        ));
  }

  loanDetailsViewModal(String? id) async {
    await loanGet(id);
    await getFileCount(refNo: loanDetails.value!.applicationRefno);
    await Get.dialog(
        useSafeArea: true,
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Container(
              height: 600,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.center,
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Obx(
                () => loanDetails.value == null
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
                              ),
                              KText(
                                text: ' Date',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: loanDetails.value!.applicationRefno,
                              ),
                              KText(
                                text:
                                    '${loanDetails.value!.applicationDate != null ? formatDate(date: loanDetails.value!.applicationDate!) : ''}',
                              ),
                            ],
                          ),
                          Divider(),
                          KText(text: 'Type'),
                          KText(text: loanDetails.value!.transactionType),
                          Divider(),
                          KText(text: 'Description'),
                          KText(
                            text: loanDetails.value!.description,
                            maxLines: 3,
                          ),
                          Divider(),
                          KText(text: 'Amount (BDT)'),
                          KText(text: loanDetails.value!.amount.toString()),
                          Divider(),
                          KText(text: 'Interest Amount (BDT)'),
                          KText(
                              text: loanDetails.value!.interestRate.toString()),
                          Divider(),
                          KText(text: 'Total Payable (BDT)'),
                          KText(text: loanDetails.value!.interest.toString()),
                          Divider(),
                          KText(text: 'Monthly Installment Amount (BDT)'),
                          KText(
                              text: loanDetails.value!.installment.toString()),
                          Divider(),
                          KText(text: 'Repayment to Start From'),
                          KText(text: loanDetails.value!.disbursementDate),
                          Divider(),
                          KText(text: 'Attachments'),
                          SizedBox(
                            height: 80,
                            width: Get.width * .8,
                            child: Obx(() => fileCount.value == ''
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: Get.width * .8,
                                        height: 20,
                                        child: Text('No Image Found'))
                                    : fileCount.value == '0'
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: Get.width * .8,
                                            height: 20,
                                            child: Text('No Image Found'))
                                        : ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children:
                                                evedenceImages[evedenceImages
                                                        .indexWhere((e) =>
                                                            e.progressId ==
                                                            loanDetails.value!
                                                                .applicationRefno)]
                                                    .images
                                                    .map((e) => GestureDetector(
                                                          onTap: () {
                                                            Get.dialog(
                                                              barrierDismissible:
                                                                  false,
                                                              // backgroundColor: Colors.transparent,
                                                              // contentPadding: EdgeInsets.zero,
                                                              // content:
                                                              Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: GestureDetector(
                                                                        onTap: () {
                                                                          Get.back();
                                                                        },
                                                                        child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              45,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            .8,
                                                                    width:
                                                                        Get.width *
                                                                            .7,
                                                                    child: PhotoView(
                                                                        backgroundDecoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10)),
                                                                        imageProvider:
                                                                            NetworkImage(e)),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Container(
                                                              height: 45,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                          e),
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
                                    minimumSize:
                                        MaterialStateProperty.all<Size?>(
                                            Size(109, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      hexToColor('#FFA133'),
                                    ),
                                    visualDensity: VisualDensity(horizontal: 2),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                    minimumSize:
                                        MaterialStateProperty.all<Size?>(
                                            Size(109, 35)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            // hexToColor('#007BEC'),
                                            hexToColor('#007BEC')),
                                    visualDensity: VisualDensity(horizontal: 2),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        // side: BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    loanDetailsEditModal(id);
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
        ));
  }

  loanDetailsEditModal(String? id) async {
    await loanGet(id);
    await getFileCount(refNo: loanDetails.value!.applicationRefno);
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
                () => loanDetails.value == null
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
                              ),
                              KText(
                                text: ' Date',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: loanDetails.value!.applicationRefno,
                              ),
                              KText(
                                text:
                                    '${loanDetails.value!.applicationDate != null ? formatDate(date: loanDetails.value!.applicationDate!) : ''}',
                              ),
                            ],
                          ),
                          Divider(),
                          KText(text: 'Type'),
                          CustomTextFieldWithDropdown(
                            suffix: DropdownButton(
                              value: selectedLoanType.value,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: hexToColor('#80939D'),
                              ),
                              items: loanTypes.map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    selectedLoanType.value = item;
                                  },
                                  value: item,
                                  child: SizedBox(
                                    width: Get.width * .7,
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
                          KText(text: 'Description'),
                          TextFormField(
                            initialValue: loanDetails.value!.description != null
                                ? loanDetails.value!.description
                                : '',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                updateValues(
                                  description: value,
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  // repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              } else {
                                updateValues(
                                  description: '',
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  // repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5),
                              ),
                              // focusedBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.black, width: .5),
                              // ),
                              // border: UnderlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.black, width: .5),
                              // ),
                            ),
                          ),
                          KText(text: 'Amount (BDT)'),
                          TextFormField(
                            initialValue: loanDetails.value!.amount != null
                                ? loanDetails.value!.amount.toString()
                                : '',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: int.parse(value),
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  //  repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              } else {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: 0,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  //  repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5),
                              ),
                            ),
                          ),
                          KText(text: 'Interest Amount (BDT)'),
                          TextFormField(
                            initialValue:
                                loanDetails.value!.interestRate != null
                                    ? loanDetails.value!.interestRate.toString()
                                    : '',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: int.parse(value),
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  //  repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              } else {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: 0,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  // repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5),
                              ),
                            ),
                          ),
                          KText(text: 'Total Payable (BDT)'),
                          TextFormField(
                            initialValue: loanDetails.value!.interest != null
                                ? loanDetails.value!.interest.toString()
                                : '',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: int.parse(value),
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  // repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              } else {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: 0,
                                  monthlyInstallment:
                                      loanDetails.value!.installment,
                                  //  repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5),
                              ),
                            ),
                          ),
                          KText(text: 'Monthly Installment Amount (BDT)'),
                          TextFormField(
                            initialValue: loanDetails.value!.installment != null
                                ? loanDetails.value!.installment.toString()
                                : '',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment: int.parse(value),
                                  // repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              } else {
                                updateValues(
                                  description: loanDetails.value!.description,
                                  amount: loanDetails.value!.amount,
                                  interest: loanDetails.value!.interestRate,
                                  totalPayable: loanDetails.value!.interest,
                                  monthlyInstallment: 0,
                                  //  repaymentDate: loanDetails.value!.disbursementDate,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: .5),
                              ),
                            ),
                          ),
                          KText(text: 'Repayment to Start From'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Get.width * .7,
                                child: Column(
                                  children: [
                                    KText(text: selectedDate.value),
                                    Divider(
                                      color: Colors.black.withOpacity(.5),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: selectDate,
                                  child: Icon(Icons.calendar_month))
                            ],
                          ),
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
                              KText(text: 'Attachments')
                            ],
                          ),
                          SizedBox(
                            height: 80,
                            width: Get.width * .8,
                            child: Obx(() => fileCount.value == ''
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: Get.width * .8,
                                        height: 20,
                                        child: Text('No Image Found'))
                                    : fileCount.value == '0'
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: Get.width * .8,
                                            height: 20,
                                            child: Text('No Image Found'))
                                        : ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children:
                                                evedenceImages[evedenceImages
                                                        .indexWhere((e) =>
                                                            e.progressId ==
                                                            loanDetails.value!
                                                                .applicationRefno)]
                                                    .images
                                                    .map((e) => GestureDetector(
                                                          onTap: () {
                                                            Get.dialog(
                                                              barrierDismissible:
                                                                  false,
                                                              // backgroundColor: Colors.transparent,
                                                              // contentPadding: EdgeInsets.zero,
                                                              // content:
                                                              Column(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: GestureDetector(
                                                                        onTap: () {
                                                                          Get.back();
                                                                        },
                                                                        child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              45,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            .8,
                                                                    width:
                                                                        Get.width *
                                                                            .7,
                                                                    child: PhotoView(
                                                                        backgroundDecoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10)),
                                                                        imageProvider:
                                                                            NetworkImage(e)),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        4.0),
                                                            child: Container(
                                                              height: 45,
                                                              width: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                          e),
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
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                        itemCount: imagefiles.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item = imagefiles[index];
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
                                                    Global.confirmDialog(
                                                      onConfirmed: () {
                                                        imagefiles
                                                            .removeAt(index);
                                                        back();
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(60),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.white
                                                          .withOpacity(0.5),
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
                                  minimumSize: MaterialStateProperty.all<Size?>(
                                      Size(109, 35)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    hexToColor('#FFA133'),
                                  ),
                                  visualDensity: VisualDensity(horizontal: 2),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                                  minimumSize: MaterialStateProperty.all<Size?>(
                                      Size(109, 35)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          // hexToColor('#007BEC'),
                                          hexToColor('#007BEC')),
                                  visualDensity: VisualDensity(horizontal: 2),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  loanAddList.add(loanDetails.value);
                                  // loanC.loanAddList.add(item)
                                  loanAdd('edit');
                                  //  push(ApplyForLoanPage());
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
    String? description,
    num? amount,
    num? interest,
    num? totalPayable,
    num? monthlyInstallment,
    //String? repaymentDate,
  }) {
    // final item = loanDetails.value!.singleWhere((x) => x!.id == currentItem!.id);
    loanDetails.value!.description = description;
    loanDetails.value!.amount = amount;
    loanDetails.value!.interestRate = interest;
    loanDetails.value!.interest = totalPayable;
    loanDetails.value!.installment = monthlyInstallment;
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
        'fileCategory': 'FILE_CATEGORY_LOAN',
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
      evedenceImageCount.add(HistoryImageModel(
          progressId: refNo!,
          imageCount: res.data['data']['fileCount'].toString(),
          status: ''));

      evedenceImages
          .add(AllImagesModel(progressId: refNo, images: [], status: ''));

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
          await getImage(
              fileCount: int.parse(element.imageCount),
              refNo: element.progressId);
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

    evedenceImages[evedenceImages.indexWhere((e) => e.progressId == refNo)]
        .images
        .clear();
    for (int i = 0; i < fileCount; i++) {
      // kLog('inner loop $i');

      // for (var element in historyImages) {
      //  // kLog('image link');
      //  // kLog(' ${element.images}');
      // }
      // await getHistoryImage();
      evedenceImages[evedenceImages.indexWhere((e) => e.progressId == refNo)]
          .images
          .add(
              '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}&username=$username&fileCategory=FILE_CATEGORY_LOAN&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=$refNo&originalFileNameNeeded=&registrationNo=&status=&flag=${i + 1}');
    }
  }
}
