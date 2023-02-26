import 'dart:io';
// ignore: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _dio;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/controllers/maintain_test_type_controller.dart';

import 'package:workforce/src/models/maintain_test_type_mode.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/image_compress.dart';

import '../config/api_endpoint.dart';
import '../config/app_theme.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/log.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../helpers/uniqe_id.dart';
import '../models/criteria_group_get_model.dart';
import '../models/history_image_count_model.dart';
import '../models/scenario_groupdata_get_model.dart';
import '../models/scenario_post_model.dart';
import '../models/test_criterias_model.dart';
import '../models/test_result_post_model.dart';
import '../models/test_user_search_model.dart';
import 'agencyController.dart';
import 'area_search_controller.dart';
import 'network_topology_controller.dart';

class RecordTestResultController extends GetxController with ApiService {
  final maintainTestTypeC = Get.put(MaintainTestTypeController());
  final networkTopologyC = Get.put(NetworkTopologyController());
  final isLoading = RxBool(false);
  final search = RxString('');
  final maintainTestTypeList = RxList<MaintainTest>();
  final selectedTestType = Rx<MaintainTest?>(null);
  final onChangedTestNo = RxString('');
  final tempImage = RxList<Map<String, RxList>>();
  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final selectedDate = RxString('');
  final selectedTestItem = Rx<TestSearchModel?>(null);
  final criteriaGroupList = RxList<CriteriaGroupGet>();

  final criteriaList = RxList<TestCriteriasGet>();
  final selectedCriteriaGroup = Rx<CriteriaGroupGet?>(null);
  final selectedCriteriaItem = Rx<CriteriaGroupGet?>(null);
  final imagefiles = RxList<TestImageModel>([]);
  final testGetList = RxList<TestSearchModel>([]);
  final testSearchList = RxList<TestSearchModel>([]);
  final testResultPostList = RxList<TestResultPostModel>([]);
  final scenarioList = RxList<ScenarioGroupGet>();
  final selectedscenarioItem = Rx<ScenarioGroupGet?>(null);

  Future<void> getCriteriaGroupList(String id) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyId': selectedAgency!.agencyId,
        'projectId': networkTopologyC.selectedProject.value!.id,
        'testTypeId': id
      };

      final res = await getDynamic(
        authentication: true,
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/get',
        queryParameters: params,
      );
      //// kLog(res);

      // kLog('${res.data}');
      // kLog(res.data['data']);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final criteriaGroupData = res.data['data']
            .map((json) =>
                CriteriaGroupGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<CriteriaGroupGet>() as List<CriteriaGroupGet>;

        if (criteriaGroupData.isNotEmpty) {
          criteriaGroupList.clear();
          criteriaGroupList.addAll(criteriaGroupData);

          selectedCriteriaGroup.value = criteriaGroupList[0];
          // kLog('added');
          // kLog(selectedCriteriaGroup.value!.groupName);
        }
        // kLog('Criteria Group');
        // kLog(criteriaGroupList.length);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getScenarioList(String id) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'projectId': networkTopologyC.selectedProject.value!.id,
        'testTypeId': id,
        'groupId': selectedCriteriaGroup.value!.id
      };

      final res = await getDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/get',
        queryParameters: params,
      );
      //// kLog(res);

      // kLog('${res.data}');
      // kLog(res.data['data']);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final scenarioListData = res.data['data']
            .map((json) =>
                ScenarioGroupGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ScenarioGroupGet>() as List<ScenarioGroupGet>;

        if (scenarioListData.isNotEmpty) {
          testResultPostList.clear();
          imagefiles.clear();
          scenarioList.clear();
          scenarioList.addAll(scenarioListData);
        }
        // kLog('Scenario group');
        // kLog(scenarioList.length);

        for (var element in criteriaList) {
          testResultPostList.add(TestResultPostModel(
              criterionId: element.id,
              remarks: '',
              testPassed: false,
              testResultScenarios: []));
          imagefiles.add(TestImageModel(criteriaId: element.id!, images: []));
        }

        for (var i = 0; i < testResultPostList.length; i++) {
          for (var element in scenarioList) {
            testResultPostList[i].testResultScenarios!.add(
                  ScenarioPostModel(scenarioId: element.id, testResult: ''),
                );
          }
        }

        // ignore: unused_local_variable
        for (var element in testResultPostList) {
          // kLog('sub print');
          // kLog(element.testResultScenarios!.length);
        }
        // kLog('main print');
        // kLog(testResultPostList.length);
        // kLog(imagefiles.length);
      } else {
        scenarioList.clear();
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getCriteriaList(String id) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'projectId': networkTopologyC.selectedProject.value!.id,
        'testTypeId': id,
        'groupId': selectedCriteriaGroup.value!.id
      };

      final res = await getDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/get',
        queryParameters: params,
      );
      // kLog('Criteria List Data');
      // kLog(params);
      // kLog('${res.data}');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final criteriaData = res.data['data']
            .map((json) =>
                TestCriteriasGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TestCriteriasGet>() as List<TestCriteriasGet>;

        if (criteriaData.isNotEmpty) {
          criteriaList.clear();
          criteriaList.addAll(criteriaData);
        }
        // kLog('criteria group');
        // kLog(criteriaGroupList.length);
      } else {
        criteriaList.clear();
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<DateTime> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      //String formattedDate = formatDate(date: pickedDate.toString());
      selectedDate.value = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(pickedDate.toString()));
      // time.value = DateFormat('yyyy-MM-dd hh:mm:ss')
      //     .format(DateTime.parse(pickedDate.toString()));

      // selectedDate.value = formattedDate;

      print('pick time ${selectedDate.value}');
    } else {}
    return pickedDate!;
  }

  //====================================================================
  // ******* Record Test Result Page Image Piker *******
  //====================================================================
  // Evidence Image picker
  Future pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(
          source: ImageSource.camera, imageQuality: 70);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        // imagefiles.value = pickedfile;
        pickedImage.value = pickedfile;
        final img = await compressFile(file: File(pickedImage.value!.path));

        update();
        return img;
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }

  postEvidenceAttachment(
      {required String? testId, required String? criteriaId}) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      var attachments = [];
      if (imagefiles[imagefiles
              .indexWhere((element) => element.criteriaId == criteriaId)]
          .images
          .isNotEmpty) {
        for (var img in imagefiles[imagefiles
                .indexWhere((element) => element.criteriaId == criteriaId)]
            .images) {
          final fileName = getExt(path: img.path);
          attachments.add(await _dio.MultipartFile.fromFile(
            img.path,
            filename: '${getUniqeId()}$fileName',
          ));

          // kLog('attachment length: ${attachments.length}');
        }
      }

      final data = _dio.FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_RECORD_TEST_RESULT',
          //'ids': transportOrderIds,
          'files': attachments,

          'projectId': networkTopologyC.selectedProject.value!.id,
          'activityId': testId,
          'ids': criteriaId,
        },
      );

      // ignore: unused_local_variable
      final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/attachment/add',
          body: data,
          authentication: true);
      // kLog('image upload');
      // kLog(res.data);

      isLoading.value = false;
    } on _dio.DioError catch (e) {
      isLoading.value = false;
      kLog(e.message);
    }
  }

  void testAdd({required String testDescription}) async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final areasearchC = Get.put(AreaSearchController());

      isLoading.value = true;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'WFC',
        'modelList': [
          {
            'countryCode': selectedAgency.countryCode,
            'countryName': selectedAgency.countryName,
            'agencyId': selectedAgency.agencyId,
            'agencyCode': selectedAgency.agencyCode,
            'agencyName': selectedAgency.agencyName,
            'projectId': networkTopologyC.selectedProject.value!.id,
            'projectCode': networkTopologyC.selectedProject.value!.projectCode,
            'projectName': networkTopologyC.selectedProject.value!.projectName,
            'testTypeId': selectedTestType.value!.id,
            'testTypeCode': selectedTestType.value!.testTypeCode,
            'testTypeName': selectedTestType.value!.testTypeName,
            'testNo': '',
            'testDate': selectedDate.value != ''
                ? selectedDate.value
                : DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(DateTime.now().toString())),
            'testerAgencyId': '',
            'testerAgencyCode': '',
            'testerAgencyName': '',
            'testerFullname': '',
            'testerUsername': '',
            'testerEmail': '',
            'testerMobile': '',
            'digest': '',
            'areaType': areasearchC.selectedItem!.areaType,
            'areaLevel': areasearchC.selectedItem!.areaLevel,
            'geoLevel1Id': areasearchC.selectedItem!.geoLevel1Id,
            'geoLevel1Code': areasearchC.selectedItem!.geoLevel1Code,
            'geoLevel1Name': areasearchC.selectedItem!.geoLevel1Name,
            'geoLevel2Id': areasearchC.selectedItem!.geoLevel2id,
            'geoLevel2Code': areasearchC.selectedItem!.geoLevel2Code,
            'geoLevel2Name': areasearchC.selectedItem!.geoLevel2Name,
            'geoLevel3Id': areasearchC.selectedItem!.geoLevel3Id,
            'geoLevel3Code': areasearchC.selectedItem!.geoLevel3Code,
            'geoLevel3Name': areasearchC.selectedItem!.geoLevel3Name,
            'geoLevel4Id': areasearchC.selectedItem!.geoLevel4Id,
            'geoLevel4Code': areasearchC.selectedItem!.geoLevel4Code,
            'geoLevel4Name': areasearchC.selectedItem!.geoLevel4Name,
            'geoLevel5Id': '',
            'geoLevel5Code': '',
            'geoLevel5Name': '',
            'levelType': '',
            'levelFullcode': areasearchC.selectedItem!.levelFullcode,
            'testDescription': testDescription
          }
        ]
      };
      // kLog('value add');
      // kLog(jsonEncode(body));
      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-result/add',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // print('data comes');
        //// kLog(res.data);
        isLoading.value = false;
        Get.back();
        testSearch(searchText: '');
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            Get.back();
          },
        );

        //  offAll(MainPage());
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

  void updateCriteriaremarks({required String remarks, required String id}) {
    testResultPostList[testResultPostList
            .indexWhere((element) => element.criterionId == id)]
        .remarks = remarks;
  }

  void updatescenarioTestResult(
      {required String value,
      required String criteriaid,
      required String scenarioid}) {
    testResultPostList[testResultPostList
            .indexWhere((element) => element.criterionId == criteriaid)]
        .testResultScenarios![testResultPostList[testResultPostList
                .indexWhere((element) => element.criterionId == criteriaid)]
            .testResultScenarios!
            .indexWhere((element) => element.scenarioId == scenarioid)]
        .testResult = value;
  }

  void testResultSave() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'appCode': 'WFC',
        'testId': selectedTestItem.value!.id,
        'testResultCriteria': testResultPostList
      };
      // kLog('value add');
      // kLog(jsonEncode(body));
      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-result/record',
        body: body,
      );

      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        testSearch(searchText: '');
        // for (var element in imagefiles) {
        //   await postEvidenceAttachment(
        //       projectId: selectedTestType.value!.projectId,
        //       testId: selectedTestItem.value!.id,
        //       criteriaId: element.criteriaId);
        // }
        for (var element in imagefiles) {
          await postEvidenceAttachment(
              testId: selectedTestType.value!.id,
              criteriaId: element.criteriaId);
        }
        imagefiles.clear();

        Get.back();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
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

  getTestList() async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      final username = Get.put(UserController()).username;
      // ignore: unused_local_variable
      final params = {
        // 'transportOrderNo': '221024.00001',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyId': selectedAgency!.agencyId!,
        'id': selectedTestType.value!.id
      };
      // kLog('value get list');
      // kLog(jsonEncode(params));
      final res = await getDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-result/get',
        queryParameters: params,
      );
      // kLog('List Data');
      // kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final itemListData = res.data['data']
            .map((json) =>
                TestSearchModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TestSearchModel>() as List<TestSearchModel>;

        testGetList.addAll(itemListData);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void testSearch({required String searchText}) async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;

      isLoading.value = true;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId!],
        'appCode': 'WFC',
        'ids': [selectedTestType.value!.id],
        'searchText': searchText != '' ? searchText : ''
      };

      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-result/search',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        print('data comes');
        // kLog(res.data);
        isLoading.value = false;
        final searchList = res.data['data']
            .map((json) =>
                TestSearchModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TestSearchModel>() as List<TestSearchModel>;
        testSearchList.clear();
        testSearchList.addAll(searchList);
        //  offAll(MainPage());
      } else {
        isLoading.value = false;
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> searchMainTainTestType(String text) async {
    isLoading.value = true;
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'searchText': text
      };

      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-type/search',
        body: body,
      );
      // kLog(res);

      // kLog('${res.data}');
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final maintainTestTypeData = res.data['data']
            .map((json) => MaintainTest.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<MaintainTest>() as List<MaintainTest>;

        if (maintainTestTypeData.isNotEmpty) {
          maintainTestTypeList.clear();
          maintainTestTypeList.addAll(maintainTestTypeData);
          maintainTestTypeList.toSet().toList();

          // kLog(maintainTestTypeList.length);
        }
        isLoading.value = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  searchProjectBottomSheet() async {
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
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Search Test Type',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          await networkTopologyC.getProjectName();
                          await searchMainTainTestType(
                            search.value,
                          );
                          //   addGeography();
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
                      : maintainTestTypeList.isEmpty
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
                                  itemCount: maintainTestTypeList.length,
                                  itemBuilder: (context, index) {
                                    final item = maintainTestTypeList[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        await getCriteriaGroupList(item.id!);
                                        selectedTestType.value = item;

                                        // siteSearch();
                                        //kLog(item.id);

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
                                          textOverflow: TextOverflow.visible,
                                          text:
                                              '${item.projectName} > ${item.testTypeName} ',
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
        isLoading.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }
}
