import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/models/criteria_group_get_model.dart';
import '../helpers/log.dart';
import '../services/api_service.dart';
import '../config/api_endpoint.dart';
import '../config/app_theme.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';

import '../helpers/route.dart';
import '../models/maintain_test_type_mode.dart';

import '../models/scenario_groupdata_get_model.dart';
import '../models/test_criterias_model.dart';
import 'network_topology_controller.dart';

class MaintainTestTypeController extends GetxController with ApiService {
  RxInt changeIndex = 0.obs;

  final isLoading = RxBool(false);
  final activeIndex = RxInt(0);

  final testTypeId = RxString('');
  final testTypeCode = RxString('');
  final testTypeName = RxString('');
  final projectId = RxString('');

  final projectName = RxString('');
  final projectCode = RxString('');

  // createCriteriaGroup

  final groupId = RxString('');
  final groupName = RxString('');
  final groupCode = RxString('');

  final maintainTestTypeList = RxList<MaintainTest>();
  final criteriaGroupList = RxList<CriteriaGroupGet>();
  final scenarioGroupList = RxList<ScenarioGroupGet>();

  final testcriteriaGroupList = RxList<TestCriteriasGet>();

  //scenario

  final scenarioCode = RxString('');
  final scenarioName = RxString('');

  // test Criteria

  final criterionCode = RxString('');
  final criterionName = RxString('');
  final expectedResult = RxString('');

  final selectedGroupName = Rx<CriteriaGroupGet?>(null);
  final selectedIndex = RxString('');

  void maintainCreateTestType() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId]
        },
        'projectId': project!.id,
        'projectName': project.projectName,
        'projectCode': project.projectCode,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value
      };
      // kLog('body');
      // kLog(body);

      if (testTypeCode.isNotEmpty && testTypeName.isNotEmpty) {
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test/types/add',
          body: body,
        );

        // kLog(res.data);

        if (res.data['status'] != null &&
            res.data['status'].contains('successful') == true) {
          isLoading.value = false;
          getMaintainTestType();
          Get.back();

          Get.defaultDialog(
              barrierDismissible: false,
              onWillPop: () {
                return Future.value(false);
              },
              backgroundColor: Colors.white,
              title: '',
              content: Container(
                alignment: Alignment.center,
                height: 200,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green.withOpacity(.8),
                      size: 60,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: KText(
                        text: 'Test Type created successfully',
                        maxLines: 3,
                        fontSize: 14,
                        bold: false,
                        color: AppTheme.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: Get.width / 2,
                      child: TextButton(
                        onPressed: () {
                          back();
                          //   offAll(MaintainTestTypePage());
                          getMaintainTestType();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppTheme.primaryColor)),
                        child: KText(
                          text: 'OK',
                          bold: true,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ));
          //  offAll(ProjectDashboardv1());
        }
      } else {
        Get.snackbar('Aleart', 'Please fillup all text field',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getMaintainTestType() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'projectId': projectId.value
      };
      // kLog(params);
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test/types/get',
        queryParameters: params,
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
          isLoading.value = false;
          maintainTestTypeList.clear();
          maintainTestTypeList.addAll(maintainTestTypeData);
          maintainTestTypeList.toSet().toList();
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void updateData({
    required String projectId,
    required String projectName,
    required String id,
    required String projectCode,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [id]
        },
        'projectId': project!.id,
        'projectName': projectName,
        'projectCode': projectCode,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value
      };
      // kLog(body);

      if (testTypeCode.isNotEmpty && testTypeName.isNotEmpty) {
        final res = await postDynamic(
          body: body,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-types/update',
          // queryParameters: params,
        );

        // kLog(res.data);

        if (res.data['status'] != null &&
            res.data['status'].contains('successful') == true) {
          isLoading.value = false;

          Get.defaultDialog(
              barrierDismissible: false,
              onWillPop: () {
                return Future.value(false);
              },
              backgroundColor: Colors.white,
              title: '',
              content: Container(
                alignment: Alignment.center,
                height: 200,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green.withOpacity(.8),
                      size: 60,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: KText(
                        text: 'Update successfully',
                        maxLines: 3,
                        fontSize: 14,
                        bold: false,
                        color: AppTheme.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: Get.width / 2,
                      child: TextButton(
                        onPressed: () {
                          back(); //  offAll(MaintainTestTypePage());
                          getMaintainTestType();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppTheme.primaryColor)),
                        child: KText(
                          text: 'OK',
                          bold: true,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ));
          //  offAll(ProjectDashboardv1());
        }
      } else {
        Get.snackbar('Aleart', 'Please fillup all text field',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void deleteMaintainTestTypeList({
    required String id,
    required MaintainTest item,
  }) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;

      // final params = {
      //   'agencyIds': selectedAgency!.agencyId,
      //   'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      //   'appCode': 'WFC',
      //   'username': username,
      //   'ids': [id]
      // };
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id]
      };
      final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-types/delete',
          body: body);

      // kLog(res.data);

      back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        await getMaintainTestType();
        maintainTestTypeList.remove(item);
        scenarioGroupList.clear();
        testcriteriaGroupList.clear();
        criteriaGroupList.clear();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 1.delay();

        back();

        // vehicleGet.clear();
      } else {
        back();
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
      // vehicleGet.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  // Criteria Group

  void postCreateCriteriaGroup(
    String projectId,
    String id,
  ) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': []
        },
        'projectId': project!.id,
        'projectName': projectName.value,
        'projectCode': '',
        'testTypeId': id,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'groupId': '',
        'groupCode': groupCode.value,
        'groupName': groupName.value
      };
      // kLog('valoooooooo');
      // kLog(body);

      // ignore: unused_local_variable
      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/add',
        body: body,
      );

      // kLog(',,,,,,,,,,,,,,,,,,,oshin..........................');
      // kLog(res.data);
      // await getCreateCriteriaGroup(projectId, id);

      // if (res.data['status'] != null &&
      //     res.data['status'].contains('successful') == true) {
      isLoading.value = false;
      groupCode.value = '';
      groupName.value = '';
      back();
      await getCreateCriteriaGroup(projectId, id);
      Get.defaultDialog(
          barrierDismissible: false,
          onWillPop: () {
            return Future.value(false);
          },
          backgroundColor: Colors.white,
          title: '',
          content: Container(
            alignment: Alignment.center,
            height: 200,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  color: Colors.green.withOpacity(.8),
                  size: 60,
                ),
                SizedBox(
                  height: 22,
                ),
                Center(
                  child: KText(
                    text: 'Critera Group created successfully',
                    maxLines: 3,
                    fontSize: 14,
                    bold: false,
                    color: AppTheme.textColor,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextButton(
                    onPressed: () async {
                      // push(DefineTestAcceptancecriteriaPage(
                      //   id: id,
                      //   pName: projectName.value,
                      //   tName: testTypeCode.value,
                      // ));

                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primaryColor)),
                    child: KText(
                      text: 'OK',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ));
      //  offAll(ProjectDashboardv1());

    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getCreateCriteriaGroup(String projectId, String id) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyId': selectedAgency!.agencyId,
        'projectId': projectId,
        'testTypeId': id,
      };
      // kLog(params);

      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/get',
        queryParameters: params,
      );

      // kLog('${res.data}');
      // kLog(res.data['data']);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final criteriaGroupData = res.data['data']
            .map((json) =>
                CriteriaGroupGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<CriteriaGroupGet>() as List<CriteriaGroupGet>;
        print('........done...........');
        if (criteriaGroupData.isNotEmpty) {
          criteriaGroupList.clear();
          criteriaGroupList.addAll(criteriaGroupData);
          selectedGroupName.value = criteriaGroupList[0];
        }
        // kLog('printed');
        // kLog(criteriaGroupList.length);
      } else {
        criteriaGroupList.clear();
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void criteriaGroupUpdate({
    required String projectId,
    required String projectName,
    required String id,
    required String testTypeId,
    required String projectCode,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [id],
        },
        'projectId': project!.id,
        'projectName': projectName,
        'projectCode': projectCode,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'testTypeId': testTypeId,
        'groupCode': groupCode.value,
        'groupId': groupId.value,
        'groupName': groupName.value
      };
      // kLog('body');
      // kLog(jsonEncode(body));

      final res = await postDynamic(
        authentication: true,
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/add',
        body: body,
      );

      // final res = await _dio.post(
      //   '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/add?id=$id',
      //   data: body,
      //   options: Options(
      //     followRedirects: false,
      //     validateStatus: (status) => true,
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
      //     },
      //   ),
      // );
      // kLog('updated value');
      // kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;

        await getCreateCriteriaGroup(projectId, testTypeId);
        Get.defaultDialog(
            barrierDismissible: false,
            onWillPop: () {
              return Future.value(false);
            },
            backgroundColor: Colors.white,
            title: '',
            content: Container(
              alignment: Alignment.center,
              height: 200,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.green.withOpacity(.8),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: KText(
                      text: 'Update successfully',
                      maxLines: 3,
                      fontSize: 14,
                      bold: false,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () async {
                        await getCreateCriteriaGroup(projectId, id);
                        Get.back();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ));
        //  offAll(ProjectDashboardv1());
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void deleteCriteriaTestTypeList({
    required String id,
    required CriteriaGroupGet item,
  }) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id]
      };
      final res = await postDynamic(
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criteria-groups/delete',
          body: body);

      // kLog(res.data);
      back();

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        criteriaGroupList.remove(item);

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 1.delay();

        back();

        // vehicleGet.clear();
      } else {
        back();
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
      // vehicleGet.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  //Scenario

  void postScenario(
    String id,
  ) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId]
        },
        'projectId': project!.id,
        'projectName': project.projectName,
        'projectCode': projectCode.value,
        'testTypeId': id,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'scenarioCode': scenarioCode.value,
        'scenarioName': scenarioName.value
      };

      // kLog('create sn');
      // kLog(jsonEncode(body));
      //// kLog('${res.data}');
      if (scenarioCode.isNotEmpty && scenarioName.isNotEmpty) {
        back();
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/add',
          body: body,
        );
        // final res = await _dio.post(
        //   '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/add',
        //   data: body,
        //   options: Options(
        //     followRedirects: false,
        //     validateStatus: (status) => true,
        //     headers: {
        //       'Content-Type': 'application/json',
        //       'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
        //     },
        //   ),
        // );
        // kLog('................create scenario...........');
        // kLog(res.data);

        await getScenario();

        if (res.data['status'] != null &&
            res.data['status'].contains('successful') == true) {
          isLoading.value = false;

          Get.defaultDialog(
              barrierDismissible: false,
              onWillPop: () {
                return Future.value(false);
              },
              backgroundColor: Colors.white,
              title: '',
              content: Container(
                alignment: Alignment.center,
                height: 200,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green.withOpacity(.8),
                      size: 60,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: KText(
                        text: 'Project created successfully',
                        maxLines: 3,
                        fontSize: 14,
                        bold: false,
                        color: AppTheme.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: Get.width / 2,
                      child: TextButton(
                        onPressed: () {
                          back();
                          // offAll(DefineTestAcceptancecriteriaPage(
                          //   id: id,
                          //   pName: projectName.value,
                          //   tName: scenarioCode.value,
                          // )
                        },
                        // onPressed: () async {
                        //   push(DefineTestAcceptancecriteriaPage(
                        //     id: id,
                        //     pName: projectName.value,
                        //     tName: testTypeCode.value,
                        //   ));

                        //   Get.back();
                        // },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppTheme.primaryColor)),
                        child: KText(
                          text: 'OK',
                          bold: true,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ));
          //  offAll(ProjectDashboardv1());

        }
      } else {
        Get.snackbar('Aleart', 'Please fillup all text field',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getScenario() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'projectId': project!.id,
        'testTypeId': testTypeId.value
      };
      // kLog(params);
      // kLog('........done........');

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/get',
        queryParameters: params,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final scenarioGroupData = res.data['data']
            .map((json) =>
                ScenarioGroupGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ScenarioGroupGet>() as List<ScenarioGroupGet>;

        if (scenarioGroupData.isNotEmpty) {
          scenarioGroupList.clear();
          scenarioGroupList.addAll(scenarioGroupData);
        }
        // kLog(scenarioGroupList.length);
      } else {
        scenarioGroupList.clear();
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void deleteScenarioTestTypeList({
    required String id,
    required ScenarioGroupGet item,
    //ScenarioGroupGet
  }) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id]
      };
      // kLog('body');
      // kLog(body);
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/delete',
        body: body,
      );

      // kLog(res.data);

      back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        scenarioGroupList.remove(item);
        await getScenario();

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 1.delay();

        back();

        // vehicleGet.clear();
      } else {
        back();
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
      // vehicleGet.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  void scenarioGroupUpdate({
    required String projectId,
    required String projectName,
    required String id,
    required String testTypeId,
    required String projectCode,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project = Get.put(NetworkTopologyController())
          .selectedProject
          .value; //     Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [id]
        },
        'projectId': project!.id,
        'projectName': projectName,
        'projectCode': projectCode,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'testTypeId': testTypeId,
        'scenarioCode': scenarioCode.value,
        'scenarioName': scenarioName.value
      };
      // kLog('body');
      // kLog(body);

      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/update?id=$id',
        body: body,
      );

      // kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;

        Get.defaultDialog(
            barrierDismissible: false,
            onWillPop: () {
              return Future.value(false);
            },
            backgroundColor: Colors.white,
            title: '',
            content: Container(
              alignment: Alignment.center,
              height: 200,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.green.withOpacity(.8),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: KText(
                      text: 'Project created successfully',
                      maxLines: 3,
                      fontSize: 14,
                      bold: false,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () {
                        getScenario();

                        Get.back();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ));
        //  offAll(ProjectDashboardv1());
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  // test criteria

  void postTestCriteria(
    String id,
  ) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': []
        },
        'projectId': project!.id,
        'projectName': project.projectName,
        'projectCode': project.projectCode,
        'testTypeId': testTypeId.value,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'scenarioCode': scenarioCode.value,
        'scenarioName': scenarioName.value,
        'groupCode': groupCode.value,
        'groupId': groupId.value,
        'groupName': groupName.value,
        'criterionCode': criterionCode.value,
        'criterionName': criterionName.value,
        'expectedResult': expectedResult.value
      };
      print('..........projectId.............');
      // kLog(body);
      //// kLog(jsonEncode(body));
      //// kLog('${res.data}');
      if (criterionCode.isNotEmpty &&
          criterionName.isNotEmpty &&
          expectedResult.isNotEmpty) {
        // final res = await _dio.post(
        //   '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/add',
        //   data: body,
        //   options: Options(
        //     followRedirects: false,
        //     validateStatus: (status) => true,
        //     headers: {
        //       'Content-Type': 'application/json',
        //       'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
        //     },
        //   ),
        // );

        // ignore: unused_local_variable
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/add',
          body: body,
        );
        // kLog('create test criteria');
        // kLog(res.data);

        //     await getTestCriteria(id, g);

        // if (res.data['status'] != null &&
        //     res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        getTestCriteria();
        back();
        Get.defaultDialog(
            barrierDismissible: false,
            onWillPop: () {
              return Future.value(false);
            },
            backgroundColor: Colors.white,
            title: '',
            content: Container(
              alignment: Alignment.center,
              height: 200,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.green.withOpacity(.8),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: KText(
                      text: 'Project created successfully',
                      maxLines: 3,
                      fontSize: 14,
                      bold: false,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () {
                        back();

                        // getTestCriteria(id,testTypeId);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ));
        //  offAll(ProjectDashboardv1());
        //   await getTestCriteria();
      }
      // } else {
      //   Get.snackbar('Aleart', 'Please fillup all text field',
      //       backgroundColor: Colors.white, colorText: Colors.black);
      // }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getTestCriteria() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final params = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'agencyIds': selectedAgency!.agencyId,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'projectId': project!.id,
        'testTypeId': testTypeId.value,
        'groupId': groupId.value,
      };

      // kLog(params);
      // kLog('........done........');

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/get',
        queryParameters: params,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final testcriteriaGroupData = res.data['data']
            .map((json) =>
                TestCriteriasGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<TestCriteriasGet>() as List<TestCriteriasGet>;

        if (testcriteriaGroupData.isNotEmpty) {
          testcriteriaGroupList.clear();
          testcriteriaGroupList.addAll(testcriteriaGroupData);
        }
        // kLog(testcriteriaGroupList.length);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void deleteTestCriteriaTypeList({
    required String id,
    required TestCriteriasGet item,
    //ScenarioGroupGet
  }) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final body = {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id]
      };
      // kLog('body');
      // kLog(body);
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/delete',
        body: body,
      );

      // final res = await _dio.post(
      //   '${dotenv.env['BASE_URL_WFC']}/v1/project/test-scenarios/delete',
      //   data: body,
      //   options: Options(
      //     followRedirects: false,
      //     validateStatus: (status) => true,
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
      //     },
      //   ),
      // );

      // kLog(res.data);

      back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        testcriteriaGroupList.remove(item);

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 1.delay();

        back();

        // vehicleGet.clear();
      } else {
        back();
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
      // vehicleGet.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }

  void testCriteriaUpdate({
    required String projectId,
    required String projectName,
    required String id,
    required String testTypeId,
    required String projectCode,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final project =
          Get.put(NetworkTopologyController()).selectedProject.value;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'ids': [id]
        },
        'projectId': project!.id,
        'projectName': projectName,
        'projectCode': projectCode,
        'testTypeCode': testTypeCode.value,
        'testTypeName': testTypeName.value,
        'testTypeId': testTypeId,
        'groupId': groupId.value,
        'groupCode': groupCode.value,
        'groupName': groupName.value,
        'criterionCode': criterionCode.value,
        'criterionName': criterionName.value,
        'expectedResult': expectedResult.value,
      };
      // kLog('body');
      // kLog(body);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/test-criterias/add',
        body: body,
      );

      // kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        await getTestCriteria();
        Get.defaultDialog(
            barrierDismissible: false,
            onWillPop: () {
              return Future.value(false);
            },
            backgroundColor: Colors.white,
            title: '',
            content: Container(
              alignment: Alignment.center,
              height: 200,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.green.withOpacity(.8),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: KText(
                      text: 'Test Criteria created successfully',
                      maxLines: 3,
                      fontSize: 14,
                      bold: false,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () async {
                        //await getTestCriteria();
                        Get.back();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ));
        //  offAll(ProjectDashboardv1());
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
