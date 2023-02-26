import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/image_compress.dart';
import 'package:workforce/src/models/change_request_model.dart';
import 'package:workforce/src/pages/change_request_workbench_page.dart';

import '../helpers/get_file_name.dart';
import '../helpers/uniqe_id.dart';
import '../services/api_service.dart';
import '../config/app_theme.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/geography.dart';
import '../models/project_dropdown.dart';
import '../models/site_location_v2.dart';
import 'agencyController.dart';
import 'location_controller.dart';

class ChangeRequestController extends GetxController with ApiService {
  final priority = RxString('Low');
  final priorityCode = RxString('4');

  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  final pickedImageMemory = Rx<Uint8List?>(null);
  final imageCount = RxInt(0);

  final changeRequest = RxList<ChangeRequest>();
  //project
  final projectNameList = RxList<ProjectDropdown>();

  final selectedproject = Rx<ProjectDropdown?>(null);

//location
  final siteLocationsV2 = Rx<SiteLocationV2?>(null);

  final locations = RxList<Geograpphy>();

  final selectedGeograpphy = Rx<Geograpphy?>(null);
  final search = RxString('');
  //post
  final requestTitle = RxString('');
  final changeReason = RxString('');
  final changeImpact = RxString('');
  final changeDescription = RxString('');
  final assumptions = RxString('');

  final isLoading = RxBool(false);
  final isCheckstatus = RxBool(false);
  final isStatus = RxString('');
  final isStatusValue = RxString('');

  //====================================================================
  // ******* Create Change Request Page Image Piker *******
  //====================================================================
  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(
        source: ImageSource.camera,
      );
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);
      }

      pickedImage.value = File(pickedfile!.path);
      // File image

      // Image compress function
      final img = await compressFile(
        file: pickedImage.value,
      );
      print('image size ...............');
      print(img.readAsBytesSync().lengthInBytes / 1024);

      // Load compress image
      pickedImage.value = img;
      pickedImageMemory.value = await pickedImage.value!.readAsBytes();
      // imagefiles.value = pickedfile;

      imagefiles.add(pickedImage.value!);
      // back();

    } catch (e) {
      print('error while picking file.');
    }
  }

  //====================================================================
  // ******* attachments *******
  //====================================================================

  Future<void> postEvidenceAttachment(String id) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      for (var img in imagefiles) {
        //// kLog('image path: ${img.path}');
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': ApiEndpoint.WFC_API_KEY,
          'appCode': 'WFC',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_CHANGE_REQUEST',
          'files': attachments,
          'projectId': selectedproject.value!.id,
          'ids': id,
        },
      );
      // kLog(data);
      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      // kLog(res);
      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

  //=============================================================
  // ************  vehicle Image Get Api ************
  //=============================================================
  getFileCount(String fId) async {
    try {
      //  isLoading.value = true;
      // historyImageCount.clear();
      // for (var element in taskHistoryList) {
      //  // kLog(element.id);

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'agencyId': selectedAgency!.agencyId,
        //'agencyId': ['e3b21bef-1afb-4ed7-8a46-2b1801d8649b'],
        'username': username,
        'fileCategory': 'FILE_CATEGORY_CHANGE_REQUEST',
        'fileRefId': fId,
        'fileRefNo': '',

        'fileEntryUsername': ''
      };

      final res = await getDynamic(
        path: ApiEndpoint.getFileCount(),
        queryParameters: params,
      );
      print('image Count');

      imageCount.value = int.parse(res.data['data']['fileCount'].toString());
      // kLog(imageCount);
    } on DioError catch (e) {
      print(e.message);
    }
//get history image
  }

  Future<String> getImageChangeRequest(String id) async {
    final username = Get.put(UserController()).username;
    final locationC = Get.put(LocationController());
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    var params = {
      'apiKey': ApiEndpoint.WFC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'countryCode': selectedAgency!.countryCode,
      'latLng': '${locationC.latLng}',
      'username': username,
      'fileCategory': 'FILE_CATEGORY_CHANGE_REQUEST',
      'projectId': selectedproject.value!.id,
      'geoLevelId': '',
      'siteId': '',
      'activityId': '',
      'supportId': '',
      'progressId': '',
      'ids': id,
      'originalFileNameNeeded': '',
      'registrationNo': '',
      'status': '',
      'flag': 1,
    };

    // kLog(jsonEncode(params));
    final res = await getDynamic(
      path: '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get',
      queryParameters: params,
    );
    // kLog('Image paichi ');
    // kLog(params);
    print(res.statusCode);
    return res.statusCode.toString();
  }

  //====================================================================
  // ******* project name *******
  //====================================================================

  Future<void> getProjectName() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: ApiEndpoint.getProjectNameUrl(),
        queryParameters: params,
      );

      // kLog(jsonEncode(res.data));
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final pojectInfo = res.data['data']
            .map((json) =>
                ProjectDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectDropdown>() as List<ProjectDropdown>;
        if (pojectInfo.isNotEmpty) {
          projectNameList.clear();
          projectNameList.addAll(pojectInfo);
        }

        isLoading.value = false;
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  openProjectNameDialog() async {
    getProjectName();
    await Get.bottomSheet(
      isScrollControlled: true,
      persistent: false,
      isDismissible: true,
      Obx(
        () => SingleChildScrollView(
          child: Container(
            height: 420,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: projectNameList.isEmpty
                ? isLoading.value
                    ? SizedBox(
                        height: Get.height / 1.5,
                        child: Center(
                          child: Loading(),
                        ),
                      )
                    : SizedBox(
                        height: Get.height / 1.5,
                        child: Center(child: KText(text: 'No data found')),
                      )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: projectNameList.length,
                    itemBuilder: (context, index) {
                      final item = projectNameList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: KText(
                              fontSize: 14,
                              maxLines: 1,
                              bold: true,
                              text: 'Project Name',
                            ),
                          ),

                          // KText(
                          //   fontSize: 14,
                          //   maxLines: 5,
                          //   text: item.projectName!.isEmpty
                          //       ? ''
                          //       : '${item.projectName} ',
                          // ),
                          // ListTile(
                          //   title:
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: InkWell(
                              onTap: () {
                                changeRequest.clear();
                                selectedproject.value = item;

                                getChangeRequest();

                                back();
                              },
                              child: KText(
                                fontSize: 14,
                                maxLines: 5,
                                text: item.projectName!.isEmpty
                                    ? ''
                                    : '${item.projectName} ',
                              ),
                            ),
                          ),

                          // dense: true,
                          // autofocus: true,
                          // hoverColor: Colors.amberAccent,
                          //  ),
                        ],
                      );
                    }),
          ),
        ),
      ),
    );
  }

  //====================================================================
  // ******* geography *******
  //====================================================================

  addGeography() async {
    try {
      if (search.value.isNotEmpty) {
        isLoading.value = true;

        final body = {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'SURVEY',
          'uiCodes': ['0000'],
          'areaLevel': 4,
          'areaType': 'COUNTRY UNIT',
          'countryCode': 'BD',
          'searchText': search.value
        };

        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrl(),
          body: body,
          authentication: true,
        );

        final data = res.data['data']
            .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Geograpphy>() as List<Geograpphy>;

        //// kLog(data[0].toJson());

        locations.clear();
        locations.addAll(data);
        isLoading.value = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void siteSearchV2() async {
    isLoading.value = true;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'searchText': selectedGeograpphy.value!.levelFullcode,
      // 'searchText': 'BD40010835',
    };
    // kLog(selectedGeograpphy.value!.levelFullcode);
    final res = await postDynamic(
      path: ApiEndpoint.getSiteLocV2Url(),
      body: body,
      authentication: true,
    );

    // kLog(res.data);
    siteLocationsV2.value = null;
    final siteLoc =
        SiteLocationV2.fromJson(res.data['data'] as Map<String, dynamic>);
    siteLocationsV2.value = siteLoc;

    isLoading.value = false;
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
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Search Geography',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          addGeography();
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: search.value.isNotEmpty
                              ? hexToColor('#FFA133')
                              : hexToColor('#9BA9B3'),
                        ),
                      ),
                      // focusedBorder: InputBorder.none,
                      hintText: 'Search here...',
                    ),
                  ),
                  isLoading.value
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
                      : locations.isEmpty
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
                                  itemCount: locations.length,
                                  itemBuilder: (context, index) {
                                    final item = locations[index];
                                    return GestureDetector(
                                      onTap: () {
                                        selectedGeograpphy.value = item;

                                        siteSearchV2();
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
                                          text: item.geoLevel4Name!.isEmpty
                                              ? ''
                                              : '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
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
        locations.clear();

        isLoading.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  //====================================================================
  // ******* get change request *******
  //====================================================================

  void getChangeRequest() async {
    try {
      //  isLoading.value = true;
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'type': 'dashboard',
        'projectId': selectedproject.value!.id
      };

      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/change-request/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) => ChangeRequest.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ChangeRequest>() as List<ChangeRequest>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          changeRequest.clear();
          changeRequest.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================
  // ******* create change request *******
  //====================================================================

  void createChangeRequest() async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final userInfo = Get.put(UserController()).currentUser.value;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.WFC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [],
        },
        'projectId': selectedproject.value!.id,
        'projectName': selectedproject.value!.projectName,
        'projectCode': selectedproject.value!.projectCode,
        'pmFullname': selectedproject.value!.pmFullname,
        'pmUsername': selectedproject.value!.pmUsername,
        'pmEmail': selectedproject.value!.pmEmail,
        'pmMobile': selectedproject.value!.pmMobile,
        'priority': priority.value,
        'priorityCode': int.parse(priorityCode.value),
        'changeDescription': changeDescription.value,
        'requestedOn': getCurrrentDateForWF(),
        'changeReason': changeReason.value,
        'changeImpact': changeImpact.value,
        'assumptions': assumptions.value,
        'requestTitle': requestTitle.value,
        'requesterUsername': userInfo!.username,
        'requesterFullname': userInfo.fullName,
        'requesterMobile': '',
        'requesterEmail': '',
        'areaLevel': 4,
        'areaType': 'Country Unit',
        'countryCode': selectedAgency.countryCode,
        'countryName': selectedAgency.countryName,
        'geoLevel1Id': selectedGeograpphy.value!.geoLevel1Id,
        'geoLevel1Code': selectedGeograpphy.value!.geoLevel1Code,
        'geoLevel1Name': selectedGeograpphy.value!.geoLevel1Name,
        'geoLevel2Id': selectedGeograpphy.value!.geoLevel2id,
        'geoLevel2Code': selectedGeograpphy.value!.geoLevel2Code,
        'geoLevel2Name': selectedGeograpphy.value!.geoLevel2Name,
        'geoLevel3Id': selectedGeograpphy.value!.geoLevel3Id,
        'geoLevel3Code': selectedGeograpphy.value!.geoLevel3Code,
        'geoLevel3Name': selectedGeograpphy.value!.geoLevel3Name,
        'geoLevel4Id': selectedGeograpphy.value!.geoLevel4Id,
        'geoLevel4Code': selectedGeograpphy.value!.geoLevel4Code,
        'geoLevel4Name': selectedGeograpphy.value!.geoLevel4Name,
        'geoLevel5Id': '',
        'geoLevel5Code': '',
        'geoLevel5Name': '',
        'levelType': selectedGeograpphy.value!.levelType,
        'levelFullcode': selectedGeograpphy.value!.levelFullcode,
        'status': 'Draft',
        'statusCode': '00'
      };
      //  // kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/change-request/add',
        body: data,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        final id = res.data['data']['id'];
        // kLog(id);
        await postEvidenceAttachment(id.toString());
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            //  getChangeRequest();
            back();
            back();
          },
        );
        await 6.delay();

        back();
        back();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            // push(ChangeRequestWorkbenchPage());
            back();
            back();
            //  getChangeRequest();
          },
        );
        await 6.delay();
        // push(ChangeRequestWorkbenchPage());
        back();
        back();
      }
      // getChangeRequest();
      isLoading.value = false;
      priority.value = 'Low';
      priorityCode.value = '4';
      requestTitle.value = '';
      changeReason.value = '';
      changeImpact.value = '';
      changeDescription.value = '';
      assumptions.value = '';
      selectedGeograpphy.value = null;
    } on DioError catch (e) {
      print(e.message);
    }
  }
  //====================================================================
  // ******* edit change request *******
  //====================================================================

  void editChangeRequest({required ChangeRequest item}) async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final userInfo = Get.put(UserController()).currentUser.value;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.WFC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [item.id],
        },
        'projectId': selectedproject.value!.id,
        'projectName': selectedproject.value!.projectName,
        'projectCode': selectedproject.value!.projectCode,
        'pmFullname': selectedproject.value!.pmFullname,
        'pmUsername': selectedproject.value!.pmUsername,
        'pmEmail': selectedproject.value!.pmEmail,
        'pmMobile': selectedproject.value!.pmMobile,
        'priority':
            priority.value == item.priority ? item.priority : priority.value,
        'priorityCode': int.parse(priorityCode.value) == item.priorityCode
            ? item.priorityCode
            : int.parse(priorityCode.value),
        'changeDescription': changeDescription.value.isEmpty
            ? item.changeDescription
            : changeDescription.value,
        'requestedOn': getCurrrentDateForWF(),
        'changeReason':
            changeReason.value.isEmpty ? item.changeImpact : changeImpact.value,
        'changeImpact':
            changeImpact.value.isEmpty ? item.changeImpact : changeImpact.value,
        'assumptions':
            assumptions.value.isEmpty ? item.assumptions : assumptions.value,
        'requestTitle':
            requestTitle.value.isEmpty ? item.requestTitle : requestTitle.value,
        'requesterUsername': userInfo!.username,
        'requesterFullname': userInfo.fullName,
        'requesterMobile': '',
        'requesterEmail': '',
        'areaLevel': 4,
        'areaType': 'Country Unit',
        'countryCode': selectedAgency.countryCode,
        'countryName': selectedAgency.countryName,
        'geoLevel1Id': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel1Id
            : item.geoLevel1Id,
        'geoLevel1Code': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel1Code
            : item.geoLevel1Code,
        'geoLevel1Name': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel1Name
            : item.geoLevel1Name,
        'geoLevel2Id': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel2id
            : item.geoLevel2Id,
        'geoLevel2Code': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel2Code
            : item.geoLevel2Code,
        'geoLevel2Name': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel2Name
            : item.geoLevel2Name,
        'geoLevel3Id': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel3Id
            : item.geoLevel3Id,
        'geoLevel3Code': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel3Code
            : item.geoLevel3Code,
        'geoLevel3Name': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel3Name
            : item.geoLevel3Name,
        'geoLevel4Id': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel4Id
            : item.geoLevel4Id,
        'geoLevel4Code': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel4Code
            : item.geoLevel4Code,
        'geoLevel4Name': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.geoLevel4Name
            : item.geoLevel4Name,
        'geoLevel5Id': '',
        'geoLevel5Code': '',
        'geoLevel5Name': '',
        'levelType': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.levelType
            : item.levelType,
        'levelFullcode': selectedGeograpphy.value != null
            ? selectedGeograpphy.value!.levelFullcode
            : item.levelFullcode,
        'status': isStatus.value.isEmpty ? item.status : isStatus.value,
        'statusCode':
            isStatusValue.value.isEmpty ? item.statusCode : isStatusValue.value,
      };
      // kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/change-request/add',
        body: data,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        // ignore: unused_local_variable
        final id = res.data['data']['id'];
        // kLog(id);
        await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            //   getChangeRequest();
            back();
            back();
          },
        );
        await 6.delay();

        back();
        back();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            // push(ChangeRequestWorkbenchPage());
            back();
            back();
            //  getChangeRequest();
          },
        );
        await 6.delay();
        // push(ChangeRequestWorkbenchPage());
        back();
        back();
      }
      //  getChangeRequest();
      isLoading.value = false;
      priority.value = 'Low';
      priorityCode.value = '4';
      requestTitle.value = '';
      changeReason.value = '';
      changeImpact.value = '';
      changeDescription.value = '';
      assumptions.value = '';
      selectedGeograpphy.value = null;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//====================================================================
  // ******* edit Attachments *******
  //====================================================================

  Future<void> postEditEvidenceAttachment(
      String projectId, String changeReqId) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      for (var img in imagefiles) {
        //// kLog('image path: ${img.path}');
        final fileName = getExt(path: img.path);
        attachments.add(await MultipartFile.fromFile(
          img.path,
          filename: '${getUniqeId()}$fileName',
        ));

        // kLog('attachment length: ${attachments.length}');
      }

      final data = FormData.fromMap(
        {
          'apiKey': ApiEndpoint.WFC_API_KEY,
          'appCode': 'WFC',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_CHANGE_REQUEST',
          'files': attachments,
          'projectId': projectId,
          'ids': changeReqId,
        },
      );
      // kLog(data);
      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      // kLog(res);
      imagefiles.clear();
      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;
      print(e.message);
    }
  }

  //====================================================================
  // ******* delete change request *******
  //====================================================================

  void deleteChangeRequest(String id) async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id],
      };
      // kLog(data);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/change-request/delete',
        body: data,
      );
      back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        changeRequest.removeWhere((element) => element.id == id);
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            //  getChangeRequest();
            back();
          },
        );
        await 6.delay();

        push(ChangeRequestWorkbenchPage());
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () => back(),
        );
        await 6.delay();
        back();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
