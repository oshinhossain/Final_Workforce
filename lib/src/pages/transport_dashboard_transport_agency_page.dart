import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/ui_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/widgets/title_bar.dart';

import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../helpers/loading.dart';

class TransportationDashboardTransportAgencyPage extends StatelessWidget
    with Base {
  @override
  Widget build(BuildContext context) {
    transportationDashboardC.getTransportOrderByUserType();

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleBar(title: 'Transportation Dashboard'),
            SizedBox(height: 15),
            transportationDashboardC.getTransportComponentByUserType(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class WdddddWidget extends StatelessWidget {
  WdddddWidget({
    Key? key,
    required this.uiC,
  }) : super(key: key);

  final UiController uiC;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          // Row(
          //   children: [
          //     RenderSvg(path: 'icon_transport_pipeline'),
          //     SizedBox(
          //       width: 12,
          //     ),
          //     KText(
          //       text: 'Transportation Orders in My Pipeline',
          //       fontSize: 16,
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 7,
          // ),
          // Divider(
          //   thickness: .5,
          //   color: AppTheme.nBorderC2,
          // ),
          Column(
            children: [
              // ListView.builder(
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   primary: false,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Obx(
              //       () => GestureDetector(
              //         onTap: () => uiC.isExpanded.toggle(),
              //         child: Container(
              //           margin: EdgeInsets.only(top: 12),
              //           height: uiC.isExpanded.value ? 210 : 240,
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.all(Radius.circular(12)),
              //               border: Border.all(
              //                   color: hexToColor('#DBECFB'), width: 1)),
              //           child: Column(
              //             children: [
              //               Container(
              //                 width: Get.width,
              //                 height: 40,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(8),
              //                     topRight: Radius.circular(8),
              //                   ),
              //                   // border: Border.all(),
              //                   color: hexToColor('#DBECFB'),
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 12,
              //                     ),
              //                     Icon(
              //                       uiC.isExpanded.value
              //                           ? EvaIcons.arrowIosDownwardOutline
              //                           : EvaIcons.arrowIosUpwardOutline,
              //                       color: AppTheme.nEvaIconC,
              //                     ),
              //                     SizedBox(
              //                       width: 12,
              //                     ),
              //                     KText(
              //                       text: 'Transport Order No.',
              //                       bold: true,
              //                       fontSize: 13,
              //                     ),
              //                     Spacer(),
              //                     KText(
              //                       text: 'A21345D6',
              //                       bold: true,
              //                       fontSize: 14,
              //                     ),
              //                     SizedBox(
              //                       width: 12,
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 12,
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.only(left: 15, right: 15),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     KText(
              //                       text: 'Order Date',
              //                       color: AppTheme.nTextLightC,
              //                     ),
              //                     KText(
              //                       text: 'ETD',
              //                       color: AppTheme.nTextLightC,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               uiC.isExpanded.value
              //                   ? Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(text: '06 Sep 2022'),
              //                               KText(text: '07 Sep 2022'),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Start Date',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: '06 Sep 2022',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Orderer',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Arafat Trading',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Destination',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Jessore Sadar, Jessore',
              //                                 //   bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   : Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               // SizedBox(width: 15,),
              //                               KText(
              //                                   text: '06 Sep 2022',
              //                                   color: AppTheme.nTextC),
              //                               KText(
              //                                   text: '07 Sep 2022',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Start Date',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: '06 Sep 2022',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Source',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Gazipur Sadar, Gazipur',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Distination',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Jossore Sadar, Jessore',
              //                                 //     bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Orderer',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Arafat Trading',
              //                                 //  bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: [
              //     RenderSvg(path: 'icon_transport_in_progress'),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     KText(
              //       text: 'My Transports in Progress',
              //       fontSize: 16,
              //       //  bold: true,
              //     )
              //   ],
              // ),
              // SizedBox(height: 7),
              // Divider(
              //   thickness: .5,
              //   color: AppTheme.nBorderC2,
              // ),
              // ListView.builder(
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   primary: false,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Obx(
              //       () => GestureDetector(
              //         onTap: () => uiC.isExpanded.toggle(),
              //         child: Container(
              //           margin: EdgeInsets.only(top: 12),
              //           height: uiC.isExpanded.value ? 240 : 360,
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.all(Radius.circular(12)),
              //               border: Border.all(
              //                   color: hexToColor('#DBECFB'), width: 1)),
              //           child: Column(
              //             children: [
              //               Container(
              //                 width: Get.width,
              //                 height: 40,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(8),
              //                     topRight: Radius.circular(8),
              //                   ),
              //                   // border: Border.all(),
              //                   color: hexToColor('#DBECFB'),
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 12,
              //                     ),
              //                     Icon(
              //                       uiC.isExpanded.value
              //                           ? EvaIcons.arrowIosDownwardOutline
              //                           : EvaIcons.arrowIosUpwardOutline,
              //                       color: AppTheme.nEvaIconC,
              //                     ),
              //                     SizedBox(
              //                       width: 12,
              //                     ),
              //                     KText(
              //                       text: 'Transport Order No.',
              //                       bold: true,
              //                       fontSize: 13,
              //                     ),
              //                     Spacer(),
              //                     KText(
              //                       text: 'A21345D6',
              //                       bold: true,
              //                       fontSize: 14,
              //                     ),
              //                     SizedBox(
              //                       width: 12,
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 12,
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.only(left: 15, right: 15),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     KText(
              //                       text: 'Start Date',
              //                       color: AppTheme.nTextLightC,
              //                     ),
              //                     KText(
              //                       text: 'Vechile No.',
              //                       color: AppTheme.nTextLightC,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               uiC.isExpanded.value
              //                   ? Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(text: '06 Sep 2022'),
              //                               KText(text: 'Dhaka-Metro X-21345'),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Orderer',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Arafat Trading',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Receiving Party',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Jessore Trade Agency',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Destination',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Jessore Sadar, Jessore',
              //                                 //   bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Status',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Inspected and Accepted',
              //                                 bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   : Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               // SizedBox(width: 15,),
              //                               KText(
              //                                   text: '06 Sep 2022',
              //                                   color: AppTheme.nTextC),
              //                               KText(
              //                                   text: 'Dhaka-Metro X-21345',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Driver',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Monu Mia',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                   text: 'Orderer',
              //                                   color: AppTheme.nTextLightC),
              //                               KText(
              //                                   text: 'Arafat Trading',
              //                                   color: AppTheme.nTextC),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Receiving Party',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Jossore Sadar, Jessore',
              //                                 //     bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Source',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Gazipur Sadar, Gazipur',
              //                                 //  bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Destination',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Jessore Sadar, Jessore',
              //                                 //  bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Route',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text:
              //                                     'Gazipur Sadar, Gazipur -->\nJessore Sadar, Jessore',
              //                                 //  bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Divider(
              //                           color: AppTheme.nBorderC1,
              //                           thickness: 1.2,
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: 15, right: 15),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               KText(
              //                                 text: 'Status',
              //                                 color: AppTheme.nTextLightC,
              //                               ),
              //                               KText(
              //                                 text: 'Inspected and Accepted',
              //                                 bold: true,
              //                                 color: AppTheme.nTextC,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   children: [
              //     RenderSvg(path: 'trucklogo'),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     KText(
              //       text: 'My Vehicles',
              //       fontSize: 16,
              //       //  bold: true,
              //     )
              //   ],
              // ),
              // SizedBox(height: 7),
              // Divider(
              //   thickness: .5,
              //   color: AppTheme.nBorderC2,
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: 12),
              //   height: 230,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(12)),
              //       border: Border.all(color: AppTheme.nBorderC1, width: 1)),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: Get.width,
              //         height: 40,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(8),
              //             topRight: Radius.circular(8),
              //           ),
              //           // border: Border.all(),
              //           color: AppTheme.nColor1,
              //         ),
              //         child: Row(
              //           children: [
              //             SizedBox(
              //               width: 15,
              //             ),
              //             KText(
              //               text: 'Total:',
              //               //  bold: true,
              //               fontSize: 13,
              //             ),
              //             KText(
              //               text: '210',
              //               bold: true,
              //               fontSize: 14,
              //             ),
              //             SizedBox(
              //               width: 15,
              //             )
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 12,
              //       ),
              //       Column(children: [
              //         Padding(
              //           padding: EdgeInsets.only(left: 15, right: 15),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               KText(
              //                 text: 'Functional',
              //                 //  bold: true,
              //                 fontSize: 14,
              //                 color: AppTheme.nTextLightC,
              //               ),
              //               KText(
              //                 text: 'Inactive',
              //                 // bold: true,
              //                 fontSize: 14,
              //                 color: AppTheme.nTextLightC,
              //               ),
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.only(
              //               top: 10, left: 15, right: 15, bottom: 10),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(8)),
              //                   color: AppTheme.nBoxC1,
              //                 ),
              //                 height: 32,
              //                 width: 47,
              //                 child: Center(
              //                   child: KText(
              //                     text: '95',
              //                     fontSize: 14,
              //                     bold: true,
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(8)),
              //                   color: AppTheme.nBoxC2,
              //                 ),
              //                 height: 32,
              //                 width: 47,
              //                 child: Center(
              //                   child: KText(
              //                     text: '25',
              //                     fontSize: 14,
              //                     bold: true,
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //         Divider(
              //           color: AppTheme.nBorderC1,
              //           thickness: 1.2,
              //         ),
              //         Padding(
              //           padding: EdgeInsets.only(left: 15, right: 15),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               KText(
              //                 text: 'On Duty',
              //                 //  bold: true,
              //                 fontSize: 14,
              //                 color: AppTheme.nTextLightC,
              //               ),
              //               KText(
              //                 text: 'Request for Service',
              //                 // bold: true,
              //                 fontSize: 14,
              //                 color: AppTheme.nTextLightC,
              //               ),
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.only(
              //               top: 10, left: 15, right: 15, bottom: 10),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(8)),
              //                   color: AppTheme.nBoxC3,
              //                 ),
              //                 height: 32,
              //                 width: 47,
              //                 child: Center(
              //                   child: KText(
              //                     text: '75',
              //                     fontSize: 14,
              //                     bold: true,
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(8)),
              //                   color: AppTheme.nBoxC4,
              //                 ),
              //                 height: 32,
              //                 width: 47,
              //                 child: Center(
              //                   child: KText(
              //                     text: '05',
              //                     fontSize: 14,
              //                     bold: true,
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ]),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                children: [
                  RenderSvg(path: 'icon_complaints'),
                  SizedBox(
                    width: 12,
                  ),
                  KText(
                    text: 'Complaints in Transportation',
                    fontSize: 16,
                  )
                ],
              ),
              Divider(
                color: AppTheme.nBorderC2,
                thickness: .5,
              ),
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () => uiC.isExpanded.toggle(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        height: uiC.isExpanded.value ? 150 : 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                                color: AppTheme.nBorderC1, width: 1)),
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                // border: Border.all(),
                                color: AppTheme.nColor1,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    uiC.isExpanded.value
                                        ? EvaIcons.arrowIosDownwardOutline
                                        : EvaIcons.arrowIosUpwardOutline,
                                    color: AppTheme.nEvaIconC,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  KText(
                                    text: 'Transport Order No.',
                                    bold: true,
                                    fontSize: 13,
                                  ),
                                  Spacer(),
                                  KText(
                                    text: 'A21345D6',
                                    bold: true,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Start Date',
                                    color: AppTheme.nTextLightC,
                                  ),
                                  KText(
                                    text: 'Vechile No.',
                                    color: AppTheme.nTextLightC,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            uiC.isExpanded.value
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(text: '06 Sep 2022'),
                                            KText(text: 'Dhaka-Metro X-21345'),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Customer',
                                              color: AppTheme.nTextLightC,
                                            ),
                                            KText(
                                              text: 'Arafat Trading',
                                              bold: true,
                                              color: AppTheme.nTextC,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // SizedBox(width: 15,),
                                            KText(
                                                text: '06 Sep 2022',
                                                color: AppTheme.nTextC),
                                            KText(
                                                text: 'Dhaka-Metro X-21345',
                                                color: AppTheme.nTextC),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                                text: 'Customer',
                                                color: AppTheme.nTextLightC),
                                            KText(
                                                text: 'Arafat trading',
                                                color: AppTheme.nTextC),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                                text: 'Driver',
                                                color: AppTheme.nTextLightC),
                                            KText(
                                                text: 'Monu Mia',
                                                color: AppTheme.nTextC),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Source',
                                              color: AppTheme.nTextLightC,
                                            ),
                                            KText(
                                              text: 'Gazipur Sadar, Gazipur',
                                              //  bold: true,
                                              color: AppTheme.nTextC,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Destination',
                                              color: AppTheme.nTextLightC,
                                            ),
                                            KText(
                                              text: 'Jessore Sadar, Jessore',
                                              //  bold: true,
                                              color: AppTheme.nTextC,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, bottom: 5),
                                        child: KText(
                                          text: 'Remarks',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, bottom: 5),
                                        child: TextField(
                                            // autofillHints: 'Your Remarks Here',
                                            ),
                                        // KText(
                                        //     text:
                                        //         'RCC Poles from BMTF',
                                        //     color: AppTheme.nTextC),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//==================================================
// Operational Dashboard for Transport Orderer
//==================================================
class TransportationOrdersPlacedWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.dashboardTransportOrder.isEmpty
          ? transportationDashboardC.isLoading.value
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
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_bill'),
                      SizedBox(width: 8),
                      KText(
                        text: 'Transportation Orders',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        itemCount: transportationDashboardC
                            .dashboardTransportOrder.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          final item = transportationDashboardC
                              .dashboardTransportOrder[index];
                          return GestureDetector(
                            onTap: () {
                              transportationDashboardC
                                  .transportOrderExapndItem(item);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 12),
                              // height: uiC.isExpanded.value ? 210 : 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  color: hexToColor('#DBECFB'),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(4)),
                                      // border: Border.all(),
                                      color: hexToColor('#DBECFB'),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Icon(
                                          item.isExpanded!
                                              ? EvaIcons.arrowIosUpwardOutline
                                              : EvaIcons
                                                  .arrowIosDownwardOutline,
                                          color: hexToColor('#80939D'),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        KText(
                                          text: 'Transport Order No.',
                                          bold: true,
                                          fontSize: 13,
                                        ),
                                        Spacer(),
                                        KText(
                                          text: item.transportOrderNo,
                                          bold: true,
                                          fontSize: 14,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Date',
                                              color: AppTheme.nTextLightC,
                                            ),
                                            KText(
                                              text: 'ETD',
                                              color: AppTheme.nTextLightC,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (item.transportOrderDate != null)
                                              KText(
                                                text: formatDate(
                                                    date: item
                                                        .transportOrderDate!),
                                              ),
                                            if (item.latestEtd != null)
                                              KText(
                                                  text: formatDate(
                                                      date: item.latestEtd!)),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: AppTheme.nBorderC1,
                                        thickness: 1.2,
                                      ),
                                    ],
                                  ),
                                  item.isExpanded!
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text: 'Source',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.sourceLocName !=
                                                                null
                                                            ? '${item.sourceLocName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text: 'Destination',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.destinationLocName !=
                                                                null
                                                            ? '${item.destinationLocName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text:
                                                          'Transportation Party',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.transporterAgencyName !=
                                                                null
                                                            ? '${item.transporterAgencyName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text: 'Receiving Party',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.receiverAgencyName !=
                                                                null
                                                            ? '${item.receiverAgencyName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
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
                                                    color: AppTheme.nTextLightC,
                                                  ),
                                                  KText(
                                                    text: item.remarks != null
                                                        ? '${item.remarks}'
                                                        : '',
                                                    color: AppTheme.nTextC,
                                                    maxLines: 3,
                                                    bold: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 6,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'Status',
                                                    color: AppTheme.nTextLightC,
                                                  ),
                                                  KText(
                                                    text: item.status,
                                                    bold: true,
                                                    color: AppTheme.nTextC,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text: 'Destination',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.destinationLocName !=
                                                                null
                                                            ? '${item.destinationLocName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  KText(
                                                      text: 'Receiving Party ',
                                                      color:
                                                          AppTheme.nTextLightC),
                                                  Spacer(),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: KText(
                                                        text: item.receiverAgencyName !=
                                                                null
                                                            ? '${item.receiverAgencyName}'
                                                            : '',
                                                        color: AppTheme.nTextC,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppTheme.nBorderC1,
                                              thickness: 1.2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 6,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'Status',
                                                    color: AppTheme.nTextLightC,
                                                  ),
                                                  KText(
                                                    text: item.status,
                                                    bold: true,
                                                    color: AppTheme.nTextC,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // ListView.builder(
                      //   itemCount: 1,
                      //   shrinkWrap: true,
                      //   primary: false,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Obx(
                      //       () => GestureDetector(
                      //         onTap: () => uiC.isExpanded.toggle(),
                      //         child: Container(
                      //           margin: EdgeInsets.only(top: 12),
                      //           height: uiC.isExpanded.value ? 340 : 330,
                      //           width: double.infinity,
                      //           decoration: BoxDecoration(
                      //             color: AppTheme.white,
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: AppTheme.nBorderC3,
                      //                 spreadRadius: 1,
                      //                 blurRadius: 3,
                      //               )
                      //             ],
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(12)),
                      //             // border: Border.all(
                      //             //     color: AppTheme.nBorderC3, width: 1),
                      //           ),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Container(
                      //                 width: Get.width,
                      //                 height: 40,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(8),
                      //                     topRight: Radius.circular(8),
                      //                   ),
                      //                   // border: Border.all(),
                      //                   color: hexToColor('#98F2DB'),
                      //                 ),
                      //                 child: Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       width: 12,
                      //                     ),
                      //                     Icon(
                      //                       uiC.isExpanded.value
                      //                           ? EvaIcons.arrowIosUpwardOutline
                      //                           : EvaIcons
                      //                               .arrowIosDownwardOutline,
                      //                       color: hexToColor('#80939D'),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12,
                      //                     ),
                      //                     KText(
                      //                       text: 'Transport Order No.',
                      //                       bold: true,
                      //                       fontSize: 13,
                      //                     ),
                      //                     Spacer(),
                      //                     KText(
                      //                       text: 'A21345D6',
                      //                       bold: true,
                      //                       fontSize: 14,
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12,
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 12,
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     EdgeInsets.only(left: 15, right: 15),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     KText(
                      //                       text: 'Date',
                      //                       color: AppTheme.nTextLightC,
                      //                     ),
                      //                     KText(
                      //                       text: 'ETD',
                      //                       color: AppTheme.nTextLightC,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 5,
                      //               ),
                      //               uiC.isExpanded.value
                      //                   ? Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(text: '06 Sep 2022'),
                      //                               KText(text: '07 Sep 2022'),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Source',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Gazipur Sadar, Gazipur',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Destination',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Sadar, Jessore',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text:
                      //                                       'Transportation Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Dalta Transport Services',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Receiving Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Trade Agency',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, bottom: 5),
                      //                           child: KText(
                      //                             text: 'Remarks',
                      //                             color: AppTheme.nTextLightC,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, bottom: 5),
                      //                           child: KText(
                      //                               text: 'RCC Poles from BMTF',
                      //                               color: AppTheme.nTextC),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                 text: 'Status',
                      //                                 color: AppTheme.nTextLightC,
                      //                               ),
                      //                               KText(
                      //                                 text: 'Inspect and Accpted',
                      //                                 bold: true,
                      //                                 color: AppTheme.nTextC,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   : Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               // SizedBox(width: 15,),
                      //                               KText(
                      //                                   text: '06 Sep 2022',
                      //                                   color: AppTheme.nTextC),
                      //                               KText(
                      //                                   text: '07 Sep 2022',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Source',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Gazipur Sadar, Gazipur',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Destination',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Sadar, Jessore',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text:
                      //                                       'Transportation Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Dalta Transport Services',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Receiving Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Trade Agency',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, bottom: 5),
                      //                           child: KText(
                      //                             text: 'Remarks',
                      //                             color: AppTheme.nTextLightC,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, bottom: 5),
                      //                           child: KText(
                      //                               text: 'Jessore Trade Agency',
                      //                               color: AppTheme.nTextC),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC3,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                 text: 'Status',
                      //                                 color: AppTheme.nTextLightC,
                      //                               ),
                      //                               KText(
                      //                                 text: 'Inspect and Accpted',
                      //                                 bold: true,
                      //                                 color: AppTheme.nTextC,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // ListView.builder(
                      //   itemCount: 1,
                      //   shrinkWrap: true,
                      //   primary: false,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Obx(
                      //       () => GestureDetector(
                      //         onTap: () => uiC.isExpanded.toggle(),
                      //         child: Container(
                      //           margin: EdgeInsets.only(top: 12),
                      //           height: uiC.isExpanded.value ? 210 : 200,
                      //           width: double.infinity,
                      //           decoration: BoxDecoration(
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(12)),
                      //               border: Border.all(
                      //                   color: AppTheme.nBorderC4, width: 1)),
                      //           child: Column(
                      //             children: [
                      //               Container(
                      //                 width: Get.width,
                      //                 height: 40,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(8),
                      //                     topRight: Radius.circular(8),
                      //                   ),
                      //                   // border: Border.all(),
                      //                   color: AppTheme.nTONColor3,
                      //                 ),
                      //                 child: Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       width: 12,
                      //                     ),
                      //                     Icon(
                      //                       uiC.isExpanded.value
                      //                           ? EvaIcons.arrowIosUpwardOutline
                      //                           : EvaIcons
                      //                               .arrowIosDownwardOutline,
                      //                       color: hexToColor('#80939D'),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12,
                      //                     ),
                      //                     KText(
                      //                       text: 'Transport Order No.',
                      //                       bold: true,
                      //                       fontSize: 13,
                      //                     ),
                      //                     Spacer(),
                      //                     KText(
                      //                       text: 'A21345D6',
                      //                       bold: true,
                      //                       fontSize: 14,
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12,
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 12,
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     EdgeInsets.only(left: 15, right: 15),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     KText(
                      //                       text: 'Date',
                      //                       color: AppTheme.nTextLightC,
                      //                     ),
                      //                     KText(
                      //                       text: 'ETD',
                      //                       color: AppTheme.nTextLightC,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 5,
                      //               ),
                      //               uiC.isExpanded.value
                      //                   ? Column(
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(text: '06 Sep 2022'),
                      //                               KText(text: '07 Sep 2022'),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Destination',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Sadar, Jessore',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Receiving Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Trade Agency',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                 text: 'Status',
                      //                                 color: AppTheme.nTextLightC,
                      //                               ),
                      //                               KText(
                      //                                 text:
                      //                                     'Inspected and Rejeceted',
                      //                                 bold: true,
                      //                                 color: AppTheme.nTextC,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   : Column(
                      //                       children: [
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               // SizedBox(width: 15,),
                      //                               KText(
                      //                                   text: '06 Sep 2022',
                      //                                   color: AppTheme.nTextC),
                      //                               KText(
                      //                                   text: '07 Sep 2022',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Destination',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Sadar, Jessore',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                   text: 'Receiving Party',
                      //                                   color:
                      //                                       AppTheme.nTextLightC),
                      //                               KText(
                      //                                   text:
                      //                                       'Jessore Trade Agency',
                      //                                   color: AppTheme.nTextC),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                         Divider(
                      //                           color: AppTheme.nBorderC4,
                      //                           thickness: 1.2,
                      //                         ),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               left: 15, right: 15),
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             children: [
                      //                               KText(
                      //                                 text: 'Status',
                      //                                 color: AppTheme.nTextLightC,
                      //                               ),
                      //                               KText(
                      //                                 text:
                      //                                     'Inspected and Rejeceted',
                      //                                 bold: true,
                      //                                 color: AppTheme.nTextC,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

//==================================================
// Operational Dashboard for Transport Agency
//==================================================
class TransportationOrdersInMyPipelineWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              RenderSvg(path: 'icon_transport_pipeline'),
              SizedBox(
                width: 12,
              ),
              KText(
                text: 'Transportation Orders in My Pipeline',
                fontSize: 15,
                bold: true,
              )
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Divider(
            thickness: .5,
            color: AppTheme.nBorderC2,
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return Obx(
                () => GestureDetector(
                  onTap: () => uiC.isExpanded.toggle(),
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(color: hexToColor('#DBECFB'), width: 1)),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            // border: Border.all(),
                            color: hexToColor('#DBECFB'),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Icon(
                                uiC.isExpanded.value
                                    ? EvaIcons.arrowIosDownwardOutline
                                    : EvaIcons.arrowIosUpwardOutline,
                                color: AppTheme.nEvaIconC,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              KText(
                                text: 'Transport Order No.',
                                bold: true,
                                fontSize: 13,
                              ),
                              Spacer(),
                              KText(
                                text: 'A21345D6',
                                bold: true,
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 12,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: 'Order Date',
                                color: AppTheme.nTextLightC,
                              ),
                              KText(
                                text: 'ETD',
                                color: AppTheme.nTextLightC,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        uiC.isExpanded.value
                            ? Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: '06 Sep 2022'),
                                        KText(text: '07 Sep 2022'),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Start Date',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: '06 Sep 2022',
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Orderer',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Arafat Trading',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Destination',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Jessore Sadar, Jessore',
                                          //   bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(width: 15,),
                                        KText(
                                            text: '06 Sep 2022',
                                            color: AppTheme.nTextC),
                                        KText(
                                            text: '07 Sep 2022',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Start Date',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: '06 Sep 2022',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Source',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Gazipur Sadar, Gazipur',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Distination',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Jossore Sadar, Jessore',
                                          //     bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Orderer',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Arafat Trading',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//My Transports in Progress
class MyTransportsinProgressWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              RenderSvg(path: 'icon_transport_in_progress'),
              SizedBox(
                width: 12,
              ),
              KText(
                text: 'My Transports in Progress',
                fontSize: 15,
                bold: true,
              )
            ],
          ),
          SizedBox(height: 7),
          Divider(
            thickness: .5,
            color: AppTheme.nBorderC2,
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return Obx(
                () => GestureDetector(
                  onTap: () => uiC.isExpanded.toggle(),
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    // height: uiC.isExpanded.value ? 240 : 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: hexToColor('#DBECFB'),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            // border: Border.all(),
                            color: hexToColor('#DBECFB'),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Icon(
                                uiC.isExpanded.value
                                    ? EvaIcons.arrowIosDownwardOutline
                                    : EvaIcons.arrowIosUpwardOutline,
                                color: AppTheme.nEvaIconC,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              KText(
                                text: 'Transport Order No.',
                                bold: true,
                                fontSize: 13,
                              ),
                              Spacer(),
                              KText(
                                text: 'A21345D6',
                                bold: true,
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 12,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: 'Start Date',
                                color: AppTheme.nTextLightC,
                              ),
                              KText(
                                text: 'Vechile No.',
                                color: AppTheme.nTextLightC,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(width: 15,),
                                  KText(
                                      text: '06 Sep 2022',
                                      color: AppTheme.nTextC),
                                  KText(
                                      text: 'Dhaka-Metro X-21345',
                                      color: AppTheme.nTextC),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                      text: 'Driver',
                                      color: AppTheme.nTextLightC),
                                  KText(
                                      text: 'Monu Mia', color: AppTheme.nTextC),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                      text: 'Orderer',
                                      color: AppTheme.nTextLightC),
                                  KText(
                                      text: 'Arafat Trading',
                                      color: AppTheme.nTextC),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Receiving Party',
                                    color: AppTheme.nTextLightC,
                                  ),
                                  KText(
                                    text: 'Jossore Sadar, Jessore',
                                    //     bold: true,
                                    color: AppTheme.nTextC,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                            if (uiC.isExpanded.value)
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Destination',
                                      color: AppTheme.nTextLightC,
                                    ),
                                    KText(
                                      text: 'Jessore Sadar, Jessore',
                                      //  bold: true,
                                      color: AppTheme.nTextC,
                                    ),
                                  ],
                                ),
                              ),
                            if (!uiC.isExpanded.value)
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
                                          text: 'Source',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Gazipur Sadar, Gazipur',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Destination',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Jessore Sadar, Jessore',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Route',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text:
                                              'Gazipur Sadar, Gazipur -->\nJessore Sadar, Jessore',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 6,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Status',
                                    color: AppTheme.nTextLightC,
                                  ),
                                  KText(
                                    text: 'Inspected and Accepted',
                                    bold: true,
                                    color: AppTheme.nTextC,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//My Vehicles
class MyVehiclesWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return transportationDashboardC.agencyMyVehicles.value == null
        ? SizedBox()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Builder(builder: (context) {
              final item = transportationDashboardC.agencyMyVehicles.value;
              return Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'trucklogo'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'My Vehicles',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  SizedBox(height: 7),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border:
                            Border.all(color: AppTheme.nBorderC1, width: 1)),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            // border: Border.all(),
                            color: AppTheme.nColor1,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              KText(
                                text: 'Total:',
                                //  bold: true,
                                fontSize: 13,
                              ),
                              KText(
                                text: '${item!.total}',
                                bold: true,
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 15,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: 'Functional',
                                  //  bold: true,
                                  fontSize: 14,
                                  color: AppTheme.nTextLightC,
                                ),
                                KText(
                                  text: 'Inactive',
                                  // bold: true,
                                  fontSize: 14,
                                  color: AppTheme.nTextLightC,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 15, right: 15, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppTheme.nBoxC1,
                                  ),
                                  height: 32,
                                  width: 47,
                                  child: Center(
                                    child: KText(
                                      text: '${item.functional}',
                                      fontSize: 14,
                                      bold: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppTheme.nBoxC2,
                                  ),
                                  height: 32,
                                  width: 47,
                                  child: Center(
                                    child: KText(
                                      text: '${item.inAcative}',
                                      fontSize: 14,
                                      bold: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: AppTheme.nBorderC1,
                            thickness: 1.2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: 'On Duty',
                                  //  bold: true,
                                  fontSize: 14,
                                  color: AppTheme.nTextLightC,
                                ),
                                KText(
                                  text: 'Request for Service',
                                  // bold: true,
                                  fontSize: 14,
                                  color: AppTheme.nTextLightC,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 15, right: 15, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppTheme.nBoxC3,
                                  ),
                                  height: 32,
                                  width: 47,
                                  child: Center(
                                    child: KText(
                                      text: '${item.onDuty}',
                                      fontSize: 14,
                                      bold: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppTheme.nBoxC4,
                                  ),
                                  height: 32,
                                  width: 47,
                                  child: Center(
                                    child: KText(
                                      text: '${item.requestForService}',
                                      fontSize: 14,
                                      bold: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
  }
}

//Complaints in Transportation
class ComplaintsInTransportationWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              RenderSvg(path: 'icon_complaints'),
              SizedBox(
                width: 12,
              ),
              KText(
                text: 'Complaints in Transportation',
                fontSize: 15,
                bold: true,
              )
            ],
          ),
          Divider(
            color: AppTheme.nBorderC2,
            thickness: .5,
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return Obx(
                () => GestureDetector(
                  onTap: () => uiC.isExpanded.toggle(),
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    // height: uiC.isExpanded.value ? 150 : 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(color: AppTheme.nBorderC1, width: 1)),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            // border: Border.all(),
                            color: AppTheme.nColor1,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Icon(
                                uiC.isExpanded.value
                                    ? EvaIcons.arrowIosDownwardOutline
                                    : EvaIcons.arrowIosUpwardOutline,
                                color: AppTheme.nEvaIconC,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              KText(
                                text: 'Transport Order No.',
                                bold: true,
                                fontSize: 13,
                              ),
                              Spacer(),
                              KText(
                                text: 'A21345D6',
                                bold: true,
                                fontSize: 14,
                              ),
                              SizedBox(
                                width: 12,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Start Date',
                                    color: AppTheme.nTextLightC,
                                  ),
                                  KText(
                                    text: 'Vechile No.',
                                    color: AppTheme.nTextLightC,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(text: '06 Sep 2022'),
                                  KText(text: 'Dhaka-Metro X-21345'),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppTheme.nBorderC1,
                              thickness: 1.2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        uiC.isExpanded.value
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: 'Customer',
                                      color: AppTheme.nTextLightC,
                                    ),
                                    KText(
                                      text: 'Arafat Trading',
                                      bold: true,
                                      color: AppTheme.nTextC,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Customer',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Arafat trading',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                            text: 'Driver',
                                            color: AppTheme.nTextLightC),
                                        KText(
                                            text: 'Monu Mia',
                                            color: AppTheme.nTextC),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Source',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Gazipur Sadar, Gazipur',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Destination',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Jessore Sadar, Jessore',
                                          //  bold: true,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, bottom: 5),
                                    child: KText(
                                      text: 'Remarks',
                                      color: AppTheme.nTextLightC,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, bottom: 5),
                                    child: TextField(
                                        // autofillHints: 'Your Remarks Here',
                                        ),
                                    // KText(
                                    //     text:
                                    //         'RCC Poles from BMTF',
                                    //     color: AppTheme.nTextC),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//==================================================
// Operational Dashboard for Driver
//==================================================

class MyTransportationOrdersToDriverWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return transportationDashboardC.dashboardDriverOrder.isEmpty
        ? SizedBox(
            // height: Get.height / 1.5,
            // child: Center(child: Loading()),
            )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    RenderSvg(path: 'icon_bill'),
                    SizedBox(width: 6),
                    KText(
                      text: 'My Transportation Orders to Drive',
                      fontSize: 15,
                      bold: true,
                    )
                  ],
                ),
                Divider(
                  color: AppTheme.nBorderC2,
                  thickness: .5,
                ),
                ListView.builder(
                  itemCount:
                      transportationDashboardC.dashboardDriverOrder.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    // final item =
                    //     transportationDashboardC.dashboardDriverOrder[index];
                    return Obx(
                      () => GestureDetector(
                        onTap: () => uiC.isExpanded.toggle(),
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          // height: uiC.isExpanded.value ? 150 : 320,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: AppTheme.nBorderC1, width: 1)),
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  // border: Border.all(),
                                  color: AppTheme.nColor1,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      uiC.isExpanded.value
                                          ? EvaIcons.arrowIosDownwardOutline
                                          : EvaIcons.arrowIosUpwardOutline,
                                      color: AppTheme.nEvaIconC,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    KText(
                                      text: 'Transport Order No.',
                                      bold: true,
                                      fontSize: 13,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: 'A21345D6',
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
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
                                          text: 'ETS',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'ETD',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: '06 Sep 2022'),
                                        KText(text: '06 Sep 2022'),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              uiC.isExpanded.value
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 6,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'Destination',
                                            color: AppTheme.nTextLightC,
                                          ),
                                          KText(
                                            text: 'Jessore Sadar, Jessore',
                                            bold: true,
                                            color: AppTheme.nTextC,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Vehicle No.',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: 'Dhaka-Metro X-21345',
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Receiving Party',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                text: 'Jessore Trade Agency',
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Source',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              KText(
                                                text: 'Gazipur Sadar, Gazipur',
                                                //  bold: true,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Destination',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              KText(
                                                text: 'Jessore Sadar, Jessore',
                                                //  bold: true,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'ETD',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              KText(
                                                text: '09  Sep 2022',
                                                //  bold: true,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            // bottom: 6,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text:
                                                    'Remarks from Transport Agency',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              SizedBox(height: 5),
                                              KText(
                                                text:
                                                    'Bind the poles strongly. Because the truck may tremble at times.',
                                                color: AppTheme.nTextC,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            bottom: 6,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Remarks',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              SizedBox(height: 5),
                                              KText(
                                                text: 'RCC Poles from BMTF',
                                                color: AppTheme.nTextC,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}

//==================================================
// Operational Dashboard for Inspector
//==================================================

//My Preloading Inspection Orders
class PreloadingInspectionOrdersWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.inspectionPreloading.isEmpty
          ? SizedBox()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_box'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'My Preloading Inspection Orders',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  SizedBox(height: 7),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  ListView.builder(
                    itemCount:
                        transportationDashboardC.inspectionPreloading.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item =
                          transportationDashboardC.inspectionPreloading[index];
                      return GestureDetector(
                        onTap: () => transportationDashboardC
                            .inspectionPreloadingExapndItem(item),
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          // height: uiC.isExpanded.value ? 395 : 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.nColor1,
                                spreadRadius: 1,
                                blurRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: AppTheme.nColor1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  // border: Border.all(),
                                  color: AppTheme.nColor1,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      item.isExpanded!
                                          ? EvaIcons.arrowIosUpwardOutline
                                          : EvaIcons.arrowIosDownwardOutline,
                                      color: hexToColor('#80939D'),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    KText(
                                      text: 'Transport Order No.',
                                      bold: true,
                                      fontSize: 13,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.transportOrderNo,
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'ETS',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Vehicle No.',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: item.ets),
                                        KText(
                                          text: item.vehicleNo != null
                                              ? '${item.vehicleNo}'
                                              : '',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppTheme.nBorderC1,
                                thickness: 1.2,
                              ),
                              item.isExpanded!
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Number of Items',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: item.numberOfItems!
                                                      .toInt()
                                                      .toString(),
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Total Weight',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text:
                                                      '${item.totalWeight!.toInt()}',
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              KText(
                                                  text: 'Source',
                                                  color: AppTheme.nTextLightC),
                                              Spacer(),
                                              Expanded(
                                                flex: 5,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: KText(
                                                    text: item.sourceLocName !=
                                                            null
                                                        ? '${item.sourceLocName}'
                                                        : '',
                                                    color: AppTheme.nTextC,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Status',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: item.status,
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                            text:
                                                'Remarks from Transport Agency',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                              text: item.remarksFromAgency !=
                                                      null
                                                  ? '${item.remarksFromAgency}'
                                                  : '',
                                              color: AppTheme.nTextC),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                            text: 'Remarks',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 8, right: 15),
                                          child: SizedBox(
                                            height: 25,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText:
                                                    item.remarksFromInspector !=
                                                            null
                                                        ? '${item.remarksFromInspector}'
                                                        : '',
                                                hintStyle: TextStyle(
                                                  color: hexToColor('#D9D9D9'),
                                                  fontSize: 14,
                                                  fontFamily: 'Manrope Regular',
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Status',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              KText(
                                                text: item.status,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Remarks',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              SizedBox(height: 2),
                                              KText(
                                                text: item.remarksFromInspector !=
                                                        null
                                                    ? '${item.remarksFromInspector}'
                                                    : '',
                                                color: AppTheme.nTextC,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

//My Post Delivery Inspection Orders
class PostDeliveryInspectionOrdersWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.inspectionPostloading.isEmpty
          ? SizedBox()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_transport_pipeline'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'My Post Delivery Inspection Orders',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  ListView.builder(
                    itemCount:
                        transportationDashboardC.inspectionPostloading.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item =
                          transportationDashboardC.inspectionPostloading[index];
                      return GestureDetector(
                        onTap: () => transportationDashboardC
                            .inspectionPostloadingExapndItem(item),
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          // height: uiC.isExpanded.value ? 395 : 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.nColor1,
                                spreadRadius: 1,
                                blurRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: AppTheme.nColor1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  // border: Border.all(),
                                  color: AppTheme.nColor1,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      item.isExpanded!
                                          ? EvaIcons.arrowIosUpwardOutline
                                          : EvaIcons.arrowIosDownwardOutline,
                                      color: hexToColor('#80939D'),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    KText(
                                      text: 'Transport Order No.',
                                      bold: true,
                                      fontSize: 13,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.transportOrderNo,
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'ETS',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Vehicle No.',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: item.etd),
                                        KText(
                                          text: item.vehicleNo,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppTheme.nBorderC1,
                                thickness: 1.2,
                              ),
                              if (item.isExpanded!)
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Number of Items',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                            text: item.numberOfItems!
                                                .toInt()
                                                .toString(),
                                            color: AppTheme.nTextC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Total Weight',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                              text:
                                                  '${item.totalWeight!.toInt()} Kg',
                                              color: AppTheme.nTextC),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Destination',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                              text: item.destination,
                                              color: AppTheme.nTextC),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                  ],
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Status',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: item.status,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 6,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Remarks',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        SizedBox(height: 2),
                                        KText(
                                          text: item.remarks,
                                          color: AppTheme.nTextC,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

//==================================================
// Operational Dashboard for WH Manager
//==================================================

//Transport Orders for Loading to Vehicle
class TransportOrdersForLoadingToVehicleWidget extends StatelessWidget
    with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.dashboardLoadingVehicle.isEmpty
          ? SizedBox()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_box'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Transport Orders for Loading to Vehicle',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  SizedBox(height: 7),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  ListView.builder(
                    itemCount:
                        transportationDashboardC.dashboardLoadingVehicle.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item = transportationDashboardC
                          .dashboardLoadingVehicle[index];
                      return GestureDetector(
                        // onTap: () => transportationDashboardC
                        //     .inspectionPreloadingExapndItem(item),
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          // height: uiC.isExpanded.value ? 395 : 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.nColor1,
                                spreadRadius: 1,
                                blurRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: AppTheme.nColor1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  // border: Border.all(),
                                  color: AppTheme.nColor1,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      item.isExpanded!
                                          ? EvaIcons.arrowIosUpwardOutline
                                          : EvaIcons.arrowIosDownwardOutline,
                                      color: hexToColor('#80939D'),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    KText(
                                      text: 'Transport Order No.',
                                      bold: true,
                                      fontSize: 13,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.transportOrderNo,
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'ETS',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Vehicle No.',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: item.etd),
                                        KText(
                                          text: item.vehicleNo,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppTheme.nBorderC1,
                                thickness: 1.2,
                              ),
                              item.isExpanded!
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Number of Items',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: item.numberOfItem!
                                                      .toInt()
                                                      .toString(),
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'total Weight',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: '${item.weight} Kg',
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Source',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: item.source,
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                  text: 'Status',
                                                  color: AppTheme.nTextLightC),
                                              KText(
                                                  text: item.status,
                                                  color: AppTheme.nTextC),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                            text:
                                                'Remarks from Transport Agency',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                              text: item
                                                  .remarksFromTransportAgencey,
                                              color: AppTheme.nTextC),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: KText(
                                            text: 'Remarks',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 8, right: 15),
                                          child: SizedBox(
                                            height: 25,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: ' Remarks',
                                                hintStyle: TextStyle(
                                                  color: hexToColor('#D9D9D9'),
                                                  fontSize: 14,
                                                  fontFamily: 'Manrope Regular',
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(
                                                text: 'Status',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              KText(
                                                text: item.status,
                                                color: AppTheme.nTextC,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: AppTheme.nBorderC1,
                                          thickness: 1.2,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Remarks',
                                                color: AppTheme.nTextLightC,
                                              ),
                                              SizedBox(height: 2),
                                              KText(
                                                text: 'Remarks',
                                                color: AppTheme.nTextC,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

//Transport Orders to Unload From Vehicle
class TransportOrdersToUnloadFromVehicleWidget extends StatelessWidget
    with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.dashboardUnloadVehicle.isEmpty
          ? SizedBox()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_box'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Transport Orders to Unload From Vehicle',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  ListView.builder(
                    itemCount:
                        transportationDashboardC.dashboardUnloadVehicle.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item = transportationDashboardC
                          .dashboardUnloadVehicle[index];
                      return GestureDetector(
                        // onTap: () => transportationDashboardC
                        //     .inspectionPostloadingExapndItem(item),
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          // height: uiC.isExpanded.value ? 395 : 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.nColor1,
                                spreadRadius: 1,
                                blurRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: AppTheme.nColor1, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                  // border: Border.all(),
                                  color: AppTheme.nColor1,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      item.isExpanded!
                                          ? EvaIcons.arrowIosUpwardOutline
                                          : EvaIcons.arrowIosDownwardOutline,
                                      color: hexToColor('#80939D'),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    KText(
                                      text: 'Transport Order No.',
                                      bold: true,
                                      fontSize: 13,
                                    ),
                                    Spacer(),
                                    KText(
                                      text: item.transportOrderNo,
                                      bold: true,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'ETS',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: 'Vehicle No.',
                                          color: AppTheme.nTextLightC,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(text: item.etd),
                                        KText(
                                          text: item.vehicleNo,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppTheme.nBorderC1,
                                thickness: 1.2,
                              ),
                              if (item.isExpanded!)
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Number of Items',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                            text: item.numberOfItem!
                                                .toInt()
                                                .toString(),
                                            color: AppTheme.nTextC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Total Weight',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                              text: '${item.weight} Kg',
                                              color: AppTheme.nTextC),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                              text: 'Destination',
                                              color: AppTheme.nTextLightC),
                                          KText(
                                              text: 'Destination',
                                              color: AppTheme.nTextC),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.nBorderC1,
                                      thickness: 1.2,
                                    ),
                                  ],
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        KText(
                                          text: 'Status',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        KText(
                                          text: item.status,
                                          color: AppTheme.nTextC,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.nBorderC1,
                                    thickness: 1.2,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      bottom: 6,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Remarks',
                                          color: AppTheme.nTextLightC,
                                        ),
                                        SizedBox(height: 2),
                                        KText(
                                          text: 'Remarks',
                                          color: AppTheme.nTextC,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

//==================================================
// Operational Dashboard for Receiver
//==================================================
//Transport Orders to Receive
class TransportOrdersToReceiveWidget extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transportationDashboardC.dashboardReceiverOrder.isEmpty
          ? SizedBox(
              // height: Get.height / 1.5,
              // child: Center(
              //   child: Loading(),
              // ),
              )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(path: 'icon_box'),
                      SizedBox(
                        width: 12,
                      ),
                      KText(
                        text: 'Transport Orders to Receive',
                        fontSize: 15,
                        bold: true,
                      )
                    ],
                  ),
                  Divider(
                    thickness: .5,
                    color: AppTheme.nBorderC2,
                  ),
                  ListView.builder(
                    itemCount:
                        transportationDashboardC.dashboardReceiverOrder.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item = transportationDashboardC
                          .dashboardReceiverOrder[index];
                      return Obx(
                        () => GestureDetector(
                          // onTap: () => transportationDashboardC
                          //     .inspectionPostloadingExapndItem(item),
                          onTap: () {
                            transportationDashboardC.isExpanded.toggle();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12),
                            // height: uiC.isExpanded.value ? 395 : 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.nColor1,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border:
                                  Border.all(color: AppTheme.nColor1, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(4)),
                                    // border: Border.all(),
                                    color: AppTheme.nColor1,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        item.isExpanded!
                                            ? EvaIcons.arrowIosUpwardOutline
                                            : EvaIcons.arrowIosDownwardOutline,
                                        color: hexToColor('#80939D'),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      KText(
                                        text: 'Transport Order No.',
                                        bold: true,
                                        fontSize: 13,
                                      ),
                                      Spacer(),
                                      KText(
                                        text: item.transportOrderNo,
                                        bold: true,
                                        fontSize: 14,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: 'ETS',
                                            color: AppTheme.nTextLightC,
                                          ),
                                          KText(
                                            text: 'Vehicle No.',
                                            color: AppTheme.nTextLightC,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(text: item.etd),
                                          KText(
                                            text: item.vehicleNo,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  color: AppTheme.nBorderC1,
                                  thickness: 1.2,
                                ),
                                transportationDashboardC.isExpanded.value
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                    text: 'Number of Items',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                  text: item.numberOfItems!
                                                      .toInt()
                                                      .toString(),
                                                  color: AppTheme.nTextC,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                    text: 'Total Weight',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text:
                                                        '${item.totalWeight} Kg',
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                    text: 'Source',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: item.source,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                    text: 'Destination',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: item.destination,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                    text: 'Status',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: item.status,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                    text:
                                                        'Remarks from Transport Agency',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text:
                                                        item.remarksFromAgency,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                    text: 'Remarks from Driver',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: item.remarksDriver,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                    text:
                                                        'Remarks from Warehouese Manager',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: item
                                                        .remarksFromWarehouseManager,
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15, bottom: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                    text: 'Remarks',
                                                    color:
                                                        AppTheme.nTextLightC),
                                                KText(
                                                    text: '2 Poles are Damaged',
                                                    color: AppTheme.nTextC),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                KText(
                                                  text: 'Status',
                                                  color: AppTheme.nTextLightC,
                                                ),
                                                KText(
                                                  text: item.status,
                                                  color: AppTheme.nTextC,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: AppTheme.nBorderC1,
                                            thickness: 1.2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 6,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Remarks',
                                                  color: AppTheme.nTextLightC,
                                                ),
                                                SizedBox(height: 2),
                                                KText(
                                                  text: 'Poles looks OK.',
                                                  color: AppTheme.nTextC,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
