import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/route.dart';
import '../services/api_service.dart';
import '../config/api_endpoint.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_svg.dart';
import '../models/activity_name_model.dart';
import '../models/bucket_name_model.dart';
import '../models/project_dropdown.dart';
import '../models/user_model.dart';
import '../pages/project_dashboard_page.dart';

enum PartyType { person, agency }

enum DateType { end, start, delivery }

class ProjectDashboardCreateController extends GetxController with ApiService {
  final q = RxString('');

  final deliveryDate = RxString('');

  final scheduledEndDate = RxString('');
  final scheduledStartDate = RxString('');

  DateTime? eTD;

  final searchUsers = RxList();
  final addUser = RxList();
  final searchAgency = RxList();
  final isLoading = RxBool(false);
//post create activity
  final assignTo = RxString('');
  final pmUserName = RxString('');
  final pmUserAgencyId = RxString('');
  final pmUserAgencyCode = RxString('');
  final pmUserAgencyName = RxString('');

  final projectNameList = RxList<ProjectDropdown>();

  final projectName = RxString('');
  final projectId = RxString('');
  final projectcode = RxString('');

  final categoryName = RxString('');

  final bucketName = RxString('');
  final bucketId = RxString('');
  final bucketCode = RxString('');

  final activityName = RxString('');

  final activityGroupList = RxList<ActivityDropdown>();

//bucket name
  final creatTaskDate = RxString('');
  final bucketNameList = RxList<BucketDropdown>();

  final description = RxString('');

  final quntity = RxString('');
  final outputDescr = RxString('');

  //post create task
  // final deliveryDate = RxString('');

  final taskId = RxString('');
  final taskName = RxString('');
  final taskRole = RxString('');
  final unitOfMeasure = RxString('');

  //post creat project

  final projecType = RxString('');
  final projectManager = Rx<UserModel?>(null);

  final areaLevel = RxString('');

  //project dashboard drop down

  final projecTypecreate = RxList<String>(['Constraction', 'Network']);
  final selectProjectType = RxString('Constraction');

  final agencyCollobration = RxList<String>([
    'Collaboration type',
    'Collaboration type2',
    'Collaboration type2',
  ]);
  final selectAgencyCollobration = RxString('Collaboration type');

  // final selectAgencyCollobration = RxString('Single Agency');
  // final AgencyCollobrationType = RxList<String>(['Single Agency']);

  final AgencyCollobrationType = RxList<String>([
    'Single Agency',
    'network',
  ]);

  final areaTypeItem = RxList<String>([
    'Country Unit',
  ]);
  final selectareaType = RxString('Country Unit');

  //final selectareaType = RxString('');

  final arealevelItem = RxList<String>(['1', '2', '3', '4']);
  final selectLevelType = RxString('1');
  //.....................................................

//date picker
  Future<DateTime?> selectDate(DateType type) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      final date =
          formatDate(date: pickedDate.toString(), format: 'yyyy-MM-dd');

      switch (type) {
        case DateType.end:
          scheduledEndDate.value = date;
          break;
        case DateType.start:
          scheduledStartDate.value = date;
          break;
        case DateType.delivery:
          deliveryDate.value = date;
          break;
      }
    }
    return null;
  }

  openProjectNameDialog() async {
    // getProjectName();
    await Get.bottomSheet(
      isScrollControlled: true,
      persistent: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      Obx(
        () => Container(
          height: 400,
          color: Colors.white,
          child: projectNameList.isEmpty
              ? Center(child: Loading())
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: projectNameList.length,
                  itemBuilder: (context, index) {
                    final item = projectNameList[index];
                    return GestureDetector(
                      onTap: () {
                        projectName.value = item.projectName!;
                        projectId.value = item.id!;
                        getBucketName();
                        print(projectId.value);
                        back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                        height: 30,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child:
                            Center(child: KText(text: '${item.projectName}')),
                      ),
                    );
                  }),
        ),
      ),
    );
  }

  activityGroupDialog() async {
    await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        Container(
          height: 400,
          color: Colors.white,
          child: Obx(
            () => activityGroupList.isEmpty
                ? isLoading.value
                    ? SizedBox(
                        height: Get.height / 1.5,
                        width: 20,
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
                    itemCount: activityGroupList.length,
                    itemBuilder: (context, index) {
                      final item = activityGroupList[index];
                      return GestureDetector(
                        onTap: () {
                          categoryName.value = item.groupName as String;
                          back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          height: 30,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child:
                              Center(child: KText(text: '${item.groupName}')),
                        ),
                      );
                    }),
          ),
        ));
  }

//get Project Name  Api Integrate
  void getProjectName() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final params = {
      'agencyIds': selectedAgency!.agencyId,
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
    };

    final res = await getDynamic(
      path: ApiEndpoint.getProjectNameUrl(),
      queryParameters: params,
    );

    final pojectInfo = res.data['data']
        .map((json) {
          final item = ProjectDropdown.fromJson(json as Map<String, dynamic>);
          //  item.name = [];
          return item;
        })
        .toList()
        .cast<ProjectDropdown>() as List<ProjectDropdown>;
    projectNameList.clear();
    projectNameList.addAll(pojectInfo);

    // // kLog(projectNameList[1].projectName);

    isLoading.value = false;
  }
// bucket name

  void getActivityName() async {
    print('bucket id');
    print(bucketId.value);
    print(projectId.value);
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      // kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'bucketId': bucketId.value,
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'projectId': projectId.value
      };

      final res = await getDynamic(
        path: ApiEndpoint.getActivityGroup(),
        //  path: ApiEndpoint.getBucketName(),
        queryParameters: params,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                ActivityDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ActivityDropdown>() as List<ActivityDropdown>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          activityGroupList.clear();
          activityGroupList.addAll(data);
        }
      } else {
        activityGroupList.clear();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }

    // isLoading.value = true;
    // final selectedAgency = Get.put(AgencyController()).selectedAgency;
    // final username = Get.put(UserController()).username;
    // final params = {
    //   'bucketId': '4a8a5119-f38b-40be-82c9-461e52d9abc3',
    //   'agencyIds': selectedAgency!.agencyId,
    //   'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
    //   'appCode': 'WFC',
    //   'username': username,
    //   'projectId': '75d60cf8-48af-42cd-8017-84c23bc5c7be'
    // };

    // final res = await getDynamic(
    //   path: ApiEndpoint.getActivityGroup(),
    //   queryParameters: params,
    // );

    // final pojectInfo = res.data['data']
    //     .map((json) {
    //       final item = ActivityDropdown.fromJson(json as Map<String, dynamic>);
    //       //  item.name = [];
    //       return item;
    //     })
    //     .toList()
    //     .cast<ActivityDropdown>() as List<ActivityDropdown>;
    // activityGroupList.clear();
    // activityGroupList.addAll(pojectInfo);

    // // // kLog(activityGroupList[0].groupName);

    // isLoading.value = false;
  }

  void getBucketName() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      // kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        // 'projectId': 'd5433254-0dc2-42f6-b7b4-b9a7ad1d9439'
        'projectId': projectId.value
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/bucket/get',
        //  path: ApiEndpoint.getBucketName(),
        queryParameters: params,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map(
                (json) => BucketDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<BucketDropdown>() as List<BucketDropdown>;

        // kLog(data.length);

        if (data.isNotEmpty) {
          isLoading.value = false;
          bucketNameList.clear();
          bucketNameList.addAll(data);
        }
      } else {
        bucketNameList.clear();
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  bucketNameDialog() async {
    await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        Container(
          height: 400,
          width: Get.width,
          color: Colors.white,
          child: Obx(
            () => bucketNameList.isEmpty
                ? isLoading.value
                    ? SizedBox(
                        height: Get.height / 1.5,
                        width: 20,
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
                    itemCount: bucketNameList.length,
                    itemBuilder: (context, index) {
                      final item = bucketNameList[index];
                      return GestureDetector(
                        onTap: () {
                          bucketName.value = item.bucketName!;
                          bucketId.value = item.id!;
                          print(bucketName.value);
                          getActivityName();
                          back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                          height: 30,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child:
                              Center(child: KText(text: '${item.bucketName}')),
                        ),
                      );
                    }),
          ),
        ));
  }

  void postCreateProjectActivityAdd() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'uiCodes': ['abc']
        },
        'scheduledStartDate': scheduledStartDate.value,
        'scheduledEndDate': scheduledEndDate.value,
        'projectName': projectName.value,
        'projecType': selectProjectType.value,
        'pmUsername': assignTo.value,
        'areaType': selectareaType.value,
        'areaLevel': areaLevel.value,
        'countryCode': selectedAgency.countryCode,
        'countryName': selectedAgency.countryName,
        'projectDescr': description.value,
        'agencyId': selectedAgency.agencyId,
        'agencyCode': '',
        'agencyName': ''
      };

      // kLog(jsonEncode(body));
      if (projectName.isNotEmpty &&
          selectProjectType.isNotEmpty &&
          projectManager.value!.fullname != null &&
          selectareaType.isNotEmpty &&
          description.isNotEmpty) {
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/activity/add',
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
                        text: 'Create Project Activity successfully',
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
                          offAll(ProjectDashboardPage());
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
        }
      } else {
        Get.snackbar('Aleart', 'Please check validation',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void postCreateTaskProjectSupportAdd() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'uiCodes': ['abc'],
        },
        'taskId': taskId.value,
        'deliveryDate': deliveryDate.value,
        'taskName': taskName.value,
        'taskRole': taskRole.value,
        'assignedTo': assignTo.value,
        'outPutQuantity': int.parse(quntity.value),
        'description': description.value,
        'unitOfMeasure': unitOfMeasure.value
      };
      // kLog(body);
      if (taskId.value.isNotEmpty &&
          taskName.value.isNotEmpty &&
          taskRole.value.isNotEmpty &&
          assignTo.value.isNotEmpty &&
          quntity.value.isNotEmpty &&
          unitOfMeasure.value.isNotEmpty &&
          description.value.isNotEmpty) {
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/support/add',
          body: body,
        );
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
                        text: 'Transport order created successfully',
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
                          offAll(ProjectDashboardPage());
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
        }
      } else {
        Get.snackbar('Aleart', 'Please check validation',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  // done
  void postCreateProjectAdd() async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final body = {
        'masterViewModel': {
          'apiKey': ApiEndpoint.KYC_API_KEY,
          'appCode': ApiEndpoint.WFC_APP_CODE,
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'uiCodes': ['abc']
        },
        'scheduledStartDate': scheduledStartDate.value,
        'scheduledEndDate': scheduledEndDate.value,
        'projectName': projectName.value,
        'projecType': selectProjectType.value,
        'pmUsername': projectManager.value!.fullname,
        'areaType': selectareaType.value,
        'areaLevel': areaLevel.value,
        'countryCode': selectedAgency.countryCode,
        'countryName': selectedAgency.countryName,
        'projectDescr': description.value,
        'agencyId': selectedAgency.agencyId,
        'agencyCode': '',
        'agencyName': ''
      };
      //// kLog(body);
      // return;
      if (projectName.isNotEmpty &&
          selectProjectType.isNotEmpty &&
          projectManager.value != null) {
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/project/add',
          body: body,
        );

        //// kLog(res.data);

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
                          offAll(ProjectDashboardPage());
                          scheduledStartDate.value = '';
                          scheduledEndDate.value = '';
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
        Get.snackbar('Aleart', 'Please check validation',
            backgroundColor: Colors.white, colorText: Colors.black);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

//done
  searchUserBottomsheet() async {
    try {
      await Get.bottomSheet(
        // isScrollControlled: true,
        // persistent: false,
        // isDismissible: true,
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
                  TextField(
                    onChanged: q,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchPersons();
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isLoading.value
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                ),
                                Center(
                                  child: Loading(),
                                )
                              ],
                            )
                          : searchUsers.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchUsers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = searchUsers[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // addUser.add(item);
                                          final searchUser = UserModel.fromJson(
                                              item as Map<String, dynamic>);

                                          projectManager.value = searchUser;
                                          print(projectManager.value!.fullname);

                                          back();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 15, top: 15),
                                          child: Container(
                                            width: Get.width,
                                            height: 75,
                                            //color: Colors.green,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border(
                                                left: BorderSide(
                                                  color: hexToColor('#DBECFB'),
                                                  width: 1.5,
                                                ),
                                                right: BorderSide(
                                                  color: hexToColor('#DBECFB'),
                                                  width: 1.5,
                                                ),
                                                top: BorderSide(
                                                  color: hexToColor('#DBECFB'),
                                                  width: 1.5,
                                                ),
                                                bottom: BorderSide(
                                                  color: hexToColor('#DBECFB'),
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 2,
                                                    left: 10,
                                                  ),
                                                  child: Container(
                                                    height: 64,
                                                    width: 64,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF5F5FA),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 230, 230, 233),
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 2,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(
                                                                  0xffF5F5FA)
                                                              .withOpacity(0.6),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: FutureBuilder(
                                                      // future: getImage(
                                                      //     username:
                                                      //         '${item['username']}'),
                                                      builder:
                                                          (BuildContext context,
                                                              snapshot) {
                                                        return !snapshot
                                                                    .hasData &&
                                                                snapshot.data !=
                                                                    null
                                                            ? Container(
                                                                height: 38,
                                                                width: 38,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              1.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    child: Image
                                                                        .asset(
                                                                      '${Constants.imgPath}/icon_avatar.png',
                                                                      width: 37,
                                                                      height:
                                                                          37,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: 38,
                                                                width: 38,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              1.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    child: Image
                                                                        .asset(
                                                                      '${Constants.imgPath}/icon_avatar.png',
                                                                      width: 37,
                                                                      height:
                                                                          37,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 240,
                                                          child: KText(
                                                            text:
                                                                '${item['fullname']}',
                                                            color: hexToColor(
                                                                '#141C44'),
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ),
                                                      KText(
                                                        text:
                                                            '${item['email']}',
                                                        fontSize: 12,
                                                        color: hexToColor(
                                                            '#72778F'),
                                                      ),
                                                      KText(
                                                        text:
                                                            '${item['mobile']}',
                                                        fontSize: 12,
                                                        color: hexToColor(
                                                            '#72778F'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        q.value = '';
        searchUsers.clear();
        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  searchPersons() async {
    isLoading.value = true;
    // final selectedAgency = Get.put(AgencyController()).selectedAgency;
    // final username = Get.put(UserController()).username;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'uiCodes': ['0000'],
      'appCode': 'WFC',
      'searchText': q.value
    };
    final res = await post(
      path: '/search_user',
      body: body,
    );
    // kLog(res.data['data'][0]);

    // kLog('dddd');
    final data = res.data['data'] as List;
    if (data.isNotEmpty) {
      searchUsers.clear();
      searchUsers.addAll(data);
    }
    isLoading.value = false;
  }

  // searchPersons() async {
  //   isLoading.value = true;
  //   final selectedAgency = Get.put(AgencyController()).selectedAgency;
  //   final username = Get.put(UserController()).username;

  //   final body = {
  //     'username': username,
  //     'additionalUsernames': [username],
  //     'agencyIds': [selectedAgency!.agencyId],
  //     'searchText': q.value,
  //     'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
  //     'appCode': 'WFC',
  //     'uiCodes': ['0000']
  //   };
  //   final res = await post(
  //     path: '/search_agency_employees',
  //     body: body,
  //   );
  //  // kLog(res.data['data'][0]);

  //  // kLog('dddd');
  //   final data = res.data['data'] as List;
  //   if (data.isNotEmpty) {
  //     searchUsers.clear();
  //     searchUsers.addAll(data);
  //   }
  //   isLoading.value = false;
  // }
}



//  searchPersons() async {
//     isLoading.value = true;
//     final selectedAgency = Get.put(AgencyController()).selectedAgency;
//     final username = Get.put(UserController()).username;
//     final body = {
//       'username': username,
//       'agencyIds': [selectedAgency!.agencyId],
//       'searchText': q.value,
//       'uiCodes': ['122011'],
//       'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
//       'appCode': 'SHOUT'
//     };
//     final res = await post(path: '/search_user', body: body);
//     //// kLog(res.data['data']);
//     final data = res.data['data'] as List;
//     if (data.isNotEmpty) {
//       searchUsers.clear();
//       searchUsers.addAll(data);
//     }
//     isLoading.value = false;
//   }