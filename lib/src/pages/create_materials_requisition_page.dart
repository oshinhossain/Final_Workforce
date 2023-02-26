import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';

import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';

class CreateMaterialRequisitionPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CreateMaterialRequisitionPageState createState() => _CreateMaterialRequisitionPageState();
}

class _CreateMaterialRequisitionPageState extends State<CreateMaterialRequisitionPage> with SingleTickerProviderStateMixin, Base {
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
            text: 'Create Materials Requisition',
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
                padding: EdgeInsets.only(left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
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
            Materials(),
            Geographies(),
          ],
        ),
        persistentFooterButtons: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (createMaterialReqC.orderingParty.value.isNotEmpty &&
                    createMaterialReqC.suplyingParty.value.isNotEmpty &&
                    createMaterialReqC.delivaryLocName.value.isNotEmpty &&
                    createMaterialReqC.projectName.value.isNotEmpty &&
                    createMaterialReqC.selectedDate.value.isNotEmpty &&
                    createMaterialReqC.geographyList.isNotEmpty) {
                  createMaterialReqC.postMaterialRequisition();
                }
              },
              child: Container(
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
                  color: createMaterialReqC.orderingParty.value.isNotEmpty &&
                          createMaterialReqC.suplyingParty.value.isNotEmpty &&
                          createMaterialReqC.delivaryLocName.value.isNotEmpty &&
                          createMaterialReqC.projectName.value.isNotEmpty &&
                          createMaterialReqC.selectedDate.value.isNotEmpty &&
                          createMaterialReqC.geographyList.isNotEmpty
                      ? hexToColor('#007BEC')
                      : Colors.blue.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(fontFamily: 'Manrope', fontSize: 14.0, color: Colors.amber, fontWeight: FontWeight.w700),
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
        unselectedLabelStyle: TextStyle(fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'Materials'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border(left: BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Geographies')),
        ],
      );
}

class Materials extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    //  unloadMaterialsC.unloadMaterialsGet();
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    KText(
                      text: 'Reference No.',
                      fontSize: 14,
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text: '(Auto)',
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: createMaterialReqC.selectDate,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.blueAccent,
                              ),
                            )),
                        KText(
                          text: 'ETD',
                          fontSize: 14,
                        ),
                        KText(
                          text: '*',
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    KText(
                      text: createMaterialReqC.selectedDate.value == null || createMaterialReqC.selectedDate.value == ''
                          ? 'Choose Date'
                          : createMaterialReqC.selectedDate.value,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: hexToColor('#EBEBEC'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    KText(
                      text: 'Project Name',
                      fontSize: 14,
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text: '*',
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      createMaterialReqC.projectNameDropdown();
                    },
                    child: RenderSvg(
                      path: 'dropdown',
                      height: 12,
                    ),
                  ),
                )
              ],
            ),
            KText(
              text: createMaterialReqC.projectName.value.isEmpty ? '' : createMaterialReqC.projectName.value,
            ),
            Divider(
              color: hexToColor('#515D64'),
            ),
            Row(
              children: [
                KText(
                  text: 'Default Delivery Location',
                  fontSize: 13,
                  color: hexToColor('#80939D'),
                ),
                KText(
                  text: '*',
                  fontSize: 14,
                  color: Colors.red,
                ),
                GestureDetector(
                    onTap: () {
                      createMaterialReqC.locationBottomSheet();
                    },
                    child: SvgPicture.asset('${Constants.svgPath}/icon_Search_Elements.svg')),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: KText(
                text: createMaterialReqC.delivaryLocName.isEmpty ? '' : createMaterialReqC.delivaryLocName.value,
                fontSize: 15,
                color: hexToColor('#515D64'),
              ),
            ),
            Divider(
              color: hexToColor('#515D64'),
            ),
            Row(
              children: [
                KText(
                  text: 'Supplying Party',
                  fontSize: 13,
                  color: hexToColor('#80939D'),
                ),
                KText(
                  text: '*',
                  fontSize: 14,
                  color: Colors.red,
                ),
                GestureDetector(
                    onTap: () {
                      createMaterialReqC.openBottomSheet('Search Supplying Party', 'Supplying Party');
                    },
                    child: SvgPicture.asset('${Constants.svgPath}/icon_Search_Elements.svg')),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: KText(
                text: createMaterialReqC.suplyingParty.value.isEmpty ? '' : createMaterialReqC.suplyingParty.value,
                fontSize: 15,
                color: hexToColor('#515D64'),
              ),
            ),
            Divider(
              color: hexToColor('#515D64'),
            ),
            Row(
              children: [
                KText(
                  text: 'Ordering Party',
                  fontSize: 13,
                  color: hexToColor('#80939D'),
                ),
                KText(
                  text: '*',
                  fontSize: 14,
                  color: Colors.red,
                ),
                GestureDetector(
                    onTap: () {
                      createMaterialReqC.openBottomSheet('Search Ordering Party', 'Ordering Party');
                    },
                    child: SvgPicture.asset('${Constants.svgPath}/icon_Search_Elements.svg')),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: KText(
                text: createMaterialReqC.orderingParty.value.isEmpty ? '' : createMaterialReqC.orderingParty.value,
                fontSize: 15,
                color: hexToColor('#515D64'),
              ),
            ),
            Divider(
              color: hexToColor('#515D64'),
            ),
            SizedBox(
              height: 20,
            ),
            if (createMaterialReqC.orderingParty.value.isNotEmpty &&
                createMaterialReqC.suplyingParty.value.isNotEmpty &&
                createMaterialReqC.delivaryLocName.value.isNotEmpty &&
                createMaterialReqC.projectName.value.isNotEmpty &&
                createMaterialReqC.selectedDate.value.isNotEmpty &&
                createMaterialReqC.geographyList.isNotEmpty)
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            createMaterialReqC.searchMaterialBottomSheet();
                            //  openBottomSheet();
                          },
                          child: SvgPicture.asset('${Constants.svgPath}/icon_add_box.svg')),
                      SizedBox(
                        width: 5,
                      ),
                      KText(
                        text: 'Materials',
                        fontSize: 14,
                        color: hexToColor('#41525A'),
                        bold: true,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          createMaterialReqC.loadFromBudget();
                        },
                        child: Container(
                          height: 30,
                          width: 203,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.searchColor)),
                          child: Center(
                            child: KText(
                              text: 'Load From Geography Budget',
                              bold: true,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: hexToColor('#515D64'),
                  ),
                  // ListView.builder(
                  //   itemCount: createMaterialReqC.productItemList.length,
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     final item = createMaterialReqC.productItemList[index];
                  //     return Container(
                  //       margin: EdgeInsets.only(top: 15),
                  //       height: 220,
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         // borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         border: Border.all(width: 1, color: hexToColor('#DBECFB')),
                  //         color: hexToColor('#FFFFFF'),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         //  mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Container(
                  //             height: 34,
                  //             width: double.infinity,
                  //             // color: hexToColor('#FFE9CF'),
                  //             decoration: BoxDecoration(
                  //               border: Border.all(width: 1, color: hexToColor('#DBECFB')),
                  //               borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  //               color: hexToColor('#DBECFB'),
                  //             ),
                  //             child: Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Expanded(
                  //                   flex: 8,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(bottom: 5, left: 15, top: 5),
                  //                     child: KText(
                  //                       text: item.productName,
                  //                       fontSize: 16,
                  //                       color: hexToColor('#41525A'),
                  //                       bold: true,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   flex: 2,
                  //                   child: GestureDetector(
                  //                     onTap: () {
                  //                       createMaterialReqC.productItemList.removeWhere((x) => x.productId == item.productId);
                  //                     },
                  //                     child: Padding(
                  //                       padding: EdgeInsets.symmetric(horizontal: 10),
                  //                       child: SvgPicture.asset(
                  //                         '${Constants.svgPath}/icon_delete.svg',
                  //                         width: 25,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 16, right: 16, top: 6),
                  //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  //               KText(text: 'Code ', color: hexToColor('#80939D')),
                  //               KText(
                  //                 text: item.productFullcode,
                  //                 color: AppTheme.txtColor,
                  //               ),
                  //             ]),
                  //           ),
                  //           Divider(
                  //             color: AppTheme.borderColor,
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 16, right: 16),
                  //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  //               KText(text: 'Quantity', color: AppTheme.textfieldColor),
                  //               Spacer(),
                  //               SizedBox(
                  //                 width: 60,
                  //                 child: TextFormField(
                  //                   inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  //                   keyboardType: TextInputType.number,
                  //                   // initialValue: '${item.demandUomQuantity == 0 ? '' : item.demandUomQuantity!.toInt()}',
                  //                   onChanged: (value) {
                  //                     if (value.isNotEmpty) {
                  //                       createMaterialReqC.updateItem(
                  //                         item,
                  //                         int.parse(value),
                  //                       );
                  //                     } else {
                  //                       createMaterialReqC.updateItem(
                  //                         item,
                  //                         0,
                  //                       );
                  //                     }
                  //                   },

                  //                   decoration: InputDecoration(
                  //                     contentPadding: EdgeInsets.all(0),
                  //                     isDense: true,
                  //                     labelStyle: TextStyle(color: hexToColor('#FF0000')),
                  //                     enabledBorder: UnderlineInputBorder(
                  //                       borderSide: BorderSide(color: AppTheme.borderColor),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               KText(text: item.baseUom, color: AppTheme.textfieldColor),
                  //             ]),
                  //           ),
                  //           Divider(
                  //             color: AppTheme.borderColor,
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 16, right: 16, top: 6),
                  //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  //               KText(text: 'Location', color: hexToColor('#80939D')),
                  //               KText(
                  //                 text: createMaterialReqC.delivaryLocName.value,
                  //                 color: AppTheme.txtColor,
                  //               ),
                  //             ]),
                  //           ),
                  //           Divider(
                  //             color: AppTheme.borderColor,
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 16, right: 16),
                  //             child: KText(text: 'Material Description ', color: hexToColor('#80939D')),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 16, right: 16),
                  //             child: KText(
                  //               text: item.productDescription,
                  //               color: AppTheme.textColor,
                  //               maxLines: 2,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  createMaterialReqC.isLoading.value
                      ? Center(
                          child: Loading(),
                        )
                      :
                      // if (createMaterialReqC.projectBudget.isNotEmpty)
                      ListView.builder(
                          itemCount: createMaterialReqC.projectBudget.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            final item = createMaterialReqC.projectBudget[index];
                            return Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 240,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(Radius.circular(5)),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(width: 1, color: hexToColor('#DBECFB')),
                                color: hexToColor('#FFFFFF'),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //  mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 34,
                                    width: double.infinity,
                                    // color: hexToColor('#FFE9CF'),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: hexToColor('#DBECFB')),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                      color: hexToColor('#DBECFB'),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 5, left: 15, top: 5),
                                            child: KText(
                                              text: item.productName,
                                              fontSize: 16,
                                              color: hexToColor('#41525A'),
                                              bold: true,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              createMaterialReqC.projectBudget.removeWhere((x) => x.productId == item.productId);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: SvgPicture.asset(
                                                '${Constants.svgPath}/icon_delete.svg',
                                                width: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16, top: 6),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                                      KText(text: 'Code ', color: hexToColor('#80939D')),
                                      KText(
                                        text: item.productFullcode,
                                        color: AppTheme.txtColor,
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: AppTheme.borderColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                                      KText(text: 'Quantity', color: AppTheme.textfieldColor),
                                      Spacer(),
                                      SizedBox(
                                        width: 60,
                                        child: TextFormField(
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                          keyboardType: TextInputType.number,
                                          initialValue: '${item.poleCnt == 0 ? '' : item.poleCnt}',
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              createMaterialReqC.updatePole(
                                                item,
                                                int.parse(value),
                                              );
                                            } else {
                                              createMaterialReqC.updatePole(
                                                item,
                                                0,
                                              );
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            isDense: true,
                                            labelStyle: TextStyle(color: hexToColor('#FF0000')),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: AppTheme.borderColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      KText(text: 'Pcs', color: AppTheme.textfieldColor),
                                    ]),
                                  ),
                                  Divider(
                                    color: AppTheme.borderColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16, top: 6),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Expanded(flex: 4, child: KText(text: 'Location', color: hexToColor('#80939D'))),
                                      Expanded(
                                        flex: 8,
                                        child: KText(
                                          text: item.dropLocTitle,
                                          color: AppTheme.txtColor,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: AppTheme.borderColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: KText(text: 'Material Description ', color: hexToColor('#80939D')),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: KText(
                                      text: item.productDescription,
                                      color: AppTheme.textColor,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      KText(
                        text: 'Overall Remarks',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    initialValue: createMaterialReqC.overAllRemarks.value == '' ? '' : createMaterialReqC.overAllRemarks.value,
                    onChanged: createMaterialReqC.overAllRemarks,
                    maxLines: 5,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Remarks Here',
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: .1)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Geographies extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    // createMaterialReqC.addGeographyToList();
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        RenderSvg(path: 'icon_pointer'),
                        // SvgPicture.asset(
                        //     '${Constants.svgPath}/trucklogo.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        KText(
                          text: 'Geography',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                      ],
                    ),
                    Spacer(),
                    KText(
                      text: 'Add ',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('object');
                        createMaterialReqC.geographiesBottomSheet();
                      },
                      child: RenderSvg(path: 'icon_add_box'),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashGapLength: 1,
                dashColor: AppTheme.borderColor3,
                dashLength: 3,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: AppTheme.borderColor3),
                  ),
                  color: AppTheme.areaColor,
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [KText(text: 'Area Type'), KText(text: 'Level')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: 'Country Unit',
                        bold: true,
                      ),
                      KText(
                        text: '4',
                        bold: true,
                      )
                    ],
                  ),
                ]),
              ),
              ListView.builder(
                  itemCount: createMaterialReqC.geographyList.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: ((context, index) {
                    final item = createMaterialReqC.geographyList[index];
                    return Container(
                      height: 113,
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.searchColor)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(text: 'Level 2'),
                                    KText(
                                      text: item.geoLevel2Name,
                                      bold: true,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    createMaterialReqC.geographyList.removeWhere((x) => x.id == item.id);
                                    createMaterialReqC.levelCode.removeAt(index);
                                  },
                                  child: SvgPicture.asset(
                                    '${Constants.svgPath}/icon_delete.svg',
                                    width: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppTheme.searchColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(text: 'Level 3'),
                                      KText(
                                        text: item.geoLevel3Name,
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      KText(text: 'Level 4'),
                                      KText(
                                        text: item.geoLevel4Name,
                                        bold: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
