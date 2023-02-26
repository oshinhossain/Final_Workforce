import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/pages/main_page.dart';
import '../config/api_endpoint.dart';
import '../helpers/global_helper.dart';
import '../models/change_request_model.dart';
import '../services/api_service.dart';

import 'package:workforce/src/helpers/route.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/hex_color.dart';
import '../models/my_approval_dashboard_transport_order.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class MyApprovalDashboardController extends GetxController with ApiService {
  // final _dio = Dio();
  final isLoading = RxBool(false);
  final status = RxString('');

  //change request
  final changeRequest = RxList<ChangeRequest>();

  final transportOrder = RxList<MyApprovalDashboardTransportOrder?>([]);
  //====================================================================
  // ******* Basic Data *******
  //====================================================================
  void getTransportOrder({required String transportOrderNo}) async {
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;

      final params = {
        'transportOrderNo': '',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'status': ['Submitted'],
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/get',
        queryParameters: params,
      );

      //// kLog('${res.data}');

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        //Add item list
        //----------------------------------------------------------
        final itemListData = res.data['data']
                .map((json) {
                  final item = MyApprovalDashboardTransportOrder.fromJson(
                      json as Map<String, dynamic>);

                  item.isExpanded = false;
                  item.singleReceivingPerson = false;
                  item.singleGoodsInspectorAtTheDropLocation = false;
                  item.singleDropLocation = false;
                  item.prescribeTravelPath = false;

                  return item;
                })
                .toList()
                .cast<MyApprovalDashboardTransportOrder>()
            as List<MyApprovalDashboardTransportOrder>;

        if (itemListData.isNotEmpty) {
          isLoading.value = false;
          transportOrder.clear();
          transportOrder.addAll(itemListData);
        }
        // log('${itemList.length}');
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void isExpandedItem({
    required String id,
    required bool value,
  }) {
    final item = transportOrder.singleWhere((x) => x!.id == id);
    item!.isExpanded = value ? false : true;

    transportOrder[transportOrder.indexOf(item)] = item;

    // kLog(item.isExpanded);
  }

  void isExpandedItemOfItem({
    required String id,
    required String itemId,
    required bool value,
  }) {
    final item = transportOrder.singleWhere((x) => x!.id == id);
    final items = item!.transportOrderLines!.singleWhere((x) => x.id == itemId);
    items.isExpanded = value ? false : true;

    transportOrder[transportOrder.indexOf(item)] = item;

    // kLog(item.isExpanded);
  }

  void postTransportOrderApprove({
    required String? id,
    required String? status,
  }) async {
    try {
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': [id],
        'status': status,
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/approve',
        body: body,
      );
      //// kLog(res);
      // kLog(res.data['status']);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        transportOrder.removeWhere((x) => x!.id == id);

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 6.delay();

        back();
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

  //====================================================================
  // ******* Change Request *******
  //====================================================================
  // void isExpandedItem1({
  //   required String id,
  //   required bool value,
  // }) {
  //   final item = changeRequest.singleWhere((x) => x.id == id);
  //   item!.isExpanded = value ? false : true;

  //   changeRequest[changeRequest.indexOf(item)] = item;

  //  // kLog(item.isExpanded);
  // }

  // void isExpandedItemOfItem1({
  //   required String id,
  //   required String itemId,
  //   required bool value,
  // }) {
  //   final item = changeRequest.singleWhere((x) => x.id == id);
  //   // final items = item.changeRequest.singleWhere((x) => x.id == itemId);
  //   item.isExpanded = value ? false : true;

  //   changeRequest[changeRequest.indexOf(item)] = item;

  //  // kLog(item.isExpanded);
  // }
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
        'type': 'approval',
      };

      final res = await getDynamic(
          queryParameters: params,
          path: '${dotenv.env['BASE_URL_WFC']}/v1/change-request/get');

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

          for (var item in data) {
            if (item.status == 'Submitted') {
              changeRequest.add(item);
            }
          }
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void editChangeRequest(
      {required ChangeRequest item,
      required status,
      required String statuscode}) async {
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
        'projectId': item.projectId,
        'projectName': item.projectName,
        'projectCode': item.projectCode,
        'pmFullname': item.pmFullname,
        'pmUsername': item.pmUsername,
        'pmEmail': item.pmEmail,
        'pmMobile': item.pmMobile,
        'priority': item.priority,
        'priorityCode': item.priorityCode,
        'changeDescription': item.changeDescription,
        'requestedOn': getCurrrentDateForWF(),
        'changeReason': item.changeImpact,
        'changeImpact': item.changeImpact,
        'assumptions': item.assumptions,
        'requestTitle': item.requestTitle,
        'requesterUsername': userInfo!.username,
        'requesterFullname': userInfo.fullName,
        'requesterMobile': '',
        'requesterEmail': '',
        'areaLevel': 4,
        'areaType': 'Country Unit',
        'countryCode': selectedAgency.countryCode,
        'countryName': selectedAgency.countryName,
        'geoLevel1Id': item.geoLevel1Id,
        'geoLevel1Code': item.geoLevel1Code,
        'geoLevel1Name': item.geoLevel1Name,
        'geoLevel2Id': item.geoLevel2Id,
        'geoLevel2Code': item.geoLevel2Code,
        'geoLevel2Name': item.geoLevel2Name,
        'geoLevel3Id': item.geoLevel3Id,
        'geoLevel3Code': item.geoLevel3Code,
        'geoLevel3Name': item.geoLevel3Name,
        'geoLevel4Id': item.geoLevel4Id,
        'geoLevel4Code': item.geoLevel4Code,
        'geoLevel4Name': item.geoLevel4Name,
        'geoLevel5Id': '',
        'geoLevel5Code': '',
        'geoLevel5Name': '',
        'levelType': item.levelType,
        'levelFullcode': item.levelFullcode,
        'status': status,
        'statusCode': statuscode,
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
        // await postEditEvidenceAttachment(item.projectId!, item.id!);
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 6.delay();

        offAll(MainPage());
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            // push(ChangeRequestWorkbenchPage());
            offAll(MainPage());
            //  getChangeRequest();
          },
        );
        await 6.delay();
        // push(ChangeRequestWorkbenchPage());
        offAll(MainPage());
      }
      getChangeRequest();
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
