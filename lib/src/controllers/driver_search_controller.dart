import 'package:flutter/material.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import 'package:workforce/src/models/vehicle.dart';

import 'package:workforce/src/services/api_service.dart';
import 'package:get/get.dart';

import 'agencyController.dart';
import 'user_controller.dart';

class DriverSearchController extends GetxController with ApiService {
  final search = RxString('');
  final isLoading = RxBool(false);
  final tempDriver = RxList<Driver>();
  final driverList = RxList<Driver>();

  addDriverBottomSheet() async {
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
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchDriver();
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
                          : tempDriver.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: tempDriver.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = tempDriver[index];
                                      return GestureDetector(
                                        onTap: () {
                                          driverList.clear();
                                          driverList.add(item);
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
                                            text: '${item.driverUsername}',
                                            bold: true,
                                            fontSize: 15,
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
        search.value = '';
        tempDriver.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  searchDriver() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': search.value
    };

    final res = await postDynamic(
      path: ApiEndpoint.getDriverUrl(),
      body: body,
    );
    print(res.data);
    final data = res.data['data']
        .map((json) {
          final item = Driver.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<Driver>() as List<Driver>;
    print(data);

    tempDriver.clear();
    tempDriver.addAll(data);

    isLoading.value = false;
  }

  deleteItem(Driver item) {
    driverList.remove(item);
  }
}
