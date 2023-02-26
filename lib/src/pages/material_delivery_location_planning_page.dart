import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/material_location_planning.dart';
import 'package:workforce/src/pages/define_goods_delivery_location_geographies_page.dart';

class MaterialsDeliveryLocationPlanningPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    deliveryLocPlaningC.getProjectName();
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: KAppbar(),
          bottom: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: AppTheme.appbarColor))),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: back,
                  ),
                  KText(
                    text: 'Materials Delivery Location Planning',
                    bold: true,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        GestureDetector(
                          onTap: () {
                            deliveryLocPlaningC.projectNameDropdown();
                          },
                          child: RenderSvg(
                            path: 'dropdown',
                            height: 10,
                          ),
                        )
                      ],
                    ),
                    KText(
                      text: deliveryLocPlaningC.projectName.value.isEmpty
                          ? ''
                          : deliveryLocPlaningC.projectName.value,
                    ),
                    Divider(
                      color: hexToColor('#515D64'),
                    ),
                    deliveryLocPlaningC.isLoading.value
                        ? Center(
                            child: Loading(),
                          )
                        : ListView.builder(
                            itemCount: deliveryLocPlaningC.itemList.length,
                            shrinkWrap: true,
                            primary: false,
                            reverse: true,
                            itemBuilder: (context, index) {
                              final item = deliveryLocPlaningC.itemList[index];
                              return Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: Colors.white,
                                    shadowColor: Colors.grey,
                                    elevation: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFormField(
                                              initialValue: item.dropLocTitle,
                                              onChanged:
                                                  deliveryLocPlaningC.area,
                                              readOnly: deliveryLocPlaningC
                                                      .isEdit.value
                                                  ? false
                                                  : true,
                                              decoration: InputDecoration(
                                                  //  enabled: deliveryLocPlaningC.isEdit.value == true ? true : false,
                                                  //  hintText: item.dropLocTitle,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: hexToColor(
                                                                '#515D64')
                                                            .withOpacity(0.5),
                                                        width: 1),
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      deliveryLocPlaningC.isEdit
                                                          .toggle();
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: deliveryLocPlaningC
                                                              .isEdit.value
                                                          ? Colors.lightBlue
                                                          : Colors.lightBlue
                                                              .withOpacity(0.3),
                                                    ),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  KText(
                                                    text: 'Delivery Location',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                    text: '*',
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        deliveryLocPlaningC
                                                            .locationBottomSheet(
                                                                item.id!);
                                                      },
                                                      child: SvgPicture.asset(
                                                          '${Constants.svgPath}/icon_Search_Elements.svg')),
                                                ],
                                              ),
                                            ),
                                            KText(
                                              text: item.dropLocName,
                                              fontSize: 15,
                                              color: hexToColor('#515D64'),
                                            ),
                                            Divider(
                                              color: hexToColor('#515D64'),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 21,
                                                      backgroundColor:
                                                          hexToColor('#515D64')
                                                              .withOpacity(0.5),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            hexToColor(
                                                                '#EEF0F6'),
                                                        radius: 20,
                                                        child: KText(
                                                          text: item
                                                              .dropLocationCount
                                                              .toString(), //'${item.geograpphy!.length}',
                                                          //defineGoodDeliveryLocC.geographyList.length.toString(),
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // kLog('pressed');
                                                        push(
                                                            DefineGoodsDeliveryLocationGeographiesPage(
                                                          id: item.id,
                                                          levelFullCode: item
                                                              .levelFullcode,
                                                        ));
                                                      },
                                                      child: Container(
                                                        width: 130,
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: hexToColor(
                                                              '#E9EAF0'),
                                                        ),
                                                        child: Center(
                                                          child: KText(
                                                            text: 'Geographies',
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // kLog('value');
                                                    deliveryLocPlaningC.itemList
                                                        .removeWhere((x) =>
                                                            x.id == item.id);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: SvgPicture.asset(
                                                      '${Constants.svgPath}/icon_delete.svg',
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              );
                            }),

                    // deliveryLocPlaningC.isLoading.value
                    //     ? Center(
                    //         child: Loading(),
                    //       )
                    //     :
                    // deliveryLocPlaningC.isLoading.value
                    //     ? Center(
                    //         child: Loading(),
                    //       )
                    //     : ListView.builder(
                    //         itemCount: deliveryLocPlaningC.deliverylocations.length,
                    //         shrinkWrap: true,
                    //         primary: false,
                    //         itemBuilder: (context, index) {
                    //           final item = deliveryLocPlaningC.deliverylocations[index];
                    //           return Padding(
                    //             padding: EdgeInsets.only(bottom: 10),
                    //             child: Card(
                    //               color: Colors.white,
                    //               shadowColor: Colors.grey,
                    //               elevation: 2,
                    //               child: Padding(
                    //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    //                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    //                   Obx(
                    //                     () => TextFormField(
                    //                       onChanged: deliveryLocPlaningC.area,
                    //                       readOnly: deliveryLocPlaningC.isEdit.value ? false : true,
                    //                       initialValue: item.dropLocTitle,
                    //                       decoration: InputDecoration(
                    //                           //  enabled: deliveryLocPlaningC.isEdit.value == true ? true : false,
                    //                           //  hintText: item.areaName,

                    //                           enabledBorder: UnderlineInputBorder(
                    //                             borderSide: BorderSide(color: hexToColor('#515D64').withOpacity(0.5), width: 1),
                    //                           ),
                    //                           suffixIcon: GestureDetector(
                    //                             onTap: () {
                    //                               deliveryLocPlaningC.isEdit.toggle();
                    //                             },
                    //                             child: Icon(
                    //                               Icons.edit,
                    //                               color: deliveryLocPlaningC.isEdit.value
                    //                                   ? Colors.lightBlue
                    //                                   : Colors.lightBlue.withOpacity(0.3),
                    //                             ),
                    //                           )),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: EdgeInsets.only(top: 10),
                    //                     child: Row(
                    //                       children: [
                    //                         KText(
                    //                           text: 'Delivery Location',
                    //                           fontSize: 13,
                    //                           color: hexToColor('#80939D'),
                    //                         ),
                    //                         KText(
                    //                           text: '*',
                    //                           fontSize: 14,
                    //                           color: Colors.red,
                    //                         ),
                    //                         GestureDetector(
                    //                             onTap: () {
                    //                               //  deliveryLocPlaningC.locationBottomSheet(item.id!);
                    //                             },
                    //                             child: SvgPicture.asset('${Constants.svgPath}/icon_Search_Elements.svg')),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   KText(
                    //                     text: item.dropLocName,
                    //                     fontSize: 15,
                    //                     color: hexToColor('#515D64'),
                    //                   ),
                    //                   Divider(
                    //                     color: hexToColor('#515D64'),
                    //                   ),
                    //                   Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Row(
                    //                         children: [
                    //                           CircleAvatar(
                    //                             radius: 21,
                    //                             backgroundColor: hexToColor('#515D64').withOpacity(0.5),
                    //                             child: CircleAvatar(
                    //                               backgroundColor: hexToColor('#EEF0F6'),
                    //                               radius: 20,
                    //                               child: KText(
                    //                                 text: '${item.dropLocationCount}',
                    //                                 //defineGoodDeliveryLocC.geographyList.length.toString(),
                    //                                 color: Colors.red,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           SizedBox(
                    //                             width: 10,
                    //                           ),
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                              // kLog('pressed');
                    //                               push(DefineGoodsDeliveryLocationGeographiesPage(
                    //                                 id: '',
                    //                                 levelFullCode: item.levelFullcode!,
                    //                               ));
                    //                             },
                    //                             child: Container(
                    //                               width: 130,
                    //                               height: 34,
                    //                               decoration: BoxDecoration(
                    //                                 borderRadius: BorderRadius.circular(5),
                    //                                 color: hexToColor('#E9EAF0'),
                    //                               ),
                    //                               child: Center(
                    //                                 child: KText(
                    //                                   text: 'Geographies',
                    //                                   bold: true,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       GestureDetector(
                    //                         onTap: () {
                    //                          // kLog('value');
                    //                           deliveryLocPlaningC.deliverylocations.removeWhere((x) => x.id == item.id);
                    //                         },
                    //                         child: Padding(
                    //                           padding: EdgeInsets.symmetric(horizontal: 10),
                    //                           child: SvgPicture.asset(
                    //                             '${Constants.svgPath}/icon_delete.svg',
                    //                             width: 25,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   )
                    //                 ]),
                    //               ),
                    //             ),
                    //           );
                    //         }),
                  ]),
            ),
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      persistentFooterButtons: [
        GestureDetector(
            child: Container(
          height: 34,
          width: 109,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppTheme.primaryColor),
          child: Center(
              child: KText(
            text: 'Save',
            color: Colors.white,
            bold: true,
          )),
        )),
        SizedBox(
          width: 40,
        ),
        GestureDetector(
          onTap: () {
            final item = MaterialLocationPlanning(
              id: getUniqeId(),
              dropLocTitle: '',
              dropLocationCount: 0,
              dropLocName: '',
              levelFullcode: '',
              // geographyNo: 0,
              // areaName: '',
              // deliveryLocation: '',
              geograpphy: [],
            );
            deliveryLocPlaningC.itemList.add(item);
            // kLog('value');
          },
          child: CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: hexToColor('#449EF1'),
          ),
        )
      ],
    );
  }
}
