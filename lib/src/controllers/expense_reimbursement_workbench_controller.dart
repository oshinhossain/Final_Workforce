import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/pages/main_page.dart';
import '../config/app_theme.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';
import '../helpers/global_dialog.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/image_compress.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/log.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../helpers/uniqe_id.dart';
import '../models/expense_reimbursement_workbench.dart';
import '../models/history_image_count_model.dart';
import '../services/api_service.dart';
import '../widgets/custom_textfield_with_dropdown.dart';

class ExpenseReimbursementWorkbenchController extends GetxController
    with ApiService {
  final isLoading = RxBool(false);
  final expenseReimbursementSearchList =
      RxList<ExpenseReimbursementSearchModel>([]);
  final expenseReimbursementSearch = Rx<ExpenseReimbursementSearchModel?>(null);
  final expenseReimbursementGetList = RxList<ExpenseReimbursementGetModel>([]);
  final purposeTypes = RxList([
    'Staff Loan',
    'Weadding Loan',
    'Others',
  ]);
  final selectedPurposeType = RxString('Staff Loan');
  final selectedDate = RxString('');
  final description = RxString('');
  final amount = RxNum(0.0);
  final balanceAmount = RxString('');

  final evedenceImageCount = RxList<HistoryImageModel>();
  final evedenceImages = RxList<AllImagesModel>();

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

  //-------------------------------------
  final search = RxString('');
  //-------------------------------------

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

  //==================================================================

  void getExpenseReimbursement() async {
    try {
      isLoading.value = true;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username
      };
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/pr-reimbursement-claims/get',
        body: body,
      );

      // kLog(jsonEncode(res.data['data']));

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final expenseReimbursementData = res.data['data']
                .map((json) => ExpenseReimbursementGetModel.fromJson(
                    json as Map<String, dynamic>))
                .toList()
                .cast<ExpenseReimbursementGetModel>()
            as List<ExpenseReimbursementGetModel>;

        if (expenseReimbursementData.isNotEmpty) {
          isLoading.value = false;
          expenseReimbursementGetList.clear();
          expenseReimbursementGetList.addAll(expenseReimbursementData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void postExpenseReimbursement() async {
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
        'modelList': [
          {
            // 'id': '',
            'countryCode': selectedAgency.countryCode,
            'countryName': selectedAgency.countryName,
            'agencyId': selectedAgency.agencyId,
            'agencyCode': selectedAgency.agencyCode,
            'agencyName': selectedAgency.agencyName,
            'fullname': selectedAgency.fullname,
            'username': selectedAgency.username,
            'email': selectedAgency.email,
            'mobile': selectedAgency.mobile,
            'expensePurposeType': selectedPurposeType.value,
            'claimRefno': '',
            'claimDate': getCurrrentDateForWF(),
            'expenseDescription': description.value,
            'createdAt': getCurrrentDateForWF(),
            'lastEditedAt': '',
            'amount': amount.value,
            'currcy': 'BDT',
            'paid': false,
            'paymentDate': '',
            'paymentMethod': '',
            'paymentRefno': '',
            'paymentRemarks': '',
            'attachmentCount': '',
            'statusCode': '00',
            'status': 'Draft',
            'approverCount': '',
            'isApprover1Passed': '',
            'approvedby1Fullname': '',
            'approvedby1Username': '',
            'approvedby1Email': '',
            'approvedby1Mobile': '',
            'approved1On': '',
            'approvedby1Remarks': '',
            'approver2Passed': false,
            'approvedby2Fullname': '',
            'approvedby2Username': '',
            'approvedby2Email': '',
            'approvedby2Mobile': '',
            'approved2On': '',
            'approvedby2Remarks': '',
            'approver3Passed': false,
            'approvedby3Fullname': '',
            'approvedby3Username': '',
            'approvedby3Email': '',
            'approvedby3Mobile': '',
            'approved3On': '',
            'approvedby3Remarks': ''
          }
        ]
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/pr-reimbursement-claims/add',
        body: body,
      );

      // kLog('${res.data}');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        if (imagefiles.isNotEmpty) {
          await postEvidenceAttachment(
              refNo: '${res.data['data']['claimRefno']}');
        }
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 1.delay();

        offAll(MainPage());
        selectedPurposeType.value = 'Staff Loan';
        amount.value = 0.0;
        description.value = '';
        balanceAmount.value = '';
        expenseReimbursementSearch.value = null;
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
        await 6.delay();
        back();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
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
          'fileCategory': 'FILE_CATEGORY_REIMBURSEMENT',
          'ids': refNo,
          'files': attachments,
        },
      );
      // ignore: unused_local_variable
      final res = await postDynamic(
        path: ApiEndpoint.siteEvedenseSave(),
        body: data,
      );
      kLog(res.data);
      imagefiles.clear();
      //isLoading.value = false;
    } on DioError catch (e) {
      // isLoading.value = false;
      print(e.message);
    }
  }

  //==================================================================
  void reimbursementClaimsSearch() async {
    try {
      isLoading.value = true;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
        'searchText': search.value
      };

      final res = await postDynamic(
        //  path: '${dotenv.env['BASE_URL_WFC']}/v1/pr-reimbursement-claims/search',
        path: '${dotenv.env['BASE_URL_WFC']}/v1/pr-loan/search',
        body: body,
      );

      // kLog('${res.data}');

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final data = res.data['data']
                .map((json) => ExpenseReimbursementSearchModel.fromJson(
                    json as Map<String, dynamic>))
                .toList()
                .cast<ExpenseReimbursementSearchModel>()
            as List<ExpenseReimbursementSearchModel>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          expenseReimbursementSearchList.clear();
          expenseReimbursementSearchList.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  searchLocationBottomSheet() async {
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Search Data',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      expenseReimbursementSearchList();
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // kLog(search.value);
                          reimbursementClaimsSearch();
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: hexToColor('#9BA9B3'),
                        ),
                      ),
                      // focusedBorder: InputBorder.none,
                      hintText: 'Search here...',
                    ),
                  ),
                  expenseReimbursementSearchList.isEmpty
                      ? isLoading.value
                          ? SizedBox(
                              height: 100,
                              child: Center(
                                child: Loading(),
                              ),
                            )
                          : SizedBox(
                              height: 100,
                              child:
                                  Center(child: KText(text: 'No data found')),
                            )
                      : SizedBox(
                          height: 280,
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: expenseReimbursementSearchList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    expenseReimbursementSearchList[index];
                                return GestureDetector(
                                  onTap: () {
                                    expenseReimbursementSearch.value = item;

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
                                      maxLines: 3,
                                      text: item.claimRefno != null
                                          ? '${item.claimRefno}'
                                          : '',
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
        //   locations.clear();
        expenseReimbursementSearchList.clear();
        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  editExpenseReimbursementDialog() {
    GlobalDialog.addSiteDialog(
      title: 'View Details',
      widget:
          // Obx(
          //   () =>
          SizedBox(
        height: Get.height * .9,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Ref. No.',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: '(Auto)',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Date',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: formatDate(date: DateTime.now().toString()),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(color: hexToColor('#EBEBEC')),
                KText(
                  text: 'Purpose Type',
                  color: hexToColor('#80939D'),
                ),
                CustomTextFieldWithDropdown(
                  borderColor: hexToColor('#EBEBEC'),
                  suffix: DropdownButton(
                    value: selectedPurposeType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: purposeTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          selectedPurposeType.value = item;
                        },
                        value: item,
                        child: SizedBox(
                          width: Get.width / 1.4,
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
                SizedBox(height: 8),
                KText(
                  text: 'Description',
                  color: hexToColor('#80939D'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 8),
                KText(
                  text: 'Amount (BDT)',
                  color: hexToColor('#80939D'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: hexToColor('#EEF0F6'),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Ref. No.',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: ''),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  KText(
                                    text: 'Date',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: ''),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Amount (BDT)',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: '',
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Advance Type',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: '',
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        width: Get.width / 1.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            KText(
                              text: 'Advance Payment to Adjust',
                              fontSize: 12,
                            ),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                // kLog('value');
                                searchLocationBottomSheet();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: RenderSvg(path: 'icon_search_elements'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                KText(
                  text: 'Balance Amount to Pay (BDT)',
                  color: hexToColor('#80939D'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickMultiImage();
                      },
                      child: RenderSvg(
                        path: 'icon_add_box',
                        width: 22.0,
                        color: hexToColor('#FFA133'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    KText(
                      text: 'Attachments',
                      color: hexToColor('#80939D'),
                    )
                  ],
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
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                              ),
                              itemCount: 2,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return DottedBorder(
                                  color: hexToColor('#FFE1BF'),
                                  strokeWidth: 2,
                                  dashPattern: [4, 4],
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(5),
                                  child: Container(
                                    // height: 130,
                                    width: double.infinity,
                                    color: hexToColor('#FFFBF7'),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () => pickMultiImage(),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ),
                                    ),

                                    //background color of inner container
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color:
                                                Colors.white.withOpacity(0.5),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133'),
                        ),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    // Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            // hexToColor('#007BEC'),
                            hexToColor('#007BEC')),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: KText(
                        text: 'Save',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      // ),
    );
  }

  num getTotalBalance() {
    num a;
    if (expenseReimbursementSearch.value != null) {
      a = expenseReimbursementSearch.value!.amount!;
    } else {
      a = 0.0;
    }
    num totalBalance = amount.value - a;

    return totalBalance;
  }

//-----//
  viewExpenseReimbursementDialog(ExpenseReimbursementGetModel item) async {
    await getFileCount(refNo: item.claimRefno);

    GlobalDialog.addSiteDialog(
      title: 'View Details',
      widget:
          // Obx(
          //   () =>
          SizedBox(
        height: Get.height * .9,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Ref. No.',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: item.claimRefno != null
                              ? '${item.claimRefno}'
                              : '',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Date',
                          color: hexToColor('#80939D'),
                        ),
                        if (item.claimDate != null)
                          KText(
                            text: formatDate(date: item.claimDate!),
                          ),
                      ],
                    ),
                  ],
                ),
                Divider(color: hexToColor('#EBEBEC')),
                KText(
                  text: 'Purpose Type',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: 'Other',
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 8),
                KText(
                  text: 'Description',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: item.expenseDescription != null
                      ? '${item.expenseDescription}'
                      : '',
                  maxLines: 3,
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 8),
                KText(
                  text: 'Amount (BDT)',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: item.amount != null ? '${item.amount}' : '',
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: hexToColor('#EEF0F6'),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Ref. No.',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: ''),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  KText(
                                    text: 'Date',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: ''),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Amount (BDT)',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: '',
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    KText(
                                      text: 'Advance Type',
                                      color: hexToColor('#80939D'),
                                    ),
                                    KText(
                                      text: '',
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        width: Get.width / 1.9,
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: KText(
                          text: 'Advance Payment to Adjust',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                KText(
                  text: 'Balance Amount to Pay (BDT)',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: '',
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 20),
                KText(
                  text: 'Attachments',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 5,
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
                                  children: evedenceImages[
                                          evedenceImages.indexWhere((e) =>
                                              e.progressId == item.claimRefno)]
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
                                                      alignment:
                                                          Alignment.topRight,
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
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                          imageProvider:
                                                              NetworkImage(e)),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.0),
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

                // Container(
                //   padding:
                //       EdgeInsets.all(10),
                //   child: Column(
                //     mainAxisAlignment:
                //         MainAxisAlignment
                //             .center,
                //     children: [
                //       expenseRWC
                //               .imagefiles
                //               .isEmpty
                //           ? GridView
                //               .builder(
                //               gridDelegate:
                //                   const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount:
                //                     2,
                //                 crossAxisSpacing:
                //                     15,
                //               ),
                //               itemCount:
                //                   2,
                //               primary:
                //                   false,
                //               shrinkWrap:
                //                   true,
                //               itemBuilder:
                //                   (BuildContext
                //                           context,
                //                       int index) {
                //                 return DottedBorder(
                //                   color: hexToColor(
                //                       '#FFE1BF'),
                //                   strokeWidth:
                //                       2,
                //                   dashPattern: [
                //                     4,
                //                     4
                //                   ],
                //                   borderType:
                //                       BorderType.RRect,
                //                   radius:
                //                       Radius.circular(5),
                //                   child:
                //                       Container(
                //                     // height: 130,
                //                     width:
                //                         double.infinity,
                //                     color:
                //                         hexToColor('#FFFBF7'),
                //                     child:
                //                         Center(
                //                       child:
                //                           IconButton(
                //                         onPressed: () {},
                //                         icon: Icon(
                //                           Icons.add,
                //                           color: Colors.grey,
                //                           size: 15,
                //                         ),
                //                       ),
                //                     ),

                //                     //background color of inner container
                //                   ),
                //                 );
                //               },
                //             )
                //           : GridView
                //               .builder(
                //               gridDelegate:
                //                   const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount:
                //                     2,
                //               ),
                //               itemCount: expenseRWC
                //                   .imagefiles
                //                   .length,
                //               primary:
                //                   false,
                //               shrinkWrap:
                //                   true,
                //               itemBuilder:
                //                   (BuildContext
                //                           context,
                //                       int index) {
                //                 final item =
                //                     expenseRWC
                //                         .imagefiles[index];
                //                 return Stack(
                //                   children: [
                //                     Container(
                //                       width:
                //                           double.infinity,
                //                       margin:
                //                           EdgeInsets.all(5),
                //                       decoration:
                //                           BoxDecoration(
                //                         borderRadius: BorderRadius.circular(5),
                //                       ),
                //                       child:
                //                           ClipRRect(
                //                         borderRadius: BorderRadius.circular(5),
                //                         child: Image.file(
                //                           File(item.path),
                //                           fit: BoxFit.cover,
                //                         ),
                //                       ),
                //                     ),
                //                     Positioned(
                //                       top:
                //                           0,
                //                       right:
                //                           0,
                //                       left:
                //                           0,
                //                       bottom:
                //                           0,
                //                       child:
                //                           InkWell(
                //                         onTap: () {},
                //                         child: Container(
                //                           margin: EdgeInsets.all(60),
                //                           decoration: BoxDecoration(
                //                             borderRadius: BorderRadius.circular(50),
                //                             color: Colors.white.withOpacity(0.5),
                //                           ),
                //                           child: Icon(
                //                             Icons.delete,
                //                             color: Colors.redAccent,
                //                             size: 30,
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 );
                //               },
                //             ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133'),
                        ),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    // Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            // hexToColor('#007BEC'),
                            hexToColor('#007BEC')),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // kLog('Edit');
                        back();
                        editExpenseReimbursementDialog();
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
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      // ),
    );
  }
//---------------//

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
        'fileCategory': 'FILE_CATEGORY_REIMBURSEMENT',
        'fileRefId': '',
        'fileRefNo': refNo,

        'fileEntryUsername': ''
      };
      kLog(params);
      final res = await getDynamic(
        path: ApiEndpoint.getFileCount(),
        queryParameters: params,
      );
      fileCount.value = res.data['data']['fileCount'].toString();
      // kLog('**************0 ${res.data['data']['fileCount']}');
      // kLog(res.data);
      // kLog(fileCount.value);
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
        /// print('image Count');
        //  kLog('${element.progressId} ${element.imageCount}');
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
              '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=WFC&countryCode=BD&latLng=${locationC.currentLatLng!.latitude},${locationC.currentLatLng!.longitude}&username=$username&fileCategory=FILE_CATEGORY_REIMBURSEMENT&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=$refNo&originalFileNameNeeded=&registrationNo=&status=&flag=${i + 1}');
    }
  }
}
