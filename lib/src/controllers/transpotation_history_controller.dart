import 'package:get/get.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';

import 'package:workforce/src/models/transportation_history.dart';
import 'package:workforce/src/services/api_service.dart';

class TranspotationHistoryController extends GetxController with ApiService {
  final isLoading = RxBool(false);

  final allHistoryList = RxList<TransportationHistory>();

  void getTranspotationHistory(String status) async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final params = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'agencyIds': selectedAgency!.agencyId,
      'status': status,
    };

    final res = await getDynamic(
      path: ApiEndpoint.getAllTranspotationHistoryUrl(),
      queryParameters: params,
    );

    final allData = res.data['data']
        .map((json) {
          final item =
              TransportationHistory.fromJson(json as Map<String, dynamic>);

          item.isExpand = true;
          // item.ets = getFormatDate(value: item.ets!, format: '');
          return item;
        })
        .toList()
        .cast<TransportationHistory>() as List<TransportationHistory>;

    allHistoryList.clear();
    allHistoryList.addAll(allData);
    // kLog(allHistoryList);
    isLoading.value = false;
  }

  exapndItem(TransportationHistory v) {
    final item = allHistoryList.singleWhere((x) => x.id == v.id);

    item.isExpand = item.isExpand! ? false : true;

    allHistoryList[allHistoryList.indexOf(item)] = item;
  }
}
