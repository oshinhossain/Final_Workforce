import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../controllers/inspect_materials_at_drop_location_controller.dart';
import '../helpers/loading.dart';

class InspectMaterialsToDropLocationPage extends StatefulWidget {
  final String? transportOrderNo;
  final String? vehicleRegistrationNo;
  final bool? isFromNotification;

  InspectMaterialsToDropLocationPage({
    this.transportOrderNo,
    this.vehicleRegistrationNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InspectMaterialsToDropLocationPageState createState() =>
      _InspectMaterialsToDropLocationPageState();
}

class _InspectMaterialsToDropLocationPageState
    extends State<InspectMaterialsToDropLocationPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );

    //***************************************//
    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      inspectMaterialsDropLocationC.getInspectMaterialsDropLocation(
        transportOrderNo: widget.transportOrderNo!,
        vehicleRegistrationNo: widget.vehicleRegistrationNo!,
      );
    } else {
      inspectMaterialsDropLocationC.getInspectMaterialsDropLocation(
        transportOrderNo: '20221002.00001',
        vehicleRegistrationNo: '20221002.00001',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController!.index;
        });
      }
    });

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     inspectMaterialsDropLocationC.postEvidenceAttachment(
      //         registrationNo: inspectMaterialsDropLocationC
      //             .vehicleInfo.value!.registrationNo!,
      //         transportOrderIds: inspectMaterialsDropLocationC
      //             .vehicleInfo.value!.transportOrderId!,
      //         transportOrderNo: inspectMaterialsDropLocationC
      //             .vehicleInfo.value!.transportOrderNo!);
      //   },
      // ),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: hexToColor('#9BA9B3'),
              )),
          title: KText(
            text: 'Inspect Materials at Drop Location',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: hexToColor('#EEF0F6'),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: _tabBar,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BasicData(),
            Evidence(),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            color: Colors.amber,
            fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: _activeIndex == 0
              ? BorderRadius.only(topLeft: Radius.circular(5.0))
              : _activeIndex == 1
                  ? BorderRadius.only(topRight: Radius.circular(5.0))
                  : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'Basic Data'),
          // Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         border: Border(
          //             left:
          //             BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
          //     child: Tab(text: 'Materials')),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Evidence')),
        ],
      );
}

void openBottomSheet() {
  Get.bottomSheet(
    isScrollControlled: true,

    //persistent: true,
    SingleChildScrollView(
      child: Container(
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
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: KText(
                text: 'Select Transport Order',
                fontSize: 16,
                bold: true,
                color: hexToColor('#41525A'),
              ),
            ),
            Divider(
              thickness: 1,
              color: hexToColor('#9BA9B3'),
            ),

            TextField(
              enabled: true,
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  height: 7,
                  width: 7,
                  child: SvgPicture.asset(
                    '${Constants.svgPath}/icon_search_elements.svg',
                    height: 5,
                    width: 5,
                    fit: BoxFit.scaleDown,
                    color: hexToColor('#66A1D9'),
                  ),
                ),
                focusedBorder: InputBorder.none,
                errorText: '',
                hintText: 'Show Transport Order by',
              ),
            ),

            // OutlinedButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   child: Text('Close'),
            // ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 2,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: KText(
                      text: 'Data',
                      fontSize: 15,
                      bold: true,
                      color: hexToColor('#515D64'),
                    ),
                  ),
                ),
                Divider(
                  color: hexToColor('#DBECFB'),
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 15,
                    left: 10,
                  ),
                  child: KText(
                    text: 'Source Location',
                    fontSize: 15,
                    bold: true,
                    color: hexToColor('#515D64'),
                  ),
                ),
                Divider(
                  color: hexToColor('#DBECFB'),
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 15,
                    left: 10,
                  ),
                  child: KText(
                    text: 'Destination Location',
                    fontSize: 15,
                    bold: true,
                    color: hexToColor('#515D64'),
                  ),
                ),
                Divider(
                  color: hexToColor('#DBECFB'),
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 15,
                    left: 10,
                  ),
                  child: KText(
                    text: 'Transport Party',
                    fontSize: 15,
                    bold: true,
                    color: hexToColor('#515D64'),
                  ),
                ),
                Divider(
                  color: hexToColor('#DBECFB'),
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 15,
                    left: 10,
                  ),
                  child: KText(
                    text: 'Receiving Party',
                    fontSize: 15,
                    bold: true,
                    color: hexToColor('#515D64'),
                  ),
                ),
                Divider(
                  color: hexToColor('#DBECFB'),
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    top: 15,
                    left: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),

    //backgroundColor: Colors.white,
    elevation: 0,
  );
}

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool searchIcon;
  final bool avatar;
  final bool hasCheckbox;
  final String srchText;
  final Color? color;

  TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = true,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    this.color,
    required this.srchText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isActive = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.hasCheckbox)
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                  ),
                ),
              ),
            KText(
              text: widget.title,
              color: hexToColor('#80939D'),
              fontSize: 13,
            ),
            SizedBox(
              width: 3,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            widget.avatar
                ? Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5FA),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Color.fromARGB(255, 230, 230, 233),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF5F5FA).withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              '${Constants.imgPath}/bill.jpeg',
                              width: 37,
                              height: 37,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            KText(
              text: widget.srchText,
              fontSize: 15,
              color: widget.color != null ? widget.color : AppTheme.textColor,
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class BasicData extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => inspectMaterialsDropLocationC.itemList.isEmpty
          ? inspectMaterialsDropLocationC.isLoading.value
              ? SizedBox(
                  height: Get.height / 1.5,
                  child: Center(
                    child: Loading(),
                  ),
                )
              : SizedBox(
                  height: Get.height / 1.5,
                  child: Center(child: KText(text: 'No data found')),
                )
          : Builder(builder: (context) {
              final item = inspectMaterialsDropLocationC.vehicleInfo.value;
              return Padding(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                KText(
                                  text: 'Transport Order',
                                  fontSize: 14,
                                ),
                                // SizedBox(
                                //   height: 30,
                                //   width: 40,
                                //   child: IconButton(
                                //     constraints: BoxConstraints(),
                                //     padding: EdgeInsets.all(0),
                                //     onPressed: () {
                                //       openBottomSheet();
                                //     },
                                //     icon: SvgPicture.asset(
                                //       '${Constants.svgPath}/icon_Search_Elements.svg',
                                //       color: hexToColor('#66A1D9'),
                                //       width: 25,
                                //     ),
                                //   ),
                                // ),
                                // IconButton(
                                //   onPressed: openBottomSheet,
                                //   icon: SvgPicture.asset(
                                //       '${Constants.svgPath}/icon_search_elements.svg'),
                                // )
                              ],
                            ),
                            KText(
                              text: item!.transportOrderNo,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Date',
                              fontSize: 14,
                            ),
                            KText(
                              text: formatDate(date: item.transportOrderDate!),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: hexToColor('#EBEBEC'),
                      height: 2,
                      width: Get.width,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      avatar: false,
                      title: 'Sending Party (Who placed the Order)',
                      srchText: item.transporterPartyName != null
                          ? '${item.transporterPartyName}'
                          : '',
                    ),
                    TextFieldWidget(
                      avatar: false,
                      title: 'Source Location (Loading Point)',
                      srchText: item.sourceLocName != null
                          ? '${item.sourceLocName}'
                          : '',
                    ),
                    Row(
                      children: [
                        RenderSvg(path: 'trucklogo'),
                        // SvgPicture.asset('${Constants.svgPath}/trucklogo.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        KText(
                          text: 'Vehicles',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#515D64'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 155,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(width: 1, color: hexToColor('#FFE9CF')),
                        color: hexToColor('#FFFFFF'),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 34,
                            width: double.infinity,
                            // color: hexToColor('#FFE9CF'),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              color: hexToColor('#FFE9CF'),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, left: 15, top: 5),
                                  child: KText(
                                    text: item.registrationNo,
                                    fontSize: 16,
                                    color: hexToColor('#41525A'),
                                    bold: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Type: ${item.vehicleType}',
                                        fontSize: 14,
                                        color: hexToColor('#80939D'),
                                        bold: false,
                                      ),
                                      Row(
                                        children: [
                                          KText(
                                            text: 'Capacity: ',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                          KText(
                                            text: item.capacity != 'null null'
                                                ? '${item.capacity}'
                                                : '',
                                            fontSize: 14,
                                            color: hexToColor('#80939D'),
                                            bold: false,
                                          ),
                                        ],
                                      ),
                                      KText(
                                        text: 'Brand: ${item.brand}',
                                        fontSize: 14,
                                        color: hexToColor('#80939D'),
                                        bold: false,
                                      ),
                                      KText(
                                        text: 'Driver: ${item.driverFullname}',
                                        fontSize: 14,
                                        color: hexToColor('#80939D'),
                                        bold: false,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 150,
                                  padding: EdgeInsets.only(
                                      top: 14, left: 5, bottom: 16, right: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white60),
                                  child: RenderSvg(path: 'image_vehicle'),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          RenderSvg(path: 'icon_bill'),
                          // SvgPicture.asset('${Constants.svgPath}/icon_bill.svg'),
                          SizedBox(
                            width: 5,
                          ),
                          KText(
                            text: 'BOQ',
                            bold: true,
                            fontSize: 14,
                            color: hexToColor('#41525A'),
                          ),
                          KText(
                            text: '(Bill of Quantity)',
                            bold: false,
                            fontSize: 14,
                            color: hexToColor('#41525A'),
                          ),
                        ],
                      ),
                    ),
                    // TextFieldWidget(
                    //   srchText: 'Tamal Sharkar',
                    //   hasCheckbox: false,
                    //   // searchIcon: false,
                    //   title: ' Goods Inspector at the Loading Point',
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    DottedLine(
                      lineThickness: 0.1,
                      dashColor: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (inspectMaterialsDropLocationC.itemList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                            inspectMaterialsDropLocationC.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              inspectMaterialsDropLocationC.itemList[index];
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: hexToColor('#DBECFB'), width: 2),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    // border: Border.all(),
                                    color: hexToColor('#DBECFB'),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: KText(
                                          text:
                                              '${item.productName} (${item.productCode})',
                                          bold: true,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 40,
                                        child: Checkbox(
                                          value:
                                              item.foundItOkayAtDroppingPoint,
                                          onChanged: (value) {
                                            if (value == true) {
                                              inspectMaterialsDropLocationC
                                                  .updateItem(
                                                item,
                                                UpdateDropLocationInputType
                                                    .foundItOkay,
                                                value,
                                              );
                                            } else {
                                              inspectMaterialsDropLocationC
                                                  .updateItem(
                                                item,
                                                UpdateDropLocationInputType
                                                    .foundItOkay,
                                                false,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: KText(
                                          text: 'Found it okay',
                                          bold: true,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Dropped Quantity ',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text: 'Found Quantity',
                                        fontSize: 13,
                                        color: hexToColor('#80939D'),
                                      ),
                                      //  Text('Serial Number'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: '${item.droppedQuantity}',
                                                fontSize: 15,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 70,

                                            //found Quantity (get text)
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue:
                                                  '${item.inspectorFoundQuantityAtDroppingPoint == 0 ? '' : item.inspectorFoundQuantityAtDroppingPoint!.toInt()}',
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  inspectMaterialsDropLocationC
                                                      .updateItem(
                                                    item,
                                                    UpdateDropLocationInputType
                                                        .quantity,
                                                    double.parse(value),
                                                  );
                                                } else {
                                                  inspectMaterialsDropLocationC
                                                      .updateItem(
                                                    item,
                                                    UpdateDropLocationInputType
                                                        .quantity,
                                                    0.0,
                                                  );
                                                }
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                isDense: true,
                                                labelStyle: TextStyle(
                                                    color:
                                                        hexToColor('#FF0000')),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: hexToColor(
                                                          '#DBECFB')),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 1,
                                  width: Get.width,
                                  color: hexToColor('#DBECFB'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Remarks',
                                            color: hexToColor('#41525A'),
                                          ),

                                          //  Text('Serial Number'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          // remarks (get text)
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            initialValue:
                                                //   '${item.inspectorRemarkAtDroppingPoint == '' ? '' : item.inspectorRemarkAtDroppingPoint}',
                                                '',
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                inspectMaterialsDropLocationC
                                                    .updateItem(
                                                  item,
                                                  UpdateDropLocationInputType
                                                      .remark,
                                                  value,
                                                );
                                              } else {
                                                inspectMaterialsDropLocationC
                                                    .updateItem(
                                                  item,
                                                  UpdateDropLocationInputType
                                                      .remark,
                                                  '',
                                                );
                                              }
                                            },
                                            maxLines: 5,
                                            minLines: 1,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              hintText: 'Remarks here ...',
                                              contentPadding: EdgeInsets.all(5),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: .1)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 20),

                    KText(text: 'Overall Remarks'),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        onChanged: inspectMaterialsDropLocationC.overAllRemarks,
                        decoration: InputDecoration(
                          hintText: 'Remark Here...',
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      height: 40,
                      width: Get.width,
                      // margin: EdgeInsets.symmetric(vertical: .5),

                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // showTopSnackBar(
                              //   context,
                              //   CustomSnackBar.error(
                              //     message: 'Canceled',
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: hexToColor('#FFA133'),
                              ),
                              child: Center(
                                child: KText(
                                  text: 'Cancel',
                                  color: Colors.white,
                                  bold: true,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: inspectMaterialsDropLocationC
                                        .itemList.last.receivedQuantity !=
                                    null
                                ? () {
                                    inspectMaterialsDropLocationC
                                        .postEvidenceAttachment(
                                            registrationNo:
                                                inspectMaterialsDropLocationC
                                                    .vehicleInfo
                                                    .value!
                                                    .registrationNo!,
                                            transportOrderIds:
                                                inspectMaterialsDropLocationC
                                                    .vehicleInfo
                                                    .value!
                                                    .transportOrderId!,
                                            transportOrderNo:
                                                inspectMaterialsDropLocationC
                                                    .vehicleInfo
                                                    .value!
                                                    .transportOrderNo!);
                                    inspectMaterialsDropLocationC
                                        .postInspectMaterialsDropLocationData(
                                      transportOrderId: item.transportOrderId!,
                                      transportOrderNo: item.transportOrderNo!,
                                    );
                                  }
                                : null,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: inspectMaterialsDropLocationC
                                            .itemList.last.receivedQuantity !=
                                        null
                                    ? hexToColor('#007BEC')
                                    : hexToColor('#007BEC').withOpacity(.5),
                              ),
                              child: Center(
                                child: inspectMaterialsDropLocationC
                                        .isLoading.value
                                    ? Loading(color: Colors.white)
                                    : KText(
                                        text: 'Confirm',
                                        color: Colors.white,
                                        bold: true,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              );
            }),
    );
  }
}

class Evidence extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return
        //  Obx(
        //   () => inspectMaterialsDropLocationC.vehicleInfo.value == null
        //       ? Center(child: Loading())
        //       :
        SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                // final item =
                //     loadMaterialsToVehicleC.transportOrderVehicle[index];
                return Obx(
                  () => Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border:
                          Border.all(width: 1, color: hexToColor('#FFE9CF')),
                      color: hexToColor('#FFFFFF'),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 34,
                          width: double.infinity,
                          // color: hexToColor('#FFE9CF'),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: hexToColor('#FFE9CF'),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 14,
                                      ),
                                      RenderSvg(path: 'trucklogo'),
                                      // SvgPicture.asset(
                                      //     '${Constants.svgPath}/trucklogo.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      inspectMaterialsDropLocationC
                                                  .vehicleInfo.value ==
                                              null
                                          ? Center(child: Loading())
                                          : KText(
                                              text:
                                                  inspectMaterialsDropLocationC
                                                      .vehicleInfo
                                                      .value!
                                                      .registrationNo,
                                              fontSize: 16,
                                              color: hexToColor('#41525A'),
                                              bold: true,
                                            ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        inspectMaterialsDropLocationC
                                            .pickMultiImage();
                                      },
                                      child: RenderSvg(path: 'icon_add_box'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            inspectMaterialsDropLocationC.imagefiles.isEmpty
                                ? SizedBox()
                                : GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: inspectMaterialsDropLocationC
                                        .imagefiles.length,
                                    primary: false,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = inspectMaterialsDropLocationC
                                          .imagefiles[index];
                                      return Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.file(
                                                File(item.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            left: 0,
                                            bottom: 0,
                                            child: InkWell(
                                              onTap: () {
                                                Global.confirmDialog(
                                                  onConfirmed: () {
                                                    inspectMaterialsDropLocationC
                                                        .imagefiles
                                                        .removeAt(index);
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(60),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // GestureDetector(
            //   onTap: () {
            //     inspectMaterialsDropLocationC.postEvidenceAttachment(
            //         registrationNo: inspectMaterialsDropLocationC
            //             .vehicleInfo.value!.registrationNo!,
            //         transportOrderIds: inspectMaterialsDropLocationC
            //             .vehicleInfo.value!.transportOrderId!,
            //         transportOrderNo: inspectMaterialsDropLocationC
            //             .vehicleInfo.value!.transportOrderNo!);
            //   },
            //   child: KText(text: 'save'),
            // )
          ],
        ),
        //  ),
      ),
    );
  }
}
