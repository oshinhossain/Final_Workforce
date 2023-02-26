import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';

import '../models/ktransport_order_model.dart';

class TransportationWorkbenchController extends GetxController with ApiService {
  final workbenchTransportOrders = RxList<KTransportOrderModel>();
  final isLoading = RxBool(false);

  void getTransportOrdersForWorkbench() async {
    // const status = 'DRAFT';
    try {
      isLoading.value = true;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'transportOrderNo': '',
        'status': ['Draft', 'Submitted', 'Rejected'],
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final data = res.data['data']
            .map((json) =>
                KTransportOrderModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<KTransportOrderModel>() as List<KTransportOrderModel>;

        if (data.isNotEmpty) {
          isLoading.value = false;
          workbenchTransportOrders.clear();
          workbenchTransportOrders.addAll(data);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void expendITem(String id) {
    final item = workbenchTransportOrders.singleWhere((x) => x.id == id);

    item.expended = item.expended == true ? false : true;

    workbenchTransportOrders[workbenchTransportOrders.indexOf(item)] = item;
  }

  void submitForApproval(KTransportOrderModel item) async {
    item.isLoading = true;

    workbenchTransportOrders[workbenchTransportOrders.indexOf(item)] = item;

    final userC = Get.put(UserController());
    final agencyC = Get.put(AgencyController());
    try {
      final body = {
        'masterViewModel': {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'username': userC.username,
          'agencyIds': [agencyC.selectedAgency!.agencyId]
        },
        'id': item.id,
        'transportOrderDate': getCurrrentDateForWF(),
        'statusCode': '02',
        'action': 'SUBMITTED'
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/add',
        body: body,
      );
      if (convertStatusCode(res.data['responseCode']) == 200) {
        item.isLoading = false;
        item.statusCode = '02';
        item.action = 'SUBMITTED';
        item.status = 'Submitted';

        workbenchTransportOrders[workbenchTransportOrders.indexOf(item)] = item;

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
                    text: 'Transport order Submitted successfully',
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
          ),
        );
      }
    } catch (e) {
      // kLog(e);
    }
  }
}
