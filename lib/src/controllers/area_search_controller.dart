// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workforce/src/services/api_service.dart';

import '../config/api_endpoint.dart';
import '../config/app_theme.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/geography.dart';
import '../models/site_location_v2.dart';

class AreaSearchController extends GetxController with ApiService {
  final isLoading = RxBool(false);

  final siteLocationsV2 = Rx<SiteLocationV2?>(null);
  final district = RxString('');
  final subDisctrict = RxString('');
  final venue = RxString('');
  final levelFullCode = RxString('');
  final search = RxString('');
  final locations = RxList<Geograpphy>();
  Geograpphy? selectedItem;

  addGeography() async {
    try {
      if (search.value.isNotEmpty) {
        isLoading.value = true;

        final body = {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'SURVEY',
          'uiCodes': ['0000'],
          'areaLevel': 4,
          'areaType': 'COUNTRY UNIT',
          'countryCode': 'BD',
          'searchText': search.value
        };

        final res = await postDynamic(
          path: ApiEndpoint.addGeographiesUrl(),
          body: body,
          authentication: true,
        );

        final data = res.data['data']
            .map((json) => Geograpphy.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<Geograpphy>() as List<Geograpphy>;

        //// kLog(data[0].toJson());

        locations.clear();
        locations.addAll(data);
        isLoading.value = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void siteSearchV2() async {
    isLoading.value = true;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SURVEY',
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'searchText': levelFullCode.value,
      // 'searchText': 'BD40010835',
    };
    // kLog(levelFullCode);
    final res = await postDynamic(
      path: ApiEndpoint.getSiteLocV2Url(),
      body: body,
      authentication: true,
    );

    // kLog(res.data);
    siteLocationsV2.value = null;
    final siteLoc =
        SiteLocationV2.fromJson(res.data['data'] as Map<String, dynamic>);
    siteLocationsV2.value = siteLoc;

    isLoading.value = false;
  }

  searchLocationBottomSheet() async {
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
                  KText(
                    text: 'Search Geography',
                    bold: true,
                  ),
                  TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          addGeography();
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
                      : locations.isEmpty
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
                                  itemCount: locations.length,
                                  itemBuilder: (context, index) {
                                    final item = locations[index];
                                    return GestureDetector(
                                      onTap: () {
                                        district.value = item.geoLevel2Name!;
                                        subDisctrict.value =
                                            item.geoLevel3Name!;
                                        venue.value = item.geoLevel4Name!;
                                        levelFullCode.value =
                                            item.levelFullcode as String;
                                        print('data=>:$levelFullCode');
                                        selectedItem = item;

                                        // kLog(selectedItem!.countryName!);
                                        // geol4Id.value =
                                        //     item.geoLevel4Id as String;
                                        // getAreaByIds();
                                        siteSearchV2();
                                        // siteSearch();
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
                                          text: item.geoLevel4Name!.isEmpty
                                              ? ''
                                              : '${item.geoLevel2Name} > ${item.geoLevel3Name} > ${item.geoLevel4Name}',
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
        locations.clear();

        isLoading.value = false;
        //// kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }
}
