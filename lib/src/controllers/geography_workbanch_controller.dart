import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/pages/my_geography_workbench_for_equipment_inspector_page.dart';
import 'package:workforce/src/pages/my_geography_workbench_for_network_inspector_page.dart';
import 'package:workforce/src/pages/my_geography_workbench_for_network_installer_page.dart';
import 'package:workforce/src/pages/my_geography_workbench_for_site_inspector_page.dart';
import 'package:workforce/src/pages/my_geography_workbench_for_site_installer_page.dart';
import '../config/api_endpoint.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/route.dart';
import '../models/geography_workbanch_model.dart';
import '../pages/my_geography_workbench_for_equipment_installer_page.dart';
import '../services/api_service.dart';
import '../helpers/hex_color.dart';

class GeographyWorkBanchController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  // ignore: unused_field
  final _dio = Dio();
  //......................................................
  final geographyWorkbanchGet = RxList<GeographyWorkbanchGet?>();

  final projectId = RxString('');
  final status = RxString('');
  final status2 = RxString('');
//..........................................
// My Geography Workbanch for Site Installer Get Api
//..........................................

  Future<void> geographyWorkbanchGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'siteInstaller',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        // kLog('color guri .........................');
        // kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
//..........................................

//..........................................
// My Geography Workbanch for Site Inspector Get Api
//..........................................

  Future<void> geographyWorkbanchSiteInspectorGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'siteInspector',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        //kLog('color guri .........................');
        //// kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//...................................................

//..........................................
// My Geography Workbanch for Network Inastaller Get Api
//..........................................

  Future<void> geographyWorkbanchNetworkInstallerGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'networkInstaller',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        //kLog('color guri .........................');
        //// kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//.....................................................

//..........................................
// My Geography Workbanch for Network Inspector Get Api
//..........................................

  Future<void> geographyWorkbanchNetworkInspectorGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'networkInspector',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        //kLog('color guri .........................');
        //// kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//...................................................

//..........................................
// My Geography Workbanch for Equipment Inastaller Get Api
//..........................................

  Future<void> geographyWorkbanchEquipmentInstallerGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'equipmentInstaller',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        //kLog('color guri .........................');
        //// kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//.....................................................

//..........................................
// My Geography Workbanch for Equipment Inspector Get Api
//..........................................

  Future<void> geographyWorkbanchEquipmentInspectorGetApi() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      //// kLog(selectedAgency!.agencyId);
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        // 'username': 'kabir2',
        'username': username,
        'type': 'equipmentInspector',
        'projectId': projectId.value,
      };
      final res = await getDynamic(
          queryParameters: params,
          path:
              '${dotenv.env['BASE_URL_WFC']}/v1/project/my-geography-workbench/get');
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                GeographyWorkbanchGet.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<GeographyWorkbanchGet>() as List<GeographyWorkbanchGet>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          geographyWorkbanchGet.clear();
          geographyWorkbanchGet.addAll(data);
        }
        //kLog('color guri .........................');
        //// kLog(geographyWorkbanchGet.length);
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

//...................................................

//................................  All Post Api ----------------------------------------

  //..........................................
  // My Geography Workbanch for Site Installer
  //..........................................

  void geographyProjectWorkbanchStatusUpdateSiteInstaller(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'siteInstaller',
        'statusCode': statuscode,
        'status': status,
      };

      // kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForSiteInstaller());
          },
        );
        await geographyWorkbanchGetApi();
        await 1.delay();
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
            push(MyGeographyForSiteInstaller());
            //  getChangeRequest();
          },
        );
        await 2.delay();
        push(MyGeographyForSiteInstaller());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //...............................................................

  //..........................................
  // My Geography Workbanch for Site Inspector
  //..........................................

  void geographyProjectWorkbanchStatusUpdateSiteInspector(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'siteInspector',
        'statusCode': statuscode,
        'status': status,
      };

      // kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForSiteInspector());
          },
        );
        await geographyWorkbanchSiteInspectorGetApi();
        await 1.delay();

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
            push(MyGeographyForSiteInspector());
            //  getChangeRequest();
          },
        );
        await 1.delay();
        // push(ChangeRequestWorkbenchPage());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //......................................................

  //..........................................
  // My Geography Workbanch for Network installer
  //..........................................

  void geographyProjectWorkbanchStatusUpdateNetworkInstaller(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'networkInstaller',
        'statusCode': statuscode,
        'status': status,
      };

      // kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForNetworkInstaller());
          },
        );
        await geographyWorkbanchNetworkInstallerGetApi();
        await 1.delay();

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
            push(MyGeographyForNetworkInstaller());
            //  getChangeRequest();
          },
        );
        await 1.delay();
        // push(ChangeRequestWorkbenchPage());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //......................................................

  //..........................................
  // My Geography Workbanch for Network Inspector post
  //..........................................

  void geographyProjectWorkbanchStatusUpdateNetworkInspector(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'networkInspector',
        'statusCode': statuscode,
        'status': status,
      };

      // kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForNetworkInspector());
          },
        );
        await geographyWorkbanchNetworkInspectorGetApi();
        await 1.delay();

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
            push(MyGeographyForNetworkInspector());
            //  getChangeRequest();
          },
        );

        await 1.delay();
        back();
        // push(ChangeRequestWorkbenchPage());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //.............................................

  //..........................................
  // My Geography Workbanch for Equipment Installer Post
  //..........................................

  void geographyProjectWorkbanchStatusUpdateEquipmentInstaller(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'equipmentInstaller',
        'statusCode': statuscode,
        'status': status,
      };

      //kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForEquipmentInstaller());
          },
        );
        await geographyWorkbanchEquipmentInstallerGetApi();
        await 1.delay();

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
            push(MyGeographyForEquipmentInstaller());
            //  getChangeRequest();
          },
        );
        await 1.delay();
        back();
        // push(ChangeRequestWorkbenchPage());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //......................................................

  //..........................................
  // My Geography Workbanch for Equipment Installer Post
  //..........................................

  void geographyProjectWorkbanchStatusUpdateEquipmentInspector(
      {required GeographyWorkbanchGet item,
      required status,
      required String statuscode}) async {
    try {
      // isLoading.value = true;
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final data = {
        'apiKey': ApiEndpoint.WFC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [item.id],
        'type': 'equipmentInspector',
        'statusCode': statuscode,
        'status': status,
      };

      // kLog(data);
      //kLog(jsonEncode(data));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/project/work-status/update',
        body: data,
      );
      // kLog(res);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // isLoading.value = false;

        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(MyGeographyForEquipmentInspector());
          },
        );
        await geographyWorkbanchEquipmentInspectorGetApi();
        await 1.delay();

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
            push(MyGeographyForEquipmentInspector());
            //  getChangeRequest();
          },
        );
        await 1.delay();
        back();
        // push(ChangeRequestWorkbenchPage());
        //  offAll(MyGeographyForSiteInstaller());
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void disposeData() {
    geographyWorkbanchGet.clear();
  }
  //......................................................
}
