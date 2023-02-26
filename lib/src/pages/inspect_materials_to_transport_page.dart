import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../controllers/inspect_materials_controller.dart';
import '../helpers/global_helper.dart';
import 'assign_vehicle_and_driver_page.dart';

class InspectMaterialsToTransportPage extends StatefulWidget {
  final String? transportOrderNo;
  final String? transportOrderId;
  final bool? isFromNotification;

  InspectMaterialsToTransportPage({
    this.transportOrderNo,
    this.transportOrderId,
    this.isFromNotification,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InspectMaterialsToTransportPageState createState() =>
      _InspectMaterialsToTransportPageState();
}

class _InspectMaterialsToTransportPageState
    extends State<InspectMaterialsToTransportPage>
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
      inspectMaterialsC.getTransportOrder(
        transportOrderNo: widget.transportOrderNo!,
        transportOrderId: widget.transportOrderId!,
      );
    } else {
      inspectMaterialsC.getTransportOrder(
          transportOrderNo: '20221026.00004',
          transportOrderId: widget.transportOrderId!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    inspectMaterialsC.overAllRemarks.value = '';
    inspectMaterialsC.transportOrderItemList.clear();

    _tabController!.dispose();
  }

  final datepicker = TextEditingController();

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
            text: 'Inspect Materials to Transport',
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
            //evidence(),
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
                  ? BorderRadius.only(
                      topRight: Radius.circular(5.0),
                    )
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
                    left: BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
            child: Tab(text: 'Evidence'),
          ),
        ],
      );

  //             // color: hexToColor('#FFE9CF'),
  //             decoration: BoxDecoration(
  //               // borderRadius: BorderRadius.all(Radius.circular(5)),
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //               color: hexToColor('#FFE9CF'),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   children: [
  //                     SizedBox(
  //                       width: 14,
  //                     ),
  //                     RenderSvg(path: 'icon_pointer'),
  //                     //  SvgPicture.asset('${Constants.svgPath}/trucklogo.svg'),
  //                     SizedBox(
  //                       width: 5,
  //                     ),
  //                     KText(
  //                       text: 'Picture of Dropped Materials',
  //                       fontSize: 16,
  //                       color: hexToColor('#41525A'),
  //                       bold: true,
  //                     ),
  //                     Spacer(),
  //                     Padding(
  //                       padding:   EdgeInsets.only(right: 10),
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           Get.put(InspectMaterialsController())
  //                               .pickMultiImage();
  //                         },
  //                         child: RenderSvg(path: 'icon_add_box'),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),

  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               inspectMaterialsC.imagefiles.isEmpty
  //                   ? GridView.builder(
  //                       gridDelegate:
  //                             SliverGridDelegateWithFixedCrossAxisCount(
  //                         crossAxisCount: 2,
  //                       ),
  //                       itemCount: 2,
  //                       primary: false,
  //                       shrinkWrap: true,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Container(
  //                           margin: EdgeInsets.all(5),
  //                           child: Image.asset(
  //                             '${Constants.imgPath}/truck3.png',
  //                             fit: BoxFit.cover,
  //                           ),
  //                         );
  //                       },
  //                     )
  //                   : GridView.builder(
  //                       gridDelegate:
  //                             SliverGridDelegateWithFixedCrossAxisCount(
  //                         crossAxisCount: 2,
  //                       ),
  //                       itemCount: loadMaterialsToVehicleC.imagefiles.length,
  //                       primary: false,
  //                       shrinkWrap: true,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         final item =
  //                             loadMaterialsToVehicleC.imagefiles[index];
  //                         return Stack(
  //                           children: [
  //                             Container(
  //                               width: double.infinity,
  //                               margin: EdgeInsets.all(5),
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 child: Image.file(
  //                                   File(item.path),
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                               ),
  //                             ),
  //                             Positioned(
  //                               top: 0,
  //                               right: 0,
  //                               left: 0,
  //                               bottom: 0,
  //                               child: InkWell(
  //                                 onTap: () {
  //                                   loadMaterialsToVehicleC.imagefiles
  //                                       .removeAt(index);
  //                                 },
  //                                 child: Container(
  //                                   margin: EdgeInsets.all(60),
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(50),
  //                                     color: Colors.white.withOpacity(0.5),
  //                                   ),
  //                                   child: Icon(
  //                                     Icons.delete,
  //                                     color: Colors.redAccent,
  //                                     size: 30,
  //                                   ),
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         );
  //                       },
  //                     ),
  //             ],
  //           ),

  //           // Column(
  //           //   mainAxisAlignment: MainAxisAlignment.center,
  //           //   children: [
  //           //     Container(
  //           //       margin: EdgeInsets.all(14.0),
  //           //       height: 340,
  //           //       width: double.infinity,
  //           //       // decoration: BoxDecoration(
  //           //       //     border: Border.all(color: Colors.grey, width: 3)),
  //           //       child: GridView(
  //           //         physics: NeverScrollableScrollPhysics(),
  //           //         scrollDirection: Axis.horizontal,
  //           //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           //           crossAxisCount: 2,
  //           //         ),
  //           //         children: [
  //           //           Container(
  //           //             margin: EdgeInsets.all(5),
  //           //             child: Image.asset(
  //           //                 '${Constants.imgPath}/receive_material01.png',
  //           //                 height: 142.73,
  //           //                 fit: BoxFit.cover),
  //           //           ),
  //           //           Container(
  //           //             margin: EdgeInsets.all(5),
  //           //             child: Image.asset(
  //           //                 '${Constants.imgPath}/receive_material02.png',
  //           //                 fit: BoxFit.cover),
  //           //           ),
  //           //           Container(
  //           //             margin: EdgeInsets.all(5),
  //           //             child: Image.asset(
  //           //                 '${Constants.imgPath}/receive_material03.png',
  //           //                 fit: BoxFit.cover),
  //           //           ),
  //           //           Container(
  //           //             margin: EdgeInsets.all(5),
  //           //             child: Image.asset(
  //           //                 '${Constants.imgPath}/receive_material04.png',
  //           //                 fit: BoxFit.cover),
  //           //           ),
  //           //         ],
  //           //       ),
  //           //     ),
  //           //   ],
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void openBottomSheet() {
  //   Get.bottomSheet(
  //     isScrollControlled: true,

  //     //persistent: true,
  //     SingleChildScrollView(
  //       child: Container(
  //         height: 600,
  //         padding: EdgeInsets.symmetric(
  //           horizontal: 20,
  //         ),
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(40.0),
  //                 topRight: Radius.circular(40.0))),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: 10,
  //             ),

  //             Padding(
  //               padding: EdgeInsets.only(
  //                 top: 10,
  //               ),
  //               child: KText(
  //                 text: 'Select Transport Order',
  //                 fontSize: 16,
  //                 bold: true,
  //                 color: hexToColor('#41525A'),
  //               ),
  //             ),
  //             Divider(
  //               thickness: 1,
  //               color: hexToColor('#9BA9B3'),
  //             ),

  //             TextField(
  //               enabled: true,
  //               decoration: InputDecoration(
  //                 suffixIcon: SizedBox(
  //                   height: 7,
  //                   width: 7,
  //                   child: SvgPicture.asset(
  //                     '${Constants.svgPath}/icon_search_elements.svg',
  //                     height: 5,
  //                     width: 5,
  //                     fit: BoxFit.scaleDown,
  //                     color: hexToColor('#66A1D9'),
  //                   ),
  //                 ),
  //                 focusedBorder: InputBorder.none,
  //                 errorText: '',
  //                 hintText: 'Show Transport Order by',
  //               ),
  //             ),

  //             // OutlinedButton(
  //             //   onPressed: () {
  //             //     Get.back();
  //             //   },
  //             //   child: Text('Close'),
  //             // ),

  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 2,
  //                   ),
  //                   child: Padding(
  //                     padding:
  //                         EdgeInsets.symmetric(vertical: 2, horizontal: 10),
  //                     child: KText(
  //                       text: 'Data',
  //                       fontSize: 15,
  //                       bold: true,
  //                       color: hexToColor('#515D64'),
  //                     ),
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: hexToColor('#DBECFB'),
  //                   height: 2,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 15,
  //                     left: 10,
  //                   ),
  //                   child: KText(
  //                     text: 'Source Location',
  //                     fontSize: 15,
  //                     bold: true,
  //                     color: hexToColor('#515D64'),
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: hexToColor('#DBECFB'),
  //                   height: 2,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 15,
  //                     left: 10,
  //                   ),
  //                   child: KText(
  //                     text: 'Destination Location',
  //                     fontSize: 15,
  //                     bold: true,
  //                     color: hexToColor('#515D64'),
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: hexToColor('#DBECFB'),
  //                   height: 2,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 15,
  //                     left: 10,
  //                   ),
  //                   child: KText(
  //                     text: 'Transport Party',
  //                     fontSize: 15,
  //                     bold: true,
  //                     color: hexToColor('#515D64'),
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: hexToColor('#DBECFB'),
  //                   height: 2,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 15,
  //                     left: 10,
  //                   ),
  //                   child: KText(
  //                     text: 'Receiving Party',
  //                     fontSize: 15,
  //                     bold: true,
  //                     color: hexToColor('#515D64'),
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: hexToColor('#DBECFB'),
  //                   height: 2,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(
  //                     bottom: 5,
  //                     top: 15,
  //                     left: 10,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),

  //     //backgroundColor: Colors.white,
  //     elevation: 0,
  //   );
  // }
}

// class TextFieldWidget extends StatefulWidget {
//   final String title;
//   bool searchIcon;
//   final bool avatar;
//   final bool hasCheckbox;
//   final String srchText;
//   final Color? color;

//   TextFieldWidget({
//     super.key,
//     this.searchIcon = true,
//     this.avatar = true,
//     required this.title,
//     //this.enabled = false,
//     this.hasCheckbox = false,
//     this.color,
//     required this.srchText,
//   });

//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   bool isActive = true;
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15, right: 15),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               if (widget.hasCheckbox)
//                 Padding(
//                   padding: EdgeInsets.only(right: 5),
//                   child: SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: Checkbox(
//                       activeColor: hexToColor('#84BEF3'),
//                       value: isActive,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isActive = !isActive;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               KText(
//                 text: widget.title,
//                 color: hexToColor('#80939D'),
//                 fontSize: 13,
//               ),
//               SizedBox(
//                 width: 3,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               widget.avatar
//                   ? Padding(
//                       padding: EdgeInsets.only(right: 10),
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Color(0xffF5F5FA),
//                           borderRadius: BorderRadius.circular(50),
//                           border: Border.all(
//                             color: Color.fromARGB(255, 230, 230, 233),
//                             style: BorderStyle.solid,
//                             width: 2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xffF5F5FA).withOpacity(0.6),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset:
//                                   Offset(0, 3), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Container(
//                           height: 38,
//                           width: 38,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(1.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Image.asset(
//                                 '${Constants.imgPath}/bill.jpeg',
//                                 width: 37,
//                                 height: 37,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Container(),
//               KText(
//                 text: widget.srchText,
//                 fontSize: 15,
//                 color: widget.color != null ? widget.color : AppTheme.textColor,
//               ),
//             ],
//           ),
//           Divider(
//             color: Colors.black,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }
// }

class BasicData extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    inspectMaterialsC.overAllRemarks.value = '';
    // inspectMaterialsC.transportOrderItemList.clear();
    return Obx(
      () => inspectMaterialsC.transportOrderItemList.isEmpty
          ? Center(child: Loading())
          : ListView(
              children: [
                SizedBox(height: 22),
                if (inspectMaterialsC.transportOrder.value != null)
                  Builder(builder: (context) {
                    final item = inspectMaterialsC.transportOrder.value;

                    print(item!.id.toString());
                    return Column(
                      children: [
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          color: hexToColor('#FFFFFF'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'Transport Order',
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                  KText(
                                    text: '${item.transportOrderNo}',
                                  )
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
                                    text: formatDate(
                                        date: item.transportOrderDate!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          color: hexToColor('#EBEBEC'),
                          height: 1,
                          width: Get.width,
                        ),
                        SizedBox(height: 15),
                        TextFieldWidget(
                          avatar: false,
                          title: 'Sending Party (Who placed the Order)',
                          srchText: '${item.orderingAgencyName}',
                        ),
                        TextFieldWidget(
                          avatar: false,
                          title: 'Source Location (Loading Point)',
                          srchText: '${item.sourceLocName}',
                        ),
                      ],
                    );
                  }),
                if (inspectMaterialsC.transportOrderItemList.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'icon_bill'),
                            SizedBox(width: 5),
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
                        SizedBox(height: 10),
                        DottedLine(
                          lineThickness: 0.1,
                          dashColor: Colors.black,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              inspectMaterialsC.transportOrderItemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item =
                                inspectMaterialsC.transportOrderItemList[index];

                            return Container(
                              margin: EdgeInsets.only(top: 15),
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: hexToColor('#DBECFB'),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                          child: Checkbox(
                                            value:
                                                item.foundItOkayAtLoadingPoint,
                                            onChanged: (value) {
                                              if (value == true) {
                                                inspectMaterialsC.updateItem(
                                                  item,
                                                  UpdateInputType.foundItOkay,
                                                  value,
                                                );
                                              } else {
                                                inspectMaterialsC.updateItem(
                                                  item,
                                                  UpdateInputType.foundItOkay,
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
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Ordered Quantity',
                                          fontSize: 13,
                                          color: hexToColor('#80939D'),
                                        ),
                                        Row(
                                          children: [
                                            KText(
                                              text: 'Found Quantity',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(
                                              text: '*',
                                              fontSize: 13,
                                              color: Colors.redAccent,
                                            ),
                                          ],
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                  text:
                                                      '${item.baseUomQuantity}',
                                                  fontSize: 15,
                                                ),
                                              ],
                                            ),
                                            item.foundItOkayAtLoadingPoint!
                                                ? SizedBox(
                                                    width: 70,
                                                    child: TextField(
                                                      readOnly: true,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            '${item.inspectorFoundQuantityAtLoadingPoint}',
                                                        hintStyle: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'Manrope Bold',
                                                          color: AppTheme
                                                              .textColor,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(0),
                                                        isDense: true,
                                                        labelStyle: TextStyle(
                                                            color: hexToColor(
                                                                '#FF0000')),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: hexToColor(
                                                                '#DBECFB'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 70,
                                                    child: TextFormField(
                                                      // inputFormatters: <
                                                      //     TextInputFormatter>[
                                                      //   FilteringTextInputFormatter
                                                      //       .digitsOnly
                                                      // ],
                                                      // controller: foundQuantity,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      // initialValue: foundQuantity.text,
                                                      // initialValue:
                                                      //     '${item.inspectorFoundQuantityAtLoadingPoint!.toInt() == 0 ? '' : item.inspectorFoundQuantityAtLoadingPoint!.toInt()}',
                                                      onChanged: (v) {
                                                        // final regExp = RegExp(r'^[0-9]+$');

                                                        //// kLog(regExp.hasMatch(v));
                                                        // //// kLog(v);
                                                        if (v.isNotEmpty) {
                                                          inspectMaterialsC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType
                                                                .quantity,
                                                            v,
                                                          );
                                                        } else {
                                                          inspectMaterialsC
                                                              .updateItem(
                                                            item,
                                                            UpdateInputType
                                                                .quantity,
                                                            0.0,
                                                          );
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0),
                                                        isDense: true,
                                                        labelStyle: TextStyle(
                                                            color: hexToColor(
                                                                '#FF0000')),
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
                                    height: 2,
                                    width: Get.width,
                                    color: hexToColor('#EBEBEC'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            KText(
                                              text: 'Drop Location',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            Expanded(
                                              flex: 6,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: KText(
                                                  //  text: '${item.dropLocName}',
                                                  text: item.dropLocName != null
                                                      ? '${item.dropLocName} '
                                                      : '',
                                                  bold: true,
                                                  fontSize: 15,
                                                  color: AppTheme.appTextColor1,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 2,
                                        width: Get.width,
                                        color: hexToColor('#EBEBEC'),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'Remarks',
                                              color: hexToColor('#41525A'),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.multiline,
                                                initialValue:
                                                    '${item.inspectorRemarkAtLoadingPoint == '' ? '' : item.inspectorRemarkAtLoadingPoint}',
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    inspectMaterialsC
                                                        .updateItem(
                                                      item,
                                                      UpdateInputType.remark,
                                                      value,
                                                    );
                                                  } else {
                                                    inspectMaterialsC
                                                        .updateItem(
                                                      item,
                                                      UpdateInputType.remark,
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
                                                  contentPadding:
                                                      EdgeInsets.all(5),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: .1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: 'Overall Remarks',
                        color: hexToColor('#41525A'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue:
                            inspectMaterialsC.overAllRemarks.value == ''
                                ? ''
                                : inspectMaterialsC.overAllRemarks.value,
                        onChanged: inspectMaterialsC.overAllRemarks,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Remarks Here',
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: .1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
                          //     message: 'Rejected',
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
                      GestureDetector(
                        onTap: inspectMaterialsC.transportOrderItemList.last
                                    .inspectorFoundQuantityAtLoadingPoint!
                                    .toInt() >
                                0
                            ? () {
                                inspectMaterialsC.addInspectionSending();

                                //// kLog(
                                //     'no ${inspectMaterialsC.transportOrder.value!.transportOrderNo!}');
                                //// kLog(
                                //     'no: 1 ${inspectMaterialsC.transportOrder.value!.id!}');
                                inspectMaterialsC.postEvidenceAttachment(
                                    transportOrderNo: inspectMaterialsC
                                        .transportOrder
                                        .value!
                                        .transportOrderNo!,
                                    transportOrderIds: inspectMaterialsC
                                        .transportOrder.value!.id!);
                              }
                            : () {
                                print('no data ');
                              },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: inspectMaterialsC.transportOrderItemList.last
                                        .inspectorFoundQuantityAtLoadingPoint!
                                        .toInt() >
                                    0
                                ? hexToColor('#007BEC')
                                : hexToColor('#007BEC').withOpacity(.5),
                          ),
                          child: Center(
                            child: inspectMaterialsC.isLoading.value
                                ? Loading(
                                    color: Colors.white,
                                  )
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
                                RenderSvg(path: 'trucklogo'),
                                // SvgPicture.asset(
                                //     '${Constants.svgPath}/trucklogo.svg'),
                                SizedBox(
                                  width: 5,
                                ),
                                KText(
                                  text: 'Pictures of Loaded Materials',
                                  fontSize: 16,
                                  color: hexToColor('#41525A'),
                                  bold: true,
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Get.put(InspectMaterialsController())
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
                        inspectMaterialsC.imagefiles.isEmpty
                            ? SizedBox()
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: inspectMaterialsC.imagefiles.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      inspectMaterialsC.imagefiles[index];
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
                                            // inspectMaterialsC.imagefiles
                                            //     .removeAt(index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(60),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Global.confirmDialog(
                                                  onConfirmed: () {
                                                    inspectMaterialsC.imagefiles
                                                        .removeAt(index);
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                                size: 30,
                                              ),
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
            // GestureDetector(
            //   onTap: () {
            //     inspectMaterialsC.postEvidenceAttachment();
            //   },
            //   child: KText(text: 'save'),
            // )
          ],
        ),
      ),
    );
  }
}
