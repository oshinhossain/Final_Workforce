import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/material_workbench_geography.dart';
import 'package:workforce/src/models/material_workbench_geography_details.dart';
import 'package:workforce/src/models/project_dropdown.dart';

class MaterialBudgetingWorkbenchController extends GetxController
    with ApiService {
  final viewType = Rx<ViewType>(ViewType.geographies);

  final deliveryDate = RxBool(false);
  final isShow = RxBool(false);
  final selectedDate = RxString('');
  final tentativeETD = RxString('');

  final projectNameList = RxList<ProjectDropdown>();

  final projectName = RxString('');
  final projectId = RxString('');
  final projectCode = RxString('');

  final geoList = RxList<MaterialWorkbenchGeography>();
  final geoDetailList = RxList<MaterialWorkbenchGeoDetail>();

//date picker
  void selectDate(String title) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null && title == 'etd') {
      tentativeETD.value = formatDate(date: pickedDate.toString());
    }

    if (pickedDate != null && title == '') {
      selectedDate.value = formatDate(date: pickedDate.toString());
    }
  }

  projectNameDropdown() async {
    await Get.defaultDialog(
        title: '',
        backgroundColor: Colors.transparent,
        content: Obx(
          () => Container(
            color: Colors.white,
            //  margin: EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: projectNameList.length,
                itemBuilder: (context, index) {
                  final item = projectNameList[index];
                  return GestureDetector(
                    onTap: () {
                      projectName.value = item.projectName as String;
                      projectId.value = item.id as String;
                      projectCode.value = item.projectCode as String;
                      getmaterialWorkbenchGeography();
                      back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.textColor,
                            width: .2,
                          ),
                        ),
                      ),
                      child: Center(child: KText(text: '${item.projectName}')),
                    ),
                  );
                }),
          ),
        ));
  }

//get Project Name  Api Integrate
  void getProjectName() async {
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

    // kLog(res.data);
    final pojectInfo = res.data['data']
        .map((json) {
          final item = ProjectDropdown.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<ProjectDropdown>() as List<ProjectDropdown>;
    projectNameList.clear();
    projectNameList.addAll(pojectInfo);
  }

  void getmaterialWorkbenchGeography() async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;

    final params = {
      'agencyIds': selectedAgency!.agencyId,
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
      'projectId': projectId.value,
    };

    final res = await getDynamic(
      path: ApiEndpoint.getMaterialWorkbechGeographyUrl(),
      queryParameters: params,
    );

    final data = res.data['data']
        .map((json) {
          final item =
              MaterialWorkbenchGeography.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<MaterialWorkbenchGeography>() as List<MaterialWorkbenchGeography>;

    // kLog(data);
    geoList.addAll(data);
  }

  void getmaterialWorkbenchGeographyDetails(String levelFullCode) async {
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;

    final params = {
      'agencyIds': selectedAgency!.agencyId,
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'projectId': projectId.value,
      'levelFullcode': levelFullCode,
    };

    final res = await getDynamic(
      path: ApiEndpoint.getMaterialWorkbechGeographyDetailsUrl(),
      queryParameters: params,
    );

    final data = res.data['data']
        .map((json) {
          final item =
              MaterialWorkbenchGeoDetail.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<MaterialWorkbenchGeoDetail>() as List<MaterialWorkbenchGeoDetail>;

    // kLog(data);
    geoDetailList.clear();
    geoDetailList.addAll(data);
  }

  updateQuantity(
    MaterialWorkbenchGeoDetail currentItem,
    double value,
  ) {
    final item = geoDetailList.singleWhere((x) => x.id == currentItem.id);

    item.quantity = value;

    geoDetailList[geoDetailList.indexOf(item)] = item;
  }

// PopupMenu menu = PopupMenu(
//       items: [
//         MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
//         MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)),
//         MenuItem(title: 'Mail', image: Icon(Icons.mail, color: Colors.white,)),
//         MenuItem(title: 'Power', image: Icon(Icons.power, color: Colors.white,)),
//         MenuItem(title: 'Setting', image: Icon(Icons.settings, color: Colors.white,)),
//         MenuItem(title: 'Traffic', image: Icon(Icons.traffic, color: Colors.white,))],
//       onClickMenu: onClickMenu,
//       stateChanged: stateChanged,
//       onDismiss: onDismiss);
// menu.show(rect: rect);
// void stateChanged(bool isShow) {
//   print('menu is ${ isShow ? 'showing': 'closed' }');
// }

}
