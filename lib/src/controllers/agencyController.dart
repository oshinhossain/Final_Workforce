import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workforce/src/helpers/global_helper.dart';

import 'package:workforce/src/models/agency_model.dart';
import 'package:workforce/src/services/api_service.dart';

class AgencyController extends GetxController with ApiService {
  late Box<AgencyModel> agenciesBox;

  final agencies = RxList<AgencyModel>();

  final selectedAgencyData = Rx<AgencyModel?>(null);

  AgencyModel? get selectedAgency => selectedAgencyData.value;

  set setSelectedAgency(AgencyModel? agency) =>
      selectedAgencyData.value = agency;

  @override
  void onReady() {
    agenciesBox = Hive.box<AgencyModel>('agencies');

    // kLog('agencies box opened');
    super.onReady();
  }

  Future<void> putSelectedAgency(AgencyModel? agency) async {
    await agenciesBox.put('current_agency', agency!);
  }

  Future<void> getAgencies(String username) async {
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'username': username,
      'uiCodes': ['0000']
    };
    final res = await post(path: '/get_agencies_by_username', body: body);

    if (convertStatusCode(res.data['responseCode']) == 200) {
      final rawData = res.data['data'] as List;

      if (rawData.isNotEmpty) {
        final items = rawData
            .map(
              (e) => AgencyModel.fromJson(e as Map<String, dynamic>),
            )
            .toList()
            .cast<AgencyModel>();
        agenciesBox.clear();
        agencies.clear();

        for (var item in items) {
          await agenciesBox.put(item.agencyId, item);
        }
        await agenciesBox.put('current_agency', items[0]);

        agencies.addAll(items);
        setSelectedAgency = items[0];

        agencies.toSet().toList();
      }
    }
  }

  Future<void> getAgenciesFromLocalDB() async {
    final items = agenciesBox.values.toList();
    //// kLog(items);

    if (items.isNotEmpty) {
      agencies.addAll(items);
      final currentAgency = agenciesBox.get('current_agency');
      if (currentAgency != null) {
        setSelectedAgency = currentAgency;
        await putSelectedAgency(currentAgency);
      } else {
        setSelectedAgency = items[0];
        await putSelectedAgency(items[0]);
      }
    }
  }

  Future<void> clearLocalAgencies() async {
    await agenciesBox.clear();
    agencies.clear();
    setSelectedAgency = null;
  }
}
