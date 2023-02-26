import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../models/confirm_transport_readiness.dart';

class UnloadMaterialsVehicle extends StatefulWidget {
  final String? transportOrderNo;

  final bool? isFromNotification;

  UnloadMaterialsVehicle({
    this.transportOrderNo,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _UnloadMaterialsVehicleState createState() => _UnloadMaterialsVehicleState();
}

class _UnloadMaterialsVehicleState extends State<UnloadMaterialsVehicle>
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
    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      unloadMaterialsC.unloadMaterialsGet(
        transportOrderNo: widget.transportOrderNo!,
      );
    } else {
      unloadMaterialsC.unloadMaterialsGet(transportOrderNo: '20221002.00001');
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
            text: 'Unload Materials from Vehicle',
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
            EvidenceInspect(),
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

// ignore: must_be_immutable
class BasicData extends StatelessWidget with Base {
  UnloadModel? item;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => unloadMaterialsC.unloadMaterial.value == null
          ? Center(child: Loading())
          : ListView(
              children: [
                Builder(builder: (context) {
                  final item = unloadMaterialsC.unloadMaterial.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
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
                                if (item.transportOrderDate != null)
                                  KText(
                                    text: formatDate(
                                        date: item.transportOrderDate!),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: hexToColor('#EBEBEC')),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Sending Party (who placed the Order)',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: KText(
                                text: item.transporterPartyName,
                                fontSize: 15,
                                color: hexToColor('#515D64'),
                              ),
                            ),
                            Divider(color: hexToColor('#515D64')),
                            KText(
                              text: 'Source Location (Loading point)',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: KText(
                                text: item.sourceLocName,
                                fontSize: 15,
                                color: hexToColor('#515D64'),
                              ),
                            ),
                            Divider(color: hexToColor('#515D64')),
                            KText(
                              text: 'Destination Location (Unloading Point)',
                              fontSize: 13,
                              color: hexToColor('#80939D'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: KText(
                                text: item.destinationLocName,
                                fontSize: 15,
                                color: hexToColor('#515D64'),
                              ),
                            ),
                            Divider(color: hexToColor('#515D64')),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
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
                            Divider(color: hexToColor('#515D64')),
                            SizedBox(height: 12),
                            Container(
                              height: 155,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(Radius.circular(5)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    width: 1, color: hexToColor('#FFE9CF')),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text:
                                                    'Type: ${item.vehicleType}',
                                                fontSize: 14,
                                                color: hexToColor('#80939D'),
                                                bold: false,
                                              ),
                                              KText(
                                                text: 'Capacity: ',
                                                //     'Capacity: ${item.capacity}',
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
                                                text:
                                                    'Driver: ${item.driverFullname}',
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
                                              top: 14,
                                              left: 5,
                                              bottom: 16,
                                              right: 16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white60),
                                          child:
                                              RenderSvg(path: 'image_vehicle'),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RenderSvg(path: 'icon_bill'),
                          SizedBox(width: 5),
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
                      Divider(color: hexToColor('#515D64')),
                      SizedBox(height: 12),
                      ListView.builder(
                        itemCount: unloadMaterialsC.unloadNewList.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          final item = unloadMaterialsC.unloadNewList[index];
                          return Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                                              bottom: 5, left: 15, top: 5),
                                          child: KText(
                                            text:
                                                '${item.productName} (${item.productCode})',
                                            fontSize: 16,
                                            color: hexToColor('#41525A'),
                                            bold: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        KText(
                                            text: 'Droppable Quantity ',
                                            color: hexToColor('#80939D')),
                                        KText(
                                            text: 'Dropped Quantity',
                                            color: hexToColor('#80939D')),
                                      ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            // kLog(item.loadedQuantity);
                                          },
                                          child: KText(
                                              text: item.loadedQuantity
                                                  .toString(),
                                              color: hexToColor('#80939D')),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: TextFormField(
                                            // inputFormatters: <
                                            //     TextInputFormatter>[
                                            //   FilteringTextInputFormatter
                                            //       .digitsOnly
                                            // ],
                                            keyboardType: TextInputType.number,
                                            initialValue:
                                                '${item.droppedQuantity == 0 ? '' : item.droppedQuantity}',
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                unloadMaterialsC.updateItem(
                                                  item,
                                                  double.parse(value),
                                                );
                                              } else {
                                                unloadMaterialsC.updateItem(
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
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        hexToColor('#DBECFB')),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // ListView.builder(
                      //   itemCount: unloadMaterialsC.unloaditemList.length,
                      //   shrinkWrap: true,
                      //   primary: false,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     item = unloadMaterialsC.unloaditemList[index];
                      //     return Container(
                      //       margin: EdgeInsets.only(top: 15),
                      //       height: 100,
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //         // borderRadius: BorderRadius.all(Radius.circular(5)),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(5)),
                      //         border: Border.all(
                      //             width: 1, color: hexToColor('#DBECFB')),
                      //         color: hexToColor('#FFFFFF'),
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Container(
                      //             height: 34,
                      //             width: double.infinity,
                      //             // color: hexToColor('#FFE9CF'),
                      //             decoration: BoxDecoration(
                      //               border: Border.all(
                      //                   width: 1, color: hexToColor('#DBECFB')),
                      //               borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(5),
                      //                   topRight: Radius.circular(5)),
                      //               color: hexToColor('#DBECFB'),
                      //             ),
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Expanded(
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                         bottom: 5, left: 15, top: 5),
                      //                     child: KText(
                      //                       text:
                      //                           '${item!.productName} (${item!.productCode})',
                      //                       fontSize: 16,
                      //                       color: hexToColor('#41525A'),
                      //                       bold: true,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: EdgeInsets.only(
                      //                 left: 16, right: 16, top: 5),
                      //             child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: <Widget>[
                      //                   KText(
                      //                       text: 'Droppable Quantity ',
                      //                       color: hexToColor('#80939D')),
                      //                   KText(
                      //                       text: 'Dropped Quantity',
                      //                       color: hexToColor('#80939D')),
                      //                 ]),
                      //           ),
                      //           Padding(
                      //             padding: EdgeInsets.only(left: 16, right: 16),
                      //             child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: <Widget>[
                      //                   KText(
                      //                       text:
                      //                           item!.loadedQuantity.toString(),
                      //                       color: hexToColor('#80939D')),
                      //                   SizedBox(
                      //                     width: 60,
                      //                     child: TextFormField(
                      //                       // inputFormatters: <
                      //                       //     TextInputFormatter>[
                      //                       //   FilteringTextInputFormatter
                      //                       //       .digitsOnly
                      //                       // ],
                      //                       keyboardType: TextInputType.number,
                      //                       initialValue:
                      //                           '${item!.droppedQuantity == 0 ? '' : item!.droppedQuantity}',
                      //                       onChanged: (value) {
                      //                         if (value.isNotEmpty) {
                      //                           unloadMaterialsC.updateItem(
                      //                             item!,
                      //                             double.parse(value),
                      //                           );
                      //                         } else {
                      //                           unloadMaterialsC.updateItem(
                      //                             item!,
                      //                             0.0,
                      //                           );
                      //                         }
                      //                       },
                      //                       decoration: InputDecoration(
                      //                         contentPadding: EdgeInsets.all(0),
                      //                         isDense: true,
                      //                         labelStyle: TextStyle(
                      //                             color: hexToColor('#FF0000')),
                      //                         enabledBorder:
                      //                             UnderlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color:
                      //                                   hexToColor('#DBECFB')),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ]),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Remarks',
                          color: hexToColor('#80939D'),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: unloadMaterialsC.remarks.value == ''
                              ? ''
                              : unloadMaterialsC.remarks.value,
                          onChanged: unloadMaterialsC.remarks,
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
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
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
                      InkWell(
                        onTap: unloadMaterialsC.unloadNewList.isNotEmpty
                            ? () {
                                unloadMaterialsC.unloadMaterialsConfirm();
                                unloadMaterialsC.postEvidenceAttachment(
                                    transportOrderId: unloadMaterialsC
                                        .unloadMaterial.value!.transportOrderId
                                        .toString(),
                                    registrationNo: unloadMaterialsC
                                        .unloadMaterial.value!.registrationNo
                                        .toString());
                              }
                            : null,
                        child: Container(
                          height: 35,
                          width: 100,
                          // ignore: sort_child_properties_last
                          child: Center(
                            child: unloadMaterialsC.isLoading.value
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
                            color: unloadMaterialsC.unloadNewList.isNotEmpty
                                ? hexToColor('#007BEC')
                                : hexToColor('#007BEC').withOpacity(.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
  }
}

class EvidenceInspect extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
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
                                // SvgPicture.asset(
                                //     '${Constants.svgPath}/trucklogo.svg'),
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Pictures of Unload Materials',
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
                                  Get.put(unloadMaterialsC).pickMultiImage();
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
                        unloadMaterialsC.imagefiles.isEmpty
                            ? Container()
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: unloadMaterialsC.imagefiles.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      unloadMaterialsC.imagefiles[index];
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
                                                unloadMaterialsC.imagefiles
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
            // InkWell(
            //   onTap: () {
            //     unloadMaterialsC.postEvidenceAttachment(
            //         transportOrderNo: '20221026.00004');
            //   },
            //   child: Container(
            //     height: 35,
            //     width: 100,
            //     child: Center(
            //       child: KText(
            //         text: 'Confirm',
            //         color: Colors.white,
            //         bold: true,
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       color: hexToColor('#007BEC'),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
