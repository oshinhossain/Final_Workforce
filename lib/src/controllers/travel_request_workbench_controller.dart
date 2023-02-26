import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/log.dart';
import '../components/check_box.dart';
import '../config/api_endpoint.dart';
import '../config/app_theme.dart';
import '../helpers/global_dialog.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/image_compress.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/history_image_count_model.dart';
import '../models/travel_request_workbench.dart';
import '../services/api_service.dart';
import '../widgets/custom_textfield_with_dropdown.dart';

class TravelRequestWorkbenchController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  final travelRequest = RxList<TravelRequestWorkbench>([]);
  final travelTypes = RxList([
    'By Road',
    'By Air',
    'By Train',
    'By Water',
    'Others',
  ]);
  final selectedTravelType = RxString('By Road');
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

  //-------------------------------------
  final search = RxString('');
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
  //==================================================================

  void getTravelRequest() async {
    try {
      isLoading.value = true;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'agencyIds': [selectedAgency!.agencyId],
        'username': username,
      };
      kLog(jsonEncode(body));
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/Trv-TravelRequests/get',
        body: body,
      );

      // kLog(jsonEncode(res.data['data']));

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final travelRequestData = res.data['data']
            .map((json) =>
                TravelRequestWorkbench.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TravelRequestWorkbench>() as List<TravelRequestWorkbench>;

        if (travelRequestData.isNotEmpty) {
          isLoading.value = false;
          travelRequest.clear();
          travelRequest.addAll(travelRequestData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void postTravelRequest() async {
    try {
      isLoading.value = true;

      // ignore: unused_local_variable
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      // ignore: unused_local_variable
      final username = Get.put(UserController()).username;
      final body = {};
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/pr-reimbursement-claims/add',
        body: body,
      );

      // kLog('${res.data}');

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        // kLog('${res.data['status']}');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //==================================================================

  searchLocationBottomSheet() async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        // Obx(
        //   () =>
        SingleChildScrollView(
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
                  onSubmitted: (value) {},
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // kLog(search.value);
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
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
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
                              text: 'Item data name',
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        // ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        // search.value = '';
        // locations.clear();

        // isLoadding.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  editTravelRequestDialog() {
    GlobalDialog.addSiteDialog(
      title: 'Edit Travel Request',
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
                SizedBox(
                  height: 10,
                ),
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
                  text: 'Travel Type',
                  color: hexToColor('#80939D'),
                ),
                CustomTextFieldWithDropdown(
                  borderColor: hexToColor('#EBEBEC'),
                  suffix: DropdownButton(
                    value: selectedTravelType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: travelTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          selectedTravelType.value = item;
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
                SizedBox(height: 25),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Date',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: '15 Dec 2022'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: Get.context!,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        // ignore: unused_local_variable
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        // authC.dateOfBirth.value = formattedDate;
                                      } else {}
                                      // datepicker.clear();
                                    },
                                    icon: RenderSvg(
                                      path: 'calender',
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Location name',
                            color: hexToColor('#80939D'),
                          ),
                          // KText(text: 'BMTF Factory, Gazipur'),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'type...',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.only(bottom: 5),
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
                            text: 'Latitude ',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '45.4097467'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Longitude',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '33.9260617'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Description',
                            color: hexToColor('#80939D'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'type...',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.only(bottom: 5),
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
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: Get.width / 3.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            KText(
                              text: 'Source',
                              fontSize: 12,
                              color: hexToColor('#80939D'),
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
                SizedBox(height: 25),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Date',
                                    color: hexToColor('#80939D'),
                                  ),
                                  KText(text: '15 Dec 2022'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: Get.context!,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        // ignore: unused_local_variable
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        // authC.dateOfBirth.value = formattedDate;
                                      } else {}
                                      // datepicker.clear();
                                    },
                                    icon: RenderSvg(
                                      path: 'calender',
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Location name',
                            color: hexToColor('#80939D'),
                          ),
                          // KText(text: 'BMTF Factory, Gazipur'),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'type...',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.only(bottom: 5),
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
                            text: 'Latitude ',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '45.4097467'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Longitude',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '33.9260617'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Description',
                            color: hexToColor('#80939D'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'type...',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              constraints: BoxConstraints(maxHeight: 40),
                              contentPadding: EdgeInsets.only(bottom: 5),
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
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: Get.width / 2.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            KText(
                              text: 'Destination',
                              fontSize: 12,
                              color: hexToColor('#80939D'),
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
                SizedBox(height: 15),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: true,
                      activeColor: hexToColor('#84BEF3'),
                      checkColor: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is transport support needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: false,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is accommodation support needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                KText(
                  text: 'Estimated Cost (BDT)',
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
                SizedBox(height: 15),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: true,
                      activeColor: hexToColor('#84BEF3'),
                      checkColor: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is advance cash needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                KText(
                  text: 'Advance Amount (BDT)',
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),

      // ),
    );
  }

//-------------//
//image get and post//
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
        'fileCategory': 'FILE_CATEGORY_TRAVEL',
        'fileRefId': '',
        'fileRefNo': refNo,

        'fileEntryUsername': ''
      };

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
