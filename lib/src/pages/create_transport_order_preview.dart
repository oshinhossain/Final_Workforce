import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/user_avatar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/create_transport_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../controllers/location_controller.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class CreateTransportOrderPreview extends StatelessWidget with Base {
  final key1 = GlobalKey<State<Tooltip>>();
  final key2 = GlobalKey<State<Tooltip>>();
  final key3 = GlobalKey<State<Tooltip>>();
  final key4 = GlobalKey<State<Tooltip>>();
  final key5 = GlobalKey<State<Tooltip>>();
  final key6 = GlobalKey<State<Tooltip>>();
  final key7 = GlobalKey<State<Tooltip>>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                height: 50,
                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: RenderSvg(
                        path: 'icon_back',
                        width: 13.0,
                      ),
                    ),
                    KText(
                      text: 'Transport Order Preview',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Container(
                height: 50,
                width: Get.width,
                color: hexToColor('#EBEBEC'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Transport Order',
                            fontSize: 12,
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: '(Auto)',
                            bold: true,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          KText(
                            text: 'Date',
                            fontSize: 14,
                          ),
                          KText(
                            text: formatDate(date: DateTime.now().toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Others parts
              SizedBox(
                height: 12,
              ),
              searchField(
                title: 'Project Name',
                placeholder: createTrasnportOrderC.selectedProject.value == null
                    ? 'Project Name'
                    : createTrasnportOrderC.selectedProject.value!.projectName
                        .toString(),
                onTap: () async {
                  await createTrasnportOrderC.openBottomSheet(
                      'Search Transport Party', 'Transport Party');
                },
              ),
              searchField(
                title: 'Logistics Provider',
                placeholder:
                    createTrasnportOrderC.getTransportPartyName() == null
                        ? 'Logistics Provider'
                        : createTrasnportOrderC.getTransportPartyName()!,
                onTap: () async {
                  await createTrasnportOrderC.openBottomSheet(
                      'Search Transport Party', 'Transport Party');
                },
              ),
              searchField(
                title: 'Receiving Party',
                placeholder: createTrasnportOrderC.getReciverPartyName() == null
                    ? 'Receiving Party'
                    : createTrasnportOrderC.getReciverPartyName()!,
                onTap: () async {
                  await createTrasnportOrderC.openBottomSheet(
                      'Search Receiving Party', 'Receiving Party');
                },
              ),

              singleRecivingPerson(),
              searchField(
                title: 'Source Location (Loading point)',
                placeholder:
                    createTrasnportOrderC.getSourcelocationName() == null
                        ? 'Source Location'
                        : createTrasnportOrderC.getSourcelocationName()!,
                onTap: () {
                  createTrasnportOrderC.allLocationBottomSheet(
                    locationPoint: LocationPoint.loading,
                    title: 'Source Location',
                  );
                },
              ),
              singleDropLocation(),

              // searchField(
              //   title: 'Destination Location (Unloading Point)',
              //   placeholder:
              //       createTrasnportOrderC.destinationLocName.value.isEmpty
              //           ? 'Select destination location'
              //           : createTrasnportOrderC.destinationLocName.value,
              //   onTap: () async {
              //     createTrasnportOrderC
              //         .searchLocationBottomsheet('Destination Location');
              //   },
              // ),

              singleGoodsInspectorAtDropLocation(),
              goodsInspectorAtLoadingPoint(),

              travelPath(),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -10,
                      left: 14,
                      child: Container(
                        child: KText(
                          text: 'Transportation controls',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      kCheckBox('Enforce Inspector at Source', key1,
                          createTrasnportOrderC.enforceInspectorAtSource),
                      kCheckBox('Enforce Vehicle Readiness', key2,
                          createTrasnportOrderC.enforceVehicleReadiness),
                      kCheckBox('Enforce Recipient Readiness', key3,
                          createTrasnportOrderC.enforceRecipientReadiness),
                      kCheckBox('Enforce Vehicle Starting by Driver', key6,
                          createTrasnportOrderC.enforceVehicleStartingbyDriver),
                      kCheckBox(
                          'Enforce Materials Droping by Driver',
                          key7,
                          createTrasnportOrderC
                              .enforceMaterialsDropingbyDriver),
                      kCheckBox('Enforce Inspector at Destination', key4,
                          createTrasnportOrderC.enforceInspectorAtDestination),
                      kCheckBox('Enforce Receipt by Receiver', key5,
                          createTrasnportOrderC.enforceReceiptByReceiver),
                    ],
                  )
                ]),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    width: Get.width,
                    color: hexToColor('#ffffff'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Total Quantity',
                              fontSize: 14,
                            ),
                            KText(
                              text:
                                  '${createTrasnportOrderC.getTotalQuantity()}',
                              color: hexToColor('#80939D'),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Gross Transportation Fee',
                              fontSize: 14,
                            ),
                            KText(
                              text: 'BDT 0',
                              color: hexToColor('#80939D'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  createTrasnportOrderC.transportOrderLines.isEmpty
                      ? Divider()
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              createTrasnportOrderC.transportOrderLines.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = createTrasnportOrderC
                                .transportOrderLines[index];
                            return GestureDetector(
                              onTap: () =>
                                  createTrasnportOrderC.exapndItem(item),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1.5, color: hexToColor('#DBECFB')),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: hexToColor('#DBECFB'),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 12),
                                          Icon(
                                            item.expended!
                                                ? EvaIcons.arrowIosUpwardOutline
                                                : EvaIcons
                                                    .arrowIosDownwardOutline,
                                            color: hexToColor('#80939D'),
                                          ),
                                          Expanded(
                                            child: KText(
                                              text: item.productName,
                                              bold: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Code',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text:
                                                      '${item.productFullcode}',
                                                  color: hexToColor('#515D64'),
                                                  fontSize: 12,
                                                  bold: true,
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                KText(
                                                  text: 'Drop Location ',
                                                  fontSize: 13,
                                                  color: hexToColor('#80939D'),
                                                ),
                                                KText(
                                                  text: createTrasnportOrderC
                                                          .isSingleDropLocation
                                                          .isTrue
                                                      ? createTrasnportOrderC
                                                              .getDropLocationName() ??
                                                          'Drop Location'
                                                      : '',
                                                  color: hexToColor('#515D64'),
                                                  fontSize: 12,
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(color: hexToColor('#DBECFB')),
                                    if (item.expended!)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text: 'Distance',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                KText(
                                                  text:
                                                      '${item.distance ?? '0.0'} Km',
                                                  bold: true,
                                                )
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(
                                          //     left: 10,
                                          //     right: 10,
                                          //     top: 10,
                                          //   ),
                                          //   child: Row(
                                          //     children: [
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           KText(text: 'Quantity'),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       Spacer(),
                                          //       SizedBox(
                                          //         width: 70,
                                          //         child: TextField(
                                          //           decoration:
                                          //               InputDecoration(
                                          //             contentPadding:
                                          //                 EdgeInsets.all(0),
                                          //             isDense: true,
                                          //             hintText: '649',
                                          //             labelStyle: TextStyle(
                                          //                 color: hexToColor(
                                          //                     '#FF0000')),
                                          //             enabledBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: hexToColor(
                                          //                       '#DBECFB')),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       KText(
                                          //         text: 'Pcs',
                                          //         fontSize: 14,
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Quantity',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 70,
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    initialValue:
                                                        '${item.quantity == 0 ? '' : item.quantity}',
                                                    keyboardType:
                                                        TextInputType.number,
                                                    // onChanged: (v) {
                                                    //   if (v.isNotEmpty) {
                                                    //     createTrasnportOrderC
                                                    //         .updateItem(
                                                    //       item,
                                                    //       UpdateInputType.pcs,
                                                    //       int.parse(v),
                                                    //     );
                                                    //   } else {
                                                    //     createTrasnportOrderC
                                                    //         .updateItem(
                                                    //       item,
                                                    //       UpdateInputType.pcs,
                                                    //       0,
                                                    //     );
                                                    //   }
                                                    // },
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Manrope Regular',
                                                      fontSize: 12,
                                                    ),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      isDense: true,
                                                      hintText: '0.0',
                                                      labelStyle: TextStyle(
                                                        color: hexToColor(
                                                            '#FF0000'),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: hexToColor(
                                                              '#DBECFB'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                KText(
                                                  text: item.baseUom != null
                                                      ? ' ${item.baseUom}'
                                                      : '',
                                                  fontSize: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    KText(
                                                      text: 'Weight',
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                SizedBox(
                                                  width: 70,
                                                  child: TextFormField(
                                                    initialValue:
                                                        '${item.weight == 0 ? '' : item.weight}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Manrope Regular',
                                                      fontSize: 12,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    readOnly: true,
                                                    // onChanged: (v) {
                                                    //   if (v.isNotEmpty) {
                                                    //     createTrasnportOrderC
                                                    //         .updateItem(
                                                    //       item,
                                                    //       UpdateInputType.kg,
                                                    //       int.parse(v),
                                                    //     );
                                                    //   } else {
                                                    //     createTrasnportOrderC
                                                    //         .updateItem(
                                                    //       item,
                                                    //       UpdateInputType.kg,
                                                    //       0,
                                                    //     );
                                                    //   }
                                                    // },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      isDense: true,
                                                      hintText: '0.0',
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: hexToColor(
                                                                '#DBECFB')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                KText(
                                                  text: ' Kg',
                                                  bold: true,
                                                )
                                              ],
                                            ),
                                          ),
                                          // KText(text: '${item.weight}'),
                                          Divider(color: hexToColor('#DBECFB')),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    KText(
                                                      text:
                                                          'Transportation Fee',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                KText(
                                                  text:
                                                      'BDT  ${item.transportationFee}',
                                                  fontSize: 14,
                                                  bold: true,
                                                  color: hexToColor(
                                                    '#41525A',
                                                  ),
                                                ),
                                                // KText(
                                                //   text: 'Kg',
                                                //   fontSize: 14,
                                                // )
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 16,
                                          // ),
                                          // Padding(
                                          //   padding:
                                          //         EdgeInsets.only(left: 10, right: 10),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           Text('26345634'),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //           Text('-'),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //           Text('21741273'),
                                          //         ],
                                          //       ),
                                          //       Text('5 Kg'),
                                          //     ],
                                          //   ),
                                          // ),

                                          Divider(color: hexToColor('#DBECFB')),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, bottom: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      KText(
                                                        text: 'Goods Receiver',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      KText(
                                                        text: createTrasnportOrderC
                                                                .isSingleRecivingPerson
                                                                .isTrue
                                                            ? createTrasnportOrderC
                                                                    .getSingleRecivingPerson() ??
                                                                'Goods Receiver'
                                                            : '',
                                                        color: hexToColor(
                                                            '#515D64'),
                                                        fontSize: 13,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      KText(
                                                        text: 'Goods Inspector',
                                                        fontSize: 13,
                                                        color: hexToColor(
                                                            '#80939D'),
                                                      ),
                                                      KText(
                                                        text: createTrasnportOrderC
                                                                .isSingleDropLocation
                                                                .isTrue
                                                            ? createTrasnportOrderC
                                                                    .getSingleGoodsInspectorAtDropLocation() ??
                                                                'Goods Inspector'
                                                            : '',
                                                        color: hexToColor(
                                                            '#515D64'),
                                                        fontSize: 13,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (!item.expended!)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Quantity',
                                              color: hexToColor('#80939D'),
                                            ),
                                            Row(
                                              children: [
                                                KText(
                                                  text: '${item.quantity} ',
                                                  bold: true,
                                                ),
                                                KText(
                                                  text: item.baseUom != null
                                                      ? '${item.baseUom}'
                                                      : '',
                                                  bold: true,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.all(12),
          // height: 40,
          width: Get.width,
          // margin: EdgeInsets.symmetric(vertical: .5),

          decoration: BoxDecoration(
            color: Colors.white,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  createTrasnportOrderC.addTransportOrder();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#007BEC'),
                  ),
                  child: createTrasnportOrderC.isLoading.isTrue
                      ? Center(
                          child: Loading(
                            color: Colors.white,
                          ),
                        )
                      : Center(
                          child: KText(
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
      ),
    );
  }

  Widget searchField({
    required String title,
    required String placeholder,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              KText(
                text: title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                color: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          KText(
            text: placeholder,
            fontSize: 15,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget singleDropLocation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                      activeColor: hexToColor('#84BEF3'),
                      value: createTrasnportOrderC.isSingleDropLocation.value,
                      onChanged: (bool? value) => {}),
                ),
              ),
              KText(
                text: 'Single Drop Location (Unloading Point)',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                color: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.getDropLocationName() == null
                    ? 'Drop Location'
                    : createTrasnportOrderC.getDropLocationName(),
                fontSize: 15,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              KText(
                text: 'Planned start date',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                color: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.plannedStartDate.value.isEmpty
                    ? 'Planned start date'
                    : formatDate(
                        date: createTrasnportOrderC.plannedStartDate.value),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              KText(
                text: 'ETD (Estimated Time of Delivery)',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                color: Colors.redAccent,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.etd.value.isEmpty
                    ? 'ETD'
                    : formatDate(date: createTrasnportOrderC.etd.value),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget travelPath() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                      activeColor: hexToColor('#84BEF3'),
                      value: createTrasnportOrderC.isPrescribeTravelPath.value,
                      onChanged: (bool? value) {}),
                ),
              ),
              KText(
                text: 'Prescribe Travel Path',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
              // IconButton(
              //   onPressed: widget.onPressed,
              //   icon: SvgPicture.asset(
              //     '${Constants.svgPath}/icon_search_elements.svg',
              //     color: hexToColor('#66A1D9'),
              //     width: 16,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: KText(
                  text: createTrasnportOrderC.prescribeTravelPath.value.isEmpty
                      ? 'Travel Path'
                      : createTrasnportOrderC.prescribeTravelPath.value,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget singleRecivingPerson() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: createTrasnportOrderC.isSingleRecivingPerson.value,
                    onChanged: (bool? _) {},
                  ),
                ),
              ),
              KText(
                text: 'Single Receiving Person',
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
              createTrasnportOrderC.singleReciverPerson.value?.username != null
                  ? Container(
                      height: 38,
                      width: 38,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 2.0,
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.singleReciverPerson.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(
                width: 10,
              ),
              KText(
                text: createTrasnportOrderC.getSingleRecivingPerson() == null
                    ? 'Single Receving Party'
                    : createTrasnportOrderC.getSingleRecivingPerson(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget singleGoodsInspectorAtDropLocation() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: createTrasnportOrderC.isSinglegoodsInspector.value,
                    onChanged: (bool? _) {},
                  ),
                ),
              ),
              KText(
                text: 'Single Goods Inspector at the Drop Location',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              // SizedBox(
              //   width: 3,
              // ),
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(0),
              //     child: GestureDetector(
              //       onTap: () {
              //         createTrasnportOrderC.searchUserBottomsheet(
              //           'Single Goods Inspector at the Drop Location',
              //         );
              //       },
              //       child: RenderSvg(
              //         path: 'icon_search_elements',
              //         width: 26,
              //         color: hexToColor('#66A1D9'),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              createTrasnportOrderC
                          .goodsInspectorAtDropLocation.value?.username !=
                      null
                  ? Container(
                      height: 38,
                      width: 38,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 2.0,
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.goodsInspectorAtDropLocation.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(width: 10),
              KText(
                text: createTrasnportOrderC
                            .getSingleGoodsInspectorAtDropLocation() ==
                        null
                    ? 'Single Goods Inspector'
                    : createTrasnportOrderC
                        .getSingleGoodsInspectorAtDropLocation(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget goodsInspectorAtLoadingPoint() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(right: 5),
              //   child: SizedBox(
              //     height: 20,
              //     width: 20,
              //     child: Checkbox(
              //       activeColor: hexToColor('#84BEF3'),
              //       value: true,
              //       onChanged: (bool? value) {},
              //     ),
              //   ),
              // ),
              KText(
                text: 'Goods Inspector at the Loading Point',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
              // IconButton(
              //   onPressed: widget.onPressed,
              //   icon: SvgPicture.asset(
              //     '${Constants.svgPath}/icon_search_elements.svg',
              //     color: hexToColor('#66A1D9'),
              //     width: 16,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              createTrasnportOrderC
                          .goodsInspectorAtLoadingPoint.value?.username !=
                      null
                  ? Container(
                      height: 38,
                      width: 38,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 2.0,
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.goodsInspectorAtLoadingPoint.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(width: 10),
              KText(
                text: createTrasnportOrderC.getGoodsInspectorAtLoadingPoint() ==
                        null
                    ? 'Goods Inspector'
                    : createTrasnportOrderC.getGoodsInspectorAtLoadingPoint(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget searchFieldWithPic({
    required String title,
    required String placeholder,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(value: true, onChanged: (v) {}),
              KText(
                text: title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Padding(
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
              ),
              KText(
                text: placeholder,
                fontSize: 15,
              ),
            ],
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget kCheckBox(String title, GlobalKey key, RxBool v) {
    return Row(
      children: [
        Checkbox(
          // visualDensity: VisualDensity(
          //     horizontal: VisualDensity.minimumDensity,
          //     vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: v.value,
          onChanged: (x) {},
          activeColor: hexToColor('#84BEF3'),
        ),
        // SizedBox(
        //   width: 12,
        // ),
        KText(
          text: title,
          fontSize: 14,
        ),
        Tooltip(
          key: key,
          triggerMode: TooltipTriggerMode.longPress,
          message: 'Lorem Ipsum is simply dummy text',
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.appbarColor,
              border: Border.all(
                  width: 1.5, color: AppTheme.textColor.withOpacity(.1))),
          padding: EdgeInsets.all(10),
          textStyle: TextStyle(
              fontFamily: 'Manrope Regular',
              color: AppTheme.textColor,
              fontSize: 13),
          child: IconButton(
            visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            onPressed: () {
              final dynamic tooltip = key.currentState!;
              tooltip?.ensureTooltipVisible();
            },
            icon: Icon(Icons.info_outline),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
  //   return Scaffold(
  //     drawer: LeftSidebarComponent(),
  //     endDrawer: RightSidebarComponent(),
  //     bottomNavigationBar: Obx(
  //       () => Container(
  //         padding: EdgeInsets.all(12),
  //         // height: 40,
  //         width: Get.width,
  //         // margin: EdgeInsets.symmetric(vertical: .5),

  //         decoration: BoxDecoration(
  //           color: AppTheme.appHomePageColor,
  //         ),

  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 createTrasnportOrderC.AddTransportOrder();
  //                 // print('dd');

  //                 // showTopSnackBar(
  //                 //
  //                 //   context,
  //                 //   CustomSnackBar.success(
  //                 //     message:
  //                 //     "Submitted",
  //                 //   ),
  //                 //  );
  //               },
  //               child: Container(
  //                 height: 40,
  //                 width: 100,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(6),
  //                   color: hexToColor('#007BEC'),
  //                 ),
  //                 child: createTrasnportOrderC.isLoading.value
  //                     ? Center(
  //                         child: Loading(
  //                           color: Colors.white,
  //                         ),
  //                       )
  //                     : Center(
  //                         child: KText(
  //                           text: 'Confirm',
  //                           color: Colors.white,
  //                           bold: true,
  //                         ),
  //                       ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     appBar: KAppbar(),
  //     body: ListView(
  //       children: [
  //         Obx(
  //           () => SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
  //                   height: 50,
  //                   width: Get.width,
  //                   // margin: EdgeInsets.symmetric(vertical: .5),

  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     border: Border(
  //                       bottom:
  //                           BorderSide(width: 2, color: Colors.grey.shade300),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () => back(),
  //                         child: RenderSvg(
  //                           path: 'icon_back',
  //                           width: 13.0,
  //                         ),
  //                       ),
  //                       KText(
  //                         text: 'Create Transport Order Preview',
  //                         fontSize: 16,
  //                         color: hexToColor('#41525A'),
  //                         bold: true,
  //                       ),
  //                       SizedBox()
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 50,
  //                   width: Get.width,
  //                   color: hexToColor('#EBEBEC'),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.only(
  //                           left: 12,
  //                         ),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             KText(
  //                               text: 'Transport Order',
  //                               fontSize: 12,
  //                               color: hexToColor('#80939D'),
  //                             ),
  //                             KText(
  //                               text: '(Auto)',
  //                               bold: true,
  //                               fontSize: 13,
  //                               color: Colors.grey,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         margin: EdgeInsets.only(
  //                           right: 12,
  //                         ),
  //                         child: createTrasnportOrderC
  //                                 .transportOrderDate.value.isEmpty
  //                             ? IconButton(
  //                                 onPressed: () async {
  //                                   DateTime? pickedDate = await showDatePicker(
  //                                     context: Get.context!,
  //                                     initialDate: DateTime.now(),
  //                                     firstDate: DateTime(1950),
  //                                     //DateTime.now() - not to allow to choose before today.
  //                                     lastDate: DateTime.now(),
  //                                   );
  //                                   if (pickedDate != null) {
  //                                     String formattedDate =
  //                                         DateFormat('yyyy-MM-dd')
  //                                             .format(pickedDate);
  //                                     createTrasnportOrderC.transportOrderDate
  //                                         .value = formattedDate;
  //                                   } else {}
  //                                 },
  //                                 icon: Icon(
  //                                   Icons.calendar_month_outlined,
  //                                   color: AppTheme.primaryColor,
  //                                 ))
  //                             : Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 crossAxisAlignment: CrossAxisAlignment.end,
  //                                 children: [
  //                                   KText(
  //                                     text: 'Date',
  //                                     fontSize: 14,
  //                                   ),
  //                                   KText(
  //                                     text: createTrasnportOrderC
  //                                         .transportOrderDate.value,
  //                                   ),
  //                                 ],
  //                               ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // Others parts
  //                 SizedBox(
  //                   height: 12,
  //                 ),
  //                 searchField(
  //                   title: 'Transport Party',
  //                   placeholder:
  //                       createTrasnportOrderC.transportParty.value.isEmpty
  //                           ? 'Select Transport Party'
  //                           : createTrasnportOrderC.transportParty.value,
  //                   onTap: () async {
  //                     await createTrasnportOrderC.openBottomSheet(
  //                         'Search Transport Party', 'Transport Party');
  //                   },
  //                 ),
  //                 searchField(
  //                   title: 'Receiving Party',
  //                   placeholder:
  //                       createTrasnportOrderC.recivingParty.value.isEmpty
  //                           ? 'Select receiving party'
  //                           : createTrasnportOrderC.recivingParty.value,
  //                   onTap: () async {
  //                     await createTrasnportOrderC.openBottomSheet(
  //                         'Search Receiving Party', 'Receiving Party');
  //                   },
  //                 ),
  //                 singleRecivingPerson(),
  //                 searchField(
  //                   title: 'Source Location (Loading point)',
  //                   placeholder:
  //                       createTrasnportOrderC.sourceLocName.value.isEmpty
  //                           ? 'Select Source Location'
  //                           : createTrasnportOrderC.sourceLocName.value,
  //                   onTap: () {
  //                     createTrasnportOrderC
  //                         .allLocationBottomSheet('Source Location');
  //                   },
  //                 ),
  //                 singleDropLocation(),

  //                 // searchField(
  //                 //   title: 'Destination Location (Unloading Point)',
  //                 //   placeholder:
  //                 //       createTrasnportOrderC.destinationLocName.value.isEmpty
  //                 //           ? 'Select destination location'
  //                 //           : createTrasnportOrderC.destinationLocName.value,
  //                 //   onTap: () async {
  //                 //     createTrasnportOrderC
  //                 //         .searchLocationBottomsheet('Destination Location');
  //                 //   },
  //                 // ),

  //                 singleInspector(),
  //                 goodsInspectorAtLoadingPoint(),

  //                 travelPath(),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Column(
  //           children: [
  //             Divider(),
  //             Container(
  //               margin: EdgeInsets.only(left: 10, top: 12),
  //               height: 47,
  //               width: Get.width,
  //               color: hexToColor('#ffffff'),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.only(
  //                       left: 0,
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         KText(
  //                           text: 'Total Quantity',
  //                           fontSize: 14,
  //                         ),
  //                         KText(
  //                           text: '${createTrasnportOrderC.getTotalQuantity()}',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(
  //                       right: 12,
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         KText(
  //                           text: 'Gross Transportation Fee',
  //                           fontSize: 14,
  //                         ),
  //                         KText(
  //                           text: 'BDT 0',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             createTrasnportOrderC.transportOrderLines.isEmpty
  //                 ? Divider()
  //                 : ListView.builder(
  //                     shrinkWrap: true,
  //                     primary: false,
  //                     itemCount:
  //                         createTrasnportOrderC.transportOrderLines.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       final item =
  //                           createTrasnportOrderC.transportOrderLines[index];
  //                       return Container(
  //                         margin: EdgeInsets.only(
  //                           left: 10,
  //                           right: 10,
  //                           bottom: 12,
  //                         ),
  //                         height: item.expended! ? 325 : 142,
  //                         //width: Get.width,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(5),
  //                           border: Border.all(
  //                               width: 1.5, color: hexToColor('#DBECFB')),
  //                         ),

  //                         child: Column(
  //                           children: [
  //                             Container(
  //                               //width: Get.width,
  //                               height: 40,
  //                               decoration: BoxDecoration(
  //                                   // borderRadius: BorderRadius.circular(12),
  //                                   // border: Border.all(),
  //                                   color: hexToColor('#DBECFB')),
  //                               child: Row(
  //                                 children: [
  //                                   SizedBox(
  //                                     width: 12,
  //                                   ),
  //                                   Icon(
  //                                     item.expended!
  //                                         ? EvaIcons.arrowIosUpwardOutline
  //                                         : EvaIcons.arrowIosDownwardOutline,
  //                                     color: hexToColor('#80939D'),
  //                                   ),
  //                                   KText(
  //                                     text: item.productName,
  //                                     bold: true,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 12,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.only(left: 10, right: 10),
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           KText(
  //                                             text: 'Code',
  //                                             fontSize: 13,
  //                                             color: hexToColor('#515D64'),
  //                                           ),

  //                                           // SvgPicture.asset(
  //                                           //   '${Constants.svgPath}/icon_search_elements.svg',
  //                                           //   width: 25,
  //                                           //   color: hexToColor('#66A1D9'),
  //                                           // ),
  //                                         ],
  //                                       ),
  //                                       item.expended!
  //                                           ? Padding(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 0,
  //                                               ),
  //                                               child: KText(
  //                                                 text: '${item.productCode}',
  //                                                 color: hexToColor('#515D64'),
  //                                                 fontSize: 13,
  //                                               ),
  //                                             )
  //                                           : Container()
  //                                     ],
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.end,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           KText(
  //                                             text: 'Drop Location ',
  //                                             fontSize: 13,
  //                                             color: hexToColor('#515D64'),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       item.expended!
  //                                           ? Padding(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 0,
  //                                               ),
  //                                               child: KText(
  //                                                 text: item.dropLocName ??
  //                                                     'not selected',
  //                                                 color: hexToColor('#515D64'),
  //                                                 fontSize: 14,
  //                                               ),
  //                                             )
  //                                           : Container(
  //                                               margin: EdgeInsets.all(0),
  //                                               padding: EdgeInsets.all(0),
  //                                             )
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             // SizedBox(
  //                             //   height: 5,
  //                             // ),
  //                             item.expended!
  //                                 ? Column(
  //                                     children: [
  //                                       Divider(color: hexToColor('#DBECFB')),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                             left: 10, right: 10),
  //                                         child: Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 KText(text: 'Distance'),
  //                                                 SizedBox(
  //                                                   width: 10,
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             KText(
  //                                               text:
  //                                                   '${item.distance ?? '0'} Km',
  //                                               bold: true,
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       // Padding(
  //                                       //   padding: EdgeInsets.only(
  //                                       //     left: 10,
  //                                       //     right: 10,
  //                                       //     top: 10,
  //                                       //   ),
  //                                       //   child: Row(
  //                                       //     children: [
  //                                       //       Row(
  //                                       //         mainAxisAlignment:
  //                                       //             MainAxisAlignment
  //                                       //                 .spaceBetween,
  //                                       //         children: [
  //                                       //           KText(text: 'Quantity'),
  //                                       //           SizedBox(
  //                                       //             width: 10,
  //                                       //           ),
  //                                       //         ],
  //                                       //       ),
  //                                       //       Spacer(),
  //                                       //       SizedBox(
  //                                       //         width: 70,
  //                                       //         child: TextField(
  //                                       //           decoration:
  //                                       //               InputDecoration(
  //                                       //             contentPadding:
  //                                       //                 EdgeInsets.all(0),
  //                                       //             isDense: true,
  //                                       //             hintText: '649',
  //                                       //             labelStyle: TextStyle(
  //                                       //                 color: hexToColor(
  //                                       //                     '#FF0000')),
  //                                       //             enabledBorder:
  //                                       //                 UnderlineInputBorder(
  //                                       //               borderSide: BorderSide(
  //                                       //                   color: hexToColor(
  //                                       //                       '#DBECFB')),
  //                                       //             ),
  //                                       //           ),
  //                                       //         ),
  //                                       //       ),
  //                                       //       KText(
  //                                       //         text: 'Pcs',
  //                                       //         fontSize: 14,
  //                                       //       )
  //                                       //     ],
  //                                       //   ),
  //                                       // ),

  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                           left: 10,
  //                                           right: 10,
  //                                           top: 10,
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 KText(text: 'Quantity'),
  //                                                 SizedBox(
  //                                                   width: 10,
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             Spacer(),
  //                                             SizedBox(
  //                                               width: 70,
  //                                               child: TextFormField(
  //                                                 initialValue:
  //                                                     '${item.quantity == 0 ? '' : item.quantity}',
  //                                                 enabled: false,
  //                                                 keyboardType:
  //                                                     TextInputType.number,
  //                                                 style: TextStyle(
  //                                                   fontFamily:
  //                                                       'Manrope Regular',
  //                                                   fontSize: 12,
  //                                                 ),
  //                                                 decoration: InputDecoration(
  //                                                   contentPadding:
  //                                                       EdgeInsets.all(0),
  //                                                   isDense: true,
  //                                                   hintText: '0',
  //                                                   labelStyle: TextStyle(
  //                                                     color:
  //                                                         hexToColor('#FF0000'),
  //                                                   ),
  //                                                   enabledBorder:
  //                                                       UnderlineInputBorder(
  //                                                     borderSide: BorderSide(
  //                                                         color: hexToColor(
  //                                                             '#DBECFB')),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             SizedBox(
  //                                               width: 4,
  //                                             ),
  //                                             KText(
  //                                               text: ' pcs',
  //                                               fontSize: 14,
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                           left: 10,
  //                                           right: 10,
  //                                           top: 10,
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 KText(text: 'Weight'),
  //                                                 SizedBox(
  //                                                   width: 10,
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             Spacer(),
  //                                             SizedBox(
  //                                               width: 70,
  //                                               child: TextFormField(
  //                                                 enabled: false,
  //                                                 initialValue:
  //                                                     '${item.weight == 0 ? '' : item.weight}',
  //                                                 style: TextStyle(
  //                                                   fontFamily:
  //                                                       'Manrope Regular',
  //                                                   fontSize: 12,
  //                                                 ),
  //                                                 keyboardType:
  //                                                     TextInputType.number,
  //                                                 decoration: InputDecoration(
  //                                                   contentPadding:
  //                                                       EdgeInsets.all(0),
  //                                                   isDense: true,
  //                                                   hintText: '0',
  //                                                   enabledBorder:
  //                                                       UnderlineInputBorder(
  //                                                     borderSide: BorderSide(
  //                                                         color: hexToColor(
  //                                                             '#DBECFB')),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             SizedBox(
  //                                               width: 12,
  //                                             ),
  //                                             KText(
  //                                               text: ' Kg',
  //                                               fontSize: 14,
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       // KText(text: '${item.weight}'),
  //                                       Divider(color: hexToColor('#DBECFB')),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                           left: 10,
  //                                           right: 10,
  //                                           top: 10,
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 KText(
  //                                                   text: 'Transportation Fee',
  //                                                   fontSize: 14,
  //                                                   color:
  //                                                       hexToColor('#41525A'),
  //                                                 ),
  //                                                 SizedBox(
  //                                                   width: 10,
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             Spacer(),
  //                                             KText(
  //                                               text:
  //                                                   'BDT  ${item.transportationFee}',
  //                                               fontSize: 14,
  //                                               bold: true,
  //                                               color: hexToColor(
  //                                                 '#41525A',
  //                                               ),
  //                                             ),
  //                                             // KText(
  //                                             //   text: 'Kg',
  //                                             //   fontSize: 14,
  //                                             // )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       // SizedBox(
  //                                       //   height: 16,
  //                                       // ),
  //                                       // Padding(
  //                                       //   padding:
  //                                       //         EdgeInsets.only(left: 10, right: 10),
  //                                       //   child: Row(
  //                                       //     mainAxisAlignment:
  //                                       //         MainAxisAlignment.spaceBetween,
  //                                       //     children: [
  //                                       //       Row(
  //                                       //         mainAxisAlignment:
  //                                       //             MainAxisAlignment.spaceBetween,
  //                                       //         children: [
  //                                       //           Text('26345634'),
  //                                       //           SizedBox(
  //                                       //             width: 10,
  //                                       //           ),
  //                                       //           Text('-'),
  //                                       //           SizedBox(
  //                                       //             width: 10,
  //                                       //           ),
  //                                       //           Text('21741273'),
  //                                       //         ],
  //                                       //       ),
  //                                       //       Text('5 Kg'),
  //                                       //     ],
  //                                       //   ),
  //                                       // ),
  //                                     ],
  //                                   )
  //                                 : Column(
  //                                     children: [
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                           left: 10,
  //                                           right: 10,
  //                                           top: 0,
  //                                         ),
  //                                         child: Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 KText(
  //                                                   text: '${item.productCode}',
  //                                                   color:
  //                                                       hexToColor('#515D64'),
  //                                                   fontSize: 13,
  //                                                 )
  //                                               ],
  //                                             ),
  //                                             SizedBox(
  //                                               height: 6,
  //                                             ),
  //                                             KText(
  //                                               text: item.dropLocName ??
  //                                                   'select drop location',
  //                                               color: hexToColor('#515D64'),
  //                                               fontSize: 14,
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                             Padding(
  //                               padding: EdgeInsets.only(left: 10),
  //                               child: Row(
  //                                 children: [
  //                                   // Container(
  //                                   //     height: 1, width: 50, color: hexToColor('#DBECFB')),
  //                                   // SizedBox(
  //                                   //   width: 50,
  //                                   // ),
  //                                   // Container(
  //                                   //     height: 1, width: 60, color: hexToColor('#DBECFB')),
  //                                   // SizedBox(
  //                                   //   width: 120,
  //                                   // ),
  //                                   // Container(
  //                                   //     height: 1, width: 50, color: hexToColor('#DBECFB'))
  //                                 ],
  //                               ),
  //                             ),
  //                             Divider(color: hexToColor('#DBECFB')),
  //                             item.expended!
  //                                 ? Padding(
  //                                     padding:
  //                                         EdgeInsets.only(left: 10, right: 10),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 KText(
  //                                                   text: 'Goods Receiver',
  //                                                   fontSize: 13,
  //                                                   color:
  //                                                       hexToColor('#80939D'),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             KText(
  //                                               text: item.receiverFullname ??
  //                                                   'select reciver',
  //                                               fontSize: 15,
  //                                               color: hexToColor('#515D64'),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.end,
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 KText(
  //                                                   text: 'Goods Inspector',
  //                                                   fontSize: 13,
  //                                                   color:
  //                                                       hexToColor('#80939D'),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             KText(
  //                                               text: item.goodsInspector ??
  //                                                   'select inspector',
  //                                               fontSize: 15,
  //                                               color: hexToColor('#515D64'),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )
  //                                 : Padding(
  //                                     padding:
  //                                         EdgeInsets.only(left: 10, right: 10),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         KText(
  //                                           text: 'Quantity',
  //                                         ),
  //                                         KText(
  //                                           text: '${item.quantity} PCs',
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget searchField({
  //   required String title,
  //   required String placeholder,
  //   void Function()? onTap,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             KText(
  //               text: title,
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 2,
  //             ),
  //             KText(
  //               text: '*',
  //               color: Colors.redAccent,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         KText(
  //           text: placeholder,
  //           fontSize: 15,
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget singleDropLocation() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                     activeColor: hexToColor('#84BEF3'),
  //                     value: createTrasnportOrderC.isSingleDropLocation.value,
  //                     onChanged: (bool? value) =>
  //                         createTrasnportOrderC.isSingleDropLocation.toggle()),
  //               ),
  //             ),
  //             KText(
  //               text: 'Single Drop Location (Unloading Point)',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 2,
  //             ),
  //             KText(
  //               text: '*',
  //               color: Colors.redAccent,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 8,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: createTrasnportOrderC.singleDropLocName.isEmpty
  //                   ? 'Select drop location'
  //                   : createTrasnportOrderC.singleDropLocName.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: 'ETD (Estimated Time of Delivery)',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 2,
  //             ),
  //             KText(
  //               text: '*',
  //               color: Colors.redAccent,
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Row(
  //           children: [
  //             KText(
  //               text: createTrasnportOrderC.etd.value.isEmpty
  //                   ? 'Select ETD'
  //                   : createTrasnportOrderC.etd.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget travelPath() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                     activeColor: hexToColor('#84BEF3'),
  //                     value: createTrasnportOrderC.isPrescribeTravelPath.value,
  //                     onChanged: (bool? value) =>
  //                         createTrasnportOrderC.isPrescribeTravelPath.toggle()),
  //               ),
  //             ),
  //             KText(
  //               text: 'Prescribe Travel Path',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: KText(
  //                 text: createTrasnportOrderC.prescribeTravelPath.value.isEmpty
  //                     ? 'select travel path'
  //                     : createTrasnportOrderC.prescribeTravelPath.value,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget singleRecivingPerson() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                   activeColor: hexToColor('#84BEF3'),
  //                   value: createTrasnportOrderC.isSingleRecivingPerson.value,
  //                   onChanged: (bool? _) =>
  //                       createTrasnportOrderC.isSingleRecivingPerson.toggle(),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: 'Single Receiving Person',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 10),
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffF5F5FA),
  //                   borderRadius: BorderRadius.circular(50),
  //                   border: Border.all(
  //                     color: Color.fromARGB(255, 230, 230, 233),
  //                     style: BorderStyle.solid,
  //                     width: 2,
  //                   ),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Color(0xffF5F5FA).withOpacity(0.6),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: Container(
  //                   height: 38,
  //                   width: 38,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(1.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child: RenderImg(
  //                         path: 'icon_avatar.png',
  //                         width: 37,
  //                         height: 37,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: createTrasnportOrderC.singleReciverPartyName.value.isEmpty
  //                   ? 'select single receving party'
  //                   : createTrasnportOrderC.singleReciverPartyName.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget singleInspector() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 5),
  //               child: SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: Checkbox(
  //                   activeColor: hexToColor('#84BEF3'),
  //                   value: createTrasnportOrderC.isSinglegoodsInspector.value,
  //                   onChanged: (bool? _) =>
  //                       createTrasnportOrderC.isSinglegoodsInspector.toggle(),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: 'Single Goods Inspector at the Drop Location',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(height: 5),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 10),
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffF5F5FA),
  //                   borderRadius: BorderRadius.circular(50),
  //                   border: Border.all(
  //                     color: Color.fromARGB(255, 230, 230, 233),
  //                     style: BorderStyle.solid,
  //                     width: 2,
  //                   ),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Color(0xffF5F5FA).withOpacity(0.6),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: Container(
  //                   height: 38,
  //                   width: 38,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(1.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child: RenderImg(
  //                         path: 'icon_avatar.png',
  //                         width: 37,
  //                         height: 37,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: createTrasnportOrderC
  //                       .singleGoodsInspectorDropLocFullName.value.isEmpty
  //                   ? 'select single goods inspector'
  //                   : createTrasnportOrderC
  //                       .singleGoodsInspectorDropLocFullName.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget goodsInspectorAtLoadingPoint() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             // Padding(
  //             //   padding: EdgeInsets.only(right: 5),
  //             //   child: SizedBox(
  //             //     height: 20,
  //             //     width: 20,
  //             //     child: Checkbox(
  //             //       activeColor: hexToColor('#84BEF3'),
  //             //       value: true,
  //             //       onChanged: (bool? value) {},
  //             //     ),
  //             //   ),
  //             // ),
  //             KText(
  //               text: 'Goods Inspector at the Loading Point',
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //             // IconButton(
  //             //   onPressed: widget.onPressed,
  //             //   icon: SvgPicture.asset(
  //             //     '${Constants.svgPath}/icon_search_elements.svg',
  //             //     color: hexToColor('#66A1D9'),
  //             //     width: 16,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 10),
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffF5F5FA),
  //                   borderRadius: BorderRadius.circular(50),
  //                   border: Border.all(
  //                     color: Color.fromARGB(255, 230, 230, 233),
  //                     style: BorderStyle.solid,
  //                     width: 2,
  //                   ),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Color(0xffF5F5FA).withOpacity(0.6),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: Container(
  //                   height: 38,
  //                   width: 38,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(1.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child: RenderImg(
  //                         path: 'icon_avatar.png',
  //                         width: 37,
  //                         height: 37,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: createTrasnportOrderC
  //                       .goodsInspectorAtLoadingPointName.value.isEmpty
  //                   ? 'select goods inspector'
  //                   : createTrasnportOrderC
  //                       .goodsInspectorAtLoadingPointName.value,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget searchFieldWithPic({
  //   required String title,
  //   required String placeholder,
  //   void Function()? onTap,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Checkbox(value: true, onChanged: (v) {}),
  //             KText(
  //               text: title,
  //               color: hexToColor('#80939D'),
  //               fontSize: 13,
  //             ),
  //             SizedBox(
  //               width: 3,
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(right: 10),
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Color(0xffF5F5FA),
  //                   borderRadius: BorderRadius.circular(50),
  //                   border: Border.all(
  //                     color: Color.fromARGB(255, 230, 230, 233),
  //                     style: BorderStyle.solid,
  //                     width: 2,
  //                   ),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Color(0xffF5F5FA).withOpacity(0.6),
  //                       spreadRadius: 5,
  //                       blurRadius: 7,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: Container(
  //                   height: 38,
  //                   width: 38,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(1.0),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(50),
  //                       child: Image.asset(
  //                         '${Constants.imgPath}/bill.jpg',
  //                         width: 37,
  //                         height: 37,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             KText(
  //               text: placeholder,
  //               fontSize: 15,
  //             ),
  //           ],
  //         ),
  //         Divider(
  //           color: Colors.black,
  //         ),
  //         SizedBox(
  //           height: 10,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
