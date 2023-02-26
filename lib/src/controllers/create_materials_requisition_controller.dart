import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:workforce/src/config/api_endpoint.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/geography.dart';
import 'package:workforce/src/models/map_data.dart';
import 'package:workforce/src/models/material_item.dart';
import 'package:workforce/src/models/project_dropdown.dart';
import 'package:workforce/src/models/transport_order_line_item.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:get/get.dart';

class CreateMaterialsRequisitionController extends GetxController
    with ApiService {
//token

  //checkbox and datepicker
  final isChecked = RxBool(true);
  final selectedDate = RxString('');
  DateTime? eTD;

  //remaks and search
  final overAllRemarks = RxString('');
  final search = RxString('');
  final srcMaterial = RxString('');
  final srcText = RxString('');
  final srcLoccation = RxString('');

  //radio button
  final locationType = Rx<LocationDelivary>(LocationDelivary.known);
  final loadFrom = Rx<LoadFrom>(LoadFrom.nmsBudget);
  final selectedParty = Rx<PartyType>(PartyType.person);

//supplyinf and ordaring party
  final searchAgency = RxList();
  final suplyingParty = RxString('');
  final orderingParty = RxString('');
  final searchUsers = RxList();
  final supplierUsername = RxString('');
  final supplierEmail = RxString('');
  final supplierMobile = RxString('');
  final supplyingAgencyId = RxString('');
  final supplyingAgencyCode = RxString('');
  final supplierPartyType = RxString('');

  final ordererUsername = RxString('');
  final ordererEmail = RxString('');
  final ordererMobile = RxString('');
  final orderingAgencyId = RxString('');
  final orderingAgencyCode = RxString('');
  final ordererPartyType = RxString('');
//delivary location

  final delivaryLocName = RxString('');
  final delivaryLocId = RxString('');
  final delivaryLat = RxDouble(0.0);
  final delivaryLong = RxDouble(0.0);
  final locations = RxList();
  final warehouses = RxList();
  final projectBudget = RxList<MaterialItem>();
  final geographyList = RxList<Geograpphy>();
  final geograpphies = RxList<Geograpphy>();

  final isLoading = RxBool(false);

  final levelCode = RxList();

//projectName Dropdown
  final projectNameList = RxList<ProjectDropdown>();
  final projectName = RxString('');
  final projectId = RxString('');
  final projectCode = RxString('');
  final kMapController = MapController();

  final pickLocation = Rx<MapData?>(null);

  //final geograpphies = Rx<Geograpphy?>(null);

  final srcProduct = RxString('');
  final srchWarehouse = RxString('');

  final productList = RxList<TransportOrderLineItem>();
  final productItemList = RxList<TransportOrderLineItem>();
  final materialItemList = RxList<MaterialItem>();

  final levelFullCodes = RxString('');

//date picker
  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      selectedDate.value = formatDate(date: pickedDate.toString());

      eTD = pickedDate;
    } else {}
  }

//Delivary location bottom sheet
  locationBottomSheet() async {
    Color getColor(Set<MaterialState> states) {
      Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.searchColor;
    }

    try {
      await Get.bottomSheet(
        isScrollControlled: true,
        persistent: false,
        isDismissible: true,

        Obx(
          () => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 460,
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
                  // SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: KText(
                      text: 'Location Type: ',
                      fontSize: 14,
                      bold: true,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          locationType.value = LocationDelivary.known;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.known,
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
                        onTap: () {
                          locationType.value = LocationDelivary.map;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.map,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
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
                          locationType.value = LocationDelivary.warehouse;
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                              height: 15.0,
                              child: Radio(
                                value: LocationDelivary.warehouse,
                                groupValue: locationType.value,
                                // activeColor: Colors.green,
                                onChanged: locationType,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                              ),
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

                  if (locationType.value == LocationDelivary.known)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Search Delivery Location',
                          bold: true,
                        ),
                        TextField(
                          onChanged: search,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchUserDefinedLoc();
                                print('pressed');
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
                                    height: 250,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: locations.length,
                                        itemBuilder: (context, index) {
                                          final item = locations[index];
                                          return GestureDetector(
                                            onTap: () {
                                              delivaryLocName.value =
                                                  item['locationName']
                                                      as String;
                                              delivaryLocId.value =
                                                  item['id'] as String;
                                              delivaryLat.value =
                                                  item['latitude'] as double;
                                              delivaryLong.value =
                                                  item['longitude'] as double;

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
                                        }),
                                  ),
                      ],
                    ),

                  if (locationType.value == LocationDelivary.map)
                    Column(
                      children: [
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
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: isChecked.value,
                                      onChanged: (_) {
                                        isChecked.toggle();
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: KText(
                              text: delivaryLocName.value == null
                                  ? ''
                                  : delivaryLocName.value),
                        ),
                        Divider(),
                        SizedBox(
                          height: 200,
                          child: FutureBuilder<LocationData?>(
                              future: currentLocation(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapchat) {
                                if (snapchat.hasData) {
                                  final LocationData currentLocation =
                                      snapchat.data as LocationData;
                                  print(currentLocation.latitude);
                                  // ignore: unused_local_variable
                                  final position = LatLng(
                                      currentLocation.latitude!,
                                      currentLocation.latitude!);
                                  return Stack(children: [
                                    FlutterMap(
                                      mapController: kMapController,
                                      options: MapOptions(
                                        // center: position,
                                        center: LatLng(23.773229395435163,
                                            90.41131542577997),
                                        zoom: 15,
                                        maxZoom: 20,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.ctrendssoftware.workforce',
                                        ),
                                        MarkerLayer(
                                          markers: [],
                                        ),
                                      ],
                                    ),
                                    Positioned.fill(
                                        child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          pickData();
                                          delivaryLocName.value = pickLocation
                                              .value!.displayName as String;
                                          delivaryLocId.value = pickLocation
                                              .value!.osmId
                                              .toString();
                                          delivaryLat.value = double.parse(
                                              pickLocation.value!.lat!);
                                          delivaryLong.value = double.parse(
                                              pickLocation.value!.lon!);
                                        },
                                        child: Icon(
                                          Icons.location_pin,
                                          size: 50,
                                          color: AppTheme.color2,
                                        ),
                                      ),
                                    )),
                                  ]);
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              // pickData();
                              // delivaryLocName.value = pickLocation.value!.displayName as String;
                              // delivaryLocId.value = pickLocation.value!.osmId.toString();
                              // delivaryLat.value = double.parse(pickLocation.value!.lat!);
                              // delivaryLong.value = double.parse(pickLocation.value!.lon!);
                              back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 34,
                              width: 150,
                              // ignore: sort_child_properties_last
                              child: Center(
                                child: KText(
                                  text: 'Select',
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

                  if (locationType.value == LocationDelivary.warehouse)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Search Warehouse',
                          bold: true,
                        ),
                        TextField(
                          onChanged: srchWarehouse,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchWarehouse();
                                print('pressed');
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
                            : warehouses.isEmpty
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
                                    height: 250,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: warehouses.length,
                                        itemBuilder: (context, index) {
                                          final item = warehouses[index];
                                          return GestureDetector(
                                            onTap: () {
                                              delivaryLocName.value =
                                                  item['whAddress'] as String;
                                              delivaryLocId.value =
                                                  item['id'] as String;
                                              delivaryLat.value =
                                                  item['latitude'] as double;
                                              delivaryLong.value =
                                                  item['longitude'] as double;

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
                                                text: '${item['whName']}',
                                                bold: true,
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                      ],
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
        srchWarehouse.value = '';
        locations.clear();
        warehouses.clear();
        isLoading.value = false;
        // kLog('closed');
      });
    } catch (e) {
      print(e);
    }
  }

//Material BottomSheet
  searchMaterialBottomSheet() async {
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
                    text: 'Search Material',
                    bold: true,
                  ),
                  TextField(
                    onChanged: srcProduct,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          searchProduct();
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
                          : productList.isEmpty
                              ? Container()
                              : SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: productList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = productList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          productItemList.add(item);
                                          // srcMaterial.value = item.productFullcode as String;
                                          // searchMaterial();
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
        srcProduct.value = '';

        productList.clear();
        isLoading.value = false;
      });
    } catch (e) {
      print(e);
    }
  }

//Supplying and Ordering Party Bottom Sheet
  Future<void> openBottomSheet(String title, String value) async {
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
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
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
                  onChanged: srcText,
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
                                          case 'Supplying Party':
                                            suplyingParty.value =
                                                '${item['agencyName']}';
                                            supplyingAgencyId.value =
                                                '${item['id']}';
                                            supplyingAgencyCode.value =
                                                '${item['agencyCode']}';
                                            supplierPartyType.value = 'agency';
                                            Get.back();
                                            break;
                                          case 'Ordering Party':
                                            orderingParty.value =
                                                '${item['agencyName']}';
                                            orderingAgencyId.value =
                                                '${item['id']}';
                                            orderingAgencyCode.value =
                                                '${item['agencyCode']}';
                                            ordererPartyType.value = 'agency';
                                            Get.back();
                                            break;
                                          default:
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
                                          case 'Supplying Party':
                                            suplyingParty.value =
                                                '${item['fullname']}';
                                            supplierUsername.value =
                                                '${item['username']}';
                                            supplierMobile.value =
                                                '${item['mobile']}';
                                            supplierEmail.value =
                                                '${item['email']}';
                                            supplierPartyType.value = 'person';
                                            Get.back();
                                            break;
                                          case 'Ordering Party':
                                            orderingParty.value =
                                                '${item['fullname']}';

                                            ordererUsername.value =
                                                '${item['username']}';
                                            ordererMobile.value =
                                                '${item['mobile']}';
                                            ordererEmail.value =
                                                '${item['email']}';
                                            ordererPartyType.value = 'person';
                                            Get.back();
                                            break;
                                          default:
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
                                                  // right: 2,
                                                  left: 10,
                                                ),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: 230,
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
                                                          width: 230,
                                                          child: KText(
                                                            text:
                                                                '${item['email']}',
                                                            fontSize: 12,
                                                            color: hexToColor(
                                                                '#72778F'),
                                                          ),
                                                        ),
                                                      ),
                                                    if (selectedParty.value ==
                                                        PartyType.person)
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
                )
              ],
            ),
          ),
        ),
      ),

      //backgroundColor: Colors.white,
      elevation: 0,
    ).then((value) {
      srcText.value = '';
      searchUsers.clear();
      searchAgency.clear();
      isLoading.value = false;
      // kLog('closed');
    });
  }

  projectNameDropdown() async {
    getProjectName();
    await Get.defaultDialog(
        backgroundColor: Colors.transparent,
        content: Obx(
          () => Container(
            height: 400,
            width: Get.width,
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
                          projectName.value = item.projectName as String;
                          projectId.value = item.id as String;
                          projectCode.value = item.projectCode as String;
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
                          child:
                              Center(child: KText(text: '${item.projectName}')),
                        ),
                      );
                    }),
          ),
        ));
  }

  loadFromBudget() async {
    await Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '',
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        content: Obx(
          () => Column(
            children: [
              Container(
                height: 34,
                width: Get.width,
                decoration: BoxDecoration(
                  color: hexToColor('#DBECFB'),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: KText(
                  text: 'Load From :',
                  fontSize: 18,
                  bold: true,
                ),
              ),
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          loadFrom.value = LoadFrom.nmsBudget;
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Radio(
                                value: LoadFrom.nmsBudget,
                                groupValue: loadFrom.value,
                                // activeColor: Colors.green,
                                onChanged: loadFrom,
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Text(
                                'NMS Budget (From Network design BoQ)',
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
                          loadFrom.value = LoadFrom.projectBudget;
                          getMaterialProjectBudget();
                          back();
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Radio(
                                value: LoadFrom.projectBudget,
                                groupValue: loadFrom.value,
                                // activeColor: Colors.green,
                                onChanged: loadFrom,
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Text(
                                'Project Budget',
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
                    ]),
              )
            ],
          ),
        ));
  }

//Material BottomSheet
  geographiesBottomSheet() async {
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
                    text: 'Search Location',
                    bold: true,
                  ),
                  TextField(
                    onChanged: srcLoccation,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          addGeography();
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
                      : geograpphies.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: RenderSvg(
                                  path: 'search_list',
                                  width: 60,
                                  color: hexToColor('#9BA9B3'),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: geograpphies.length,
                                  itemBuilder: (context, index) {
                                    final item = geograpphies[index];
                                    return GestureDetector(
                                      onTap: () {
                                        geographyList.add(item);
                                        levelCode.add(item.levelFullcode);
                                        back();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 30,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: AppTheme.bdrColor))),
                                        child: KText(text: item.geoLevel4Name),
                                      ),
                                    );
                                  }),
                            ),

                  //   if (geograpphies.value != null)
                ],
              ),
            ),
          ),
        ),

        //backgroundColor: Colors.white,
        elevation: 0,
      ).then((value) {
        srcLoccation.value = '';
        geograpphies.clear();
        isLoading.value = false;
      });
    } catch (e) {
      print(e);
    }
  }

//Supplying and Ordering Party Api Integrate
  void searchData(PartyType partyType) async {
    isLoading.value = true;

    final username = Get.put(UserController()).username;
    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'searchText': srcText.value,
    };

    switch (partyType) {
      case PartyType.agency:
        final res =
            await postDynamic(path: ApiEndpoint.getAgencyUrl(), body: body);
        //  // kLog(res.data['data']);

        final data = res.data['data'].map((x) => x).toList() as List;

        if (data.isNotEmpty) {
          searchAgency.clear();
          searchAgency.addAll(List.from(data));
        }
        break;
      case PartyType.person:
        final res =
            await postDynamic(path: ApiEndpoint.srcUserUrl(), body: body);
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

  void getMaterialProjectBudget() async {
    levelFullCodes.value = levelCode.join(',');
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    isLoading.value = true;

    final params = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'agencyIds': selectedAgency!.agencyId,
      'levelFullCodes': levelFullCodes.value,
    };

    // kLog(params);

    final res = await getDynamic(
        path: ApiEndpoint.getmaterialProjectBudgetUrl(),
        queryParameters: params);
    // kLog(res.data);
    final data = res.data['data']
        .map((json) {
          final item = MaterialItem.fromJson(json as Map<String, dynamic>);
          item.id = getUniqeId();
          return item;
        })
        .toList()
        .cast<MaterialItem>() as List<MaterialItem>;

    if (data.isNotEmpty) {
      projectBudget.clear();
      projectBudget.addAll(data);
      isLoading.value = false;
      // kLog(projectBudget.length);
    }
  }

//Known Location Api Integrate
  searchUserDefinedLoc() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': search.value,
      'uiCodes': ['122011'],
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.SHOUT_APP_CODE,
    };
    final res =
        await postDynamic(path: ApiEndpoint.srcUserLocationUrl(), body: body);

    final data = res.data['data'] as List;

    locations.clear();
    locations.addAll(data);

    isLoading.value = false;
  }

  searchWarehouse() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': srchWarehouse.value,
    };
    final res =
        await postDynamic(path: ApiEndpoint.getWarehouseUrl(), body: body);
    // kLog(res.data);
    final data = res.data['data'] as List;

    warehouses.clear();
    warehouses.addAll(data);

    isLoading.value = false;
  }

//get Project Name  Api Integrate
  void getProjectName() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final params = {
      'agencyIds': selectedAgency!.agencyId,
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
    };

    final res = await getDynamic(
      path: ApiEndpoint.getProjectNameUrl(),
      queryParameters: params,
    );

    final pojectInfo = res.data['data']
        .map((json) {
          final item = ProjectDropdown.fromJson(json as Map<String, dynamic>);

          return item;
        })
        .toList()
        .cast<ProjectDropdown>() as List<ProjectDropdown>;
    projectNameList.clear();
    projectNameList.addAll(pojectInfo);

    isLoading.value = false;
  }

//Material Api Integrate

  searchProduct() async {
    isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.WFC_APP_CODE,
      'username': username,
      'agencyIds': [selectedAgency!.agencyId],
      'searchText': srcProduct.value
    };
    final res = await postDynamic(
      path: ApiEndpoint.productSrcUrl(),
      body: body,
    );

    // kLog(res.data);
    final data = res.data['data']
        .map((json) {
          final item =
              TransportOrderLineItem.fromJson(json as Map<String, dynamic>);
          item.productId = getUniqeId();
          item.expended = true;
          item.weight = 0;
          item.quantity = 0;
          item.transportationFee = '00';
          return item;
        })
        .toList()
        .cast<TransportOrderLineItem>() as List<TransportOrderLineItem>;

    productList.clear();
    productList.addAll(data);
    isLoading.value = false;
  }

  searchMaterial() async {
    isLoading.value = true;
    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.SURVEY_APP_CODE,
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'searchText': srcMaterial.value,
      'levelFullcode': levelCode,
    };
    final res = await postDynamic(
      path: ApiEndpoint.materialRequisitionProductSrcUrl(),
      body: body,
    );

    // kLog(body);
    // kLog(res.data);
    final data = res.data['data']
        .map((json) {
          final item = MaterialItem.fromJson(json as Map<String, dynamic>);
          item.id = getUniqeId();
          return item;
        })
        .toList()
        .cast<MaterialItem>() as List<MaterialItem>;

    materialItemList.addAll(data);
  }

  addGeography() async {
    isLoading.value = true;
    final body = {
      'apiKey': ApiEndpoint.KYC_API_KEY,
      'appCode': ApiEndpoint.SURVEY_APP_CODE,
      'uiCodes': ['0000'],
      'areaLevel': 4,
      'areaType': 'COUNTRY UNIT',
      'countryCode': 'BD',
      'searchText': srcLoccation.value
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

    geograpphies.clear();
    geograpphies.addAll(data);
    isLoading.value = false;
  }

  Future<LocationData?> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  //Future<MapData>
  pickData() async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${kMapController.center.latitude}&lon=${kMapController.center.longitude}&zoom=18&addressdetails=1';

    final res = await postDynamic(
      path: url,
    );

    final mapData = MapData.fromJson(res.data as Map<String, dynamic>);
    pickLocation.value = mapData;
  }

  void postMaterialRequisition() async {
    //   isLoading.value = true;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    final username = Get.put(UserController()).username;
    final body = {
      'masterViewModel': {
        'apiKey': ApiEndpoint.KYC_API_KEY,
        'appCode': ApiEndpoint.WFC_APP_CODE,
        'username': username,
        'agencyIds': [selectedAgency!.agencyId]
      },
      'countryCode': '346344',
      'countryName': 'Bangladesh',
      'requisitionDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'etdDate': DateFormat('yyyy-MM-dd').format(eTD!),
      'projectId': projectId.value,
      'projectCode': projectCode.value,
      'projectName': projectName.value,
      'dropLocId': delivaryLocId.value,
      'dropLocName': delivaryLocName.value,
      'dropLatitude': delivaryLat.value,
      'dropLongitude': delivaryLong.value,
      'ordererPartyType': ordererPartyType.value,
      'ordererFullname':
          selectedParty.value == PartyType.person ? orderingParty.value : '',
      'ordererUsername':
          selectedParty.value == PartyType.person ? ordererUsername.value : '',
      'ordererEmail':
          selectedParty.value == PartyType.person ? ordererEmail.value : '',
      'ordererMobile':
          selectedParty.value == PartyType.person ? ordererMobile.value : '',
      'orderingAgencyId':
          selectedParty.value == PartyType.agency ? orderingAgencyId.value : '',
      'orderingAgencyCode': selectedParty.value == PartyType.agency
          ? orderingAgencyCode.value
          : '',
      'orderingAgencyName':
          selectedParty.value == PartyType.agency ? orderingParty.value : '',
      'supplierPartyType': supplierPartyType.value,
      'supplierFullname':
          selectedParty.value == PartyType.person ? suplyingParty.value : '',
      'supplierUsername':
          selectedParty.value == PartyType.person ? supplierUsername.value : '',
      'supplierEmail':
          selectedParty.value == PartyType.person ? supplierEmail.value : '',
      'supplierMobile':
          selectedParty.value == PartyType.person ? supplierMobile.value : '',
      'supplyingAgencyId': selectedParty.value == PartyType.agency
          ? supplyingAgencyId.value
          : '',
      'supplyingAgencyCode': selectedParty.value == PartyType.agency
          ? supplyingAgencyCode.value
          : '',
      'supplyingAgencyName':
          selectedParty.value == PartyType.agency ? suplyingParty.value : '',
      'overallRemarks': overAllRemarks.value,
      'areaIds': [],
      'materialRequisitionLines': projectBudget.map((item) {
        return {
          'productId': item.productId,
          'productCode': item.productFullcode,
          'baseUomQuantity': item.poleCnt.toString(),
          'dropLocId': '',
          'dropLocName': '',
          'dropLatitude': '',
          'dropLongitude': ''
        };
      }).toList(),
    };

    final res = await postDynamic(
      path: ApiEndpoint.materialRequisitionAddUrl(),
      body: body,
    );

    if (int.parse('${res.data['responseCode']}') == 200) {
      Get.defaultDialog(
          barrierDismissible: false,
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
                    text: 'Created successfully',
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
                      // offAll(MainPage());
                      // transportOrderLines.clear();
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
  }

  updateItem(
    TransportOrderLineItem currentItem,
    int value,
  ) {
    final item = productItemList.singleWhere((x) => x.id == currentItem.id);

    item.quantity = value;

    productItemList[productItemList.indexOf(item)] = item;
  }

  updatePole(
    MaterialItem currentItem,
    int value,
  ) {
    final item = projectBudget.singleWhere((x) => x.id == currentItem.id);

    item.poleCnt = value;

    projectBudget[projectBudget.indexOf(item)] = item;
  }
}
