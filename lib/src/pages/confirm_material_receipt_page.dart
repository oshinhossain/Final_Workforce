// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../controllers/confirm_material_receipt_controller.dart';

class ConfirmMaterialReceiptPage extends StatefulWidget with Base {
  final String? transportOrderNo;
  final String? vehicleRegistrationNo;
  final bool? isFromNotification;

  ConfirmMaterialReceiptPage({
    this.transportOrderNo,
    this.vehicleRegistrationNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmMaterialReceiptPageState createState() =>
      _ConfirmMaterialReceiptPageState();
}

class _ConfirmMaterialReceiptPageState extends State<ConfirmMaterialReceiptPage>
    with SingleTickerProviderStateMixin, Base {
  // String dropdownValue = list.first;
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
    if (widget.transportOrderNo != null &&
        widget.isFromNotification! != null &&
        widget.vehicleRegistrationNo! != null) {
      confirmMaterialReceiptC.receiptMaterialsGet(
        transportOrderNo: widget.transportOrderNo!,
        vehicleRegistrationNo: widget.vehicleRegistrationNo!,
      );
    } else {
      confirmMaterialReceiptC.receiptMaterialsGet(
        transportOrderNo: '20221002.00001',
        vehicleRegistrationNo: '457878',
      );
    }
    // confirmMaterialReceiptC.postEvidenceAttachment();
  }

  @override
  void dispose() {
    super.dispose();
    confirmMaterialReceiptC.remarks.value = '';
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
            text: 'Confirm Material Receipt',
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
            basicData(),
            EvidenceInspect(),
            //  evidence(),
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

  Widget basicData() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(15),
        child: confirmMaterialReceiptC.vehicleInfo.value == null
            ? confirmMaterialReceiptC.isLoading.value
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
                final item = confirmMaterialReceiptC.vehicleInfo.value;
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            KText(
                              text: 'Transport Order',
                              color: hexToColor('#80939D'),
                            ),
                            SizedBox(height: 5),
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
                              color: hexToColor('#80939D'),
                            ),
                            SizedBox(height: 5),
                            KText(
                              text: formatDate(date: item.transportOrderDate!),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Divider(
                      thickness: .5,
                      color: hexToColor('#9ba9b3'),
                    ),
                    KText(
                      text: 'Sending Party (who placed the Order)',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: KText(
                        text: item.transporterPartyName != null
                            ? '${item.transporterPartyName}'
                            : '',
                        fontSize: 15,
                        color: hexToColor('#515D64'),
                      ),
                    ),

                    Divider(
                      thickness: .5,
                      color: hexToColor('#9ba9b3'),
                    ),
                    KText(
                      text: 'Source Location (Loading point)',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: KText(
                        text: '${item.sourceLocName}',
                        fontSize: 15,
                        color: hexToColor('#515D64'),
                      ),
                    ),
                    Divider(
                      thickness: .5,
                      color: hexToColor('#9ba9b3'),
                    ),
                    KText(
                      text: 'Destination Location (Unloading Point)',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: KText(
                        text: '${item.destinationLocName}',
                        fontSize: 15,
                        color: hexToColor('#515D64'),
                      ),
                    ),
                    Divider(
                      thickness: .5,
                      color: hexToColor('#9ba9b3'),
                    ),
                    // KText(
                    //   text: 'Source Location (Loading point)',
                    //   fontSize: 13,
                    //   color: hexToColor('#80939D'),
                    // ),
                    // Padding(
                    //   padding:   EdgeInsets.symmetric(vertical: 8),
                    //   child: KText(
                    //     text: confirmMaterialReceiptC.confirmMaterialReceipt
                    //         .value!.vehicleInfo!.sourceLocName,
                    //     fontSize: 15,
                    //     color: hexToColor('#515D64'),
                    //   ),
                    // ),
                    // Divider(
                    //   color: hexToColor('#515D64'),
                    // ),
                    // KText(
                    //   text: 'Destination Location (Unloading Point)',
                    //   fontSize: 13,
                    //   color: hexToColor('#80939D'),
                    // ),
                    // Padding(
                    //   padding:   EdgeInsets.symmetric(vertical: 8),
                    //   child: KText(
                    //     text: confirmMaterialReceiptC.confirmMaterialReceipt
                    //         .value!.vehicleInfo!.dropLocName,
                    //     fontSize: 15,
                    //     color: hexToColor('#515D64'),
                    //   ),
                    // ),
                    // Divider(
                    //   color: hexToColor('#515D64'),
                    // ),
                    SizedBox(
                      height: 20,
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
                              children: [
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
                                      KText(
                                        text: 'Capacity: ',
                                        // text: 'Capacity: ${item.capacity}',
                                        fontSize: 14,
                                        color: hexToColor('#80939D'),
                                        bold: false,
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
                    Row(
                      children: [
                        RenderSvg(path: 'icon_bill'),
                        //  SvgPicture.asset('${Constants.svgPath}/icon_bill.svg'),
                        SizedBox(
                          width: 5,
                        ),

                        KText(
                          text: 'BOQ ',
                          fontSize: 18,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        KText(
                          text: '(Bill of Quantity) ',
                          fontSize: 18,
                          color: hexToColor('#41525A'),
                          bold: false,
                        ),
                      ],
                    ),
                    Divider(
                      color: hexToColor('#515D64'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      itemCount: confirmMaterialReceiptC.itemList.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        final item = confirmMaterialReceiptC.itemList[index];
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                width: 1, color: hexToColor('#DBECFB')),
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
                                    border: Border.all(
                                        width: 1, color: hexToColor('#DBECFB')),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: hexToColor('#DBECFB'),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5,
                                              left: 15,
                                              top: 5,
                                              right: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: KText(
                                                  text: '${item.productName}',
                                                  fontSize: 14,
                                                  color: hexToColor('#41525A'),
                                                  bold: true,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              KText(
                                                text: '(${item.productCode})',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        KText(
                                            text: 'Receivable Quantity ',
                                            color: hexToColor('#80939D')),
                                        KText(
                                            text: 'Received Quantity ',
                                            color: hexToColor('#80939D')),
                                      ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      KText(
                                          text: item.loadedQuantity.toString(),
                                          color: hexToColor('#80939D')),
                                      SizedBox(
                                        width: 60,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          initialValue:
                                              '${item.updateReceivedQuantity == 0 ? '' : item.updateReceivedQuantity!.toInt()}',
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              confirmMaterialReceiptC
                                                  .updateItem(
                                                item,
                                                double.parse(value),
                                              );
                                            } else {
                                              confirmMaterialReceiptC
                                                  .updateItem(
                                                item,
                                                0.0,
                                              );
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            isDense: true,
                                            labelStyle: TextStyle(
                                                color: hexToColor('#FF0000')),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: hexToColor('#DBECFB')),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Remarks',
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          initialValue:
                              confirmMaterialReceiptC.remarks.value == ''
                                  ? ''
                                  : confirmMaterialReceiptC.remarks.value,
                          onChanged: confirmMaterialReceiptC.remarks,
                          maxLines: 5,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Remarks Here',
                            contentPadding: EdgeInsets.all(5),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: .1)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
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
                            height: 35,
                            width: 100,
                            // ignore: sort_child_properties_last
                            child: Center(
                              child: KText(
                                text: 'Cancel',
                                color: Colors.white,
                                bold: true,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: hexToColor('#FFA133'),
                            ),
                          ),
                        ),
                        Spacer(),
                        Obx(
                          () => InkWell(
                            onTap:
                                confirmMaterialReceiptC.validateConfirmButton()
                                    ? () {
                                        confirmMaterialReceiptC
                                            .addConfirmMaterialData();
                                        confirmMaterialReceiptC
                                            .postEvidenceAttachment(
                                                registrationNo:
                                                    item.registrationNo!,
                                                transportOrderIds:
                                                    item.transportOrderId!,
                                                transportOrderNo:
                                                    item.transportOrderNo!);
                                      }
                                    : null,
                            child: Container(
                              height: 35,
                              width: 100,
                              // ignore: sort_child_properties_last
                              child: Center(
                                child: confirmMaterialReceiptC.isLoading.value
                                    ? Loading(
                                        color: Colors.white,
                                      )
                                    : KText(
                                        text: 'Confirm',
                                        color: Colors.white,
                                        bold: true,
                                      ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: confirmMaterialReceiptC
                                        .validateConfirmButton()
                                    ? hexToColor('#007BEC')
                                    : hexToColor('#007BEC').withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                );
              }),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = false,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    required this.srchText,
  });

  final bool avatar;
  final bool hasCheckbox;
  final bool searchIcon;
  final String srchText;
  final String title;

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
                              '${Constants.imgPath}/bill.jpg',
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
            ),
          ],
        ),
        Divider(
          color: hexToColor('#515D64'),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class EvidenceInspect extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final item = confirmMaterialReceiptC.vehicleInfo.value;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              width: double.maxFinite,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(5)),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(width: 1, color: hexToColor('#FFE9CF')),
                color: hexToColor('#FFFFFF'),
              ),
              child: Column(
                children: [
                  Container(
                    height: 34,
                    width: Get.width,
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
                                RenderSvg(path: 'icon_pointer'),
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Pictures of Received Materials',
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
                                  Get.put(ConfirmMaterialReceiptController())
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
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        confirmMaterialReceiptC.imagefiles.value.isEmpty
                            ? SizedBox()
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount:
                                    confirmMaterialReceiptC.imagefiles.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      confirmMaterialReceiptC.imagefiles[index];
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
                                          // onTap: () {
                                          //   confirmMaterialReceiptC.imagefiles
                                          //       .removeAt(index);
                                          onTap: () {
                                            Global.confirmDialog(
                                              onConfirmed: () {
                                                confirmMaterialReceiptC
                                                    .imagefiles
                                                    .removeAt(index);
                                                Get.back();
                                              },
                                            );
                                          },
                                          // },
                                          child: Container(
                                            margin: EdgeInsets.all(60),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.white.withOpacity(0.5),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
