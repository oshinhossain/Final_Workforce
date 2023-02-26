import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/ktransport_order_model.dart';
import 'package:workforce/src/models/location_model.dart';
import 'package:workforce/src/models/transport_order_line_item.dart';
import 'package:workforce/src/models/user_model.dart';
import 'package:workforce/src/models/warehouse_model.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/pages/map_view.dart';
import 'package:workforce/src/services/api_service.dart';
import '../config/api_endpoint.dart';
import '../config/constants.dart';
import '../helpers/k_text.dart';

import '../helpers/log.dart';
import '../models/project_dropdown.dart';
import '../models/transport_agency_model.dart';

enum PartyType { person, agency }

enum LocationType { known, map, warehouse }

enum LocationPoint { loading, unloading }

enum UpdateInputType { kg, pcs }

class CreateTransportController extends GetxController with ApiService {
  final remarks = RxString('');

  // project
  final projectId = RxString('');
  final projectName = RxString('');
  // --------------------------------------------------------------------

  // final createTransportModel = Rx<CreateTransportModel?>(null);

// -------------------------------NEW--------------------------------------------
// ------------------------------------------------------------------------------
  final transportPartyType = Rx<PartyType?>(PartyType.person);
  final reciverPartyType = Rx<PartyType?>(PartyType.person);

  final transportAgencyParty = Rx<TransportAgencyModel?>(null);
  final transportPersonParty = Rx<UserModel?>(null);

  final reciverAgencyParty = Rx<TransportAgencyModel?>(null);
  final reciverParsonParty = Rx<UserModel?>(null);

  final sourceLocation = Rx<LocationModel?>(null);
  final sourceLocationWarehouse = Rx<WareHouseModel?>(null);
  final sourceLocationType = Rx<LocationType?>(LocationType.warehouse);

  final dropLocation = Rx<LocationModel?>(null);
  final dropLocationWarehouse = Rx<WareHouseModel?>(null);
  final dropLocationType = Rx<LocationType?>(LocationType.known);

  final singleReciverPerson = Rx<UserModel?>(null);

  final warehouseList = RxList();

  // final inspectorAtLoadingPoint = Rx<UserModel?>(null);

  final inspectorAtDropLocation = Rx<UserModel?>(null);

  final singleInspectorAtDropLocation = RxBool(true);

  final isSingleRecivingPerson = RxBool(true);

  final singleRecivingPerson = Rx<UserModel?>(null);

  final goodsInspectorAtDropLocation = Rx<UserModel?>(null);

  final goodsInspectorAtLoadingPoint = Rx<UserModel?>(null);

// ------------------------------------------------------------------------------
// -------------------------------NEW--------------------------------------------

  // CreateTransportModel get tOrder => createTransportModel.value;

  final transportOrderDate = RxString('');
  final plannedStartDate = RxString('');
  final etd = RxString('');
  final q = RxString('');
  final searchUsers = RxList();
  final searchAgency = RxList();
  final locations = RxList();

  final selectedParty = Rx<PartyType>(PartyType.person);
  final isLoading = RxBool(false);

  // --------------------------------
  final transportParty = RxString('');
  final recivingParty = RxString('');

  final temptransportOrderLines = RxList<TransportOrderLineItem>();
  final transportOrderLines = RxList<TransportOrderLineItem>();

  //

  final isSinglegoodsInspector = RxBool(true);
  final isSingleDropLocation = RxBool(true);
  final isPrescribeTravelPath = RxBool(false);
  //

  // source location
  final sourceLat = RxDouble(0.0);
  final sourceLong = RxDouble(0.0);
  final sourceLocName = RxString('');

  // Get project list
  final projectNameList = RxList<ProjectDropdown>();
  final selectedProject = Rx<ProjectDropdown?>(null);
  final selectProjectName = RxString('Constraction');
  //
  // Destination location
  final destinationLat = RxDouble(0.0);
  final destinationLong = RxDouble(0.0);
  final destinationLocName = RxString('');

  // singleDrop location
  final singleDropLat = RxDouble(0.0);
  final singleDropLong = RxDouble(0.0);
  final singleDropLocName = RxString('');
  //
  // others
  final singleReciverName = RxString('');

  final prescribeTravelPath = RxString('Select Path');

  final singleGoodsInspectorDropLocFullName = RxString('');
  final singleGoodsInspectorDropLocEmail = RxString('');
  final singleGoodsInspectorDropLocUsername = RxString('');

  // Goods Inspector At Loading Point

  final goodsInspectorAtLoadingPointName = RxString('');
  final goodsInspectorAtLoadingPointUsername = RxString('');
  final goodsInspectorAtLoadingPointEmail = RxString('');
  //
  // single Reciver Party

  final singleReciverPartyName = RxString('');

  final locationType = Rx<LocationType>(LocationType.warehouse);

  final enforceInspectorAtSource = RxBool(false);
  final enforceVehicleReadiness = RxBool(false);
  final enforceRecipientReadiness = RxBool(false);
  final enforceInspectorAtDestination = RxBool(false);
  final enforceReceiptByReceiver = RxBool(false);
  final enforceVehicleStartingbyDriver = RxBool(false);
  final enforceMaterialsDropingbyDriver = RxBool(false);

  //
  // final selected = RxString('');
  // final firstApprover = RxList([
  //   'Reporting Manager',
  //   'Location Manager',
  //   'Unit Manager',
  //   'Agency Manager',
  // ]);

  Future<void> openBottomSheet(String title, String value) async {
    // kLog('opened');
    await Get.bottomSheet(
      isScrollControlled: true,
      persistent: false,
      isDismissible: true,

      //persistent: true,
      SingleChildScrollView(
        child: Obx(
          () => Container(
            height: 600,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    KText(
                      text: 'Party Type: ',
                      bold: true,
                      fontSize: 15,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => selectedParty.value = PartyType.person,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 28,
                            child: Radio<PartyType>(
                              value: selectedParty.value,
                              groupValue: PartyType.person,
                              onChanged: (value) {
                                selectedParty.value = PartyType.person;
                              },
                            ),
                          ),
                          KText(
                            text: 'Person',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => selectedParty.value = PartyType.agency,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 28,
                            child: Radio<PartyType>(
                              value: selectedParty.value,
                              groupValue: PartyType.agency,
                              onChanged: (value) {
                                selectedParty.value = PartyType.agency;
                              },
                            ),
                          ),
                          KText(
                            text: 'Agency',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: hexToColor('#9BA9B3'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: KText(
                    text: title,
                    fontSize: 16,
                    bold: true,
                    color: hexToColor('#41525A'),
                  ),
                ),
                TextField(
                  onChanged: q,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchData(selectedParty.value);
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
                SizedBox(
                  height: 450,
                  child: selectedParty.value == PartyType.agency
                      ? isLoading.value
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
                          : searchAgency.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 150,
                                      ),
                                      RenderSvg(
                                        path: 'search_list',
                                        width: 60,
                                        color: hexToColor('#9BA9B3'),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchAgency.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = searchAgency[index];
                                    return GestureDetector(
                                      onTap: () {
                                        switch (value) {
                                          case 'Transport Party':
                                            if (selectedParty.value ==
                                                PartyType.agency) {
                                              final tParty =
                                                  TransportAgencyModel.fromJson(
                                                      item as Map<String,
                                                          dynamic>);
                                              transportAgencyParty.value =
                                                  tParty;
                                              transportPartyType.value =
                                                  PartyType.agency;
                                              Get.back();
                                            }
                                            if (selectedParty.value ==
                                                PartyType.person) {
                                              final tParty = UserModel.fromJson(
                                                  item as Map<String, dynamic>);
                                              transportPersonParty.value =
                                                  tParty;
                                              transportPartyType.value =
                                                  PartyType.person;
                                              // kLog('Receiving Party Agency');
                                              Get.back();
                                            }
                                            break;
                                          case 'Receiving Party':
                                            if (selectedParty.value ==
                                                PartyType.agency) {
                                              final rParty =
                                                  TransportAgencyModel.fromJson(
                                                      item as Map<String,
                                                          dynamic>);
                                              reciverAgencyParty.value = rParty;
                                              reciverPartyType.value =
                                                  PartyType.agency;
                                              // kLog('Receiving Party Agency');
                                              Get.back();
                                            }
                                            if (selectedParty.value ==
                                                PartyType.person) {
                                              final rParty = UserModel.fromJson(
                                                  item as Map<String, dynamic>);
                                              reciverParsonParty.value = rParty;
                                              reciverPartyType.value =
                                                  PartyType.person;
                                              // kLog('Receiving Party person');
                                              Get.back();
                                            }
                                            break;
                                        }
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        child: Container(
                                            width: Get.width,
                                            // height: 75,
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
                                            child: Padding(
                                              padding: EdgeInsets.all(4),
                                              child: KText(
                                                text: '${item['agencyName']}',
                                                fontSize: 16,
                                                bold: true,
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                )
                      : isLoading.value
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
                          : searchUsers.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 150,
                                      ),
                                      RenderSvg(
                                        path: 'search_list',
                                        width: 60,
                                        color: hexToColor('#9BA9B3'),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchUsers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = searchUsers[index];
                                    return GestureDetector(
                                      onTap: () {
                                        switch (value) {
                                          case 'Transport Party':
                                            if (PartyType.person ==
                                                selectedParty.value) {
                                              final personParty =
                                                  UserModel.fromJson(item
                                                      as Map<String, dynamic>);
                                              transportPersonParty.value =
                                                  personParty;
                                              transportPartyType.value =
                                                  PartyType.person;

                                              Get.back();
                                            }
                                            if (PartyType.agency ==
                                                selectedParty.value) {
                                              final agencyParty =
                                                  TransportAgencyModel.fromJson(
                                                      item as Map<String,
                                                          dynamic>);
                                              transportAgencyParty.value =
                                                  agencyParty;

                                              transportPartyType.value =
                                                  PartyType.agency;
                                              //// kLog(agencyParty.toJson());

                                              Get.back();
                                            }
                                            break;
                                          // X
                                          case 'Receiving Party':
                                            if (PartyType.person ==
                                                selectedParty.value) {
                                              final personParty =
                                                  UserModel.fromJson(item
                                                      as Map<String, dynamic>);
                                              reciverParsonParty.value =
                                                  personParty;
                                              reciverPartyType.value =
                                                  PartyType.person;

                                              Get.back();
                                            }
                                            if (PartyType.agency ==
                                                selectedParty.value) {
                                              final agencyParty =
                                                  TransportAgencyModel.fromJson(
                                                      item as Map<String,
                                                          dynamic>);
                                              reciverAgencyParty.value =
                                                  agencyParty;

                                              reciverPartyType.value =
                                                  PartyType.agency;
                                              //// kLog(agencyParty.toJson());

                                              Get.back();
                                            }
                                            break;
                                        }
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
                                                      style: BorderStyle.solid,
                                                      width: 2,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0xffF5F5FA)
                                                            .withOpacity(0.6),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    height: 38,
                                                    width: 38,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(1.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Image.asset(
                                                          '${Constants.imgPath}/icon_avatar.png',
                                                          width: 37,
                                                          height: 37,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8, bottom: 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: 240,
                                                        child: KText(
                                                          text: selectedParty
                                                                      .value ==
                                                                  PartyType
                                                                      .agency
                                                              ? '${item['agencyName']}'
                                                              : '${item['fullname']}',
                                                          color: hexToColor(
                                                              '#141C44'),
                                                          bold: true,
                                                        ),
                                                      ),
                                                    ),
                                                    if (selectedParty.value ==
                                                        PartyType.person)
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 240,
                                                          child: KText(
                                                            text:
                                                                '${item['email']}',
                                                            color: hexToColor(
                                                                '#72778F'),
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ),
                                                    if (selectedParty.value ==
                                                        PartyType.person)
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 240,
                                                          child: KText(
                                                            text:
                                                                '${item['mobile']}',
                                                            color: hexToColor(
                                                                '#72778F'),
                                                            bold: true,
                                                          ),
                                                        ),
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
      searchAgency.clear();
      isLoading.value = false;
      // kLog('closed');
    });
  }

  // void openBottomSheetLocationMap() async {
  //   await Get.bottomSheet(
  //     isDismissible: true,
  //     isScrollControlled: true,

  //     //persistent: true,
  //     Container(
  //       height: 465,
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 20,
  //       ),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(15.0),
  //               topRight: Radius.circular(15.0))),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: 20),
  //           Row(
  //             children: [
  //               KText(
  //                 text: 'Location Type: ',
  //                 fontSize: 14,
  //                 bold: true,
  //               ),
  //               SizedBox(
  //                 height: 20,
  //                 width: 28,
  //                 child: Radio(
  //                   value: true,
  //                   groupValue: true,
  //                   onChanged: (value) {},
  //                 ),
  //               ),
  //               KText(
  //                 text: 'Known Location ',
  //                 fontSize: 14,
  //                 bold: true,
  //               ),
  //               SizedBox(
  //                 height: 20,
  //                 width: 28,
  //                 // child: Radio(
  //                 //     value: true,
  //                 //     groupValue: () {},
  //                 //     onChanged: (v) {
  //                 //       print(v);
  //                 //     }),

  //                 child: Radio(
  //                   value: true,
  //                   groupValue: false,
  //                   onChanged: (value) {},
  //                 ),
  //               ),
  //               KText(
  //                 text: 'Map',
  //                 fontSize: 14,
  //                 bold: true,
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Divider(
  //             height: 2,
  //             color: hexToColor('#9BA9B3'),
  //           ),
  //           Row(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   top: 10,
  //                 ),
  //                 child: KText(
  //                   text: 'Give it a Name',
  //                   fontSize: 16,
  //                   bold: true,
  //                   color: hexToColor('#41525A'),
  //                 ),
  //               ),
  //               Spacer(),
  //               SizedBox(
  //                 width: 30,
  //                 height: 25,
  //                 child: Checkbox(
  //                   // checkColor: Colors.greenAccent,
  //                   // activeColor: Colors.red,
  //                   activeColor: hexToColor('#84BEF3'),
  //                   value: true,
  //                   onChanged: (value) {},
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 3,
  //               ),
  //               KText(
  //                 text: 'Save it',
  //                 bold: true,
  //               ),
  //               SizedBox(
  //                 width: 3,
  //               ),
  //             ],
  //           ),
  //           TextField(
  //             enabled: true,
  //             decoration: InputDecoration(
  //               // suffixIcon: Container(
  //               //   height: 7,
  //               //   width: 7,
  //               //   child: SvgPicture.asset(
  //               //     '${Constants.svgPath}/icon_search_elements.svg',
  //               //     height: 5,
  //               //     width: 5,
  //               //     fit: BoxFit.scaleDown,
  //               //     color: hexToColor('#66A1D9'),
  //               //   ),
  //               // ),
  //               focusedBorder: InputBorder.none,
  //               errorText: '',
  //               hintText: 'Karim’s House',
  //             ),
  //           ),
  //           LocationSourceMap(),
  //         ],
  //       ),
  //     ),

  //     //backgroundColor: Colors.white,
  //     elevation: 0,
  //   );
  // }

  void allLocationBottomSheet({
    required String title,
    required LocationPoint locationPoint,
  }) async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 500,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Location Type: ',
                    fontSize: 14,
                    bold: true,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: locationPoint == LocationPoint.loading
                        ? [
                            GestureDetector(
                              onTap: () {
                                // locationType.value = LocationType.known;
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.known,
                                      groupValue: locationType.value,
                                      // activeColor: Colors.green,
                                      // onChanged: locationType,
                                      onChanged: (v) {},
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 15.0),
                                    child: Text(
                                      'Known Location',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              // onTap: () => locationType.value = LocationType.map,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.map,
                                      groupValue: locationType.value,
                                      // onChanged: locationType,
                                      onChanged: (v) {},
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      'Map',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // locationType.value = LocationType.warehouse,
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.warehouse,
                                      groupValue: locationType.value,
                                      // onChanged: locationType,
                                      onChanged: (v) {
                                        // kLog(v);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      'Warehouse',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        : [
                            GestureDetector(
                              onTap: () {
                                // locationType.value = LocationType.known;
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.known,
                                      groupValue: locationType.value,
                                      // activeColor: Colors.green,
                                      // onChanged: locationType,
                                      onChanged: (v) {
                                        locationType.value = v!;
                                        isLoading.value = false;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 15.0),
                                    child: Text(
                                      'Known Location',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              // onTap: () => locationType.value = LocationType.map,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.map,
                                      groupValue: locationType.value,
                                      // onChanged: locationType,
                                      onChanged: (v) {
                                        locationType.value = v!;
                                        isLoading.value = false;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      'Map',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // locationType.value = LocationType.warehouse,
                              },
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: LocationType.warehouse,
                                      groupValue: locationType.value,
                                      // onChanged: locationType,
                                      onChanged: (v) {
                                        locationType.value = v!;
                                        isLoading.value = false;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      'Warehouse',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                  ),
                  Divider(
                    color: hexToColor('#515D64'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  KText(
                    text: title,
                    bold: true,
                  ),
                  if (locationType.value == LocationType.map)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Give it a Name ',
                          bold: true,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              height: 10,
                              child: Checkbox(
                                  checkColor: Colors.white,
                                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: true,
                                  onChanged: (_) {
                                    // isChecked.toggle();
                                  }),
                            ),
                            KText(
                              text: 'Save it',
                              bold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  locationType.value == LocationType.known ||
                          locationType.value == LocationType.warehouse
                      ? TextField(
                          onChanged: q,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchLocationForAll(title);
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
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: KText(text: 'Karim House'),
                            ),
                            Divider(),
                            SizedBox(height: 200, child: MapView()),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  // push(ConfirmMaterialReceiptPage());

                                  Get.snackbar(
                                    'Status',
                                    'unloaded',
                                    colorText: AppTheme.black,
                                    backgroundColor: AppTheme.appHomePageColor,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 34,
                                  width: 150,
                                  // ignore: sort_child_properties_last
                                  child: Center(
                                    child: KText(
                                      text: 'Save',
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: hexToColor('#007BEC'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  if (locationType.value == LocationType.known ||
                      locationType.value == LocationType.warehouse)
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
                        : SizedBox(
                            height: 280,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    (locationType.value == LocationType.known)
                                        ? locations.length
                                        : warehouseList.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      (locationType.value == LocationType.known)
                                          ? locations[index]
                                          : warehouseList[index];

                                  return GestureDetector(
                                    // *
                                    onTap: () {
                                      // kLog(locationType.value);

                                      switch (title) {
                                        case 'Source Location':
                                          if (locationType.value ==
                                              LocationType.known) {
                                            final loc = LocationModel.fromJson(
                                                item as Map<String, dynamic>);
                                            sourceLocation.value = loc;
                                            sourceLocationType.value =
                                                LocationType.known;
                                            back();
                                          }
                                          if (locationType.value ==
                                              LocationType.warehouse) {
                                            final warehouse =
                                                WareHouseModel.fromJson(item
                                                    as Map<String, dynamic>);
                                            sourceLocationWarehouse.value =
                                                warehouse;
                                            sourceLocationType.value =
                                                LocationType.warehouse;

                                            back();
                                          }
                                          break;

                                        case 'Single drop location':
                                          if (locationType.value ==
                                              LocationType.known) {
                                            final loc = LocationModel.fromJson(
                                                item as Map<String, dynamic>);
                                            dropLocation.value = loc;
                                            dropLocationType.value =
                                                LocationType.known;
                                            back();
                                          }
                                          if (locationType.value ==
                                              LocationType.warehouse) {
                                            final warehouse =
                                                WareHouseModel.fromJson(item
                                                    as Map<String, dynamic>);
                                            dropLocationWarehouse.value =
                                                warehouse;
                                            dropLocationType.value =
                                                LocationType.warehouse;
                                            back();
                                          }

                                          break;
                                        default:
                                      }
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (title == 'Source Location' &&
                                              locationType.value ==
                                                  LocationType.warehouse)
                                            KText(
                                              text: '${item['whName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if (title == 'Source Location' &&
                                              locationType.value ==
                                                  LocationType.known)
                                            KText(
                                              text: '${item['locationName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if (title == 'Single drop location' &&
                                              locationType.value ==
                                                  LocationType.warehouse)
                                            KText(
                                              text: '${item['whName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if (title == 'Single drop location' &&
                                              locationType.value ==
                                                  LocationType.known)
                                            KText(
                                              text: '${item['locationName']}',
                                              bold: true,
                                              fontSize: 15,
                                            )
                                        ],
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
      ).then((_) {
        locations.clear();
        warehouseList.clear();
        q.value = '';
        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  void searchSourceLocationForLineItem(OrderLinesModel item) async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 500,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Location Type: ',
                    fontSize: 14,
                    bold: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationType.known;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.known,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Text(
                                'Known Location',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => locationType.value = LocationType.map,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.map,
                                groupValue: locationType.value,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 10.0),
                              child: Text(
                                'Map',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            locationType.value = LocationType.warehouse,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.warehouse,
                                groupValue: locationType.value,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 10.0),
                              child: Text(
                                'Warehouse',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: hexToColor('#515D64'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  KText(
                    text: 'Drop Location',
                    bold: true,
                  ),
                  if (locationType.value == LocationType.map)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Give it a Name ',
                          bold: true,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              height: 10,
                              child: Checkbox(
                                  checkColor: Colors.white,
                                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: true,
                                  onChanged: (_) {
                                    // isChecked.toggle();
                                  }),
                            ),
                            KText(
                              text: 'Save it',
                              bold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  locationType.value == LocationType.known ||
                          locationType.value == LocationType.warehouse
                      ? TextField(
                          onChanged: q,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {},
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
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: KText(text: 'Karim House'),
                            ),
                            Divider(),
                            SizedBox(height: 200, child: MapView()),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  // push(ConfirmMaterialReceiptPage());

                                  Get.snackbar(
                                    'Status',
                                    'unloaded',
                                    colorText: AppTheme.black,
                                    backgroundColor: AppTheme.appHomePageColor,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 34,
                                  width: 150,
                                  // ignore: sort_child_properties_last
                                  child: Center(
                                    child: KText(
                                      text: 'Save',
                                      color: Colors.white,
                                      bold: true,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: hexToColor('#007BEC'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  if (locationType.value == LocationType.known ||
                      locationType.value == LocationType.warehouse)
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
                        : SizedBox(
                            height: 280,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    (locationType.value == LocationType.known)
                                        ? locations.length
                                        : warehouseList.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      (locationType.value == LocationType.known)
                                          ? locations[index]
                                          : warehouseList[index];

                                  return GestureDetector(
                                    // *
                                    onTap: () {
                                      if (locationType.value ==
                                          LocationType.known) {
                                        final loc = LocationModel.fromJson(
                                            item as Map<String, dynamic>);
                                        sourceLocation.value = loc;
                                        sourceLocationType.value =
                                            LocationType.known;
                                      }
                                      if (locationType.value ==
                                          LocationType.warehouse) {
                                        final warehouse =
                                            WareHouseModel.fromJson(
                                                item as Map<String, dynamic>);
                                        sourceLocationWarehouse.value =
                                            warehouse;
                                        sourceLocationType.value =
                                            LocationType.warehouse;
                                      }

                                      if (locationType.value ==
                                          LocationType.known) {
                                        final loc = LocationModel.fromJson(
                                            item as Map<String, dynamic>);
                                        dropLocation.value = loc;
                                        dropLocationType.value =
                                            LocationType.known;
                                        back();
                                      }
                                      if (locationType.value ==
                                          LocationType.warehouse) {
                                        final warehouse =
                                            WareHouseModel.fromJson(
                                                item as Map<String, dynamic>);
                                        dropLocationWarehouse.value = warehouse;
                                        dropLocationType.value =
                                            LocationType.warehouse;
                                        back();
                                      }
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if ('' == 'Source Location' &&
                                              locationType.value ==
                                                  LocationType.warehouse)
                                            KText(
                                              text: '${item['whName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if ('' == 'Source Location' &&
                                              locationType.value ==
                                                  LocationType.known)
                                            KText(
                                              text: '${item['locationName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if ('' == 'Single drop location' &&
                                              locationType.value ==
                                                  LocationType.warehouse)
                                            KText(
                                              text: '${item['whName']}',
                                              bold: true,
                                              fontSize: 15,
                                            ),
                                          if ('' == 'Single drop location' &&
                                              locationType.value ==
                                                  LocationType.known)
                                            KText(
                                              text: '${item['locationName']}',
                                              bold: true,
                                              fontSize: 15,
                                            )
                                        ],
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
      ).then((_) {
        locations.clear();
        warehouseList.clear();
        q.value = '';
        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  void searchData(PartyType partyType) async {
    isLoading.value = true;
    final username = Get.put(UserController()).username;

    final body = {
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'WFC',
      'username': username,
      'searchText': q.value,
    };

    switch (partyType) {
      case PartyType.agency:
        final res = await post(
          path: '/search_agency',
          body: body,
        );
        // kLog(res.data['data']);

        final data = res.data['data'].map((x) => x).toList() as List;

        if (data.isNotEmpty) {
          searchAgency.clear();
          searchAgency.addAll(List.from(data));
          // kLog(searchAgency);
        }
        break;
      case PartyType.person:
        final res = await post(path: '/search_user', body: body);
        //// kLog(res.data['data']);

        final data = res.data['data'] as List;

        if (data.isNotEmpty) {
          searchUsers.clear();
          searchUsers.addAll(List.from(data));
        }
        break;
      default:
    }

    isLoading.value = false;
  }

  //------------------------------------------------------
  // Validate Transport Order Lines
  //------------------------------------------------------
  bool validateTransportOrderLines() {
    final item = transportOrderLines.where((x) => x.quantity == 0);
    //// kLog(item.isEmpty ? true : false);

    return item.isEmpty ? true : false;
  }
  //------------------------------------------------------
  //Get Project Name
  //------------------------------------------------------

  Future<void> getProjectName() async {
    try {
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

      //// kLog(jsonEncode(res.data));
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final pojectInfo = res.data['data']
            .map((json) =>
                ProjectDropdown.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<ProjectDropdown>() as List<ProjectDropdown>;
        if (pojectInfo.isNotEmpty) {
          projectNameList.clear();
          projectNameList.addAll(pojectInfo);
          selectedProject.value = projectNameList[0];
        }

        isLoading.value = false;
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void addTransportOrder() async {
    isLoading.value = true;

    try {
      final transportOrderDate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final currentUser = Get.put(UserController());

      final orderLines = transportOrderLines.map((item) {
        return {
          'lineNo': transportOrderLines.indexOf(item) + 1,
          'productId': item.id,

          // Price and others
          'baseUomQuantity': item.quantity,
          'weightKg': item.weight,
          'basePrice': 0.0,
          'vatAmount': 0.0,
          'grossAmount': 0.0,

          // Drop location
          'dropLocType': (item.dropLocationType == LocationType.known)
              ? 'Known Location'
              : 'Warehouse',
          'dropLocId': (dropLocationType.value == LocationType.known)
              ? dropLocation.value?.id
              : dropLocationWarehouse.value?.id,

          'dropLocName': (dropLocationType.value == LocationType.known)
              ? dropLocation.value?.locationName
              : dropLocationWarehouse.value?.whName,

          'dropLatitude': (dropLocationType.value == LocationType.known)
              ? dropLocation.value?.latitude
              : dropLocationWarehouse.value?.latitude,

          'dropLongitude': (dropLocationType.value == LocationType.known)
              ? dropLocation.value?.longitude
              : dropLocationWarehouse.value?.longitude,
          'distanceKm': 0.0,

          // Drop Warehouse
          'dropWhId': dropLocationWarehouse.value?.id,
          'dropWhCode': dropLocationWarehouse.value?.whCode,
          'dropWhName': dropLocationWarehouse.value?.whName,
          'dropWhAddress': dropLocationWarehouse.value?.whAddress,
          'dropWhManagerFullname': dropLocationWarehouse.value?.managerFullname,
          'dropWhManagerUsername': dropLocationWarehouse.value?.managerUsername,
          'dropWhManagerEmail': dropLocationWarehouse.value?.managerEmail,
          'dropWhManagerMobile': dropLocationWarehouse.value?.managerMobile,

          // Receiver
          'receiverFullname': singleReciverPerson.value?.fullname,
          'receiverUsername': singleReciverPerson.value?.username,
          'receiverEmail': singleReciverPerson.value?.email,
          'receiverMobile': singleReciverPerson.value?.mobile,

          // Inspector
          'inspectorAtDroppingPointFullname':
              goodsInspectorAtDropLocation.value?.fullname,
          'inspectorAtDroppingPointUsername':
              goodsInspectorAtDropLocation.value?.username,
          'inspectorAtDroppingPointEmail':
              goodsInspectorAtDropLocation.value?.email,
          'inspectorAtDroppingPointMobile':
              goodsInspectorAtDropLocation.value?.mobile,
          'inspectorRemarkAtDroppingPoint': null,

          //Other details
          'orderSource': null,
          'bizOrderId': null,
          'bizOrderRefno': null,
          'bizOrderDate': null,
          'etd': null,
          'receivedOn': null,
          'receiverReadyAt': null,
          'receiverRemarkWhileReady': null,
          'receivedQuantity': 0.0,
          'receivedAt': null,
          'receiverRemarkWhileReceived': null,
          'status': null,
          'digest': null,
          'received': false,
          'foundItOkayAtLoadingPoint': false,
          'receiverReady': false,
          'foundItOkayAtDroppingPoint': false,

          //Project
          'projectId': selectedProject.value!.id,
          'projectCode': selectedProject.value!.projectCode,
          'projectName': selectedProject.value!.projectName,
          'pmFullname': selectedProject.value!.pmFullname,
          'pmUsername': selectedProject.value!.pmUsername,
          'pmEmail': selectedProject.value!.pmEmail,
          'pmMobile': selectedProject.value!.pmMobile,
        };
      }).toList();

      //// kLog(jsonEncode(orderLines));
      // return;
      final body = {
        'masterViewModel': {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'username': currentUser.username,
          'agencyIds': [selectedAgency!.agencyId]
        },

        //Ordering Agency
        'orderingAgencyId': selectedAgency.agencyId,
        'orderingAgencyCode': selectedAgency.agencyCode,
        'orderingAgencyName': selectedAgency.agencyName,

        //Transporter Agency
        'transportOrderDate': transportOrderDate,
        'plannedStartDate': plannedStartDate.value,
        'transporterPartyType': (transportPartyType.value == PartyType.agency)
            ? 'AGENCY'
            : 'PERSON',
        'transporterAgencyId': transportAgencyParty.value?.id,
        'transporterAgencyCode': transportAgencyParty.value?.agencyCode,
        'transporterAgencyName': transportAgencyParty.value?.agencyName,
        'transporterFullname': transportPersonParty.value?.fullname,
        'transporterUsername': transportPersonParty.value?.username,
        'transporterEmail': transportPersonParty.value?.email,
        'transporterMobile': transportPersonParty.value?.mobile,

        'baseAmount': 0.0,
        'vatAmount': 0.0,
        'grossAmount': 0.0,
        'cu': 'BDT',
        'totalQuantity': getTotalQuantity(),

        //Inspector at Loading Point
        'inspectorAtLoadingPointFullname':
            goodsInspectorAtLoadingPoint.value?.fullname,
        'inspectorAtLoadingPointUsername':
            goodsInspectorAtLoadingPoint.value?.username,
        'inspectorAtLoadingPointEmail':
            goodsInspectorAtLoadingPoint.value?.email,
        'inspectorAtLoadingPointMobile':
            goodsInspectorAtLoadingPoint.value?.phone,
        'inspectorRemarkAtLoadingPoint': null,

        //Receiver Agency
        'receiverPartyType':
            reciverPartyType.value == PartyType.agency ? 'AGENCY' : 'PERSON',
        'receiverAgencyId': reciverAgencyParty.value?.id,
        'receiverAgencyCode': reciverAgencyParty.value?.agencyCode,
        'receiverAgencyName': reciverAgencyParty.value?.agencyName,

        //Receiver
        'singleReceiver': isSingleRecivingPerson.value,
        'receiverFullname': singleReciverPerson.value?.fullname,
        'receiverUsername': singleReciverPerson.value?.username,
        'receiverEmail': singleReciverPerson.value?.email,
        'receiverMobile': singleReciverPerson.value?.mobile,

        //inspector at DropLocation
        'singleInspectorAtDropLocation': singleInspectorAtDropLocation.value,
        'inspectorAtDropLocationFullname':
            goodsInspectorAtDropLocation.value?.fullname,
        'inspectorAtDropLocationUsername':
            goodsInspectorAtDropLocation.value?.username,
        'inspectorAtDropLocationEmail':
            goodsInspectorAtDropLocation.value?.email,
        'inspectorAtDropLocationMobile':
            goodsInspectorAtDropLocation.value?.mobile,
        'inspectorRemarkAtDropLocation': null,

        //Source Location
        'sourceLocType': (sourceLocationType.value == LocationType.known)
            ? 'Known Location'
            : 'Warehouse',
        'sourceLocId': (sourceLocationType.value == LocationType.known)
            ? sourceLocation.value?.id
            : sourceLocationWarehouse.value?.id,

        'sourceLocName': (sourceLocationType.value == LocationType.known)
            ? sourceLocation.value?.locationName
            : sourceLocationWarehouse.value?.whName,

        'sourceLatitude': (sourceLocationType.value == LocationType.known)
            ? sourceLocation.value?.latitude
            : sourceLocationWarehouse.value?.latitude,

        'sourceLongitude': (sourceLocationType.value == LocationType.known)
            ? sourceLocation.value?.longitude
            : sourceLocationWarehouse.value?.longitude,

        //Source Location Warehouse
        'sourceWhId': sourceLocationWarehouse.value?.id,
        'sourceWhCode': sourceLocationWarehouse.value?.whCode,
        'sourceWhName': sourceLocationWarehouse.value?.whName,
        'sourceWhAddress': sourceLocationWarehouse.value?.whAddress,
        'sourceWhManagerFullname':
            sourceLocationWarehouse.value?.managerFullname,
        'sourceWhManagerUsername':
            sourceLocationWarehouse.value?.managerUsername,
        'sourceWhManagerEmail': sourceLocationWarehouse.value?.managerEmail,
        'sourceWhManagerMobile': sourceLocationWarehouse.value?.managerMobile,

        //Drop Location
        'singleDropLoc': isSingleDropLocation.value,
        'dropLocType': dropLocationType.value == LocationType.known
            ? 'Known Location'
            : 'Warehouse',

        'dropLocId': (dropLocationType.value == LocationType.known)
            ? dropLocation.value?.id
            : dropLocationWarehouse.value?.id,

        'dropLocName': (dropLocationType.value == LocationType.known)
            ? dropLocation.value?.locationName
            : dropLocationWarehouse.value?.whName,

        'dropLatitude': (dropLocationType.value == LocationType.known)
            ? dropLocation.value?.latitude
            : dropLocationWarehouse.value?.latitude,

        'dropLongitude': (dropLocationType.value == LocationType.known)
            ? dropLocation.value?.longitude
            : dropLocationWarehouse.value?.longitude,
        'dropDistanceKm': 0.0,

        //Drop Location Warehouse
        'dropWhId': dropLocationWarehouse.value?.id,
        'dropWhCode': dropLocationWarehouse.value?.whCode,
        'dropWhName': dropLocationWarehouse.value?.whName,
        'dropWhAddress': dropLocationWarehouse.value?.whAddress,
        'dropWhManagerFullname': dropLocationWarehouse.value?.managerFullname,
        'dropWhManagerUsername': dropLocationWarehouse.value?.managerUsername,
        'dropWhManagerEmail': dropLocationWarehouse.value?.managerEmail,
        'dropWhManagerMobile': dropLocationWarehouse.value?.managerMobile,

        //Travel Path
        'latestEtd': etd.value,
        'travelPathId': '',
        'travelPathCode': 'N/A',
        'travelPathName': '',

        'status': 'Draft',
        'statusCode': '01',
        'action': 'CREATE',

        //Enforce
        'isInspectorAtSourceEnforced': enforceInspectorAtDestination.value,
        'isVehicleReadinessEnforced': enforceVehicleReadiness.value,
        'isRecipientReadinessEnforced': enforceRecipientReadiness.value,
        'isInspectorAtDestinationEnforced': enforceInspectorAtDestination.value,
        'isReceivedByReceiverEnforced': enforceReceiptByReceiver.value,

        //Project
        'projectId': selectedProject.value!.id,
        'projectCode': selectedProject.value!.projectCode,
        'projectName': selectedProject.value!.projectName,
        'pmFullname': selectedProject.value!.pmFullname,
        'pmUsername': selectedProject.value!.pmUsername,
        'pmEmail': selectedProject.value!.pmEmail,
        'pmMobile': selectedProject.value!.pmMobile,
        // 'projectId': 'b4cfbd47-7d0d-480a-b10f-35b085817007',
        // 'projectCode': 'BTCLTEST',
        // 'projectName': 'BTCL Test project',
        // 'pmFullname': 'Al Amin Arif',
        // 'pmUsername': 'amin.arif',
        // 'pmEmail': 'md.alamin@cts.com',
        // 'pmMobile': '01521253621',

        //Other Data
        'transportationMode': null,
        'transportType': null,
        'ticketNo': null,
        'driverNames': null,
        'driverUsernames': null,
        'driverMobiles': null,
        'esDate': null,
        'lsDate': null,
        'orderApproverCount': 0,
        'approvedby1Fullname': null,
        'approvedby1Username': null,
        'approvedby1Email': null,
        'approvedby1Mobile': null,
        'approved1On': null,
        'approvedby2Fullname': null,
        'approvedby2Username': null,
        'approvedby2Email': null,
        'approvedby2Mobile': null,
        'approved2On': null,
        'approvedby3Fullname': null,
        'approvedby3Username': null,
        'approvedby3Email': null,
        'approvedby3Mobile': null,
        'approved3On': null,
        'transporterAcceptorFullname': null,
        'transporterAcceptorUsername': null,
        'transporterAcceptorEmail': null,
        'transporterAcceptorMobile': null,
        'transporterAcceptorType': null,
        'transporterAcceptedOn': null,
        'receivingPartyAcceptorFullname': null,
        'receivingPartyAcceptorUsername': null,
        'receivingPartyAcceptorEmail': null,
        'receivingPartyAcceptorMobile': null,
        'receivingPartyAcceptorType': null,
        'receivingPartyAcceptedOn': null,
        'singleDestinationLoc': false,
        'destinationLocId': null,
        'destinationLocName': null,
        'destinationLatitude': 0,
        'destinationLongitude': 0,
        'approver2Passed': false,
        'approver3Passed': false,
        'approver1Passed': false,
        'acceptedByTransporter': false,
        'acceptedByReceivingParty': false,
        'acceptedByReceiver': false,
        'transportingSingleBizOrder': false,
        'digest': null,
        'remarks': remarks.value,

        //Transport Order Lines
        'transportOrderLines': orderLines,
      };

      //  // kLog(jsonEncode(body));

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/add',
        body: body,
      );

      //// kLog(res.data);

      isLoading.value = false;
      if (int.parse('${res.data['responseCode']}') == 200) {
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
                        isLoading.value = false;
                        // back();
                        offAll(MainPage());
                        resetData();
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
      }
    } on DioError catch (e) {
      kLog(e.message);
      isLoading.value = false;
    }
  }

  void deleteLineItem() {}

  // void addLineItem() {
  //   final transportOrderLineItem = TransportOrderLineItem(
  //     expended: true,
  //     productCode: 'A213456',
  //     distance: 30,
  //     quantity: 0,
  //     weight: 0,
  //   );
  //   transportOrderLines.add(transportOrderLineItem);
  // }

  addTransportLineItem() async {
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
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
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
                          searchProduct();
                        },
                        child: RenderSvg(
                          fit: BoxFit.scaleDown,
                          path: 'icon_search_elements',
                          width: 5,
                          color: q.value.isNotEmpty
                              ? hexToColor('#FFA133')
                              : hexToColor('#9BA9B3'),
                        ),
                      ),
                      // focusedBorder: InputBorder.none,
                      hintText: 'Search here..',
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
                          : temptransportOrderLines.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 330,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: temptransportOrderLines.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item =
                                          temptransportOrderLines[index];
                                      return GestureDetector(
                                        onTap: () {
                                          transportOrderLines.add(item);

                                          back();
                                          q.value = '';
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
                                            text: '${item.productName}',
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
        q.value = '';
        temptransportOrderLines.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  // searchLocationBottomsheet(String type) async {
  //   try {
  //     await Get.bottomSheet(
  //       isScrollControlled: true,
  //       persistent: false,
  //       isDismissible: true,

  //       Obx(
  //         () => SingleChildScrollView(
  //           child: Container(
  //             alignment: Alignment.center,
  //             height: 420,
  //             padding: EdgeInsets.symmetric(
  //               horizontal: 20,
  //             ),
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(15.0),
  //                     topRight: Radius.circular(15.0))),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(height: 20),
  //                 TextField(
  //                   onChanged: q,
  //                   decoration: InputDecoration(
  //                     suffixIcon: GestureDetector(
  //                       onTap: () {
  //                         searchUserDefinedLoc();
  //                       },
  //                       child: RenderSvg(
  //                         fit: BoxFit.scaleDown,
  //                         path: 'icon_search_elements',
  //                         width: 5,
  //                         color: hexToColor('#9BA9B3'),
  //                       ),
  //                     ),
  //                     // focusedBorder: InputBorder.none,
  //                     hintText: 'Search here...',
  //                   ),
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     isLoading.value
  //                         ? Column(
  //                             children: [
  //                               SizedBox(
  //                                 height: 130,
  //                               ),
  //                               Center(
  //                                 child: Loading(),
  //                               )
  //                             ],
  //                           )
  //                         : locations.isEmpty
  //                             ? Container()
  //                             : SizedBox(
  //                                 height: 300,
  //                                 child: ListView.builder(
  //                                   shrinkWrap: true,
  //                                   itemCount: locations.length,
  //                                   itemBuilder:
  //                                       (BuildContext context, int index) {
  //                                     final item = locations[index];
  //                                     return GestureDetector(
  //                                       onTap: () {
  //                                         switch (type) {
  //                                           case 'Source Location':
  //                                             final sourceLoc = sourceLat
  //                                                     .value =
  //                                                 item['latitude'] as double;
  //                                             sourceLong.value =
  //                                                 item['latitude'] as double;
  //                                             sourceLocName.value =
  //                                                 item['locationName']
  //                                                     as String;
  //                                            // kLog(sourceLat.value);
  //                                             break;
  //                                           case 'Destination Location':
  //                                             destinationLat.value =
  //                                                 item['latitude'] as double;
  //                                             destinationLong.value =
  //                                                 item['latitude'] as double;
  //                                             destinationLocName.value =
  //                                                 item['locationName']
  //                                                     as String;

  //                                             break;
  //                                           case 'Single drop location':
  //                                             singleDropLat.value =
  //                                                 item['latitude'] as double;
  //                                             singleDropLong.value =
  //                                                 item['latitude'] as double;
  //                                             singleDropLocName.value =
  //                                                 item['locationName']
  //                                                     as String;

  //                                             break;
  //                                           default:
  //                                         }

  //                                         back();
  //                                       },
  //                                       child: Container(
  //                                         padding: EdgeInsets.all(12),
  //                                         decoration: BoxDecoration(
  //                                           border: Border(
  //                                             bottom: BorderSide(
  //                                               color: AppTheme.textColor,
  //                                               width: .2,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         child: KText(
  //                                           text: '${item['locationName']}',
  //                                           bold: true,
  //                                           fontSize: 15,
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),

  //       //backgroundColor: Colors.white,
  //       elevation: 0,
  //     ).then((value) {
  //       q.value = '';
  //       locations.clear();

  //       isLoading.value = false;
  //      // kLog('closed');
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  searchOrderLineDropLocation(TransportOrderLineItem v) async {
    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 500,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KText(
                    text: 'Location Type: ',
                    fontSize: 14,
                    bold: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationType.known;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.known,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Text(
                                'Known Location',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => locationType.value = LocationType.map,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.map,
                                groupValue: locationType.value,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 10.0),
                              child: Text(
                                'Map',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            locationType.value = LocationType.warehouse,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Radio(
                                value: LocationType.warehouse,
                                groupValue: locationType.value,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 10.0),
                              child: Text(
                                'Warehouse',
                                style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 14.0,
                                    color: AppTheme.appTextColor2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: hexToColor('#515D64'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  KText(
                    text: 'Drop location',
                    bold: true,
                  ),
                  // TextField(
                  //   onChanged: q,
                  //   decoration: InputDecoration(
                  //     suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         searchLocationForAll();
                  //       },
                  //       child: RenderSvg(
                  //         fit: BoxFit.scaleDown,
                  //         path: 'icon_search_elements',
                  //         width: 5,
                  //         color: hexToColor('#9BA9B3'),
                  //       ),
                  //     ),
                  //     // focusedBorder: InputBorder.none,
                  //     hintText: 'Search here...',
                  //   ),
                  // ),
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
                          : locations.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: locations.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = locations[index];
                                      return GestureDetector(
                                        onTap: () {
                                          final currentValue =
                                              transportOrderLines.singleWhere(
                                            (x) => x.id == v.id,
                                          );

                                          currentValue.dropLatitude =
                                              item['latitude'] as double;
                                          currentValue.dropLongitude =
                                              item['longitude'] as double;
                                          currentValue.dropLocName =
                                              item['locationName'] as String;

                                          transportOrderLines[
                                              transportOrderLines.indexOf(
                                                  currentValue)] = currentValue;

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
                                            text: '${item['locationName']}',
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
        q.value = '';
        locations.clear();

        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

  searchUserBottomsheet(String type) async {
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
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
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
                                          switch (type) {
                                            case 'Single Receiving Person':
                                              final user = UserModel.fromJson(
                                                  item as Map<String, dynamic>);
                                              singleReciverPerson.value = user;

                                              Get.back();
                                              break;

                                            case 'Single Goods Inspector at the Drop Location':
                                              final user = UserModel.fromJson(
                                                  item as Map<String, dynamic>);

                                              goodsInspectorAtDropLocation
                                                  .value = user;

                                              Get.back();
                                              break;

                                            case 'Goods Inspector at the Loading Point':
                                              final user = UserModel.fromJson(
                                                  item as Map<String, dynamic>);

                                              goodsInspectorAtLoadingPoint
                                                  .value = user;

                                              Get.back();
                                              break;
                                          }
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
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Image.asset(
                                                            '${Constants.imgPath}/icon_avatar.png',
                                                            width: 37,
                                                            height: 37,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: 240,
                                                            child: KText(
                                                              text:
                                                                  '${item['email']}',
                                                              color: hexToColor(
                                                                  '#72778F'),
                                                              bold: true,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: 240,
                                                            child: KText(
                                                              text:
                                                                  '${item['mobile']}',
                                                              color: hexToColor(
                                                                  '#72778F'),
                                                              bold: true,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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

  searchUserForDropLineITem(TransportOrderLineItem v, String type) async {
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
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
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
                                          // final currentValue =
                                          //     transportOrderLines.singleWhere(
                                          //   (x) => x.id == v.id,
                                          // );
                                          // switch (type) {
                                          //   case 'inspector':
                                          //     currentValue.goodsInspector =
                                          //         item['fullname'] as String;

                                          //     break;
                                          //   case 'receiver':
                                          //     currentValue.receiverEmail =
                                          //         item['email'] as String;
                                          //     currentValue.receiverFullname =
                                          //         item['fullname'] as String;
                                          //     currentValue.receiverMobile =
                                          //         item['mobile'] as String;
                                          //     currentValue.receiverUsername =
                                          //         item['username'] as String;

                                          //     break;
                                          //   default:
                                          // }

                                          // transportOrderLines[
                                          //     transportOrderLines.indexOf(
                                          //         currentValue)] = currentValue;

                                          // back();
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
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Image.asset(
                                                            '${Constants.imgPath}/icon_avatar.png',
                                                            width: 37,
                                                            height: 37,
                                                          ),
                                                        ),
                                                      ),
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
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 240,
                                                          child: KText(
                                                            text:
                                                                '${item['email']}',
                                                            color: hexToColor(
                                                                '#72778F'),
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 240,
                                                          child: KText(
                                                            text:
                                                                '${item['mobile']}',
                                                            color: hexToColor(
                                                                '#72778F'),
                                                            bold: true,
                                                          ),
                                                        ),
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

  searchProduct() async {
    try {
      if (q.value.isNotEmpty) {
        isLoading.value = true;

        final selectedAgency = Get.put(AgencyController()).selectedAgency;
        final username = Get.put(UserController()).username;
        final body = {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'username': username,
          'agencyIds': [selectedAgency!.agencyId],
          'searchText': q.value
        };
        final res = await postDynamic(
          path: '${dotenv.env['BASE_URL_WFC']}/v1/products-by-agency/search',
          body: body,
        );

        //// kLog(jsonEncode(res.data['data']));
        final data = res.data['data']
            .map((json) {
              final item =
                  TransportOrderLineItem.fromJson(json as Map<String, dynamic>);

              item.expended = true;
              item.weight = 0;
              item.quantity = 0;
              item.transportationFee = '00';
              return item;
            })
            .toList()
            .cast<TransportOrderLineItem>() as List<TransportOrderLineItem>;
        //// kLog(data);
        temptransportOrderLines.clear();
        temptransportOrderLines.addAll(data);
        isLoading.value = false;
        q.value = '';
      } else {
        print('object');
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  exapndItem(TransportOrderLineItem v) {
    final item = transportOrderLines.singleWhere((x) => x.id == v.id);

    item.expended = item.expended! ? false : true;

    transportOrderLines[transportOrderLines.indexOf(item)] = item;
  }

  void updateItem(
    TransportOrderLineItem currentItem,
    UpdateInputType type,
    num value,
  ) {
    final item = transportOrderLines.singleWhere((x) => x.id == currentItem.id);

    switch (type) {
      case UpdateInputType.kg:
        item.weight = value;

        transportOrderLines[transportOrderLines.indexOf(item)] = item;
        break;
      case UpdateInputType.pcs:
        item.quantity = value;

        transportOrderLines[transportOrderLines.indexOf(item)] = item;
        break;
    }
  }

  deleteItem(TransportOrderLineItem item) {
    transportOrderLines.remove(item);
  }

  num getTotalQuantity() {
    num quantity = 0.0;
    for (final x in transportOrderLines) {
      quantity += x.quantity!;
    }
    return quantity;
  }

  searchLocationForAll(String title) async {
    final currentUser = Get.put(UserController()).currentUser;

    final currentAgency = Get.put(AgencyController()).selectedAgency;

    isLoading.value = true;
    switch (title) {
      case 'Source Location':
        if (locationType.value == LocationType.known) {
          // kLog(locationType.value);
          final body = {
            'username': currentUser.value?.username,
            'agencyIds': [currentAgency?.agencyId],
            'searchText': q.value,
            'uiCodes': ['122011'],
            'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
            'appCode': 'SHOUT'
          };
          final res = await postDynamic(
            path: '${dotenv.env['BASE_URL_GIS']}/search_user_defined_location',
            body: body,
          );
          //// kLog(res.data['data']);

          final data = res.data['data'] as List;

          if (data.isNotEmpty) {
            locations.clear();
            locations.addAll(data);
            //// kLog(locations);
          }
          isLoading.value = false;
          break;
        }
        if (locationType.value == LocationType.warehouse) {
          // kLog(locationType.value);
          final body = {
            'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
            'appCode': 'WFC',
            'username': currentUser.value?.username,
            'agencyIds': [currentAgency?.agencyId],
            'searchText': q.value
          };

          final res = await postDynamic(
            path:
                '${dotenv.env['BASE_URL_WFC']}/v1/warehouses-by-agency/search',
            body: body,
          );
          // kLog(res.data['data']);

          final data = res.data['data'] as List;

          if (data.isNotEmpty) {
            warehouseList.clear();
            warehouseList.addAll(data);
            //// kLog(locations);
            isLoading.value = false;
          }
          isLoading.value = false;
        }
        break;
      case 'Single drop location':
        if (locationType.value == LocationType.known) {
          // kLog(locationType.value);
          final body = {
            'username': currentUser.value?.username,
            'agencyIds': [currentAgency?.agencyId],
            'searchText': q.value,
            'uiCodes': ['122011'],
            'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
            'appCode': 'SHOUT'
          };
          final res = await postDynamic(
            path: '${dotenv.env['BASE_URL_GIS']}/search_user_defined_location',
            body: body,
          );
          //// kLog(res.data['data']);

          final data = res.data['data'] as List;

          if (data.isNotEmpty) {
            locations.clear();
            locations.addAll(data);
            //// kLog(locations);
          }
          isLoading.value = false;
          break;
        }
        if (locationType.value == LocationType.warehouse) {
          // kLog(locationType.value);
          final body = {
            'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
            'appCode': 'WFC',
            'username': currentUser.value?.username,
            'agencyIds': [currentAgency?.agencyId],
            'searchText': q.value,
          };
          final res = await postDynamic(
            path:
                '${dotenv.env['BASE_URL_WFC']}/v1/warehouses-by-agency/search',
            body: body,
          );
          //// kLog(res.data['data']);

          final data = res.data['data'] as List;

          if (data.isNotEmpty) {
            warehouseList.clear();
            warehouseList.addAll(data);
            //// kLog(locations);
            isLoading.value = false;
          }
          isLoading.value = false;
        }
        break;
    }
  }

  searchPersons() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': q.value,
      'uiCodes': ['122011'],
      'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
      'appCode': 'SHOUT'
    };
    final res = await post(path: '/search_user', body: body);
    //// kLog(res.data['data']);

    final data = res.data['data'] as List;

    if (data.isNotEmpty) {
      searchUsers.clear();
      searchUsers.addAll(data);
    }
    isLoading.value = false;
  }

  String? getSourcelocationName() {
    switch (sourceLocationType.value) {
      case LocationType.known:
        if (sourceLocation.value != null) {
          return sourceLocation.value?.locationName;
        } else {
          return null;
        }
      case LocationType.warehouse:
        if (sourceLocationWarehouse.value != null) {
          return sourceLocationWarehouse.value?.whName;
        } else {
          return null;
        }

      default:
        return null;
    }
  }

  String? getTransportPartyName() {
    switch (transportPartyType.value) {
      case PartyType.person:
        if (transportPersonParty.value != null) {
          return transportPersonParty.value?.fullname;
        } else {
          return null;
        }
      case PartyType.agency:
        if (transportAgencyParty.value != null) {
          return transportAgencyParty.value?.agencyName;
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  String? getReciverPartyName() {
    switch (reciverPartyType.value) {
      case PartyType.person:
        if (reciverParsonParty.value != null) {
          return reciverParsonParty.value?.fullname;
        } else {
          return null;
        }
      case PartyType.agency:
        if (reciverAgencyParty.value != null) {
          return reciverAgencyParty.value?.agencyName;
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  String? getDropLocationName() {
    switch (dropLocationType.value) {
      case LocationType.known:
        if (dropLocation.value != null) {
          return dropLocation.value?.locationName;
        } else {
          return null;
        }
      case LocationType.warehouse:
        if (dropLocationWarehouse.value != null) {
          return dropLocationWarehouse.value?.whName;
        } else {
          return null;
        }

      default:
        return null;
    }
  }

  String? getSingleRecivingPerson() {
    if (singleReciverPerson.value != null) {
      return singleReciverPerson.value?.fullname;
    } else {
      return null;
    }
  }

  String? getSingleGoodsInspectorAtDropLocation() {
    if (goodsInspectorAtDropLocation.value != null) {
      return goodsInspectorAtDropLocation.value?.fullname;
    } else {
      return null;
    }
  }

  String? getGoodsInspectorAtLoadingPoint() {
    if (goodsInspectorAtLoadingPoint.value != null) {
      return goodsInspectorAtLoadingPoint.value?.fullname;
    } else {
      return null;
    }
  }

  bool validateTrasnportOrder() {
    if (transportAgencyParty.value != null &&
        reciverAgencyParty.value != null &&
        isSingleRecivingPerson.value == true &&
        isSingleRecivingPerson.value != null &&
        sourceLocationWarehouse.value != null &&
        isSingleDropLocation.value == true &&
        (dropLocation.value != null || dropLocationWarehouse.value != null) &&
        plannedStartDate.value.isNotEmpty &&
        etd.value.isNotEmpty &&
        goodsInspectorAtLoadingPoint.value != null &&
        isSinglegoodsInspector.value == true &&
        goodsInspectorAtDropLocation.value != null &&
        selectedProject.value != null) {
      return true;
    }
    return false;
  }

  void resetData() {
    transportParty.value = '';
    recivingParty.value = '';
    singleReciverName.value = '';
    singleReciverPartyName.value = '';
    singleDropLocName.value = '';
    singleDropLat.value = 0.0;
    singleDropLong.value = 0.0;
    transportOrderDate.value = '';
    goodsInspectorAtLoadingPointName.value = '';
    goodsInspectorAtLoadingPointUsername.value = '';
    goodsInspectorAtLoadingPointEmail.value = '';
    singleGoodsInspectorDropLocFullName.value = '';
    singleGoodsInspectorDropLocUsername.value = '';
    singleGoodsInspectorDropLocEmail.value = '';
    sourceLocName.value = '';
    etd.value = '';
    sourceLat.value = 0.0;
    sourceLong.value = 0.0;
    sourceLocName.value = '';
    destinationLocName.value = '';
    destinationLat.value = 0.0;
    destinationLong.value = 0.0;
    transportOrderLines.clear();

    transportPartyType.value = PartyType.person;
    reciverPartyType.value = PartyType.person;

    transportAgencyParty.value = null;
    transportPersonParty.value = null;

    reciverAgencyParty.value = null;
    reciverParsonParty.value = null;

    sourceLocation.value = null;
    sourceLocationWarehouse.value = null;
    sourceLocationType.value = LocationType.warehouse;

    locationType.value = LocationType.warehouse;

    dropLocation.value = null;
    dropLocationWarehouse.value = null;
    dropLocationType.value = LocationType.warehouse;

    singleReciverPerson.value = null;

    warehouseList.clear();
// **
    // final inspectorAtLoadingPoint = Rx<UserModel?>(null);

    inspectorAtDropLocation.value = null;

    singleInspectorAtDropLocation.value = true;

    isSingleRecivingPerson.value = true;

    singleRecivingPerson.value = null;

    goodsInspectorAtDropLocation.value = null;

    goodsInspectorAtLoadingPoint.value = null;
  }
}
